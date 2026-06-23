#!/usr/bin/env bash
set -euo pipefail

PATTERN='src/open-for-test.js'
HELPER_PATTERN='playwright_chromiumdev_profile-'

pids="$(pgrep -f "$PATTERN" || true)"
if [[ -z "$pids" ]]; then
  echo "No CloakBrowser test sessions are running."
else
  echo "Closing CloakBrowser test sessions: $pids"
  echo "$pids" | xargs -r kill
  sleep 2

  remaining="$(pgrep -f "$PATTERN" || true)"
  if [[ -n "$remaining" ]]; then
    echo "Force closing remaining sessions: $remaining"
    echo "$remaining" | xargs -r kill -9
  fi

  echo "Closed CloakBrowser test sessions."
fi

helper_pids="$(ps aux | awk -v pat="$HELPER_PATTERN" '$0 ~ pat && $0 !~ /awk/ {print $2}' || true)"
if [[ -n "$helper_pids" ]]; then
  echo "Closing orphan CloakBrowser Chromium helpers:"
  echo "$helper_pids"
  echo "$helper_pids" | xargs -r kill
  sleep 1
  remaining_helpers="$(ps aux | awk -v pat="$HELPER_PATTERN" '$0 ~ pat && $0 !~ /awk/ {print $2}' || true)"
  if [[ -n "$remaining_helpers" ]]; then
    echo "Force closing remaining orphan helpers:"
    echo "$remaining_helpers"
    echo "$remaining_helpers" | xargs -r kill -9
  fi
fi

echo "No launcher test sessions or orphan helpers remain."
