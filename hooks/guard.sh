#!/usr/bin/env bash
# PreToolUse(Bash): blocks only clearly destructive commands. Exit 2 = block.
# Works on macOS, Linux, and Git Bash. Uses python3 if present, else reads raw input.
input=$(cat)
cmd=""
if command -v python3 >/dev/null 2>&1; then
  cmd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
fi
[ -z "$cmd" ] && cmd="$input"

block() {
  echo "BLOCKED: $1 Tell the student in one plain sentence, and ask what they want instead. Do not run it again unless they say so in chat." >&2
  exit 2
}

# rm -rf aimed at root, home, or a top-level folder (not a normal project subfolder)
HOMES='(Users|home)'   # where personal folders live on macOS and Linux
if printf '%s' "$cmd" | grep -Eq "rm +(-[a-zA-Z]*r[a-zA-Z]*f|-[a-zA-Z]*f[a-zA-Z]*r|-r +-f|-f +-r)[a-zA-Z]* +(\"?)(/|~|\\\$HOME|/${HOMES}|/${HOMES}/[^/ \"]+)(\"?/?)( |\$|\\*|\"|\\\\)"; then
  block "this would delete your whole home folder or drive, and it cannot be undone."
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
