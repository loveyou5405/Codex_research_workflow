# ARS Research Console

Version: 1.0

Portable Codex literature-workflow project with:

- local HTML Research Console;
- macOS start/close launchers;
- `cloakbrowser_research` MCP server for authorized academic browsing;
- `ars-literature-workflow` Codex skill;
- MarkItDown support for uploaded/downloaded literature files;
- explicit inclusion of authorized subscription journals and publisher pages during literature search;
- optional forced per-paper PDF search/download with retained files under `output_PDF/` and explicit not-downloaded report statuses;
- mandatory verified DOI or official literature URL values for every candidate-paper row;
- a Traditional Chinese mechanism summary for every candidate and included paper;
- cleanup rules for temporary downloads, uploads, screenshots, and logs.

## Quick Install On A New Mac

Prerequisites:

- Codex desktop app installed;
- Python 3 available as `python3`;
- legitimate school, library, VPN, proxy, or publisher access if you use full-text browsing.

After cloning:

```bash
cd /path/to/文獻流程化專案
chmod +x scripts/*.sh
./scripts/install-portable.sh
```

Then restart Codex.

The installer writes the MCP config to `~/.codex/config.toml`, installs the local skill to `~/.codex/skills/ars-literature-workflow`, installs Node/Python dependencies, rebuilds the launchers for this clone path, and runs verification.

## Daily Use

Open:

```text
launchers/CloakBrowser Research Launcher.app
```

Close and clean temporary files:

```text
launchers/Close CloakBrowser Research Sessions.app
```

The console runs at:

```text
http://127.0.0.1:8765
```

## Verify Deployment

Run:

```bash
./scripts/doctor.sh
```

Expected ending:

```text
OK: portable deployment v1.0 is installed and verified.
```

## Quick Install On Windows

Prerequisites:

- Codex desktop app installed;
- Git installed;
- Node.js with `node` and `npm` available in PATH;
- Python 3 available as `python` or `py`.

After cloning:

```powershell
git clone https://github.com/loveyou5405/Codex_research_workflow.git
cd Codex_research_workflow
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-portable.ps1
```

Then restart Codex.

Verify:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

Expected ending:

```text
OK: Windows portable deployment v1.0 is installed and verified.
```

Windows start and stop wrappers:

```text
launchers\Start ARS Research Console.cmd
launchers\Close ARS Research Console.cmd
```

See [docs/WINDOWS_INSTALL.md](docs/WINDOWS_INSTALL.md) for details.

## GitHub Publishing Checklist

Before pushing:

```bash
./scripts/build-cloakbrowser-launcher.sh
./scripts/doctor.sh
git status --short
```

Commit source files, reports, scripts, launchers, `package.json`, `package-lock.json`, and `.gitkeep` files. Do not commit `.venv/`, `node_modules/`, `downloads/`, `output_PDF/` contents, `uploads/`, runtime logs, or temporary screenshots.

## Project Layout

- `app/research-console/`: local HTML console and API server.
- `mcp/cloakbrowser-research/`: MCP bridge for CloakBrowser.
- `codex/skills/ars-literature-workflow/`: skill copied into `~/.codex/skills`.
- `launchers/`: macOS launcher and closer app sources and generated apps.
- `scripts/install-portable.sh`: one-command deployment on a cloned machine.
- `scripts/install-portable.ps1`: one-command Windows deployment.
- `scripts/doctor.sh`: deployment health check.
- `scripts/doctor.ps1`: Windows deployment health check.
- `scripts/build-cloakbrowser-launcher.sh`: rebuild launcher apps for the current path.
- `reports/`: final research reports.
- `output_PDF/`: literature PDFs explicitly selected for permanent preservation.
- `downloads/`, `uploads/`, `mcp/cloakbrowser-research/outputs/`: temporary/runtime storage deleted by cleanup.

## Access And Safety

This project is for authorized academic research access only. It does not bypass subscriptions, CAPTCHAs, paywalls, or institutional access controls. The default `temporary` policy keeps downloaded literature under `downloads/` and deletes it during cleanup. If you select PDF preservation in the HTML console, the workflow must search for and attempt to download a legal PDF for every paper listed in the report. Detected PDFs are moved to `output_PDF/`; failed acquisitions are recorded as `未下載 — <reason>` in the report. Non-PDF files and MarkItDown conversion artifacts remain temporary. Cleanup never deletes `output_PDF/` or `reports/`.

When you have legitimate school, library, VPN, institutional, or publisher access, searches should include relevant subscription journals and publisher pages instead of limiting discovery to open-access sources. For suitable topics, explicitly check high-impact venues such as Nature Medicine, Nature family journals, The Lancet family, NEJM, Science, Cell, Wiley, Springer Nature, Elsevier, and society journals.

Candidate-paper tables must record a verified `https://doi.org/<DOI>` link for each paper. Papers without a DOI use a verified official article page; unresolved entries must state `未取得 — <reason>` rather than leaving the field blank.
