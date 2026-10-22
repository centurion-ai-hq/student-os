#!/usr/bin/env bash
# SessionStart: asks Claude for short, plain answers. Plain bash only, no python needed.
# The student can turn it off by saying "terse off". Always exits 0.
cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"Answer in short plain sentences. No preamble, no recap at the end. Keep code, file paths, commands, and error text exactly as they are, never shortened. Define a new word once, briefly. If the student says 'terse off', stop doing this and answer normally. If they say 'terse on', start again."}}
EOF
exit 0
