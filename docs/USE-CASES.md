---
title: Use Cases
description: True Detective behavior as Gherkin scenarios — open/close list cited as UC-NN
updated: 2026-08-09
---

A use case is one behavior of the system, and Gherkin is its required
language: every case is a `Given / When / Then` scenario, concrete enough to
walk through. Prose around a scenario may set context; the scenario is the
case.

This is an open/close file: cases live as `##` chapters that open and close
as the product evolves. A case is cited as `UC-NN`; numbers are appended,
never reused. Stories in [[USER-STORIES]] name cases in `Realized by`.

Binding numbers live in [[adr-10-survey-sense]] and [[DETECTIVE-STATS]].

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

## UC-11 — Survey a dwelling through the glass

```gherkin
Given a True Detective character holding a magnifying glass
And the character aims at a residential building
And living unmarked zombies within 30 squares
When the character completes the Survey Sense channel (~5 seconds)
Then the character whispers report lines (setHaloNote) naming places
And no sound is emitted
And the outcome is deterministic (no chance rolls)
```

## UC-12 — No glass or no dwelling, no survey

```gherkin
Given a True Detective character without a magnifying glass
Or not aiming at a residential building
When the character would use Survey Sense
Then no survey channel starts and no report is produced
And a non-Detective character never surveys either
```

## UC-13 — Closest five, once per zombie

```gherkin
Given a True Detective character completes a survey channel
When more than five living unmarked zombies are in radius
Then at most the five closest are reported
And each reported zombie is marked and never reported again
And dead zombies are never reported in the area scan
```

## UC-14 — Groups named by place

```gherkin
Given a survey reports three or more zombies in the same room
Then one group line names the count and the room
And a zombie outdoors is named by compass direction instead
And a room without a translation falls back to "building"
```
