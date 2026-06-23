#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
VERSION="$(tr -d '[:space:]' < "$PROJECT_ROOT/VERSION")"
CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG_FILE="$CONFIG_DIR/config.toml"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

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
[[ -n "$NODE" ]] || fail "Cannot find Node.js"
[[ -n "$NPM" ]] || fail "Cannot find npm"
[[ -x "$PROJECT_ROOT/.venv/bin/markitdown" ]] || fail "Missing .venv/bin/markitdown. Run scripts/install-portable.sh"
[[ -d "$PROJECT_ROOT/mcp/cloakbrowser-research/node_modules" ]] || fail "Missing MCP node_modules. Run scripts/install-portable.sh"
[[ -f "$CONFIG_FILE" ]] || fail "Missing Codex config: $CONFIG_FILE"
grep -Fq "[mcp_servers.cloakbrowser_research]" "$CONFIG_FILE" || fail "Codex config is missing cloakbrowser_research"
grep -Fq "$PROJECT_ROOT/mcp/cloakbrowser-research/src/server.js" "$CONFIG_FILE" || fail "Codex config points at a different clone path"
[[ -f "$CONFIG_DIR/skills/ars-literature-workflow/SKILL.md" ]] || fail "Missing installed Codex skill: ars-literature-workflow"

"$NODE" --check "$PROJECT_ROOT/app/research-console/server.js"
"$NODE" --check "$PROJECT_ROOT/mcp/cloakbrowser-research/src/server.js"
"$NODE" --check "$PROJECT_ROOT/mcp/cloakbrowser-research/src/open-for-test.js"
(cd "$PROJECT_ROOT/mcp/cloakbrowser-research" && PATH="$(dirname "$NODE"):$PATH" "$NPM" run smoke >/dev/null)
"$PROJECT_ROOT/.venv/bin/markitdown" --version >/dev/null

CODEX_NODE_PATH="$NODE" CODEX_NPM_PATH="$NPM" PATH="$(dirname "$NODE"):$PATH" "$PROJECT_ROOT/scripts/verify-cloakbrowser-launcher.sh"

echo "OK: portable deployment v$VERSION is installed and verified."
