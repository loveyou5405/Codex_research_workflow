import http from "node:http";
import fs from "node:fs/promises";
import path from "node:path";
import { spawn } from "node:child_process";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, "../..");
const publicDir = path.join(__dirname, "public");
const bridgeDir = path.join(projectRoot, "mcp/cloakbrowser-research");
const outputsDir = path.join(bridgeDir, "outputs");
const uploadsDir = path.join(projectRoot, "uploads");
const downloadsDir = path.join(projectRoot, "downloads");
const outputPdfDir = path.join(projectRoot, "output_PDF");
const nodeBinDir = path.dirname(process.execPath);
const port = Number(process.env.RESEARCH_CONSOLE_PORT || 8765);
const versionPath = path.join(projectRoot, "VERSION");
const doiTestScript = path.join(bridgeDir, "src/open-for-test.js");
let doiTestProcess = null;

function json(res, status, data) {
  res.writeHead(status, { "content-type": "application/json; charset=utf-8" });
  res.end(JSON.stringify(data, null, 2));
}

function normalizeTarget(value) {
  const input = String(value || "").trim();
  if (!input) return "https://scholar.google.com";
  if (/^https?:\/\//i.test(input)) return input;
  return `https://doi.org/${input.replace(/^doi:/i, "").trim()}`;
}

function startOrReuseDoiTest(target, downloadMode) {
  if (doiTestProcess && doiTestProcess.exitCode === null && doiTestProcess.stdin?.writable) {
    try {
      doiTestProcess.stdin.write(`${target}\n`);
      return true;
    } catch {
      doiTestProcess = null;
    }
  }

  doiTestProcess = spawn(process.execPath, [doiTestScript, target], {
    cwd: bridgeDir,
    env: {
      ...process.env,
      PATH: `${nodeBinDir}:${process.env.PATH || ""}`,
      CLOAKBROWSER_RESEARCH_AUTHORIZED: "1",
      CLOAKBROWSER_HUMANIZE: "1",
      CLOAKBROWSER_BLOCK_FILE_DOWNLOADS: "0",
      CLOAKBROWSER_DOWNLOAD_MODE: downloadMode,
    },
    stdio: ["pipe", "ignore", "inherit"],
  });
  doiTestProcess.once("exit", () => {
    doiTestProcess = null;
  });
  doiTestProcess.stdin.on("error", (error) => {
    console.error(`DOI test browser input closed: ${error.message || error}`);
  });
  doiTestProcess.once("error", (error) => {
    console.error(`DOI test browser failed: ${error.message || error}`);
    doiTestProcess = null;
  });
  return false;
}

function stopDoiTest() {
  if (!doiTestProcess || doiTestProcess.exitCode !== null) return;
  if (doiTestProcess.stdin?.writable) doiTestProcess.stdin.write("__CLOSE__\n");
  const child = doiTestProcess;
  setTimeout(() => {
    if (child.exitCode === null) child.kill("SIGTERM");
  }, 1500).unref();
}

function safeFilename(value, fallback = "upload") {
  const name = path.basename(String(value || "").trim()).replace(/[^\w .()[\]-]+/g, "_");
  return name || fallback;
}

function parseContentDisposition(value) {
  const result = {};
  for (const part of String(value || "").split(";")) {
    const [rawKey, ...rawRest] = part.trim().split("=");
    if (!rawRest.length) continue;
    const key = rawKey.toLowerCase();
    let fieldValue = rawRest.join("=").trim();
    if (fieldValue.startsWith('"') && fieldValue.endsWith('"')) {
      fieldValue = fieldValue.slice(1, -1).replace(/\\"/g, '"');
    }
    result[key] = fieldValue;
  }
  return result;
}

function parseMultipart(buffer, contentType) {
  const match = /boundary=(?:"([^"]+)"|([^;]+))/i.exec(contentType || "");
  if (!match) throw new Error("Missing multipart boundary");
  const boundary = Buffer.from(`--${match[1] || match[2]}`);
  const files = [];
  let position = buffer.indexOf(boundary);

  while (position !== -1) {
    position += boundary.length;
    if (buffer.slice(position, position + 2).toString() === "--") break;
    if (buffer.slice(position, position + 2).toString() === "\r\n") position += 2;

    const headerEnd = buffer.indexOf(Buffer.from("\r\n\r\n"), position);
    if (headerEnd === -1) break;
    const headerText = buffer.slice(position, headerEnd).toString("utf8");
    const headers = Object.fromEntries(headerText.split("\r\n").map((line) => {
      const separator = line.indexOf(":");
      if (separator === -1) return ["", ""];
      return [line.slice(0, separator).toLowerCase(), line.slice(separator + 1).trim()];
    }).filter(([key]) => key));

    const bodyStart = headerEnd + 4;
    const nextBoundary = buffer.indexOf(boundary, bodyStart);
    if (nextBoundary === -1) break;
    const bodyEnd = buffer.slice(nextBoundary - 2, nextBoundary).toString() === "\r\n"
      ? nextBoundary - 2
      : nextBoundary;

    const disposition = parseContentDisposition(headers["content-disposition"]);
    if (disposition.filename) {
      files.push({
        field: disposition.name || "files",
        filename: safeFilename(disposition.filename),
        type: headers["content-type"] || "application/octet-stream",
        data: buffer.slice(bodyStart, bodyEnd),
      });
    }
    position = nextBoundary;
  }

  return files;
}

async function saveUploadedFiles(req) {
  const chunks = [];
  for await (const chunk of req) chunks.push(chunk);
  const buffer = Buffer.concat(chunks);
  const files = parseMultipart(buffer, req.headers["content-type"]);
  const batchDir = path.join(uploadsDir, new Date().toISOString().replace(/[:.]/g, "-"));
  await fs.mkdir(batchDir, { recursive: true });

  const saved = [];
  for (const [index, file] of files.entries()) {
    const filename = safeFilename(file.filename, `upload-${index + 1}`);
    const destination = path.join(batchDir, filename);
    await fs.writeFile(destination, file.data);
    saved.push({
      name: filename,
      type: file.type,
      size: file.data.length,
      path: destination,
    });
  }
  return saved;
}

async function cleanupTemporaryFiles() {
  const deleted = [];
  await fs.mkdir(outputsDir, { recursive: true });
  const entries = await fs.readdir(outputsDir, { withFileTypes: true });
  for (const entry of entries) {
    if (!entry.isFile()) continue;
    if (!/\.(png|jpg|jpeg|webp|log|tmp)$/i.test(entry.name)) continue;
    const fullPath = path.join(outputsDir, entry.name);
    await fs.rm(fullPath, { force: true });
    deleted.push(fullPath);
  }

  const tmpBase = process.env.TMPDIR || "/tmp";
  try {
    const tmpEntries = await fs.readdir(tmpBase, { withFileTypes: true });
    for (const entry of tmpEntries) {
      if (!entry.isDirectory()) continue;
      if (!entry.name.startsWith("playwright_chromiumdev_profile-")) continue;
      const fullPath = path.join(tmpBase, entry.name);
      await fs.rm(fullPath, { recursive: true, force: true });
      deleted.push(fullPath);
    }
  } catch {
    // Temp cleanup is best effort; running browser profiles may refuse removal.
  }

  for (const dir of [uploadsDir, downloadsDir]) {
    try {
      await fs.mkdir(dir, { recursive: true });
      const entries = await fs.readdir(dir);
      for (const entry of entries) {
        const fullPath = path.join(dir, entry);
        await fs.rm(fullPath, { recursive: true, force: true });
        deleted.push(fullPath);
      }
    } catch {
      // Uploaded and downloaded literature files are best-effort cleanup targets.
    }
  }

  return deleted;
}

async function serveStatic(req, res) {
  const url = new URL(req.url, `http://127.0.0.1:${port}`);
  const requested = url.pathname === "/" ? "/index.html" : url.pathname;
  const filePath = path.normalize(path.join(publicDir, requested));
  if (!filePath.startsWith(publicDir)) {
    res.writeHead(403);
    res.end("Forbidden");
    return;
  }
  try {
    const data = await fs.readFile(filePath);
    const ext = path.extname(filePath);
    const type = ext === ".html" ? "text/html" : ext === ".css" ? "text/css" : "application/javascript";
    res.writeHead(200, { "content-type": `${type}; charset=utf-8` });
    res.end(data);
  } catch {
    res.writeHead(404);
    res.end("Not found");
  }
}

async function readBody(req) {
  const chunks = [];
  for await (const chunk of req) chunks.push(chunk);
  if (!chunks.length) return {};
  return JSON.parse(Buffer.concat(chunks).toString("utf8"));
}

const server = http.createServer(async (req, res) => {
  try {
    if (req.method === "POST" && req.url === "/api/open-doi") {
      const body = await readBody(req);
      const target = normalizeTarget(body.target);
      const downloadMode = body.preservePdfs ? "preserve_pdf" : "temporary";
      const reused = startOrReuseDoiTest(target, downloadMode);
      json(res, 200, { ok: true, target, reused });
      return;
    }

    if (req.method === "POST" && req.url === "/api/upload") {
      const files = await saveUploadedFiles(req);
      json(res, 200, { ok: true, files });
      return;
    }

    if (req.method === "GET" && req.url === "/api/version") {
      const version = (await fs.readFile(versionPath, "utf8")).trim();
      json(res, 200, { ok: true, version });
      return;
    }

    if (req.method === "POST" && req.url === "/api/open-codex") {
      spawn("open", ["-a", "Codex"], { detached: true, stdio: "ignore" }).unref();
      json(res, 200, { ok: true });
      return;
    }

    if (req.method === "POST" && req.url === "/api/cleanup") {
      const deleted = await cleanupTemporaryFiles();
      json(res, 200, { ok: true, deleted });
      return;
    }

    if (req.method === "POST" && req.url === "/api/shutdown") {
      stopDoiTest();
      const deleted = await cleanupTemporaryFiles();
      json(res, 200, { ok: true, deleted, shutdown: true });
      setTimeout(() => process.exit(0), 250);
      return;
    }

    await serveStatic(req, res);
  } catch (error) {
    json(res, 500, { ok: false, error: String(error.message || error) });
  }
});

server.listen(port, "127.0.0.1", async () => {
  const pidPath = path.join(projectRoot, ".research-console.pid");
  await Promise.all([
    fs.mkdir(downloadsDir, { recursive: true }),
    fs.mkdir(uploadsDir, { recursive: true }),
    fs.mkdir(outputPdfDir, { recursive: true }),
  ]);
  await fs.writeFile(pidPath, String(process.pid));
  console.log(`Research Console listening on http://127.0.0.1:${port}`);
});
