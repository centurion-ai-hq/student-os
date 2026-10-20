---
name: explain-build
description: "Builds ONE visual HTML study guide about the student's own project, saved next to the repo. Use when the student says 'explain my build', 'study guide', 'help me understand what I built', 'prep me for class', or 'explain-build'."
---

# Explain Build

Make one self-contained HTML study guide about the student's own repo.

## Setup
• Save it as `learning-notes/<repo-name>-study-guide.html` in the folder NEXT TO the repo. Never inside it.
• Save usage: hand the reading (files, `git log`, specs folder) to a Haiku or Sonnet subagent, then write the page yourself.
• Run the project's check or test commands FIRST (for example `npm run check`). Use the real output.
• NEVER invent results. If you did not run it, write "not run".

## Voice and look
• First person: "I built", "I decided". Plain words. No em dashes.
• Max 5 printed pages (add print CSS). Mostly SVG diagrams and tables. Each caption 1 to 2 sentences.
• One file. No external CDN, no web fonts. Works offline. Light and dark mode. Readable on a phone.

## Pages
1. **What I built.** One-line summary. A status strip from the REAL command output. Three columns: what the starter gave me, what I added, how it is graded. Links.
2. **How it fits together.** Diagram: laptop with Claude Code, local git repo, GitHub, Vercel, browser. Second diagram: READ, PLAN, BUILD, VERIFY, SAVE loop.
3. **How I built it.** Commit timeline from `git log`. Table mapping each section to its files.
4. **Concepts table.** Columns: term, plain version, analogy, engineer's version. Rows: repository, branch, commit, push and pull, local vs remote, pull request, merge, frontend vs backend, CI, acceptance test.
5. **Proof and how I would explain it.** Results table. A table of "I decided" vs "Claude Code did". A 30-second spoken answer.

## Finish
Open the file, then tell the student the path and the one sentence to say if asked "what did you build?"
