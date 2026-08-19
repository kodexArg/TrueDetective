---
title: Use Cases
description: True Detective behavior as Gherkin scenarios — open/close list cited as UC-NN
updated: 2026-08-17
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

## UC-11 — Investigate an unalerted zombie

```gherkin
Given a True Detective character holding a magnifying glass
And an unalerted living zombie under the cursor
When the player chooses Investigate
Then the character says one mate or pack-origin lead about the closest other living partner within 30
Or an alone-pool line if no partner
And that partner is marked tdLead and never receives a second lead
```

## UC-12 — No glass, no Investigate

```gherkin
Given a True Detective character without a magnifying glass
When the player opens the world context menu on a valid target
Then Investigate is not offered
And a non-Detective character never sees Investigate
```

## UC-13 — Investigate a building door — closed

Closed 2026-08-17. Doors are not Investigate targets. Replaced by UC-17.

## UC-17 — Walk-up clue while moving

```gherkin
Given a True Detective holding a magnifying glass
And the character walks onto a new square
When the per-square chance hits and an unmarked living zombie is within 30
Then the character says one footprint line (direction or the room the prints enter) about that partner
And the partner is marked tdLead
And a failed roll or empty radius produces no speech
```

## UC-18 — Investigate a dead zombie

```gherkin
Given a True Detective character holding a magnifying glass
And a dead zombie or corpse under the cursor
When the player chooses Investigate
Then the character says one mate or pack-origin lead about the closest living partner within 30
Or an alone-pool line if no partner
And that partner is marked tdLead
```

## UC-19 — Doors are not Investigate targets

```gherkin
Given a True Detective character and a building door under the cursor
When the player opens the world context menu
Then Investigate is not offered on that door
```

## UC-14 — Glass SearchBoost

```gherkin
Given a True Detective holding a magnifying glass
When forage occupation bonuses resolve
Then visionBonus and specialisations are base times 1.5
And unequipping the glass restores base values
```

## UC-15 — Aim does not activate Survey Sense

```gherkin
Given a True Detective holding a magnifying glass
When the character aims at a residential building
Then no channel starts and no area survey report is produced
```

## UC-16 — Self Investigate stub

```gherkin
Given a True Detective holding a magnifying glass
When the player chooses Investigate on self
Then only the stub path runs (TBD design)
```
