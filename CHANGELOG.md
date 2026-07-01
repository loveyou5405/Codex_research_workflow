# Changelog

## 0.9

- Changed the opt-in PDF preservation checkbox into a mandatory per-paper PDF acquisition workflow for every paper shown in the report.
- Required an actual download attempt through legal publisher, repository, or authorized institutional routes even when abstract, metadata, or HTML full text is already available.
- Added a required `PDF 下載狀態` field with verified `已下載` paths or explicit `未下載 — <reason>` results, plus downloaded/not-downloaded totals.

## 0.8

- Added an opt-in PDF preservation policy: detected literature PDFs can be retained under `output_PDF/`, while the default policy keeps all downloads temporary under `downloads/`.
- Added the `cloakbrowser_research.set_download_policy` tool and connected the HTML console plus manual DOI test flow to temporary versus preserved-PDF modes.
- Kept cleanup behavior safe by deleting `downloads/`, `uploads/`, screenshots, and conversion artifacts while never deleting `output_PDF/` or `reports/`.
- Added a default per-paper Traditional Chinese mechanism-summary prompt with explicit evidence and non-fabrication guardrails.

## 0.7

- Added explicit literature-search guidance to include authorized subscription journals and publisher pages, including high-impact venues such as Nature Medicine when topic-relevant.
- Added the same rule to the HTML Research Console prompt generator and installed ARS literature workflow skill.

## 0.6

- Added Windows PowerShell install, doctor, start, stop, and launcher wrapper scripts.
- Added Windows installation documentation for Codex MCP, skill, MarkItDown, and Research Console deployment.
- Updated README guidance so macOS and Windows clone workflows are both explicit.

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
