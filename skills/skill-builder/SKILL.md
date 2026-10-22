---
name: skill-builder
description: "Builds a new skill (or helper agent) from a plain-English description of a chore, or turns the current chat into a skill. Use when the student says 'make me a skill', 'make me a helper', 'automate this', 'I keep doing X', 'build me an agent', 'create a command', 'turn this chat into a skill', 'save this as a skill', or 'skill-builder'."
argument-hint: "[the chore in plain words, or: turn this chat into a skill]"
---

# Skill Builder

A skill is a plain text file of instructions that Claude loads when you ask for a certain kind of job. You describe the chore in everyday words. You do not write code. Skills are plain files in a folder, so there is no settings screen to find, nothing to install, and nothing to turn on.

## Output rule
• Short answers stay in chat.
• Anything longer than about 15 lines (for example a full review of an existing skill) goes into ONE self-contained HTML file in a `learning-notes` folder next to the project (never inside a repo). Bottom line first, tables, works offline, light and dark, phone friendly, no em dashes. Tell the student the path.
• The new skill file itself is the deliverable. Do not paste all of it into chat; show a 3-line summary.

## Model routing
• The writing stays on Sonnet.
• Looking through the chat history or listing existing skills: ONE helper with `model: haiku`.
• The TEST step uses a fresh helper (no memory of the writing) on `model: haiku`.
• No Opus needed. Max one helper at a time. Never run a crowd.

## Steps

### 1. Ask (one pop-up)
Use ONE AskUserQuestion call with at most 3 questions, each with a recommended default:
• What should it do, and what does "done" look like?
• When should it run? Default: when I type its name. Other option: also automatically when I say certain words.
• What should the result look like? Default: short answer in chat. Other options: a table, an HTML page, a saved file.
If the student already answered some of these in their first message, skip those. Then stop asking and build.

### 2. Choose the kind
• **Skill** (almost always): it runs inside the current chat, so Claude can see what you see. File: `~/.claude/skills/<name>/SKILL.md`.
• **Subagent** (a big, separate job that would flood the chat, like reading 40 files): it works alone and returns a summary. File: `~/.claude/agents/<name>.md` with `model: haiku` or `model: sonnet`. Never opus by default.
Say your choice in one sentence with the reason.

### 3. Check the name
• Short, lowercase, hyphens: `weekly-recap`, not `My Weekly Recap Thing`.
• Look in `~/.claude/skills/` (or `~/.claude/agents/`). If the name exists, NEVER overwrite. Ask for a new name, or suggest `<name>-2`.

### 4. Write the file
Write `~/.claude/skills/<name>/SKILL.md` with:
• Frontmatter between two lines of `---`: `name` (same as the folder) and `description`. The description is what Claude reads to decide whether to load the skill, so make it strong: what it does, then the natural phrases the student would say ("when I say 'recap my week' or 'what did I do'"). Vague descriptions never fire. Too-broad ones fire on everything. Put quotes around it.
• A one-line purpose.
• **Output rule** (short in chat; long becomes one HTML file in `learning-notes`).
• **Model routing** (sonnet for the work, a haiku helper for reading and searching, opus only for a named hard step and only after asking).
• **Steps**: numbered, concrete, each one a thing Claude can do. Include a check at the end when the skill claims "done": a command run, or a fresh helper that verifies.
• **Rules**: what it must never do (never edit unrelated files, never invent results, never send anything).
• **Example**: a short realistic exchange.
Keep it under about 100 lines, plain words, no em dashes, bullets use •.

### 5. Test it
Never say "done" before this.
1. Re-read the file you just wrote from disk (do not trust memory).
2. Check: the first line is `---`, there is a `name:` that matches the folder, a `description:` in quotes, a closing `---`, and every required section exists.
3. For a stronger check, start ONE fresh helper (`model: haiku`) and give it only the file path. It reports PASS, FAIL or UNSURE with the exact line that proves each check. Report its answer as given. Never claim a pass you did not see.
4. Tell the student the exact test phrase to type, taken from the description, for example: "Type: recap my week". Add: "If it does not show up, start a new session. Skills load when a session starts."

## Flow B: turn this chat into a skill
Use when the student says "turn this chat into a skill" or "save this as a skill".
1. Hand the chat history to ONE haiku helper: "List every step we repeated, every correction the student made, and every format they asked for."
2. Keep only what happened at least twice, or what the student corrected. One-off details are not a skill.
3. Show the student a 5-line draft of the steps and ask one question: "Is this the chore?" (one pop-up, with the draft as the default).
4. Continue from Step 2 above. The corrections become the Rules section. The format they liked becomes the Output rule.

## Writing a strong description
The description decides everything. Claude reads only this line to choose whether to load the skill.
| Weak | Strong |
|---|---|
| "Helps with notes" | "Turns pasted lecture notes into 5 bullets and 3 quiz questions. Use when the student says 'recap my lecture', 'quiz me on this', 'summarize my notes'." |
Check it with one question: would this fire on an unrelated request? If yes, narrow it. If the student's own words are not in it, add them.

## Traps
• A skill that tries to do three jobs. Split it.
• Steps that say "be thorough" instead of naming what to do. Write the action.
• No finish line. Every skill needs a way to tell it worked.
• Copying a skill from a stranger without reading it. A skill runs with your permissions, so read every line first.
• Forgetting that new skills load at session start. A skill written mid-chat may need a new session.

## Rules
• NEVER overwrite an existing skill or agent file.
• Never edit project code, settings files, or other skills.
• Never put passwords, keys or tokens in a skill. A skill is a plain file anyone can read.
• Never promise it works until the TEST step has been done.
• At most 3 questions, in one pop-up, ever.
• One chore per skill. If the description needs the word "and" between two jobs, make two skills.

## Example
Student: "I keep summarizing my lecture notes into five bullets and a quiz. Make me a skill."
Claude: (one pop-up) "Done looks like: 5 bullets plus 3 quiz questions? When: only when I type it? Result: chat?" Student accepts defaults.
Claude writes `~/.claude/skills/lecture-recap/SKILL.md` and replies:
• What: turns pasted notes into 5 bullets and 3 quiz questions.
• Where: `~/.claude/skills/lecture-recap/SKILL.md`.
• How: sonnet does the work, answers stay in chat.
• Test: file re-read, frontmatter valid, fresh helper said PASS (name, description, sections found).
• Try it: type "recap my lecture" and paste notes. If it does not appear, start a new session.
