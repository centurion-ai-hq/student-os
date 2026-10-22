---
name: design
description: "Makes a web page, app screen, slide page, or dashboard look professional on purpose instead of by accident. Writes a short design brief first (audience, one direction, 2 fonts, 5 named colors with light and dark versions), builds with a fixed spacing and type scale, follows accessibility minimums, then checks the result at phone, tablet, and desktop width and fixes the top 3 problems. Use when you say 'design this', 'make it look good', 'make it look professional', 'style this page', 'my page looks ugly', 'build me a landing page', 'make a dashboard', or 'check my UI'."
argument-hint: "[what to design, and who it is for]"
---

# Design

Good design is a small set of decisions made once and followed everywhere. Ugly pages usually come from making a new decision on every element. This skill makes the decisions first, builds, then actually looks at the result.

New words, defined once: a token is a named value you reuse (like a color called "accent") so you never type the raw value twice. Contrast is how strongly text stands out from its background. A viewport is the visible screen area, and its width changes between a phone and a laptop. Responsive means the layout adapts to the viewport.

## Output rule
• Short answers stay in chat.
• Longer than about 15 lines? Write ONE self-contained HTML file in the `learning-notes` folder in your home folder, `~/learning-notes` (never inside a repo). Bottom line first, mostly tables, works offline, light and dark, phone friendly, no em dashes.
• Then tell the student the file path. The page being DESIGNED goes where the project needs it; only the design brief and check report go in `learning-notes`.

## Model routing
• Design and building stay on Sonnet.
• Finding existing files, reading the current CSS, or listing assets goes to ONE helper subagent with `model: haiku`.
• The width check (step 6) may use a SEPARATE fresh helper with `model: haiku` that did not build the page. It opens the page, looks, and reports PASS, FAIL, or UNSURE per width, with what it saw. One helper at a time, never in parallel. Never loop or fan out.
• Opus is only worth it for a big redesign direction call; if you want it, ask first and say "it uses more of your plan." Default: do not use it.

## Rule priority (when two rules clash, the lower number wins)
1. **Accessibility and touch.** Readable, usable by keyboard, big enough to tap.

2. **Performance.** Few and small files, no giant images, no heavy libraries for simple pages.

3. **Layout and responsive.** One column on phones, content never cut off or scrolling sideways.

4. **Typography and color.** Readable sizes, limited fonts, a consistent palette.

5. **Animation.** Small, short, optional. Respect "reduce motion."

6. **Forms.** Every field has a visible label, clear error text, and a big button.

7. **Navigation.** The user always knows where they are and how to go back.

8. **Charts.** Only if there is data; label directly, never rely on color alone.

## Steps
1. **Ask only what you must.** If the audience or purpose is missing, ask ONE question. Otherwise assume and state the assumption.

2. **Write the design brief (7 lines, before any code).** Show it to the student.
   • Audience: who uses this and on what device.
   • Goal: the one thing the page must get the visitor to do.
   • Direction: pick ONE art direction and name it in two words (examples: "calm editorial", "bold playful", "quiet dashboard", "warm friendly"). Do not mix directions.
   • Fonts: 2 maximum, one for headings, one for body. A system font stack is a fine, fast choice.
   • Colors: exactly 5 named tokens, each with a light and a dark value: `background`, `surface`, `text`, `muted`, `accent`. Check every text and background pair at 4.5 to 1 contrast or better.
   • Scales: use the numbers below.
   • Proof plan: the three widths you will check.

3. **Use these numbers.**
   • Spacing (px): 4, 8, 12, 16, 24, 32, 48, 64. Use nothing outside this list.
   • Type scale (px): 12, 14, 16 (body), 20, 24, 32, 48. Body text never below 16. Line height 1.5 for body, 1.2 for headings. Line length 45 to 75 characters.
   • Page gutter 16px on phones. Maximum content width about 720px for reading, 1100px for dashboards.
   • Corner radius: pick one (for example 8px) and reuse it.

4. **Accessibility minimums (non-negotiable).**
   • Text contrast 4.5 to 1 against its background (3 to 1 for text 24px and larger). Works in light AND dark.
   • Tap targets at least 44 by 44 px with space between them.
   • Visible focus outline on every clickable thing; never remove it without a replacement.
   • Alt text on every meaningful image; empty alt (`alt=""`) on decoration.
   • Meaning never by color alone (add a label or icon). Real buttons and links, not clickable boxes. One main heading per page.

5. **Build.** Define the 5 tokens once at the top (light values, then dark values using `prefers-color-scheme: dark`). Page background must be set explicitly. Mobile layout first, then widen. No horizontal scrolling at any width.

6. **Check at 3 widths: 375, 768, 1280.** Use a real browser or take real screenshots when you can (the browser tool, a headless browser, or ask the student to paste screenshots). Look for: cut-off text, overlap, sideways scroll, tiny tap targets, low contrast, empty gaps. Also look once in dark mode. If you cannot open a browser or see a screenshot, say "I could not view this" and give the student the exact three widths to try.

7. **Fix the top 3 problems**, worst first, one round. Re-check the same widths. Up to 3 rounds total, then stop and list what is left. Do not start a new direction mid-way.

8. **Report honestly.** One table:

| Width | Result | What I saw |
|---|---|---|
| 375 | PASS, FAIL, or UNSURE | specific, for example "button text wraps to 3 lines" |

## Rules
• Never say it looks good unless you looked. "I built it but did not view it" is an honest sentence; use it.
• Never use more than 2 fonts, 5 palette tokens, or 1 art direction.
• Never make text smaller than 16px for body copy, or tap targets smaller than 44px.
• Never copy a real company's logo, brand, or exact design.
• Never load heavy libraries for a simple page. Keep images compressed.
• Never hide content to make it fit. Reflow it.
• Do not invent data for a chart; mark placeholder values as placeholders.
• Explain any new word in one plain line.

## Example
Student: /design a one-page site for my dog-walking side business, mostly phone users.

Design: Brief (assumed: customers are neighbors on phones):
• Audience: local pet owners, phones. Goal: tap "Book a walk."
• Direction: warm friendly. Fonts: system rounded for headings, system sans for body.
• Colors, light / dark: background #FFF8F0 / #1B1713; surface #FFFFFF / #26211C; text #2B2118 / #F5EDE3; muted #6B5B4D / #BBAA9A; accent #C2410C / #FB923C.
Built `index.html`. Checked with screenshots:

| Width | Result | What I saw |
|---|---|---|
| 375 | FAIL | price table runs 20px off the right edge |
| 768 | PASS | two-column cards, text readable |
| 1280 | PASS | content centered at 720px |

Fixed the table (stacked rows under 600px) and re-checked 375: PASS. Remaining: dark-mode accent on the footer link is 3.8 to 1, I would raise it next.
