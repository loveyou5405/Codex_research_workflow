# CloakBrowser Research MCP

Version: 1.1

V1.1 keeps DOI checks in one reusable browser tab and adds migration-safe PMC PDF resolution through the current Cloud Service layout.

Small MCP bridge for using CloakBrowser as an authorized academic browsing backend.

This bridge is intended for cases where you already have legitimate access through a school network, VPN, institutional proxy, or library login. It does not solve CAPTCHAs, bypass subscriptions, or grant access to materials outside your license.

## Portable Install On macOS

From the repository root:

```bash
./scripts/install-portable.sh
```

The installer:

- installs MCP Node dependencies;
- creates `.venv` and installs MarkItDown;
- installs the `ars-literature-workflow` Codex skill;
- writes the `cloakbrowser_research` MCP block to `~/.codex/config.toml`;
- rebuilds the macOS launcher and closer apps for the current clone path;
- runs `scripts/doctor.sh` plus launcher verification.

Restart Codex after installation.

## Portable Install On Windows

From the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-portable.ps1
```

The Windows installer performs the same core deployment: MCP dependencies, `.venv`, MarkItDown, Codex skill install, `cloakbrowser_research` MCP config, and verification. Windows uses `.cmd` wrappers instead of macOS `.app` launchers.

Restart Codex after installation.

## Manual MCP Config

If you do not use the installer, add this block to `~/.codex/config.toml`, replacing `/path/to/repo` with this clone path:

```toml
[mcp_servers.cloakbrowser_research]
command = "/Applications/Codex.app/Contents/Resources/cua_node/bin/node"
args = ["/path/to/repo/mcp/cloakbrowser-research/src/server.js"]
startup_timeout_sec = 120

[mcp_servers.cloakbrowser_research.env]
CLOAKBROWSER_RESEARCH_AUTHORIZED = "1"
CLOAKBROWSER_HEADLESS = "false"
CLOAKBROWSER_HUMANIZE = "1"
CLOAKBROWSER_BLOCK_FILE_DOWNLOADS = "0"
# CLOAKBROWSER_PROXY = "http://user:pass@proxy.example.edu:8080"
# CLOAKBROWSER_GEOIP = "1"
```

Use `CLOAKBROWSER_HEADLESS=false` when publisher login, school SSO, or library proxy login requires visible browser interaction.

`CLOAKBROWSER_BLOCK_FILE_DOWNLOADS=0` allows authorized literature downloads. The default download policy is `temporary`, which stores files under `downloads/`. Call `set_download_policy` with `mode=preserve_pdf` when the user selects PDF preservation. In that mode, the research workflow must actively search for and attempt a legally accessible PDF download for every paper listed in the report. Detected PDFs are moved to `output_PDF/`; unsuccessful attempts must be reported as `未下載 — <reason>`, while non-PDF and conversion files stay temporary. The close workflow deletes `downloads/` and `uploads/` while retaining `output_PDF/` and `reports/`. Set `CLOAKBROWSER_BLOCK_FILE_DOWNLOADS=1` only when you explicitly want discovery-only browsing.

## One-Click Research Console

After macOS install, double-click:

```text
launchers/CloakBrowser Research Launcher.app
```

It opens the local HTML Research Console at `http://127.0.0.1:8765`. Use it to choose ARS modes, enter research topics, generate a ready-to-send Codex prompt, request per-paper Chinese mechanism summaries, open DOI tests through CloakBrowser, choose temporary downloads or preserved PDFs, and clean temporary screenshots/uploads/downloads.

On Windows, double-click:

```text
launchers\Start ARS Research Console.cmd
```

To close test sessions and clean temporary files on macOS, double-click:

```text
launchers/Close CloakBrowser Research Sessions.app
```

This stops the local Research Console, closes launcher test sessions started by `src/open-for-test.js`, and deletes temporary screenshots/logs, uploaded source files, and files under `downloads/`. It preserves `output_PDF/` and `reports/`. It does not stop Codex's MCP server process.

On Windows, double-click:

```text
launchers\Close ARS Research Console.cmd
```

## Verification

Run this any time after clone or after changing project files:

```bash
./scripts/doctor.sh
```

On Windows:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

When project files are updated, rebuild and verify launchers:

```bash
./scripts/build-cloakbrowser-launcher.sh
./scripts/verify-cloakbrowser-launcher.sh
```

The verification checks Node scripts, MCP smoke output, MarkItDown, launcher apps, cleanup behavior, download behavior, and version sync across `VERSION`, launchers, HTML, README, and app bundle metadata.

## Tools

- `set_download_policy`: choose `temporary` or `preserve_pdf` before downloading.
- `open_url`: reuse the current browser page/tab and navigate to the next URL.
- `resolve_pmc_pdf`: resolve the current PMC Cloud article-version PDF; during the 2026 transition it can correct a freshly returned OA package to the moved `deprecated` HTTPS path, extract the article PDF, and verify it.
- `get_text`: extract readable visible text.
- `screenshot`: save a screenshot under `outputs/`.
- `click`: click a CSS selector.
- `type_text`: type into a CSS selector.
- `close_session`: close the browser.

## Suggested ARS Workflow

Use `academic-research-suite` for protocol, review, synthesis, and citation integrity. Prefer this MCP throughout browser-backed source discovery, DOI resolution, publisher-page access, metadata extraction, screenshots, and authorization checks. When the user confirms legitimate school, library, VPN, institutional, or publisher access, include relevant subscription journals and publisher pages in discovery instead of limiting searches to open-access sources, including venues such as Nature Medicine, Nature family journals, The Lancet family, NEJM, Science, Cell, Wiley, Springer Nature, Elsevier, and society journals when topic-relevant.

Example prompt after restarting Codex:

```text
Use $academic-research-suite in deep-research lit-review mode.
Prefer cloakbrowser_research for the whole search and publisher-page workflow.
I have confirmed this is an authorized school network/session. Build a search
log. Do not limit discovery to open-access sources; actively check topic-relevant
subscription journals and publisher pages, including Nature Medicine, Nature
family journals, The Lancet family, NEJM, Science, Cell, Wiley, Springer Nature,
Elsevier, and society journals when appropriate. Before browsing, call
set_download_policy with mode=preserve_pdf. For every candidate and included
paper, record a verified `https://doi.org/<DOI>` link or official article URL,
then actively search for and attempt a legally accessible PDF download. Mark
the report row `已下載 — output_PDF/<filename>.pdf` only after verifying the
file exists; otherwise write `未下載 — <reason>`. Also add a brief Traditional
Chinese mechanism summary grounded in verified abstract or full-text evidence;
say when mechanistic evidence is insufficient.
Topic: ...
```

## MarkItDown Position

MarkItDown is installed in the project virtual environment:

```bash
.venv/bin/markitdown --version
```

Use it to convert downloaded or uploaded literature files before reading when a Markdown/text representation improves structure extraction:

```bash
.venv/bin/markitdown downloads/example.pdf -o downloads/example.md
```

Downloaded source files and MarkItDown conversion outputs under `downloads/` are temporary and must be deleted by the close workflow. When `mode=preserve_pdf` is explicitly selected, detected PDFs are retained under `output_PDF/`. Keep synthesized reports under `reports/`.

## Versioning Rule

- Current version is stored in the repository root `VERSION`.
- Small update: increment by `0.1`.
- Large update: increment by `1.0`.
- Every project update must rebuild and verify launchers.
