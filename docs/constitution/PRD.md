---
title: Product Requirements Document
description: True Detective — B42.20 profession mod objective, players served, and horizon
updated: 2026-08-05
---

**True Detective** is a **Project Zomboid Build 42.20** profession mod. It answers the want for a careful *urban* investigator fantasy: stronger indoor/urban forage vision than Veteran, high affinity for junk, trash, and ammunition, and a unique **door-adjacent small-room zombie intuition** that speaks in character — louder while searching. It is the B42 rebuild of the private B41 *Detective Profession* (Workshop [3383387174](https://steamcommunity.com/sharedfiles/filedetails/?id=3383387174)); original mechanics live under `references/original-mod/` as the port baseline.

Registration on B42.20 uses **`CharacterProfession.register`** + script definition under `Contents/mods/TrueDetective/42.0/` — **not** B41 `ProfessionFactory`. Distinct from SOTO’s simpler `soto:detective`; door-room intuition is unique to this mod.

## Who it serves

- **Solo / co-op survivor** — picks **True Detective** at character creation for stealth-leaning urban looting and early room-clearing foresight.
- **Mod author (owner)** — ships and balances one cohesive profession package under `Contents/mods/TrueDetective/42.0/`.
- **Server host** — enables the mod on a B42.20 world so players share the same profession definition and detection rules.

Narratives: [[USER-STORIES]]. Behavior: [[USE-CASES]].

## The horizon

**Done for this rebuild:** True Detective registers on B42.20 via CharacterProfession registry (`truedetective:truedetective`); forage occupation bonuses and XP match [[adr-05-true-detective-mechanics]]; door-adjacent small-room detection and phrases work for True Detective characters only; clothing spawn definitions present; installable from `~/Zomboid/mods` or Workshop layout.

**Beyond:** Workshop publish for B42, optional multiplayer edge-case polish, phrase/localisation expansion, and any balance revisits only through ADR amend.

## What it must do

Watch the assertions first. A conventional PRD inlines its use cases and
user stories here; this harness keeps behavior with its owners:

- **`docs/assertions/`** — the laws. Owner-reserved, kept few; every
  assertion that exists is binding and proven by linked tests through
  [[TDD]] and `assertion-review`. None existing is healthy
  ([[assertion-00-discipline]]).
- **[[USE-CASES]]** — the behavior, in Gherkin, an open/close list.
- **[[USER-STORIES]]** — who wants what and why, accepted through their
  cases.
- **[[REQUIREMENTS]]** — the functional and non-functional ground the
  implementation must satisfy.
- **[[adr-05-true-detective-mechanics]]** — binding profession, forage,
  detection, phrase, and clothing numbers.

This section is agnostic to any product: it ships final and stays as
written.
