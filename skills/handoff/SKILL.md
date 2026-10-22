---
name: handoff
description: "Saves a short NEXT-STEPS.md so a fresh session can resume cheaply. Use when the chat is getting long, the student says 'I have to stop', 'save my place', 'wrap up', 'new session', 'handoff', or before ending work."
---

# Handoff

A fresh session costs far less than a long one. Save your place, then start clean.

## Output rule
• Keep chat replies short. This skill writes one small markdown file, not a long report.
• Any longer explanation goes in a self-contained HTML file in a `learning-notes` folder next to the project (never inside a repo), bottom line first, no em dashes. Tell the student the path.

## Do this
1. Check the real state first: run `git status` and `git log --oneline -5`. Do not write from memory.
2. Write `NEXT-STEPS.md` in the project root (replace the old one). Use exactly these headings:

```
## Done
• what is finished, and how I know (a command that passed, a commit)

## Next
• the very next step, in one line

## Open questions
• anything I am stuck on or need to ask the instructor
```

3. Keep it under 25 lines. Plain words.
4. Do not commit it. It is for you, not for your submission. Tell the student where the file is.
5. Tell the student: "Start a new session and say: read NEXT-STEPS.md and continue."

## Rules
• Only list something as done if it was verified.
• Never put passwords, keys, or tokens in the file.
• Do not touch any other file.
