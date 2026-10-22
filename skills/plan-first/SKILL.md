---
name: plan-first
description: "Stops Claude from building the wrong thing. Forces three phases for any build bigger than a quick fix: Research (read only, no edits), Plan (numbered steps with files and checks, then waits for your yes), Implement (one step at a time with a check after each, nothing committed without asking). Also tells you when to compact the chat to save your plan usage. Use when you say 'plan first', 'plan this', 'before you build', 'break this down', 'how should we build this', 'big assignment', 'don't just start coding', or hand over a build with several parts."
argument-hint: "[the build or assignment, or a phase: research | plan | implement]"
---

# Plan first

Most wasted time on a build comes from starting before understanding. A builder does not pour concrete before reading the blueprint. This skill makes the work go in three phases with a stop sign between each, so you catch a wrong turn when it costs one sentence, not one afternoon.

Skip this skill for tiny jobs (a typo, one color, one line). It only pays off when the work touches several files or you could get it wrong.

## Output rule
• Short answers stay in chat. Phase updates are a few lines.
• The research notes and the plan together go in ONE self-contained HTML file, `~/learning-notes/<task-name>-plan.html`, in `~/learning-notes` (never inside a repo). Bottom line first, a table for the steps, works offline, light and dark mode, phone friendly, no em dashes. Update the same file at each phase; do not make new ones. Tell the student the path.

## Model routing
• All three phases run on Sonnet by default.
• Reading and searching many files goes to ONE helper with `model: haiku`. One helper at a time, never several in parallel. It returns file names and short facts, not opinions.
• Opus is allowed ONLY for the Plan phase, ONLY when the task is big or risky, and ONLY after you ask. Big or risky means: touches 5 or more files, deletes or renames things, changes login, data, or money logic, or is a large share of your grade. Ask exactly: "This plan is big or risky. Switch to Opus just for planning? It uses more of your plan. Yes or no?" If yes, tell the student to type `/model opus` now and `/model sonnet` after the plan is approved (you cannot switch models yourself). If no, stay on Sonnet.

## Steps

### Phase 1: Research (read only)
1. Say "Phase 1: Research. I will only read, not change anything."
2. Restate the goal in one line and ask up to three questions that would change the work (what counts as done, what is off limits, the deadline). Then stop asking.
3. Read what matters: the assignment or rubric, `README`, folder layout, the files likely to change, `git log --oneline -10`. For a big project, hand this to the haiku helper.
4. Write findings into the HTML file under "What I found": how the project is laid out, what already exists, what is missing, anything surprising, and what you could NOT find. Facts only. No design yet.
5. Edit nothing. No installs, no formatting, no "quick fixes". Reading commands only.
6. Compaction point (advice below), then move on.

### Phase 2: Plan (numbered steps, then STOP)
1. Say "Phase 2: Plan." Write a numbered list of steps in the HTML file as a table with four columns:
   • **Step**: one small action in plain words.
   • **Files touched**: exact names, and whether each is new or changed.
   • **How I will check it**: a real command or a thing the student can see (for example "run `npm test`, expect 0 failures" or "open the page, the button shows").
   • **Risk**: low, medium, high, with a reason if not low.
2. Rules for good steps: each one is small enough to check on its own; order by what depends on what; the first step gives something that runs end to end, even if ugly (a thin working path first, polish later); no step says "etc." or "make it work".
3. Add three short lines: what is NOT in this plan, what could go wrong, and how to undo the whole thing.
4. Check the plan against the original ask. Every requirement in the assignment must appear in some step. Say which are missing.
5. STOP. Say: "Plan is in [path]. Say yes to start, or tell me what to change." Do not edit any project file until the student says yes in chat. If they change something, update the plan and ask again.

### Phase 3: Implement (one step at a time)
1. After the yes, say "Phase 3: Implement." Take step 1 only.
2. Do the step. Run its check. Show the real result (the command and what it printed). If it fails, fix that step before moving on; do not stack steps on a broken one.
3. Mark the step done in the plan table only after the check passed. Then one line to the student ("Step 2 of 6 done, check passed. Continue?") and wait if the step was risky; otherwise continue to the next step.
4. If something unexpected shows up that the plan did not cover, stop and tell the student. Do not quietly change the plan. Ask, then update the table.
5. Commit nothing, push nothing, and delete nothing without asking. When a good stopping point arrives, offer: "Want me to commit this? Here is the message I would use."
6. When all steps are done, spawn ONE fresh helper (`model: haiku`) that has not seen the work: "Read the plan table. Re-run each check command and report PASS, FAIL, or UNSURE per step with the output." Report its answers. Never say "all done" unless you saw the PASS lines.

## Compaction advice (saves your Pro plan)
Compaction means shrinking the chat history into a short summary so each new message costs less. A long chat gets re-read on every message, so it burns your allowance and gets forgetful. The plan file is the memory, so the chat can shrink safely.
• After Research: run `/compact` (or `/clear` and say "read the plan file and continue"). Keep: the plan HTML path.
• After the student approves the Plan: same. This is the best moment, because the plan now holds everything.
• During Implement: `/compact` after every 3 or 4 steps, or whenever Claude starts repeating itself or forgetting rules.
• If the chat is very long or you are stopping for the day, use the handoff skill instead.
Always tell the student when to do it, in one line, and say what the first message afterward should be.

## Traps this skill exists to catch
• Starting to code during Research "because it is obvious". The reading is what finds the part that is not obvious.
• A plan with steps like "build the backend". If you cannot check a step in one command or one look, it is too big. Split it.
• Planning everything in a row (all the data, then all the pages, then all the buttons). Nothing runs until the end. Build one thin working path first.
• Forgetting a requirement from the rubric. Check the plan against the assignment before asking for the yes.
• Treating the plan as law. If reality disagrees, stop, tell the student, and change the table on purpose.
• Spending plan on Opus for a small task. Ask first, and only when the task is big or risky.

## The three phases at a glance

| Phase | You may | You may not | Ends when |
|---|---|---|---|
| Research | read, search, list | edit, install, run builds | notes are in the plan file |
| Plan | write the plan file | touch project files | student says yes in chat |
| Implement | edit one step at a time, run checks | commit or push unasked, skip a check | all checks PASS by a fresh helper |

## Rules
• No edits in Phase 1. No edits in Phase 2 except the plan file itself. Project files change only in Phase 3, after a yes.
• Never skip the stop in Phase 2, even if the plan looks obvious.
• Never claim a check passed that you did not run and see.
• Never switch to Opus without asking first. Never use it for Research or Implement.
• One step at a time. Do not batch several steps because they look easy.
• Commit nothing without asking.
• Bullets use •. No em dashes, no italics.

## Example
Student: "plan first: add a login page and a saved-notes list to my class app"

Claude: "Phase 1: Research, read only. Quick questions: is login real accounts or a fake demo? Does it need to match the rubric's 'saves between visits' line? Anything I must not touch?" Student answers. Claude reads the README and files, then: "Found: 6 files, no login yet, notes live in memory and vanish on refresh. Notes are in learning-notes/login-notes-plan.html. Run /compact now, then say 'continue to the plan'."

Phase 2 table (excerpt):

| Step | Files touched | How I will check it | Risk |
|---|---|---|---|
| 1. Save notes to browser storage | notes.js (changed) | add a note, refresh, it is still there | low |
| 2. Add login page | login.html (new) | open page, form shows | low |
| 3. Block notes until logged in | app.js (changed) | visit notes while logged out, redirected | medium |

Claude: "Plan is in the file. Say yes to start step 1, or tell me what to change."
