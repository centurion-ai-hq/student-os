---
name: handoff
description: "Saves your place so a brand-new session can pick up exactly where you stopped, with nothing dropped. Checks the real state of your project, lists everything you asked this session (done, not done, dropped), writes NEXT-STEPS.md, has a fresh helper re-check every 'done' claim, and gives you the one line to paste into the next session. Use when the chat is getting long, or you say 'I have to stop', 'save my place', 'wrap up', 'new session', 'handoff', 'pick this up later', or before ending work."
argument-hint: "[optional: anything you want to make sure is remembered]"
---

# Handoff

A fresh session costs far less than a long one, and a long chat forgets things. This skill saves your place so nothing you asked for gets lost. Think of a nurse handing a patient to the next shift: say what happened, what is next, and then check the next person understood.

## Output rule
• Chat replies stay short. The main product is one small file, `NEXT-STEPS.md`, in the project root (replace the old one).
• Any longer explanation (for example a big ledger) goes in ONE self-contained HTML file in a `learning-notes` folder next to the project, never inside a repo. Bottom line first, tables, works offline, light and dark mode, phone friendly, no em dashes. Tell the student the path.

## Model routing
• You (Sonnet) do the freeze, the ledger, and the writing.
• ONE fresh helper with `model: haiku` does the verification at the end. It must not see your reasoning, only the file and the project.
• No Opus. No second helper. No fan-out.

## Steps
1. **Freeze the board.** Before anything else, write three lines in chat and do not revise them later: what is in progress right now, the last thing done, the next thing you were about to do. A snapshot taken after the cleanup describes the cleanup, not the session.
2. **Freeze check, from the real project, not memory.** Run `git status` and `git log --oneline -8`. Note: uncommitted changes, untracked files, current branch, last commit. If it is not a git repo, say so and list changed files by looking at the folder. Never run commit, push, reset, or checkout.
3. **Build the ask ledger.** Read the whole chat from the student's first message. List EVERY ask, not only the big ones: tasks, questions, "also fix this", changes of mind, side requests. If the chat was compacted or you cannot see the start, say "I can only see part of this chat" and ask the student to paste or list what is missing. Give each ask a status:
   • **Done**: finished AND you can point to proof (a file, a passing command, a commit).
   • **Not done**: started or untouched.
   • **Dropped**: the student changed their mind or it was replaced. Write why in a few words.
   If you cannot tell, it is Not done. Put the ledger in the file as a table: number, ask in the student's words, status, proof or reason.
4. **Write `NEXT-STEPS.md`** with exactly these headings, under about 40 lines:
   • **Done**: each item with its proof.
   • **Next**: the very next step in one line, then up to three after it, in order.
   • **Open questions**: anything stuck, or to ask the instructor.
   • **Rulings made**: decisions the student made, so the next session never reopens them (for example "use Vercel, not Netlify", "keep the blue theme"). Include things they rejected.
   Then add the ask ledger table and the git facts from step 2 under a small "State" heading.

   Shape to follow:

```
# NEXT-STEPS (saved 2026-10-22)
Verified: 3 pass, 1 fail, 1 unsure

## Done
• Nav bar added (index.html, seen in browser)

## Next
1. Add form validation in contact.js
2. Fix missing footer link

## Open questions
• Does the instructor want a README section on testing?

## Rulings made
• Using Vercel, not Netlify
• Dark theme dropped

## State
Branch main, 2 files uncommitted, last commit "add nav"

| # | Ask (my words) | Status | Proof or reason |
|---|---|---|---|
| 1 | "add a nav bar" | Done | index.html line 12 |
| 2 | "make it dark" | Dropped | I changed my mind |
```
5. **Verify with a fresh helper.** Spawn ONE helper (`model: haiku`) with this brief and nothing else: "Read NEXT-STEPS.md. For every item under Done and every Done row in the ledger, check it against the actual project files and by running its proof command if one is given (read-only commands only). Report one line each: PASS, FAIL, or UNSURE, with the evidence (file and line, or command output)." Do not tell it your reasoning.
6. **Apply the verdict.** Any FAIL moves the item to Not done and the file is corrected. UNSURE stays Not done unless you can prove it. Never mark an item verified that the helper did not report PASS on. Add one line at the top of the file: `Verified [date]: X pass, Y fail, Z unsure.`
7. **Give the resume line.** Tell the student the file path, then give this exact line to paste into a new session:

`Read NEXT-STEPS.md, run git status, tell me in 3 lines where we are, then start on the first item under Next.`

## Traps this skill exists to catch
(Read these before step 3; they are where handoffs usually fail.)
• Writing from memory. A long chat forgets early asks, so the ledger comes from the whole chat, not the last ten messages.
• Counting only big tasks. Small asks ("also rename that button") are the ones that get lost.
• Calling something done because you wrote the code. Done means it ran, or a file shows it.
• Hiding changes of mind. If the student reversed a decision, record it under Rulings made so the next session does not undo it.
• A resume line that is vague. The new session knows nothing, so the first message must point at the file.

## Rules
• Do NOT commit `NEXT-STEPS.md`. It is for you, not for your submission. Do not add it to git or edit any other file, including `.gitignore`. If `git status` later shows it untracked, leave it alone and tell the student.
• Only list something as Done if it is proved. "I think it works" is Not done.
• Never put passwords, keys, or tokens in the file.
• Never delete or rewrite the old handoff before the new one is verified. Rename it `NEXT-STEPS.old.md` first if unsure.
• Never claim the helper passed something you did not see it report.
• Bullets use •. No em dashes, no italics.

## Example
Student: "my hands are cramping, save my place"

Handoff (chat): "Freeze: building the contact form, last done was the nav bar, next was form validation. Git: branch main, 2 files changed and uncommitted, last commit 'add nav'. I found 5 asks this session: 3 done, 1 not done, 1 dropped (you dropped the dark theme). The helper checked the 3 done items: 2 PASS, 1 FAIL (the footer link is missing in index.html), so I moved it to Not done. File: NEXT-STEPS.md in your project folder. Paste this in a new session:"

`Read NEXT-STEPS.md, run git status, tell me in 3 lines where we are, then start on the first item under Next.`
