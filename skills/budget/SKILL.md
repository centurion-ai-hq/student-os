---
name: budget
description: "Prints and applies a short checklist for stretching the $20 Pro plan. Use when the student says 'I hit my limit', 'usage', 'running out', 'save tokens', 'budget', 'why is this slow', or the chat is very long."
---

# Budget

The Pro plan has tight limits. Print this checklist, then apply what you can right now.

## Output rule
• Reply in chat, under 12 lines.
• If you ever need more, write ONE self-contained HTML file in a `learning-notes` folder next to the project (never inside a repo), bottom line first, no em dashes, and tell the student the path.

## Checklist
• Use `/model sonnet` for everyday work. Save opus for rare hard problems.
• Big task? Use plan mode (Shift+Tab) so Claude thinks before it builds.
• One task per session. Start fresh when the task changes.
• Chat getting long? Run `/compact`, or run `/handoff` and start fresh.
• Keep CLAUDE.md short. It is re-read every time.
• Quick question about a word? Use `/tutor` as a separate short question, not mid-build.
• Searching many files? Use a helper subagent pinned to `model: haiku`.
• Do not paste whole files or huge logs. Paste the error lines.

## Then do
1. Say which model this session is on (use the aliases sonnet, haiku, opus only).
2. If it is not sonnet and the task is everyday work, tell the student to type `/model sonnet`.
3. If the chat is long, suggest `/compact` or `/handoff`.
4. Give one tip that fits what they are doing now.
