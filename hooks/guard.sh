#!/usr/bin/env bash
# PreToolUse(Bash): blocks only clearly destructive commands. Exit 2 = block.
# Works on macOS, Linux, and Git Bash. Uses python3 if present, else reads raw input.
input=$(cat)
cmd=""
if command -v python3 >/dev/null 2>&1; then
  cmd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
fi
[ -z "$cmd" ] && cmd=$(printf '%s' "$input" | sed -n 's/.*"command" *: *"\(.*\)".*/\1/p' | head -1)
[ -z "$cmd" ] && cmd="$input"

block() {
  echo "BLOCKED: $1 Tell the student in one plain sentence, and ask what they want instead. If they really want it, they should run it themselves in Terminal." >&2
  exit 2
}

# rm with a recursive flag (-r, -R, -rf, --recursive) aimed at: /, ~, $HOME, a user folder,
# or ONE folder directly inside home (like ~/Desktop). Deeper project folders are allowed.
T='(/|~|\$HOME|/(Users|home)(/[^/ ]+)?|(~|\$HOME)/[^/ ]+)(/|/?\*)?'
if printf '%s' "$cmd" | grep -Eq '(^|[;&|] *)(sudo +)?(/bin/|/usr/bin/)?rm +' \
  && printf '%s' "$cmd" | grep -Eq '(^| )(-[a-zA-Z]*[rR][a-zA-Z]*|--recursive)( |$)' \
  && printf '%s' "$cmd" | grep -Eq "( |\")${T}(\"| |\$)"; then
  block "this would delete your home folder or a main folder in it, and it cannot be undone."
fi
if printf '%s' "$cmd" | grep -Eq 'git +push[^;&|]* (--force|-f|--force-with-lease)( |$|[";])'; then
  block "a force push can erase your work on GitHub."
fi
if printf '%s' "$cmd" | grep -Eq 'git +reset +--hard'; then
  block "a hard reset throws away changes you have not saved."
fi
if printf '%s' "$cmd" | grep -Eq 'gh +repo +delete'; then
  block "this would delete a GitHub repo for good."
fi
exit 0
