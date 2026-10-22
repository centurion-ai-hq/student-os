# Student Skill Pack

Nine simple commands for Claude Code in CIS 591.

| Command | What it does |
|---|---|
| `/tutor` | Explains any word, error, assignment, or your whole build |
| `/plan-first` | Research, plan, then build, with a check after each step |
| `/fix-it` | Fixes one error and proves the fix by running it |
| `/design` | Makes your page look professional, checked at 3 screen sizes |
| `/spar` | Argues against your plan before you build it |
| `/prompt-optimizer` | Turns a messy idea into one clean prompt |
| `/token-max` | Stretches your $20 plan by picking the right model |
| `/handoff` | Saves your place so a fresh session can continue |
| `/skill-builder` | Builds your own command from a plain description |

Plus three hooks (small helpers that run on their own): `welcome` shows your commands, `terse` keeps replies short, `guard` blocks dangerous commands.

Want the exact text of every skill so you can paste it into Claude Code yourself? Open [full-skills.html](full-skills.html) and press Copy.

## Install

Paste the prompt in [INSTALL-PROMPT.md](INSTALL-PROMPT.md) into Claude Code.

## No install? Copy-paste this

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

To remove everything: `bash scripts/install.sh --uninstall` (run it from the student-skill-pack folder in your home folder).

Optional: `templates/CLAUDE.md` is a short starter file you can copy into a project so Claude knows your course.

## Credits

Student Skill Pack is original work. Two pieces were inspired by public projects: `/design` by [UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) (MIT) and [taste-skill](https://github.com/Leonxlnx/taste-skill) (MIT), and the `terse` hook by [caveman](https://github.com/JuliusBrussee/caveman) (Apache 2.0). Nothing was copied. Details in [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).

Made by Luis Vega for CIS 591.
