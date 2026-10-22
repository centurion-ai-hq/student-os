Install Student OS for me. Keep every message short. Change nothing except what the installer script does.

1. Detect my operating system (Mac or Windows).
2. Run `git --version`. If git is missing, give me the one step to install it (Mac: `xcode-select --install`; Windows: Git for Windows from git-scm.com) and stop.
3. Clone https://github.com/centurion-ai-hq/student-os into a temp folder, or run `git pull` there if it is already cloned.
4. Ask ONE AskUserQuestion pop-up with three options:
   • "Install everything (9 skills + 3 hooks)" [Recommended]
   • "Choose one by one"
   • "Skills only, no hooks"
5. If I chose one by one, ask two multiSelect pop-ups.
   • Skills: tutor (explains anything), plan-first (plan before you build), fix-it (fixes one error and proves it), design (makes your page look good), spar (argues against your plan), prompt-optimizer (cleans up a messy ask), token-max (stretches your Pro plan), handoff (saves your place), skill-builder (builds your own commands).
   • Hooks: welcome (shows my commands at session start), terse (short replies to save my plan), guard (blocks dangerous commands like deleting my home folder or force-pushing).
6. From the cloned folder run `bash scripts/install.sh` with the matching flags: `--all`, or `--all --none-hooks`, or `--skills a,b --hooks c,d`.
7. On Windows the hooks run through Git Bash, which Claude Code already uses. Nothing extra to do.
8. Confirm by listing `~/.claude/skills`.
9. Then tell me, in two lines, that Anthropic also publishes free official skills, and give me the two things I can type myself (you cannot type slash commands for me): `/plugin marketplace add anthropics/skills`, then `/plugin` to browse and pick one. Say this is optional.
10. Finish with a bottom-line summary of what was installed. Repeat any "skipped" line from the installer (it means I already had a skill with that name, so it was left alone). Then say: "Start a new session, then type /tutor".

Never touch any other settings.
