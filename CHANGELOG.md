# Changelog

## 0.5

- Added portable GitHub deployment support for cloned project paths.
- Reworked launcher/start/stop verification paths so another Mac can rebuild apps after clone.
- Added one-command install, doctor, Codex MCP config, and skill deployment workflow.

## 0.4

- Installed MarkItDown in the project `.venv` for local conversion of uploaded and downloaded literature files.
- Changed research-console and CloakBrowser guidance from download blocking to authorized temporary literature downloads under `downloads/`.
- Updated close cleanup to delete both uploaded files and downloaded external literature files.
- Added report-output guidance requiring a reusable ChatGPT deep-analysis prompt at the end of generated reports.

## 0.3

- Updated the close launcher workflow to delete uploaded temporary files under `uploads/`.
- Synchronized launcher source versions, app badge defaults, README version, and verification checks.
- Rebuilt launcher apps through executable command wrappers so local start/stop scripts remain the source of truth.

## 0.2

- Added unlimited-count, unrestricted-format source upload support to the ARS Research Console.
- Uploaded files are saved under `uploads/` and included in the generated ARS prompt with local paths.
- Added prompt guidance for AI to decide when microsoft/markitdown conversion is needed before analysis.
- Added uploaded manuscript workflow guidance for extension, reviewer simulation, draft revision, rebuttal drafting, and claim/reference checks.

## 0.1

- Added local ARS Research Console HTML interface.
- Updated launcher to open the Research Console.
- Updated closer to stop local services and clean temporary screenshots/logs.
- Added version governance: update `VERSION` on every project update, then rebuild and verify launchers.
