import readline from "node:readline/promises";
import { stdin as input, stdout as output } from "node:process";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { launch } from "cloakbrowser";

const targetUrl = process.argv[2] || "https://scholar.google.com";
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const downloadsDir = path.resolve(__dirname, "..", "..", "..", "downloads");
const outputPdfDir = path.resolve(__dirname, "..", "..", "..", "output_PDF");
let browser = null;
let closing = false;

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

async function main() {
  if (process.env.CLOAKBROWSER_RESEARCH_AUTHORIZED !== "1") {
    throw new Error("Set CLOAKBROWSER_RESEARCH_AUTHORIZED=1 before testing.");
  }

  browser = await launch({
    headless: false,
    humanize: process.env.CLOAKBROWSER_HUMANIZE === "1",
    proxy: process.env.CLOAKBROWSER_PROXY || undefined,
    geoip: process.env.CLOAKBROWSER_GEOIP === "1",
  });

  const page = await browser.newPage();
  page.setDefaultTimeout(Number(process.env.CLOAKBROWSER_TIMEOUT_MS || 30000));

  if (process.env.CLOAKBROWSER_BLOCK_FILE_DOWNLOADS === "1") {
    page.on("download", async (download) => {
      console.log(`Blocked download: ${download.suggestedFilename()}`);
      await download.cancel();
    });

    await page.route("**/*", async (route) => {
      if (looksLikeDocumentDownload(route.request().url())) {
        console.log(`Blocked file-like URL: ${route.request().url()}`);
        await route.abort();
        return;
      }
      await route.continue();
    });
  } else {
    page.on("download", async (download) => {
      await fs.mkdir(downloadsDir, { recursive: true });
      const safeName = path.basename(download.suggestedFilename() || "downloaded-literature-file");
      const temporaryPath = path.join(downloadsDir, `${Date.now()}-${safeName}`);
      await download.saveAs(temporaryPath);
      if (
        process.env.CLOAKBROWSER_DOWNLOAD_MODE === "preserve_pdf" &&
        await isPdfFile(temporaryPath, safeName)
      ) {
        await fs.mkdir(outputPdfDir, { recursive: true });
        const pdfName = /\.pdf$/i.test(safeName) ? safeName : `${safeName}.pdf`;
        const outputPath = path.join(outputPdfDir, `${Date.now()}-${pdfName}`);
        await fs.rename(temporaryPath, outputPath);
        console.log(`Preserved PDF download: ${outputPath}`);
      } else {
        console.log(`Saved temporary download: ${temporaryPath}`);
      }
    });
  }

  await page.goto(targetUrl, { waitUntil: "domcontentloaded" });
  console.log(`Opened: ${page.url()}`);
  console.log(`Title: ${await page.title()}`);
  console.log("Use the visible browser window to test school login or paid-wall access.");
  console.log("Press Enter here to close the test browser.");

  const rl = readline.createInterface({ input, output });
  page.on("close", async () => {
    await cleanup("Browser page was closed.");
    process.exit(0);
  });
  await rl.question("");
  rl.close();
  await cleanup("Closed by terminal Enter.");
}

async function cleanup(reason) {
  if (closing) {
    return;
  }
  closing = true;
  if (reason) {
    console.log(reason);
  }
  if (browser) {
    await browser.close().catch(() => {});
    browser = null;
  }
}

process.on("SIGINT", () => {
  cleanup("Closed by SIGINT.").finally(() => process.exit(0));
});

process.on("SIGTERM", () => {
  cleanup("Closed by SIGTERM.").finally(() => process.exit(0));
});

main().catch((error) => {
  console.error(error);
  cleanup().finally(() => process.exit(1));
});
