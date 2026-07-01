#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
VERSION="$(tr -d '[:space:]' < "$PROJECT_ROOT/VERSION")"
BRIDGE="$PROJECT_ROOT/mcp/cloakbrowser-research"
SOURCE="$PROJECT_ROOT/launchers/CloakBrowser Research Launcher.applescript"
APP="$PROJECT_ROOT/launchers/CloakBrowser Research Launcher.app"
CLOSE_SOURCE="$PROJECT_ROOT/launchers/Close CloakBrowser Research Sessions.applescript"
CLOSE_APP="$PROJECT_ROOT/launchers/Close CloakBrowser Research Sessions.app"
START_COMMAND="$PROJECT_ROOT/launchers/Start ARS Research Console.command"
CLOSE_COMMAND="$PROJECT_ROOT/launchers/Close ARS Research Console.command"
NODE="${CODEX_NODE_PATH:-}"
NPM="${CODEX_NPM_PATH:-}"
if [[ -z "$NODE" ]]; then
  for candidate in \
    "/Applications/Codex.app/Contents/Resources/cua_node/bin/node" \
    "$(command -v node 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      NODE="$candidate"
      break
    fi
  done
fi
if [[ -z "$NPM" ]]; then
  for candidate in \
    "/Applications/Codex.app/Contents/Resources/cua_node/bin/npm" \
    "$(command -v npm 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      NPM="$candidate"
      break
    fi
  done
fi
MARKITDOWN="$PROJECT_ROOT/.venv/bin/markitdown"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

[[ -x "$NODE" ]] || fail "Codex Node not executable: $NODE"
[[ -x "$NPM" ]] || fail "Codex npm not executable: $NPM"
[[ -x "$MARKITDOWN" ]] || fail "MarkItDown not executable: $MARKITDOWN"
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+$ ]] || fail "VERSION must use major.minor format, got: $VERSION"
[[ -d "$BRIDGE" ]] || fail "Missing bridge directory: $BRIDGE"
[[ -f "$BRIDGE/src/open-for-test.js" ]] || fail "Missing open-for-test.js"
[[ -f "$BRIDGE/src/server.js" ]] || fail "Missing server.js"
[[ -f "$PROJECT_ROOT/app/research-console/server.js" ]] || fail "Missing research console server"
[[ -f "$PROJECT_ROOT/app/research-console/public/index.html" ]] || fail "Missing research console HTML"
[[ -d "$PROJECT_ROOT/output_PDF" ]] || fail "Missing persistent PDF output directory"
[[ -f "$PROJECT_ROOT/output_PDF/.gitkeep" ]] || fail "output_PDF is missing .gitkeep"
[[ -f "$SOURCE" ]] || fail "Missing launcher source: $SOURCE"
[[ -d "$APP" ]] || fail "Missing launcher app. Run scripts/build-cloakbrowser-launcher.sh"
[[ -f "$CLOSE_SOURCE" ]] || fail "Missing close launcher source: $CLOSE_SOURCE"
[[ -d "$CLOSE_APP" ]] || fail "Missing close launcher app. Run scripts/build-cloakbrowser-launcher.sh"
[[ -x "$START_COMMAND" ]] || fail "Missing executable start command. Run scripts/build-cloakbrowser-launcher.sh"
[[ -x "$CLOSE_COMMAND" ]] || fail "Missing executable close command. Run scripts/build-cloakbrowser-launcher.sh"

"$NODE" --check "$BRIDGE/src/open-for-test.js"
"$NODE" --check "$BRIDGE/src/server.js"
"$NODE" --check "$PROJECT_ROOT/app/research-console/server.js"
"$MARKITDOWN" --version >/dev/null
smoke_output="$(cd "$BRIDGE" && PATH="$(dirname "$NODE"):$PATH" "$NPM" run smoke)"
grep -Fq 'set_download_policy' <<<"$smoke_output" || fail "MCP smoke output is missing set_download_policy"
grep -Fq 'attempt a legal PDF download for every paper listed in the report' "$BRIDGE/src/server.js" || fail "MCP tool description does not enforce per-paper PDF attempts"

grep -Fq 'start-research-console.sh' "$SOURCE" || fail "Launcher does not start Research Console"
grep -Fq 'stop-research-console.sh' "$CLOSE_SOURCE" || fail "Close launcher does not stop Research Console"
grep -Fq 'start-research-console.sh' "$START_COMMAND" || fail "Start command does not call start script"
grep -Fq 'stop-research-console.sh' "$CLOSE_COMMAND" || fail "Close command does not call stop script"
grep -Fq 'UPLOADS="$PROJECT_ROOT/uploads"' "$PROJECT_ROOT/scripts/stop-research-console.sh" || fail "Close script does not clean uploaded temporary files"
grep -Fq 'DOWNLOADS="$PROJECT_ROOT/downloads"' "$PROJECT_ROOT/scripts/stop-research-console.sh" || fail "Close script does not clean downloaded literature files"
grep -Fq 'for (const dir of [uploadsDir, downloadsDir])' "$PROJECT_ROOT/app/research-console/server.js" || fail "Console cleanup targets are not limited to temporary upload/download directories"
grep -Fq 'output_PDF/*' "$PROJECT_ROOT/.gitignore" || fail "output_PDF contents are not gitignored"
grep -Fq 'CLOAKBROWSER_BLOCK_FILE_DOWNLOADS=0' "$PROJECT_ROOT/app/research-console/server.js" || fail "Console DOI test does not allow literature downloads"
grep -Fq 'CLOAKBROWSER_DOWNLOAD_MODE=' "$PROJECT_ROOT/app/research-console/server.js" || fail "Console DOI test does not select a download policy"
grep -Fq '允許下載 PDF、Word、RIS、BibTeX' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing allow-download rule"
grep -Fq 'mode=preserve_pdf' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing preserved-PDF policy"
grep -Fq '每一篇列入 report 的文獻' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt does not force a PDF attempt for every report paper"
grep -Fq 'PDF 下載狀態' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing the per-paper PDF status field"
grep -Fq '未下載 — <原因>' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing explicit not-downloaded reasons"
grep -Fq 'mode=temporary' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing default temporary policy"
grep -Fq '「DOI / 文獻網址」欄位' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing the candidate-paper DOI/URL column"
grep -Fq 'https://doi.org/<DOI>' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing normalized DOI links"
grep -Fq '未取得 — <原因>' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing unresolved DOI/URL reasons"
grep -Fq '參考文獻清單誤抓' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing reference-list DOI safeguards"
grep -Fq '此文獻未提供足夠的機制證據' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing mechanism-summary evidence guardrail"
grep -Fq 'Nature Medicine、Nature 系列' "$PROJECT_ROOT/app/research-console/public/index.html" || fail "Console prompt is missing authorized subscription journal rule"
grep -Fq 'Nature Medicine, Nature family journals' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing authorized subscription journal rule"
grep -Fq 'output_PDF/' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing persistent PDF policy"
grep -Fq 'For every paper shown in the candidate table and final included list' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill does not force a PDF attempt for every report paper"
grep -Fq '`PDF 下載狀態`' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing the PDF status output contract"
grep -Fq '`未下載 — <reason>`' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing explicit not-downloaded reasons"
grep -Fq '`DOI / 文獻網址`' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing the candidate-paper DOI/URL contract"
grep -Fq 'Never guess a DOI or take a DOI from the paper' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing DOI integrity safeguards"
grep -Fq '`未取得 — <reason>`' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing unresolved DOI/URL reasons"
grep -Fq '此文獻未提供足夠的機制證據' "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" || fail "ARS skill is missing per-paper mechanism-summary guardrail"
cmp -s "$PROJECT_ROOT/codex/skills/ars-literature-workflow/SKILL.md" "${CODEX_HOME:-$HOME/.codex}/skills/ars-literature-workflow/SKILL.md" || fail "Installed ARS skill is not synchronized"
grep -Fq "toolVersion : \"$VERSION\"" "$SOURCE" || fail "Launcher source version is not $VERSION"
grep -Fq "toolVersion : \"$VERSION\"" "$CLOSE_SOURCE" || fail "Close launcher source version is not $VERSION"
grep -Fq "v$VERSION" "$PROJECT_ROOT/app/research-console/public/index.html" || fail "HTML version badge is not $VERSION"
grep -Fq "Version: $VERSION" "$BRIDGE/README.md" || fail "README version is not $VERSION"
grep -Fq "Version: $VERSION" "$PROJECT_ROOT/README.md" || fail "Root README version is not $VERSION"
grep -Fq "Version: $VERSION" "$PROJECT_ROOT/docs/WINDOWS_INSTALL.md" || fail "Windows README version is not $VERSION"
app_version="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist" 2>/dev/null || true)"
close_app_version="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$CLOSE_APP/Contents/Info.plist" 2>/dev/null || true)"
[[ "$app_version" == "$VERSION" ]] || fail "Launcher app bundle version is $app_version, expected $VERSION"
[[ "$close_app_version" == "$VERSION" ]] || fail "Close app bundle version is $close_app_version, expected $VERSION"

echo "OK: CloakBrowser Research Launcher v$VERSION is wired correctly."
