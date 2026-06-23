# ARS Research Console

Version: 0.6

Portable Codex literature-workflow project with:

- local HTML Research Console;
- macOS start/close launchers;
- `cloakbrowser_research` MCP server for authorized academic browsing;
- `ars-literature-workflow` Codex skill;
- MarkItDown support for uploaded/downloaded literature files;
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
OK: portable deployment v0.6 is installed and verified.
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
OK: Windows portable deployment v0.6 is installed and verified.
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

Commit source files, reports, scripts, launchers, `package.json`, `package-lock.json`, and `.gitkeep` files. Do not commit `.venv/`, `node_modules/`, `downloads/`, `uploads/`, runtime logs, or temporary screenshots.

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
- `downloads/`, `uploads/`, `mcp/cloakbrowser-research/outputs/`: temporary/runtime storage.

## Access And Safety

This project is for authorized academic research access only. It does not bypass subscriptions, CAPTCHAs, paywalls, or institutional access controls. Temporary downloaded literature files should stay under `downloads/` and be deleted by the close workflow unless you intentionally preserve them outside the repository.
