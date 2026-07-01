# Windows Install

Version: 1.0

This project now includes a Windows deployment path that mirrors the macOS setup without AppleScript or `.app` launchers.

## Requirements

- Windows 10 or newer.
- Codex desktop app installed.
- Git installed.
- Node.js with `node` and `npm` available in PATH.
- Python 3 available as `python` or `py`.

## Clone

```powershell
git clone https://github.com/loveyou5405/Codex_research_workflow.git
cd Codex_research_workflow
```

## Install

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-portable.ps1
```

The installer:

- installs MCP Node dependencies;
- creates `.venv` and installs MarkItDown;
- copies `codex\skills\ars-literature-workflow` to `%USERPROFILE%\.codex\skills`;
- writes the `cloakbrowser_research` MCP block to `%USERPROFILE%\.codex\config.toml`;
- verifies Node syntax, MCP smoke output, MarkItDown, skill install, and config paths.

Restart Codex after the installer finishes.

## Verify

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

Expected ending:

```text
OK: Windows portable deployment v1.0 is installed and verified.
```

## Start And Stop

Double-click:

```text
launchers\Start ARS Research Console.cmd
```

The console opens at:

```text
http://127.0.0.1:8765
```

To stop and clean temporary files, double-click:

```text
launchers\Close ARS Research Console.cmd
```

## Notes

- Windows does not use the macOS `.app` launchers.
- Downloads remain temporary under `downloads\` unless the HTML console's PDF-preservation option is selected.
- When PDF preservation is selected, every report paper gets a legal PDF search/download attempt and a `PDF 下載狀態` value; unsuccessful attempts are reported as `未下載` with a reason.
- Preserved literature PDFs remain under `output_PDF\`; the close workflow never deletes this folder.
- Uploads remain temporary under `uploads\`.
- Final reports remain under `reports\`.
- Candidate-paper tables record a verified DOI link or official article URL for every row.
- If Codex uses a nonstandard config location, set `CODEX_HOME` before running the installer.
- If Node is not in PATH, set `CODEX_NODE_PATH` and `CODEX_NPM_PATH` before running the installer.
