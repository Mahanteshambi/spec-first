#!/usr/bin/env bash
# Blocks `gh pr merge` when the PR touches a path listed in the project's
# .frame/gated-paths (one regex per line) and lacks the owner-approved label.
# No .frame/gated-paths file: the hook does nothing.
set -euo pipefail
input=$(cat)
cmd=$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))')
case "$cmd" in *"gh pr merge"*) ;; *) exit 0 ;; esac
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
gates="$root/.frame/gated-paths"
[ -f "$gates" ] || exit 0
pr=$(printf '%s' "$cmd" | sed -nE 's/.*gh pr merge[[:space:]]+([0-9]+).*/\1/p')
view=(gh pr view)
[ -n "$pr" ] && view+=("$pr")
labels=$("${view[@]}" --json labels --jq '[.labels[].name]|join(",")' 2>/dev/null || echo "")
case ",$labels," in *",owner-approved,"*) exit 0 ;; esac
files=$("${view[@]}" --json files --jq '.files[].path' 2>/dev/null || echo "")
hits=$(printf '%s\n' "$files" | grep -E -f <(grep -vE '^\s*(#|$)' "$gates") || true)
if [ -n "$hits" ]; then
  echo "claude-frame gate: this PR touches owner-gated paths and has no owner-approved label:" >&2
  printf '  %s\n' $hits >&2
  echo "Bring it to the owner with exact steps; never add the label yourself." >&2
  exit 2
fi
exit 0
