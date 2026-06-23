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

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const DEFAULT_OUTPUT_DIR = path.resolve(__dirname, "..", "outputs");
const DEFAULT_DOWNLOAD_DIR = path.resolve(__dirname, "..", "..", "..", "downloads");

let browser = null;
let page = null;
let downloadsBlocked = false;
let downloadsSaved = false;

function textResult(text) {
  return { content: [{ type: "text", text }] };
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
      await fs.mkdir(DEFAULT_DOWNLOAD_DIR, { recursive: true });
      const safeName = path.basename(download.suggestedFilename() || "downloaded-literature-file");
      const outputPath = path.join(DEFAULT_DOWNLOAD_DIR, `${Date.now()}-${safeName}`);
      await download.saveAs(outputPath);
      console.error(`Saved download: ${outputPath}`);
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
    name: "open_url",
    description:
      "Open a URL in CloakBrowser for authorized academic research access through the user's institution, VPN, proxy, or existing network. Prefer this tool throughout literature search workflows.",
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
      "Click an element by CSS selector on the current page. File-like downloads are saved under the project downloads directory unless CLOAKBROWSER_BLOCK_FILE_DOWNLOADS=1.",
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
    case "open_url": {
      const activePage = await ensurePage();
      await activePage.goto(args.url, { waitUntil: args.waitUntil || "domcontentloaded" });
      return textResult(`Opened ${activePage.url()}\nTitle: ${await activePage.title()}`);
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

if (process.argv.includes("--smoke")) {
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
