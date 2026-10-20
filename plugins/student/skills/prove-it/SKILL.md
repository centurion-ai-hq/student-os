---
name: prove-it
description: "Runs the real checks and shows actual output before anyone says 'done'. Use when the student or Claude is about to say done, finished, working, fixed, passing, or when the student asks 'is it really done' or 'did it work'."
---

# Prove It

Nothing is "done" until you have seen it work.

## Do this
1. Find the project's check command (CLAUDE.md, package.json, or the README). Typical: `npm run check`, `npm test`, `npm run build`.
2. Run it. Show the real output, trimmed to the key lines.
3. If it is a web app, open the page and look at it. Say what you saw.
4. Report one line per check:
   • PASS: what ran, what it showed
   • FAIL: the error in plain English, and the fix
   • NOT RUN: why, and what the student should run
5. Only after that, say "done" or "not done".

## Rules
• Never say "tests pass" unless you saw them pass in this session.
• Never guess a number. If you did not run it, write NOT RUN.
• Do not skip or edit a failing test to get green. Fix the code.
• If a check takes very long, run the smallest one that proves the change, and say what you skipped.
• Keep the report under 10 lines.
