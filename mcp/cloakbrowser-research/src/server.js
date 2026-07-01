import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { launch } from "cloakbrowser";
import * as tar from "tar";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const DEFAULT_OUTPUT_DIR = path.resolve(__dirname, "..", "outputs");
const DEFAULT_DOWNLOAD_DIR = path.resolve(__dirname, "..", "..", "..", "downloads");
const DEFAULT_PDF_OUTPUT_DIR = path.resolve(__dirname, "..", "..", "..", "output_PDF");

let browser = null;
let page = null;
let downloadsBlocked = false;
let downloadsSaved = false;
let downloadPolicy = "temporary";

function textResult(text) {
  return { content: [{ type: "text", text }] };
}

function decodeXml(value) {
  return String(value || "")
    .replaceAll("&amp;", "&")
    .replaceAll("&quot;", '"')
    .replaceAll("&apos;", "'")
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">");
}

function parseXmlAttributes(fragment) {
  const attributes = {};
  for (const match of fragment.matchAll(/([\w:-]+)\s*=\s*(["'])(.*?)\2/g)) {
    attributes[match[1]] = decodeXml(match[3]);
  }
  return attributes;
}

function normalizePmcid(value) {
  const match = String(value || "").trim().toUpperCase().match(/(?:PMC)?(\d+)/);
  if (!match) throw new Error("PMCID must look like PMC123456 or 123456.");
  return `PMC${match[1]}`;
}

function s3UriToHttps(value) {
  const match = String(value || "").match(/^s3:\/\/pmc-oa-opendata\/(.+?)(?:\?.*)?$/i);
  return match
    ? `https://pmc-oa-opendata.s3.amazonaws.com/${match[1].split("/").map(encodeURIComponent).join("/")}`
    : value;
}

function normalizeFreshOaUrl(value) {
  return String(value || "")
    .replace(/^ftp:\/\/ftp\.ncbi\.nlm\.nih\.gov\//i, "https://ftp.ncbi.nlm.nih.gov/")
    .replace(/\/pub\/pmc\/(oa_package|manuscript_package)\//i, "/pub/pmc/deprecated/$1/");
}

async function fetchText(url) {
  const response = await fetch(url, { headers: { "user-agent": "CodexResearchWorkflow/1.1" } });
  if (!response.ok) throw new Error(`${response.status} ${response.statusText} for ${url}`);
  return response.text();
}

async function resolvePmcPdf(pmcidInput, { skipCloud = false } = {}) {
  const pmcid = normalizePmcid(pmcidInput);
  const prefix = `${pmcid}.`;
  const listUrl = `https://pmc-oa-opendata.s3.amazonaws.com/?list-type=2&prefix=${encodeURIComponent(prefix)}`;
  const candidates = [];
  let metadata = null;

  if (!skipCloud) {
    try {
      const listing = await fetchText(listUrl);
      const keys = [...listing.matchAll(/<Key>(.*?)<\/Key>/g)].map((match) => decodeXml(match[1]));
      const versions = keys
        .map((key) => ({ key, match: key.match(new RegExp(`^${pmcid}\\.(\\d+)\\/${pmcid}\\.\\1\\.json$`)) }))
        .filter((item) => item.match)
        .sort((a, b) => Number(b.match[1]) - Number(a.match[1]));
      if (versions.length) {
        const metadataUrl = `https://pmc-oa-opendata.s3.amazonaws.com/${versions[0].key}`;
        metadata = JSON.parse(await fetchText(metadataUrl));
        if (metadata.is_pmc_openaccess && metadata.pdf_url) {
          candidates.push({
            source: "pmc_cloud",
            format: "pdf",
            url: s3UriToHttps(metadata.pdf_url),
            version: metadata.version,
            license: metadata.license_code || null,
          });
        }
      }
    } catch (error) {
      console.error(`PMC Cloud lookup failed for ${pmcid}: ${error.message || error}`);
    }
  }

  if (!candidates.length) {
    try {
      const oaUrl = `https://www.ncbi.nlm.nih.gov/pmc/utils/oa/oa.fcgi?id=${encodeURIComponent(pmcid)}`;
      const xml = await fetchText(oaUrl);
      const record = parseXmlAttributes(xml.match(/<record\b([^>]*)>/i)?.[1] || "");
      for (const match of xml.matchAll(/<link\b([^>]*)\/?\s*>/gi)) {
        const link = parseXmlAttributes(match[1]);
        const format = String(link.format || "").toLowerCase();
        if (!link.href || !["pdf", "tgz"].includes(format)) continue;
        const url = normalizeFreshOaUrl(link.href);
        if (!candidates.some((candidate) => candidate.url === url)) {
          candidates.push({
            source: format === "tgz" ? "fresh_oa_api_deprecated_package" : "fresh_oa_api",
            format,
            url,
            license: record.license || null,
          });
        }
      }
    } catch (error) {
      console.error(`Fresh PMC OA API lookup failed for ${pmcid}: ${error.message || error}`);
    }
  }

  return { pmcid, metadata, candidates };
}

async function downloadPmcPdf(resolution) {
  const failures = [];
  for (const candidate of resolution.candidates) {
    let archivePath = null;
    let extractionDir = null;
    try {
      const response = await fetch(candidate.url, { headers: { "user-agent": "CodexResearchWorkflow/1.1" } });
      if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
      const data = Buffer.from(await response.arrayBuffer());
      let pdfData = data;
      let rawName = path.basename(new URL(candidate.url).pathname) || `${resolution.pmcid}.pdf`;

      if (candidate.format === "tgz") {
        await fs.mkdir(DEFAULT_DOWNLOAD_DIR, { recursive: true });
        const token = `${Date.now()}-${process.pid}`;
        archivePath = path.join(DEFAULT_DOWNLOAD_DIR, `${token}-${resolution.pmcid}.tar.gz`);
        extractionDir = path.join(DEFAULT_DOWNLOAD_DIR, `${token}-${resolution.pmcid}`);
        await fs.writeFile(archivePath, data);
        await fs.mkdir(extractionDir, { recursive: true });
        await tar.extract({
          cwd: extractionDir,
          file: archivePath,
          strict: true,
          filter: (entryPath) => /\.pdf$/i.test(entryPath),
        });
        const discovered = [];
        const pending = [extractionDir];
        while (pending.length) {
          const current = pending.pop();
          for (const entry of await fs.readdir(current, { withFileTypes: true })) {
            const entryPath = path.join(current, entry.name);
            if (entry.isDirectory()) pending.push(entryPath);
            else if (/\.pdf$/i.test(entry.name)) discovered.push(entryPath);
          }
        }
        if (!discovered.length) throw new Error("OA package contains no PDF");
        const ranked = await Promise.all(discovered.map(async (filePath) => ({
          filePath,
          size: (await fs.stat(filePath)).size,
          preferred: path.basename(filePath).toUpperCase().startsWith(resolution.pmcid),
        })));
        ranked.sort((a, b) => Number(b.preferred) - Number(a.preferred) || b.size - a.size);
        pdfData = await fs.readFile(ranked[0].filePath);
        rawName = path.basename(ranked[0].filePath);
      }

      if (pdfData.subarray(0, 5).toString("ascii") !== "%PDF-") {
        throw new Error("resolved file is not a PDF");
      }
      const safeName = /\.pdf$/i.test(rawName) ? rawName : `${rawName}.pdf`;
      const destinationDir = downloadPolicy === "preserve_pdf" ? DEFAULT_PDF_OUTPUT_DIR : DEFAULT_DOWNLOAD_DIR;
      const destinationName = downloadPolicy === "preserve_pdf" ? safeName : `${Date.now()}-${safeName}`;
      await fs.mkdir(destinationDir, { recursive: true });
      const destination = path.join(destinationDir, destinationName);
      await fs.writeFile(destination, pdfData);
      return { ...candidate, path: destination, bytes: pdfData.length };
    } catch (error) {
      failures.push({ source: candidate.source, url: candidate.url, error: String(error.message || error) });
    } finally {
      if (archivePath) await fs.rm(archivePath, { force: true }).catch(() => {});
      if (extractionDir) await fs.rm(extractionDir, { recursive: true, force: true }).catch(() => {});
    }
  }
  return { failures };
}

function requireAuthorizedPurpose() {
  const value = process.env.CLOAKBROWSER_RESEARCH_AUTHORIZED;
  if (value !== "1" && value !== "true") {
    throw new Error(
      "Set CLOAKBROWSER_RESEARCH_AUTHORIZED=1 after confirming you are using authorized institutional access."
    );
  }
}

async function ensurePage(options = {}) {
  requireAuthorizedPurpose();

  if (!browser) {
    browser = await launch({
      headless: options.headless ?? process.env.CLOAKBROWSER_HEADLESS !== "false",
      humanize: process.env.CLOAKBROWSER_HUMANIZE === "1",
      proxy: process.env.CLOAKBROWSER_PROXY || undefined,
      geoip: process.env.CLOAKBROWSER_GEOIP === "1",
      args: process.env.CLOAKBROWSER_ARGS
        ? process.env.CLOAKBROWSER_ARGS.split(" ").filter(Boolean)
        : undefined,
    });
  }

  if (!page) {
    page = await browser.newPage();
    page.setDefaultTimeout(Number(process.env.CLOAKBROWSER_TIMEOUT_MS || 30000));
    await configurePage(page);
  }

  return page;
}

function shouldBlockFileDownloads() {
  return process.env.CLOAKBROWSER_BLOCK_FILE_DOWNLOADS === "1";
}

function normalizeDownloadPolicy(value) {
  return value === "preserve_pdf" ? "preserve_pdf" : "temporary";
}

async function isPdfFile(filePath, suggestedName) {
  if (/\.pdf$/i.test(suggestedName)) return true;
  const handle = await fs.open(filePath, "r");
  try {
    const header = Buffer.alloc(5);
    const { bytesRead } = await handle.read(header, 0, header.length, 0);
    return bytesRead === 5 && header.toString("ascii") === "%PDF-";
  } finally {
    await handle.close();
  }
}

async function saveLiteratureDownload(download) {
  await fs.mkdir(DEFAULT_DOWNLOAD_DIR, { recursive: true });
  const suggestedName = path.basename(download.suggestedFilename() || "downloaded-literature-file");
  const temporaryPath = path.join(DEFAULT_DOWNLOAD_DIR, `${Date.now()}-${suggestedName}`);
  await download.saveAs(temporaryPath);

  if (downloadPolicy !== "preserve_pdf" || !(await isPdfFile(temporaryPath, suggestedName))) {
    console.error(`Saved temporary download: ${temporaryPath}`);
    return;
  }

  await fs.mkdir(DEFAULT_PDF_OUTPUT_DIR, { recursive: true });
  const pdfName = /\.pdf$/i.test(suggestedName) ? suggestedName : `${suggestedName}.pdf`;
  const preservedPath = path.join(DEFAULT_PDF_OUTPUT_DIR, `${Date.now()}-${pdfName}`);
  await fs.rename(temporaryPath, preservedPath);
  console.error(`Preserved PDF download: ${preservedPath}`);
}

function looksLikeDocumentDownload(url) {
  try {
    const parsed = new URL(url);
    return /\.(pdf|doc|docx|xls|xlsx|ppt|pptx|zip|rar|7z|epub|ris|nbib|bib)(?:$|[?#])/i.test(
      parsed.pathname
    );
  } catch {
    return false;
  }
}

async function configurePage(activePage) {
  if (!shouldBlockFileDownloads()) {
    if (downloadsSaved) return;
    activePage.on("download", async (download) => {
      try {
        await saveLiteratureDownload(download);
      } catch (error) {
        console.error(`Download save failed: ${error.message || error}`);
      }
    });
    downloadsSaved = true;
    return;
  }

  if (downloadsBlocked) {
    return;
  }

  activePage.on("download", async (download) => {
    await download.cancel();
  });

  await activePage.route("**/*", async (route) => {
    const request = route.request();
    if (looksLikeDocumentDownload(request.url())) {
      await route.abort();
      return;
    }
    await route.continue();
  });

  downloadsBlocked = true;
}

async function closeSession() {
  if (browser) {
    await browser.close();
  }
  browser = null;
  page = null;
  downloadPolicy = "temporary";
}

async function getReadableText(activePage) {
  return activePage.evaluate(() => {
    const selectors = [
      "script",
      "style",
      "noscript",
      "svg",
      "canvas",
      "nav",
      "footer",
      "[aria-hidden='true']",
    ];
    const clone = document.body.cloneNode(true);
    for (const selector of selectors) {
      clone.querySelectorAll(selector).forEach((node) => node.remove());
    }
    return clone.innerText.replace(/\n{3,}/g, "\n\n").trim();
  });
}

const tools = [
  {
    name: "set_download_policy",
    description:
      "Choose whether authorized literature downloads are temporary or whether PDF files are preserved under output_PDF. With preserve_pdf, actively search for and attempt a legal PDF download for every paper listed in the report, then record either the verified file path or a not-downloaded reason. Non-PDF files always remain temporary.",
    inputSchema: {
      type: "object",
      properties: {
        mode: {
          type: "string",
          enum: ["temporary", "preserve_pdf"],
          description: "temporary saves all files under downloads; preserve_pdf requires per-report-paper PDF attempts and moves detected PDFs to output_PDF.",
        },
      },
      required: ["mode"],
    },
  },
  {
    name: "open_url",
    description:
      "Navigate the current reusable CloakBrowser page to a URL for authorized academic research access. Reuse this same session and tab for sequential DOI checks; do not open a new browser window for every paper.",
    inputSchema: {
      type: "object",
      properties: {
        url: { type: "string", description: "The URL to open." },
        waitUntil: {
          type: "string",
          enum: ["load", "domcontentloaded", "networkidle"],
          default: "domcontentloaded",
        },
      },
      required: ["url"],
    },
  },
  {
    name: "resolve_pmc_pdf",
    description:
      "Resolve a PMCID against the current PMC Cloud Service article-version dataset. During the 2026 transition, fall back only to a freshly queried OA API package whose moved deprecated path is corrected, then extract and verify its PDF. Optionally download under the active policy; never relies on a cached legacy FTP path.",
    inputSchema: {
      type: "object",
      properties: {
        pmcid: { type: "string", description: "PubMed Central ID, for example PMC3257301." },
        download: { type: "boolean", default: false, description: "Download and verify the resolved PDF when true." },
      },
      required: ["pmcid"],
    },
  },
  {
    name: "get_text",
    description:
      "Extract visible readable text from the current page. Use for bibliographic metadata, abstracts, and licensed pages the user is authorized to access.",
    inputSchema: {
      type: "object",
      properties: {
        maxChars: { type: "number", default: 12000 },
      },
    },
  },
  {
    name: "screenshot",
    description: "Save a screenshot of the current page for human verification.",
    inputSchema: {
      type: "object",
      properties: {
        fileName: { type: "string", default: "cloakbrowser-page.png" },
        fullPage: { type: "boolean", default: true },
      },
    },
  },
  {
    name: "click",
    description:
      "Click an element by CSS selector on the current page. Downloads follow set_download_policy unless CLOAKBROWSER_BLOCK_FILE_DOWNLOADS=1.",
    inputSchema: {
      type: "object",
      properties: {
        selector: { type: "string" },
      },
      required: ["selector"],
    },
  },
  {
    name: "type_text",
    description: "Type text into an input selected by CSS selector.",
    inputSchema: {
      type: "object",
      properties: {
        selector: { type: "string" },
        text: { type: "string" },
        submit: { type: "boolean", default: false },
      },
      required: ["selector", "text"],
    },
  },
  {
    name: "close_session",
    description: "Close the current CloakBrowser session.",
    inputSchema: { type: "object", properties: {} },
  },
];

async function callTool(name, args = {}) {
  switch (name) {
    case "set_download_policy": {
      downloadPolicy = normalizeDownloadPolicy(args.mode);
      const destination = downloadPolicy === "preserve_pdf"
        ? DEFAULT_PDF_OUTPUT_DIR
        : DEFAULT_DOWNLOAD_DIR;
      return textResult(
        `Download policy set to ${downloadPolicy}. Primary destination: ${destination}. ` +
        "Non-PDF files remain temporary under downloads." +
        (downloadPolicy === "preserve_pdf"
          ? " Workflow requirement: attempt a legally accessible PDF for every report paper and record either 已下載 with its output_PDF path or 未下載 with a reason."
          : "")
      );
    }
    case "open_url": {
      const activePage = await ensurePage();
      await activePage.goto(args.url, { waitUntil: args.waitUntil || "domcontentloaded" });
      return textResult(`Opened ${activePage.url()}\nTitle: ${await activePage.title()}`);
    }
    case "resolve_pmc_pdf": {
      requireAuthorizedPurpose();
      const resolution = await resolvePmcPdf(args.pmcid);
      const downloaded = args.download ? await downloadPmcPdf(resolution) : null;
      return textResult(JSON.stringify({
        pmcid: resolution.pmcid,
        title: resolution.metadata?.title || null,
        doi: resolution.metadata?.doi || null,
        license: resolution.metadata?.license_code || resolution.candidates[0]?.license || null,
        candidates: resolution.candidates,
        downloaded,
      }, null, 2));
    }
    case "get_text": {
      const activePage = await ensurePage();
      const maxChars = Number(args.maxChars || 12000);
      const text = await getReadableText(activePage);
      return textResult(text.slice(0, maxChars));
    }
    case "screenshot": {
      const activePage = await ensurePage();
      await fs.mkdir(DEFAULT_OUTPUT_DIR, { recursive: true });
      const safeName = path.basename(args.fileName || "cloakbrowser-page.png");
      const outputPath = path.join(DEFAULT_OUTPUT_DIR, safeName);
      await activePage.screenshot({ path: outputPath, fullPage: args.fullPage !== false });
      return textResult(outputPath);
    }
    case "click": {
      const activePage = await ensurePage();
      await activePage.click(args.selector);
      return textResult(`Clicked ${args.selector}`);
    }
    case "type_text": {
      const activePage = await ensurePage();
      await activePage.fill(args.selector, args.text);
      if (args.submit) {
        await activePage.press(args.selector, "Enter");
      }
      return textResult(`Typed into ${args.selector}`);
    }
    case "close_session": {
      await closeSession();
      return textResult("Closed CloakBrowser session.");
    }
    default:
      throw new Error(`Unknown tool: ${name}`);
  }
}

async function runSmoke() {
  console.log(JSON.stringify({ tools: tools.map((tool) => tool.name) }, null, 2));
}

async function runServer() {
  const server = new Server(
    {
      name: "cloakbrowser-research",
      version: "0.1.0",
    },
    {
      capabilities: {
        tools: {},
      },
    }
  );

  server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools }));
  server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const { name, arguments: args } = request.params;
    return callTool(name, args);
  });

  const transport = new StdioServerTransport();
  await server.connect(transport);
}

const resolveIndex = process.argv.findIndex((arg) => arg === "--resolve-pmc" || arg === "--download-pmc");
if (resolveIndex !== -1) {
  const shouldDownload = process.argv[resolveIndex] === "--download-pmc";
  downloadPolicy = normalizeDownloadPolicy(process.env.CLOAKBROWSER_DOWNLOAD_MODE);
  resolvePmcPdf(process.argv[resolveIndex + 1], {
    skipCloud: process.argv.includes("--force-oa"),
  }).then(async (result) => {
    const downloaded = shouldDownload ? await downloadPmcPdf(result) : null;
    console.log(JSON.stringify({ ...result, downloaded }, null, 2));
  }).catch((error) => {
    console.error(error);
    process.exit(1);
  });
} else if (process.argv.includes("--smoke")) {
  runSmoke().catch((error) => {
    console.error(error);
    process.exit(1);
  });
} else {
  runServer().catch((error) => {
    console.error(error);
    process.exit(1);
  });
}
