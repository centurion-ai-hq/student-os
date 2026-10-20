#!/usr/bin/env bash
# Student OS installer. Copies skills and hooks, merges two hook lines into settings.json.
# Usage:
#   bash scripts/install.sh --all
#   bash scripts/install.sh --skills tutor,grade-it --hooks welcome,guard
#   bash scripts/install.sh --all --none-hooks
#   bash scripts/install.sh --uninstall
set -u

SRC="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
HOOKS_DIR="$CLAUDE_DIR/student-os/hooks"
SETTINGS="$CLAUDE_DIR/settings.json"
MARK=".student-os"
ALL_SKILLS="tutor grade-it handoff budget agent-builder"
ALL_HOOKS="welcome guard"
TS="$(date +%Y%m%d-%H%M%S)"

skills=""; hooks=""; uninstall=0; none_hooks=0

die() { echo "Error: $1" >&2; exit 1; }
split() { printf '%s' "$1" | tr ',' ' '; }

while [ $# -gt 0 ]; do
  case "$1" in
    --all) skills="$ALL_SKILLS"; hooks="$ALL_HOOKS" ;;
    --skills) shift; [ $# -gt 0 ] || die "--skills needs a list"
              if [ "$1" = all ]; then skills="$ALL_SKILLS"; elif [ "$1" = none ]; then skills=""; else skills="$(split "$1")"; fi ;;
    --hooks)  shift; [ $# -gt 0 ] || die "--hooks needs a list"
              if [ "$1" = all ]; then hooks="$ALL_HOOKS"; elif [ "$1" = none ]; then hooks=""; else hooks="$(split "$1")"; fi ;;
    --none-hooks) none_hooks=1 ;;
    --uninstall) uninstall=1 ;;
    -h|--help) sed -n '2,7p' "$0"; exit 0 ;;
    *) die "unknown option $1 (try --all)" ;;
  esac
  shift
done
[ "$none_hooks" = 1 ] && hooks=""
if [ "$uninstall" = 0 ] && [ -z "$skills" ] && [ -z "$hooks" ]; then
  die "nothing chosen. Use --all, or --skills a,b --hooks c,d"
fi
[ "$uninstall" = 1 ] && [ -z "$skills" ] && skills="$ALL_SKILLS"
[ "$uninstall" = 1 ] && [ -z "$hooks" ] && hooks="$ALL_HOOKS"

for s in $skills; do case " $ALL_SKILLS " in *" $s "*) ;; *) die "unknown skill: $s" ;; esac; done
for h in $hooks;  do case " $ALL_HOOKS "  in *" $h "*)  ;; *) die "unknown hook: $h"  ;; esac; done

# Find a working python (python3, python, or py on Windows).
PY=""
for c in python3 python py; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import json' >/dev/null 2>&1; then PY="$c"; break; fi
done

# Merge or remove hook lines in settings.json. Never touches other keys.
settings_edit() {  # $1 = install | uninstall, $2 = comma list of hooks
  "$PY" - "$1" "$SETTINGS" "$TS" "$HOOKS_DIR" "$2" <<'PYEOF'
import json, os, shutil, sys
mode, path, ts, hdir, want = sys.argv[1:6]
want = [w for w in want.split(",") if w]
SPEC = {"welcome": ("SessionStart", None, "welcome.sh"),
        "guard": ("PreToolUse", "Bash", "guard.sh")}
MARK = "student-os/hooks/"

data = {}
if os.path.exists(path):
    raw = open(path, encoding="utf-8").read()
    if raw.strip():
        try:
            data = json.loads(raw)
        except Exception:
            print("settings.json is not valid JSON, so I did not touch it.")
            sys.exit(3)
    if not isinstance(data, dict):
        print("settings.json is not a JSON object, so I did not touch it.")
        sys.exit(3)
before = json.dumps(data, sort_keys=True)

def has(arr, fn):
    return any(MARK + fn in h.get("command", "")
               for g in arr if isinstance(g, dict)
               for h in g.get("hooks", []) if isinstance(h, dict))

if mode == "install":
    for name in want:
        event, matcher, fn = SPEC[name]
        arr = data.setdefault("hooks", {}).setdefault(event, [])
        if has(arr, fn):
            continue
        group = {"hooks": [{"type": "command",
                            "command": 'bash "%s/%s"' % (hdir, fn),
                            "timeout": 5}]}
        if matcher:
            group = dict([("matcher", matcher)] + list(group.items()))
        arr.append(group)
else:
    hooks = data.get("hooks")
    if isinstance(hooks, dict):
        for name in want:
            event, matcher, fn = SPEC[name]
            arr = hooks.get(event)
            if not isinstance(arr, list):
                continue
            keep = []
            for g in arr:
                if isinstance(g, dict) and isinstance(g.get("hooks"), list):
                    g["hooks"] = [h for h in g["hooks"]
                                  if not (isinstance(h, dict) and MARK + fn in h.get("command", ""))]
                    if not g["hooks"]:
                        continue
                keep.append(g)
            if keep:
                hooks[event] = keep
            else:
                del hooks[event]
        if not hooks:
            del data["hooks"]

if json.dumps(data, sort_keys=True) == before:
    print("settings: already up to date")
    sys.exit(0)
if os.path.exists(path):
    shutil.copy2(path, path + ".bak-studentos-" + ts)
os.makedirs(os.path.dirname(path), exist_ok=True)
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print("settings: updated (backup saved)" if os.path.exists(path + ".bak-studentos-" + ts) else "settings: created")
PYEOF
}

print_manual() {
  echo "Python was not found, so I did not edit settings.json."
  echo "Open $SETTINGS and add this (merge it into any existing \"hooks\" section):"
  echo '{ "hooks": {'
  first=1
  for h in $hooks; do
    [ "$first" = 1 ] || echo ','
    first=0
    case "$h" in
      welcome) printf '  "SessionStart": [ { "hooks": [ { "type": "command", "command": "bash \\"%s/welcome.sh\\"", "timeout": 5 } ] } ]' "$HOOKS_DIR" ;;
      guard)   printf '  "PreToolUse": [ { "matcher": "Bash", "hooks": [ { "type": "command", "command": "bash \\"%s/guard.sh\\"", "timeout": 5 } ] } ]' "$HOOKS_DIR" ;;
    esac
  done
  echo; echo '} }'
}

if [ "$uninstall" = 1 ]; then
  removed_s=""; removed_h=""
  for s in $skills; do
    if [ -f "$SKILLS_DIR/$s/$MARK" ]; then rm -f "$SKILLS_DIR/$s/SKILL.md" "$SKILLS_DIR/$s/$MARK"; rmdir "$SKILLS_DIR/$s" 2>/dev/null; removed_s="$removed_s $s"; fi
  done
  for h in $hooks; do
    if [ -f "$HOOKS_DIR/$h.sh" ]; then rm -f "$HOOKS_DIR/$h.sh"; removed_h="$removed_h $h"; fi
  done
  rmdir "$HOOKS_DIR" "$CLAUDE_DIR/student-os" 2>/dev/null
  if [ -f "$SETTINGS" ]; then
    if [ -n "$PY" ]; then settings_edit uninstall "$(printf '%s' "$hooks" | tr ' ' ',')"; else echo "Python not found: remove the two Student OS lines from $SETTINGS by hand."; fi
  fi
  echo "Student OS removed."
  echo "  skills:${removed_s:- none}"
  echo "  hooks: ${removed_h:- none}"
  exit 0
fi

# ---- install ----
mkdir -p "$SKILLS_DIR"
done_s=""; skipped_s=""
for s in $skills; do
  dest="$SKILLS_DIR/$s"
  if [ -e "$dest" ] && [ ! -f "$dest/$MARK" ]; then
    skipped_s="$skipped_s $s"; continue
  fi
  mkdir -p "$dest"
  cp "$SRC/skills/$s/SKILL.md" "$dest/SKILL.md"
  : > "$dest/$MARK"
  done_s="$done_s $s"
done

done_h=""; hook_note=""
if [ -n "$hooks" ]; then
  mkdir -p "$HOOKS_DIR"
  for h in $hooks; do
    cp "$SRC/hooks/$h.sh" "$HOOKS_DIR/$h.sh"
    chmod +x "$HOOKS_DIR/$h.sh"
    done_h="$done_h $h"
  done
  if [ -n "$PY" ]; then
    settings_edit install "$(printf '%s' "$hooks" | tr ' ' ',')" || { echo "Hooks were copied but settings.json was not changed."; hook_note=" (copied, NOT switched on)"; }
  else
    print_manual; hook_note=" (copied, NOT switched on: paste the JSON above)"
  fi
fi

echo "Student OS installed."
echo "  skills:${done_s:- none}"
[ -n "$skipped_s" ] && echo "  skipped (you already have one with that name):$skipped_s"
echo "  hooks: ${done_h:- none}$hook_note"
case " $done_s " in *" tutor "*) echo "Start a new session, then type /tutor" ;; *) echo "Start a new session." ;; esac
exit 0
