# Student OS

Six simple commands for Claude Code in CIS 591.

| | |
|---|---|
| **What it is** | A tiny plugin: a tutor, a study-guide maker, and safe habits. |
| **Install** | Two lines, below. |
| **The 6 commands** | `/student:tutor` `/student:explain-build` `/student:spec-loop` `/student:prove-it` `/student:handoff` `/student:budget` |
| **Saves usage** | No per-message hooks. Short skills. `/student:budget` teaches Sonnet, plan mode, fresh sessions. |

## Install

Type these inside Claude Code:

```
/plugin marketplace add centurion-ai-hq/student-os
/plugin install student@student-os
```

Windows: the safety hooks need Git Bash. The six skills work either way.

## No install? Copy-paste these

Tutor:

```
Be my tutor, in the spirit of Marcus Aurelius: calm, patient, plain-spoken, one idea at a time. I am learning software engineering and I am not a developer.
Whenever I paste a term, an error, or a message from my coding agent:
1. Answer in one plain sentence first.
2. Explain it like I am five.
3. Then give the proper technical term and a one-line definition I could say in class.
4. Give one real-world analogy.
5. Tell me why it matters for the project I am building, and whether I need it now or can learn it later.
Stay under 150 words unless I ask for more. Do not change any code or files.
```

Study guide:

```
Read my repo, its git log, and the specs folder. First run the project's check commands and use only real output; never invent results. Then write ONE self-contained HTML study guide in a learning-notes folder next to the repo, not inside it. First person, plain words, no em dashes, no external links, works offline, light and dark, phone friendly, max 5 printed pages, mostly SVG diagrams and tables with 1-2 sentence captions. Pages: (1) What I built: summary, status strip, starter vs mine vs grading. (2) How it fits: laptop, local git, GitHub, Vercel, browser, plus the READ-PLAN-BUILD-VERIFY-SAVE loop. (3) How I built it: commit timeline, section map. (4) Concepts table (term, plain, analogy, engineer's version) for repository, branch, commit, push/pull, local vs remote, pull request, merge, frontend vs backend, CI, acceptance test. (5) Proof table, "I decided / Claude did" table, a 30-second answer. Use a cheaper subagent to read files.
```

Made by Luis Vega for CIS 591.
