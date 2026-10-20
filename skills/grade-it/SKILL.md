---
name: grade-it
description: "Grades the student's work against the assignment rubric before they submit it. Use when the student says 'grade it', 'grade my work', 'check my work', 'am I ready to submit', 'will this pass', 'what score would I get', or is about to hand in an assignment."
argument-hint: "[assignment or rubric file, optional]"
---

# Grade It

Be the strict grader the student will meet, but before the deadline. Report only what you actually saw.

## Output rule
• Short answers stay in chat.
• Longer than about 15 lines? Write ONE self-contained HTML file in a `learning-notes` folder next to the current project (never inside a repo). Bottom line first, mostly tables, works offline, light and dark, phone friendly, no em dashes.
• Then tell the student the file path.

## Do this
1. **Find the rubric.** Look for the assignment spec, rubric, or instructions (specs folder, README, CLAUDE.md, course files). If you cannot find one, ask the student to paste it. Do not guess the criteria.
2. **Run the real checks.** Find the project's check or test commands (CLAUDE.md or package.json) and run them. For a web app, open the page and look.
3. **Grade each criterion** from what you saw.
4. **Report, bottom line first:**

```
Estimated score: 82 / 100. Ready to submit? Not yet.
```

| Criterion | Points | Result | Evidence |
|---|---|---|---|
| Name from the rubric | 10 | PASS, FAIL, or UNSURE | the real output or file you checked |

5. **Top 3 fixes**, in priority order: biggest points first, each in one line.
6. Offer to fix them one at a time. Do not start until the student says yes.

## Rules
• PASS needs evidence you saw in this session. No evidence means UNSURE.
• Never claim a pass you did not see. Never guess a number.
• Never edit tests, the specs folder, or rubric files.
• Failed check? Show the key error lines, not the whole log.
• Explain any new word in one plain line.
