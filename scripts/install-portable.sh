#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
VERSION="$(tr -d '[:space:]' < "$PROJECT_ROOT/VERSION")"
CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG_FILE="$CONFIG_DIR/config.toml"
SKILL_SOURCE="$PROJECT_ROOT/codex/skills/ars-literature-workflow"
SKILL_TARGET="$CONFIG_DIR/skills/ars-literature-workflow"

find_node() {
  for candidate in \
    "${CODEX_NODE_PATH:-}" \
    "/Applications/Codex.app/Contents/Resources/cua_node/bin/node" \
    "$(command -v node 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

find_npm() {
  for candidate in \
    "${CODEX_NPM_PATH:-}" \
    "/Applications/Codex.app/Contents/Resources/cua_node/bin/npm" \
    "$(command -v npm 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

NODE="$(find_node || true)"
NPM="$(find_npm || true)"
if [[ -z "$NODE" || -z "$NPM" ]]; then
  echo "Cannot find Node.js/npm. Install Codex for Mac, install Node.js, or set CODEX_NODE_PATH and CODEX_NPM_PATH." >&2
  exit 1
fi

PYTHON="${PYTHON:-$(command -v python3 2>/dev/null || true)}"
if [[ -z "$PYTHON" || ! -x "$PYTHON" ]]; then
  echo "Cannot find python3. Install Python 3 first." >&2
  exit 1
fi

mkdir -p "$PROJECT_ROOT/downloads" "$PROJECT_ROOT/output_PDF" "$PROJECT_ROOT/uploads" "$PROJECT_ROOT/mcp/cloakbrowser-research/outputs"

echo "Installing MCP dependencies..."
(cd "$PROJECT_ROOT/mcp/cloakbrowser-research" && PATH="$(dirname "$NODE"):$PATH" "$NPM" install)

echo "Installing MarkItDown virtual environment..."
"$PYTHON" -m venv "$PROJECT_ROOT/.venv"
"$PROJECT_ROOT/.venv/bin/python" -m pip install --upgrade pip
"$PROJECT_ROOT/.venv/bin/python" -m pip install markitdown

echo "Installing Codex skill..."
mkdir -p "$CONFIG_DIR/skills"
rm -rf "$SKILL_TARGET"
cp -R "$SKILL_SOURCE" "$SKILL_TARGET"

echo "Writing Codex MCP config..."
mkdir -p "$CONFIG_DIR"
touch "$CONFIG_FILE"
cp "$CONFIG_FILE" "$CONFIG_FILE.bak.$(date +%Y%m%d%H%M%S)"
tmp_config="$(mktemp)"
awk '
  /^# BEGIN ARS_RESEARCH_CONSOLE_PORTABLE$/ { skip = 1; next }
  /^# END ARS_RESEARCH_CONSOLE_PORTABLE$/ { skip = 0; next }
  skip == 0 { print }
' "$CONFIG_FILE" > "$tmp_config"
cat >> "$tmp_config" <<CONFIG

# BEGIN ARS_RESEARCH_CONSOLE_PORTABLE
[mcp_servers.cloakbrowser_research]
command = "$NODE"
args = ["$PROJECT_ROOT/mcp/cloakbrowser-research/src/server.js"]
startup_timeout_sec = 120

[mcp_servers.cloakbrowser_research.env]
CLOAKBROWSER_RESEARCH_AUTHORIZED = "1"
CLOAKBROWSER_HEADLESS = "false"
CLOAKBROWSER_HUMANIZE = "1"
CLOAKBROWSER_BLOCK_FILE_DOWNLOADS = "0"
# CLOAKBROWSER_PROXY = "http://user:pass@proxy.example.edu:8080"
# CLOAKBROWSER_GEOIP = "1"
# END ARS_RESEARCH_CONSOLE_PORTABLE
CONFIG
mv "$tmp_config" "$CONFIG_FILE"

echo "Rebuilding launchers..."
CODEX_NODE_PATH="$NODE" CODEX_NPM_PATH="$NPM" "$PROJECT_ROOT/scripts/build-cloakbrowser-launcher.sh"

echo "Running doctor..."
CODEX_NODE_PATH="$NODE" CODEX_NPM_PATH="$NPM" PATH="$(dirname "$NODE"):$PATH" "$PROJECT_ROOT/scripts/doctor.sh"

echo "Installed ARS Research Console v$VERSION."
echo "Restart Codex so the cloakbrowser_research MCP server and ars-literature-workflow skill are loaded."
