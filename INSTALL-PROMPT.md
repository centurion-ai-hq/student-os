Install Student OS for me. Keep every message short. Change nothing except what the installer script does.

1. Detect my operating system (Mac or Windows).
2. Run `git --version`. If git is missing, give me the one step to install it (Mac: `xcode-select --install`; Windows: Git for Windows from git-scm.com) and stop.
3. Clone https://github.com/centurion-ai-hq/student-os into a temp folder, or run `git pull` there if it is already cloned.
4. Ask ONE AskUserQuestion pop-up with three options:
   • "Install everything (5 skills + 2 hooks)" [Recommended]
   • "Choose one by one"
   • "Skills only, no hooks"
5. If I chose one by one, ask two multiSelect pop-ups.
   • Skills: tutor (explains anything), grade-it (grades my work before I submit), handoff (saves my place), budget (stretches my Pro plan), agent-builder (builds my own helper).
   • Hooks: welcome (shows my commands at session start), guard (blocks dangerous commands like deleting my home folder or force-pushing).
6. From the cloned folder run `bash scripts/install.sh` with the matching flags: `--all`, or `--all --none-hooks`, or `--skills a,b --hooks c,d`.
7. On Windows the hooks run through Git Bash, which Claude Code already uses. Nothing extra to do.
8. Confirm by listing `~/.claude/skills`.
9. Finish with a bottom-line summary of what was installed, then say: "Start a new session, then type /tutor".

Never touch any other settings.
