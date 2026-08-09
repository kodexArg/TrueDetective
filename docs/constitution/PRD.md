---
title: Product Requirements Document
description: True Detective — B42.20 profession mod objective, who it serves, and the product horizon
updated: 2026-08-09
---

**True Detective** is a **Project Zomboid Build 42.20** **profession mod**. It adds one fully integrated, playable occupation: **the Detective** (display name **Detective**). It answers the want for a careful *urban* investigator fantasy — stronger indoor/urban forage vision than Veteran, high affinity for junk, trash, and ammunition, and a unique **magnifying-glass survey**: on demand, he investigates through the glass and whispers what he finds.

This is the B42 rebuild of the private B41 *Detective Profession* (Workshop [3383387174](https://steamcommunity.com/sharedfiles/filedetails/?id=3383387174)). Registration on B42.20 uses **`CharacterProfession.register`** plus script definition under `Contents/mods/TrueDetective/42.0/` — **never** B41 `ProfessionFactory`. The occupation is distinct from third-party packs (for example SOTO’s simpler `soto:detective`); **the magnifier survey with whispered lines is unique to this mod**.

Live product root: `Contents/mods/TrueDetective/`. Prior greenfield hello-world and older rebuild trees may sit under `legacy/` as archive only — they are not the product.

## Who it serves

- **Solo / co-op survivor** — picks **True Detective** at character creation for stealth-leaning urban looting and early room-clearing foresight.
- **Mod author (owner · kodexArg)** — ships and balances one cohesive profession package under the Workshop-shaped tree.
- **Server host** — enables the mod on a B42.20 world so every client shares the same profession definition and detection rules.

Narratives: [[USER-STORIES]]. Behavior: [[USE-CASES]].

## The horizon

**Done for the profession product:** True Detective registers on B42.20 via the CharacterProfession registry (`truedetective:truedetective`); forage occupation bonuses and XP match the binding mechanics ADR; Survey Sense (on-demand magnifier investigation → whispered report) runs for True Detective characters only; clothing spawn definitions present; installable from `~/Zomboid/mods` (via `scripts/install-local.sh`) or Workshop layout with load folder **`42.0/`**.

**Beyond:** Workshop publish for B42, multiplayer edge polish, phrase and localisation expansion, and any balance revisits only through ADR amend — never by re-activating `legacy/` as live code.

Baseline tag **v42.20-0.1** was harness + hello-world mock only. Profession features ship after that baseline under new tags and `modversion` bumps.

## What it must do

Watch the assertions first. A conventional PRD inlines its use cases and
user stories here; this harness keeps behavior with its owners:

- **`docs/assertions/`** — the laws. Owner-reserved, kept few; every
  assertion that exists is binding and proven by linked tests through
  [[TDD]] and `kskill-assertion-review`. None existing is healthy
  ([[assertion-00-discipline]]).
- **[[USE-CASES]]** — the behavior, in Gherkin, an open/close list.
- **[[USER-STORIES]]** — who wants what and why, accepted through their
  cases.
- **[[REQUIREMENTS]]** — the functional and non-functional ground the
  implementation must satisfy.

This section is agnostic to any product: it ships final and stays as
written.
