---
name: spec-loop
description: "The course build loop for one spec section at a time: read, plan, build, verify, save. Use when the student says 'build the next section', 'start section', 'spec loop', 'what do I do next', or begins any new piece of the assignment."
argument-hint: "[section name or number]"
---

# Spec Loop

One section at a time. Never start the next section before the current one is saved.

## The loop
1. **READ.** Open the spec file for this section in the specs folder. Quote its goal and its "done" checks in two lines.
2. **PLAN.** Show a short plan: files to touch, steps, and what you will not touch. Then STOP and wait for the student to say yes. Do not build before approval.
3. **BUILD.** Do only what the plan says. Keep changes small.
4. **VERIFY.** Run the project's check or test command (see CLAUDE.md or package.json). Open the app in the browser and look. Show the real result. If it fails, fix and run again.
5. **SAVE.** Commit with a clear message, for example: "Module 1: pricing section". Show the commit.

## Rules
• Never edit tests or the specs folder. Those are the grader's.
• If the plan needs more than 5 files, say so and ask if the student wants to split it.
• New word? Explain it in one plain line.
• End with: "Section saved. Next: <name>. Say go."
• Tip: use plan mode (Shift+Tab) for the PLAN step.
