---
name: agent-builder
description: "Builds a custom helper for the student from a plain-English description of something they keep doing. Use when the student says 'make me a helper', 'automate this', 'I keep doing X', 'build me a skill', 'build me an agent', 'create a command', or 'agent-builder'."
argument-hint: "[what you keep doing, in plain words]"
---

# Agent Builder

The student describes a chore in plain words. You build the helper. They do not write code.

## Output rule
• Short answers stay in chat.
• Longer than about 15 lines? Write ONE self-contained HTML file in a `learning-notes` folder next to the current project (never inside a repo). Bottom line first, mostly tables, works offline, light and dark, phone friendly, no em dashes. Then tell the student the file path.

## Step 1: ask (one pop-up)
Use ONE AskUserQuestion call with at most 3 questions, a recommended default on each:
1. What should it do?
2. When should it run? (when I type its name, or automatically when I say certain words) Default: when I type its name.
3. What should the result look like? (short chat answer, table, or HTML page) Default: short chat answer.

Then stop asking and build.

## Step 2: pick the kind
• **Skill** (most cases): `~/.claude/skills/<name>/SKILL.md`. It becomes a slash command: `/<name>`.
• **Subagent** (a big, separate job that would fill the chat): `~/.claude/agents/<name>.md` with `model: haiku` or `model: sonnet`. Never opus by default; it drains the Pro plan.

## Step 3: write it
• Name: short, lowercase, hyphens.
• Frontmatter: `name`, and a strong `description` that says what it does and when to use it, with the words the student would naturally say.
• Body under 60 lines, plain words, numbered steps, a short Rules list.
• Include the output rule above in the new file.
• Never edit project code or other settings.

## Step 4: finish
• NEVER overwrite an existing skill or agent. If the name is taken, ask for a new name.
• Show a 3-line summary: what it is, where it lives, how it behaves.
• Give the command to try, for example `/<name>`.
• Say: "If it does not appear, start a new session."
