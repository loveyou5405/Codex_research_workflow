#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PID_FILE="$PROJECT_ROOT/.research-console.pid"
LOG_FILE="$PROJECT_ROOT/.research-console.log"

"$PROJECT_ROOT/scripts/close-cloakbrowser-test-sessions.sh" || true

OUTPUTS="$PROJECT_ROOT/mcp/cloakbrowser-research/outputs"
UPLOADS="$PROJECT_ROOT/uploads"
DOWNLOADS="$PROJECT_ROOT/downloads"
if [[ -d "$OUTPUTS" ]]; then
  find "$OUTPUTS" -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.webp' -o -name '*.log' -o -name '*.tmp' \) -delete
fi
if [[ -d "$UPLOADS" ]]; then
  find "$UPLOADS" -mindepth 1 -delete
fi
if [[ -d "$DOWNLOADS" ]]; then
  find "$DOWNLOADS" -mindepth 1 -delete
fi

if [[ -f "$PID_FILE" ]]; then
  pid="$(cat "$PID_FILE" || true)"
  if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
    kill "$pid" || true
    sleep 1
    kill -9 "$pid" 2>/dev/null || true
  fi
  rm -f "$PID_FILE"
fi

rm -f "$LOG_FILE"
echo "Research Console stopped and temporary files cleaned. reports/ and output_PDF/ were preserved."
