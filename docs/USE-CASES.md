---
title: Use Cases
description: True Detective behavior as Gherkin scenarios — open/close list cited as UC-NN
updated: 2026-08-08
---

A use case is one behavior of the system, and Gherkin is its required
language: every case is a `Given / When / Then` scenario, concrete enough to
walk through. Prose around a scenario may set context; the scenario is the
case.

This is an open/close file: cases live as `##` chapters that open and close
as the product evolves. A case is cited as `UC-NN`; numbers are appended,
never reused. Stories in [[USER-STORIES]] name cases in `Realized by`.

Binding numbers for cost, XP, forage, and detection live in the mechanics
ADR once that ADR is in force under `docs/adrs/`. Until then, cases state the
intended profession behavior from [[PRD]] and [[REQUIREMENTS]].

## UC-01 — True Detective profession available at creation

```gherkin
Given Project Zomboid Build 42.20 with True Detective enabled
When the player opens character creation professions
Then True Detective is listed as a playable profession
And registration used CharacterProfession (not ProfessionFactory)
```

## UC-02 — Urban forage occupation bonuses apply

```gherkin
Given a living character with the True Detective profession
When the forage/search systems resolve occupation bonuses
Then vision and specialisations match the binding mechanics ADR
And Junk, Trash, and Ammunition remain high-affinity categories
```

## UC-03 — CLOSED (legacy tile-change roll)

Retired 2026-08-08 with the door/window senses; archive on the `legacy`
branch. Survey Sense (UC-11 and up) replaces the roll model.

## UC-04 — CLOSED (legacy passive roll)

Retired 2026-08-08, see UC-03.

## UC-05 — CLOSED (legacy room-size gate)

Retired 2026-08-08, see UC-03.

## UC-06 — CLOSED (legacy living-only gate)

Retired 2026-08-08, see UC-03.

## UC-07 — CLOSED (legacy profession gate case)

Retired 2026-08-08, see UC-03. The profession gate itself lives on in UC-11.

## UC-08 — CLOSED (legacy search-start phrase)

Retired 2026-08-08, see UC-03.

## UC-11 — Survey after five still seconds

```gherkin
Given a True Detective character with a magnifying glass equipped as primary
And living unmarked zombies within 15 squares
When the character stays on the same square for about 5 real seconds
Then the character whispers a report line (setHaloNote) naming places
And no sound is emitted
```

## UC-12 — No glass, no survey

```gherkin
Given a True Detective character without a magnifying glass as primary
When the character stands still for any length of time
Then no survey report is produced
And a non-Detective character never surveys either
```

## UC-13 — Closest five, once per zombie

```gherkin
Given a True Detective character surveying
When more than five living unmarked zombies are in radius
Then at most the five closest are reported
And each reported zombie is marked and never reported again
And dead zombies are never reported
```

## UC-14 — Groups named by place

```gherkin
Given a survey reports three or more zombies in the same room
Then one group line names the count and the room
And a zombie outdoors is named by compass direction instead
And a room without a translation falls back to "building"
```

## UC-09 — Clothing spawn definitions

```gherkin
Given character creation for True Detective
When clothing selection is resolved
Then profession clothing definitions apply for the Detective identity
```

## UC-10 — Mod loads on B42.20

```gherkin
Given a local install via scripts/install-local.sh
And Project Zomboid Build 42.20 with True Detective enabled
When the client boots to the main menu
Then the mod loads without requiring ProfessionFactory
And the load root used is 42.0
```
