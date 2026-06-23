#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
NODE="${CODEX_NODE_PATH:-}"
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
PID_FILE="$PROJECT_ROOT/.research-console.pid"
LOG_FILE="$PROJECT_ROOT/.research-console.log"
URL="http://127.0.0.1:8765"

if [[ -z "$NODE" || ! -x "$NODE" ]]; then
  echo "Cannot find Node.js. Install Codex for Mac or set CODEX_NODE_PATH." >&2
  exit 1
fi

if [[ -f "$PID_FILE" ]]; then
  old_pid="$(cat "$PID_FILE" || true)"
  if [[ -n "$old_pid" ]] && kill -0 "$old_pid" 2>/dev/null; then
    open "$URL"
    exit 0
  fi
fi

cd "$PROJECT_ROOT"
nohup "$NODE" "$PROJECT_ROOT/app/research-console/server.js" >"$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"
sleep 1
open "$URL"
open -a Codex >/dev/null 2>&1 || true
