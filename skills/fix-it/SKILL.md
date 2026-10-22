---
name: fix-it
description: "Fixes a broken thing the careful way: read the whole error first, name the one file or function that is broken, fix only that, prove the fix by running the failing command again, and write a short bug note. Stops and reports after two failed attempts. Use when you say 'it's broken', 'this isn't working', 'I got an error', 'why did it break', 'fix this', 'it worked yesterday', or paste an error message or a failing test."
argument-hint: "[the error text, or the command that fails]"
---

# Fix It

A broken thing is the worst moment to let an AI wander around your project. This skill keeps the fix small, proven, and written down. The most common way students lose a night: they guess before they read, change five things at once, and cannot tell which change mattered.

New words, defined once: a blast radius is everything one change could affect. A repro (reproduction) is making the failure happen on purpose, on demand. A hypothesis is your best guess about the cause, which is not yet a fact.

## Output rule
• Short answers stay in chat.

• Longer than about 15 lines? Write ONE self-contained HTML file in a `learning-notes` folder next to the current project (never inside a repo). Bottom line first, mostly tables, works offline, light and dark, phone friendly, no em dashes.

• Then tell the student the file path. The bug note (step 7) always goes there, as a short HTML file or a short chat block if it fits in 15 lines.

## Model routing
• All the fixing stays on Sonnet. Do not switch models for debugging; more thinking is not the missing ingredient, more reading is.

• Searching the project for where a function is used, listing files, or reading long logs goes to ONE helper subagent with `model: haiku`.

• The independent check (step 6) uses a SEPARATE fresh helper with `model: haiku` that has no memory of the fix. That is the one allowed helper for checking. Never fan out many agents. Never loop.

• Opus is not needed for this skill.

## Steps
1. **Capture the whole error.** Run the failing command and save the complete output to a file in the scratchpad or a temp spot outside the repo. Read ALL of it, top to bottom. The reason for a failure is usually at the top and the repeated symptoms pile up under it, so never cut it with `tail` and never judge from the last line alone. Quote the exact error text back to the student before saying what it means. If a theory pops into your head first, write it down and set it aside; it is a hypothesis, not a finding.

2. **Make it fail again.** Reproduce it. If you cannot make it fail twice, the status is BLOCKED: tell the student what you tried and stop. Fixing something you cannot reproduce is guessing.

3. **Freeze the blast radius.** Name the ONE file and ONE function (or the one config line) that is broken. Write two lists out loud:
   • IN SCOPE: the single file or function to change.

   • PROTECTED: everything else, including every test file and the assignment spec. Not touched.
   Before any edit, note a way back: if the project uses git, run `git status` and `git diff` to see the starting point; if not, copy the in-scope file to a backup name first. Never edit something that has no second copy.

4. **State the cause in one sentence.** "The function crashes because it assumes the list is never empty." If you cannot say it in one plain sentence, you have not found it yet; keep reading, do not start editing to see what happens. Before editing, search for every place the broken function is used. A fix in the wrong place is a second bug.

5. **Fix only that.** One logical change, nothing else. No renames, no tidy-ups, no "while I am here." If you spot a second, unrelated bug, write it in the bug note and leave it alone.
   • Change ONE thing per attempt and say what it is before you run anything.

   • **Two-attempt rule.** If an attempt fails, form a CHANGED hypothesis (a different theory, backed by something new you read or measured) and try once more. If that also fails, STOP. Do not try a third time. Report: the exact error, both hypotheses, what each attempt changed, what you ruled out, and what you would check next. Repeating the same idea with small tweaks is hope, not debugging.

6. **Prove it.** Run the exact command that failed at the start, the same way, in the same place. Show the passing output to the student. Then start ONE fresh helper (`model: haiku`) with only: the command, the original error text, and the in-scope file name. It runs the command itself and reports PASS, FAIL, or UNSURE with the output it saw. Also run `git diff` (or compare to your backup) and confirm only the in-scope file changed. If the helper says anything but PASS, you are not done.

7. **Write the bug note.** Five lines, no more:

```
BUG NOTE
What broke: (one line, plain words)
Cause: (the one sentence from step 4)
Fix: (file and function, what changed)
Proof: (the command, and PASS as the helper saw it)
Watch for: (how to spot this shape next time)
```

## Rules
• Never edit tests, the assignment spec, or the rubric to make a failure go away. If a test seems wrong, say so and let the student decide.

• Never delete a failing check, comment it out, or add code that special-cases the test.

• Never claim "fixed" without the passing output in front of you from this session.

• Never touch anything outside IN SCOPE. Widening the scope is a different job; stop and ask.

• Never run risky cleanup commands (hard reset, force push, deleting folders) to "start fresh."

• Never print or read a password or key. If the error mentions one, say "a key is involved" and ask the student to check it themselves.

• Explain any new word in one plain line.

## Example
Student: /fix-it My script crashes. Here is the error: `TypeError: cannot unpack non-iterable NoneType object` on line 42 of report.py.

Fix-it: I ran it and saved the full output. Top line, exactly: "TypeError: cannot unpack non-iterable NoneType object", from report.py line 42, called from `load_rows()`. I reproduced it twice.
• IN SCOPE: `load_rows()` in report.py. PROTECTED: everything else, all tests.
• Cause: `load_rows()` returns nothing when the file is empty, and line 42 expects two values.
• Fix: return an empty pair when the file is empty. One line changed.
• Proof: `python report.py data.csv` now prints the report, no error. A fresh helper ran it too: PASS. `git diff` shows only report.py changed.
```
BUG NOTE
What broke: report crashed on an empty data file
Cause: load_rows() returned None when empty
Fix: report.py load_rows() now returns an empty pair
Proof: python report.py data.csv, PASS
Watch for: "NoneType" errors usually mean a function forgot to return something
```
