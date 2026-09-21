#!/usr/bin/env bash
# Managed by BosskuAI (`bossku hooks install`). Codex Stop/SessionEnd wrapper.
# Curated one-way Obsidian export, then continue JSON required by Codex Stop.
set -u
if [ -t 0 ]; then
  INPUT=""
else
  INPUT="$(cat || true)"
fi
run_sync() {
  if command -v bossku >/dev/null 2>&1; then
    if [ -n "$INPUT" ]; then printf '%s' "$INPUT" | bossku sync-hook; else bossku sync-hook </dev/null; fi
  else
    if [ -n "$INPUT" ]; then printf '%s' "$INPUT" | python3 -m bossku sync-hook; else python3 -m bossku sync-hook </dev/null; fi
  fi
}
run_sync >/dev/null 2>&1 || true
printf '%s\n' '{"continue": true}'
