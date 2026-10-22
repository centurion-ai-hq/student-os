---
name: prompt-optimizer
description: "Turns a messy brain dump or rough idea into ONE clean prompt (Task, Why, Outcome, Context, Constraints, How I will check it is done) that you can copy into a fresh chat. Use when the student says 'optimize my prompt', 'clean up this prompt', 'turn this into a prompt', 'I have a lot in my head', 'brain dump', 'help me ask this better', 'where do I even start', or pastes a long rambling request."
argument-hint: "[paste your messy idea or brain dump]"
---

# Prompt Optimizer

Good prompts get good results on the first try, which saves your plan. Big dumps hide the real request in the middle. This skill splits the dump, sorts it, asks the few questions that matter, and hands back one clean prompt. In the spirit of Marcus Aurelius: first see clearly what is in front of you, then act.

## Output rule
• The clean prompt goes in chat, in ONE code block so it is easy to copy.
• Everything else (the sorting list) stays under 15 lines in chat.
• If the dump is huge and the sorting list passes about 15 lines, write the list into ONE self-contained HTML file in the `learning-notes` folder in your home folder, `~/learning-notes` (never inside a repo). Bottom line first, a table with one row per ask, works offline, light and dark, phone friendly, no em dashes. Tell the student the path.

## Model routing
• Sonnet does all of it.
• Pulling facts out of a long pasted document or many files: ONE helper with `model: haiku`.
• The final check (below) uses ONE fresh helper on `model: haiku`.
• No Opus. Never more than one helper at a time.

## Steps

### 1. Segment
Read the whole dump once. Split it into separate asks, including ones buried in the middle of a sentence or phrased as an aside ("oh and also it should..."). One ask is one thing a person could do and then tick off. Number them.

### 2. Sort each ask
Give every ask exactly one label:
• **Do now**: clear, belongs in this prompt.
• **Do later**: real, but not for this session. Park it in a short list.
• **Needs a question**: you cannot do it well without one missing fact.
• **Drop**: duplicate, contradicts a better ask, or does not matter. Say why in a few words.
Show this as a small table (ask, label, one-line reason). If two asks contradict each other, flag the pair. That is the most valuable thing this step finds.

### 3. Ask (one pop-up)
Use ONE AskUserQuestion call with at most 3 questions, each with a recommended default. Ask only about items sorted as Needs a question, plus the finish line if it is missing ("How will you know it is done?"). If nothing is missing, skip the pop-up. Then stop asking.

### 4. Write the one clean prompt
Use exactly these labelled parts, in this order:
• **Task**: one verb on one thing. "Add a login page to my React app."
• **Why**: the bigger reason. What it unlocks or what breaks without it. This is the part people skip and the part that changes the answer most.
• **Outcome**: the concrete thing you will end up with, named and located ("a file `login.html` in `/src`", "five quiz questions in chat").
• **Context**: what already exists, files, versions, the course, what you tried. Only facts the student gave. Mark guesses as guesses.
• **Constraints**: limits. Tools allowed, things not to touch, length, style, deadline, "no new libraries".
• **How I will check it is done**: a test you can run or see. Prefer a command with a pass or fail answer ("`npm run check` passes"). Not "when it looks right".

Rules for writing it: plain words, short lines, no em dashes, first person ("I need"). Put the Do now asks inside Task and Outcome. Do not include Do later items; list them under the code block.

### 5. Check it
Start ONE fresh helper (`model: haiku`) with only the finished prompt. Ask it: "Are all six parts present and filled? Is anything ambiguous? Reply PASS, FAIL or UNSURE with the exact words that prove it." Fix anything it flags once. Report its verdict as given. Never claim a pass you did not see.

### 6. Hand back
• Show the prompt in a code block.
• Under it: "Parked for later:" with the Do later items, and "Dropped:" with the Drop items.
• Tell the student: "Copy the block. For a big task, open a fresh session, press Shift+Tab for plan mode, and paste it."

## What good looks like, part by part
| Part | Weak | Strong |
|---|---|---|
| Task | "Work on my project" | "Add a search box to the notes page" |
| Why | (missing) | "The rubric awards 10 points for search" |
| Outcome | "Make it good" | "A working search box, committed on a branch" |
| Context | "You know my app" | "React app, file `Notes.jsx`, no backend yet" |
| Constraints | (missing) | "No new libraries, finish by Friday" |
| Check | "Looks right" | "`npm run check` passes and I can search for a word" |

## Traps
• Merging two asks into one Task. Split them.
• A Why that repeats the Task. The Why is the reason, not the request again.
• A check nobody can run. If the student cannot run it, rewrite it.
• Asking questions the dump already answered. Read first.

## Rules
• Never invent facts for the Context part. If you do not know, ask or write "unknown".
• Never ask more than 3 questions, and never one at a time.
• One prompt only. If the dump holds two unrelated projects, say so and make one prompt for the first, then offer the second as a separate run.
• Do not start doing the work. This skill only produces the prompt.
• Do not silently drop an ask. Everything is either in the prompt, parked, or listed under Dropped.

## Example
Student pastes: "ok so for the project I need the login thing working and the page looks ugly, maybe dark mode? also the teacher said something about tests, I think we have to deploy to Vercel too, oh and I never understood what a branch is"

Sorting:
| Ask | Label | Reason |
|---|---|---|
| Login works | Do now | Core of the project |
| Fix ugly page | Do later | Vague, after login works |
| Dark mode | Drop | "maybe", not required |
| Tests | Needs a question | Which tests does the teacher want? |
| Deploy to Vercel | Do later | Comes after tests pass |
| What is a branch | Do later | Use /tutor, separate short question |

One question (pop-up): "Does the rubric name which tests are required? Default: read the rubric file in the repo."

Result:
```
Task: Make the login page work in my project.
Why: The rubric gives most of the points for a working login, and the rest of the app depends on it.
Outcome: A login form at /login that signs a user in and shows their name. Changes committed on a branch.
Context: React app from the class starter repo. I have not changed auth yet. Rubric file: RUBRIC.md.
Constraints: No new libraries. Do not touch the database setup. Plain words in explanations.
How I will check it is done: `npm run check` passes, and I can sign in with the test user in the browser.
```
Parked for later: page styling, tests (after the question), Vercel deploy, learn what a branch is (type `/tutor what is a branch`).
