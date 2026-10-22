---
name: token-max
description: "Makes your $20 Pro plan last: picks the right model for the job (sonnet, haiku, opus), checks which model you are on, gives the cheap-habits checklist, and runs terse mode (short plain answers). Use when the student says 'I hit my limit', 'usage', 'running out', 'save tokens', 'budget', 'which model', 'am I on the right model', 'why is this slow', 'terse on', 'terse off', 'shorter answers', or when the chat is very long."
argument-hint: "[what you are about to do, or: terse on / terse off]"
---

# Token Max

The Pro plan gives you a limited amount of work per few hours. A token is a small chunk of text (about three quarters of a word). Everything Claude reads and writes spends tokens, and a long chat re-reads itself every turn. This skill spends them wisely: right model, short answers, fresh sessions.

## Output rule
• Reply in chat, under 12 lines.
• If you need more than about 15 lines, write ONE self-contained HTML file in a `learning-notes` folder next to the project (never inside a repo). Bottom line first, tables, works offline, light and dark, phone friendly, no em dashes. Tell the student the path.

## Model routing
• This skill itself runs on Sonnet. It needs no helper and no Opus.
• Reading, searching or listing many files for the student: hand it to ONE helper subagent with `model: haiku`. Never more than one helper at a time.
• Opus is only for a named hard step (a design decision, a final review, a stubborn bug that Sonnet failed twice). Ask first: "This one is hard enough for opus, which uses much more of your plan. Switch?" Wait for a yes.

## The routing table for the Pro plan
| Job | Model | Command |
|---|---|---|
| Everyday work: writing code, fixing bugs, drafting, explaining | Sonnet (the default) | `/model sonnet` |
| Reading, searching, listing files, simple edits, renames, formatting | Haiku | `/model haiku` |
| Hard reasoning, design decisions, a final review before you submit | Opus, after asking | `/model opus` |

How to check: type `/model` with nothing after it. It shows the current model. The words sonnet, haiku and opus always point to the newest version, so you never need a version number.

Switch back to sonnet when the hard step is over. Opus left on by accident is the most common way a student empties the plan by Tuesday.

## Effort settings
Effort is how long the model thinks before it answers. More thinking costs more.
• Leave effort at the default for normal work. If your version has `/effort`, use low for simple edits and questions.
• Turn it up only for a problem that Sonnet already got wrong once. One notch, not the top.
• Never set the highest effort and then ask small questions. That is paying for a lecture to hear "yes".

## The cheap-habits checklist
• Plan mode (Shift+Tab) before any big task. Planning is cheap, rebuilding is not.
• `/compact` when the chat gets long. It shrinks the history and keeps the key facts.
• `/handoff` then a fresh session when the topic changes. A new chat starts with an empty history.
• One task per session. Mixed sessions drag old context into every answer.
• Paste the error lines, not the whole log or whole file.
• Keep CLAUDE.md short (under about 40 lines). It is re-read every turn.
• Ask for what you need once, with the goal and the finish line, instead of ten small nudges.
• Quick vocabulary question mid-build? Use `/tutor` in a separate short turn.

## Fan-out law
Never run many helpers at once on a Pro plan. Each helper has its own history and spends tokens in parallel, so five helpers drain the plan five times faster. The limit is one helper per run, on haiku, for reading and searching only. If a task seems to need a crowd, split it into separate sessions and do them one after another.

## Terse mode
Terse mode makes answers short. A SessionStart hook named `terse` turns it on by default. A hook is a small automatic action that runs when a session begins. This section is what the hook switches on.

When terse is ON:
• Answer in short plain sentences. Lead with the answer.
• No preamble ("Sure, here is...") and no recap at the end.
• Code, file paths, commands and error text stay exactly as they are. Never shorten those.
• Define a new word once, in a few words, then move on.
• Ask a question only when you truly cannot continue.

When terse is OFF: answer normally, with more explanation.

The student controls it by typing `terse on` or `terse off`. Confirm in one line ("Terse on."). Terse mode never overrides safety: if an answer needs a warning, say it, briefly. If the student says "explain", "teach me" or "why", give the longer answer for that one question, then go back to terse.

## Steps
1. Read what the student is about to do (or what they asked).
2. Name the model this session is on. If you cannot tell, ask them to type `/model` and read it back.
3. Compare to the table. Wrong model? Say the exact command to switch.
4. If they said `terse on` or `terse off`, apply it and confirm. Stop.
5. If the chat is long, suggest `/compact`, or `/handoff` plus a fresh session.
6. Finish with the routing check below.

## Routing check (last thing you say)
Two lines:
• Model: "This session is on <model>. For <their task> that is <right / too big, type /model sonnet / too small, type /model sonnet>."
• Tip: one habit from the checklist that fits the current task, for example "You are about to build a big feature, press Shift+Tab for plan mode first."

## Traps
• Staying on opus after one hard question. Switch back when it is answered.
• Using haiku for a task that needs judgment (grading, design choices). It is fast and cheap but makes more mistakes on reasoning.
• Restarting a session without a handoff, then paying to re-explain everything.
• Reading a whole big file when one function was needed. Ask for the part.

## Rules
• Never switch to opus without asking and getting a yes.
• Never spawn more than one helper, and never for thinking work.
• Never shorten code, paths, commands or error text, even in terse mode.
• Never guess usage numbers. If the student wants real numbers, tell them to check the usage page of their Claude account or type `/usage` if their version has it.
• Do not edit project files. This skill only advises and sets the answer style.

## Example
Student: "I keep hitting my limit and I am only on week 2."
Claude:
• Model: This session is on opus. For your task (fixing a CSS bug) that is too big. Type `/model sonnet`.
• Why you run out: a long chat re-reads itself every turn, and opus costs far more per turn.
• Do now: `/compact`, then work on sonnet. Paste only error lines.
• Tip: start a new session for each assignment, and say `terse on` for shorter answers.
