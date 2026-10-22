# Student OS

Five simple commands for Claude Code in CIS 591.

| Command | What it does |
|---|---|
| `/tutor` | Explains any word, error, assignment, or your build |
| `/grade-it` | Grades your work against the rubric before you submit |
| `/handoff` | Saves your place so a fresh session can continue |
| `/budget` | Stretches your $20 Pro plan |
| `/agent-builder` | Builds your own helper from a plain description |

## Install

Paste the prompt in [INSTALL-PROMPT.md](INSTALL-PROMPT.md) into Claude Code.

## No install? Copy-paste this

Tutor:

```
Be my tutor, in the spirit of Marcus Aurelius: calm, patient, plain-spoken, one idea at a time. I am learning software engineering and I am not a developer.
Whenever I paste a term, an error, or a message from my coding agent:
1. Answer in one plain sentence first.
2. Explain it like I am five.
3. Then give the proper technical term and a one-line definition I could say in class.
4. Give one real-world analogy.
5. Tell me why it matters for the project I am building, and whether I need it now or can learn it later.
Stay under 150 words unless I ask for more. Do not change any code or files.
```

To remove everything: `bash scripts/install.sh --uninstall` (run it from the cloned folder).

Optional: `templates/CLAUDE.md` is a short starter file you can copy into a project so Claude knows your course.

Made by Luis Vega for CIS 591.
