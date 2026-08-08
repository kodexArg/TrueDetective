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

## UC-03 — Search mode raises detection chance

```gherkin
Given a True Detective character standing next to a door into a small room
And that room contains at least one living zombie
And the character is in search mode
When the character moves onto a new tile and the detection roll succeeds
Then the character speaks a danger phrase
```

## UC-04 — Passive intuition is rare

```gherkin
Given a True Detective character not in search mode
And a door-adjacent small room contains a living zombie
When the character changes tile
Then a danger phrase is spoken only when the passive roll succeeds
```

## UC-05 — Large rooms never alert

```gherkin
Given a True Detective character and a door-adjacent room larger than the room size gate
And living zombies are present in that room
When a detection roll would otherwise run
Then no danger phrase is spoken for that room
```

## UC-06 — Only living zombies count

```gherkin
Given a True Detective character and a small door-adjacent room
And the room contains only dead zombies or no IsoZombie objects
When detection runs
Then no danger phrase is spoken
```

## UC-07 — Non–True Detective characters do not get intuition

```gherkin
Given a character without the True Detective profession
When they change tiles beside a small room full of living zombies
Then True Detective does not speak danger phrases for them
```

## UC-08 — Search start phrase

```gherkin
Given a True Detective character
When they enter search mode
Then the character speaks a search-start phrase from the mod phrase pool
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
