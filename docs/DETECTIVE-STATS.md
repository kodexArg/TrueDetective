---
title: Detective Stats
description: True Detective stat decisions, one fact per section — value, justification, vanilla reference
updated: 2026-08-18
---

# Detective Stats

Each section is one stat decision: the value, why it is that value, and the
vanilla professions that anchor it. Sections marked **shipped** are live in
`Contents/mods/TrueDetective/42.0/`.

## Aiming +2 — shipped

> The Detective is no marksman — he leaves the nimble gunplay to others.
> But the revolver on his hip is not a prop: he has carried it every working
> day for years, and that routine makes him a measured, reliable shot.
> Aiming +2 puts him at the Veteran's level of gun handling, without the
> Veteran's nerves of steel or military training.

### Reference

- Police Officer (−4): Aiming +4, Reloading +1, Nimble +1
- Veteran (−8): Aiming +2, Reloading +2, trait Desensitized

## Cost −8 — shipped

> A fedora, a leather coat, a revolver he already owns, and the best urban
> search eye in Knox County. That package does not come cheap: the Detective
> costs what the Veteran costs, the ceiling of the vanilla scale. Balance
> notes on this price are still open — the number is set, the reasoning
> continues.

### Reference

- Veteran (−8): the most expensive vanilla profession
- Burglar (−6): the next step down

## visionBonus 1.75 — shipped

> Decades of reading rooms and scenes trained the Detective's eye for what
> people drop, hide, and leave behind. He ties the Veteran's search radius
> and stays below the Park Ranger — the wilderness keeps its crown; the
> town is his.

### Reference

- Park Ranger: visionBonus 2.0 (the crown we do not take)
- Veteran: visionBonus 1.75 (the tie)

## darknessEffect 15 — shipped

> Detective work happens indoors, at night, in buildings without power.
> He searches the dark as well as any burglar, ranger, or veteran — the
> shared vanilla ceiling — and no better.

### Reference

- Burglar / Park Ranger / Veteran / Lumberjack: darknessEffect 15 (ceiling)
- Police / Security Guard: darknessEffect 10

## weatherEffect 0 — shipped

> Rain and fog are outdoor problems. The Detective works the urban grid and
> takes the full weather penalty like any office-bred profession.

### Reference

- Fisherman: weatherEffect 40 (outdoor ceiling)
- Most urban professions: weatherEffect 0–5

## Glass search ×1.5 — shipped

> With the magnifying glass in either hand, the Detective's occupation
> forage package multiplies by **1.5**: `visionBonus` 1.75 → **2.625**,
> each urban specialisation 10 → **15**. Drop the glass and the base
> numbers return. This is SearchBoost, not aim-channel Survey.

### Reference

- Base occupation package: visionBonus 1.75, specialisations 10
- Hook: `forageSystem.skillDefs.occupation.truedetective` via `SearchBoost.lua`

## Walk-up clue — 4% search / 1% walk · 90 s cooldown — shipping

> The Detective does not press a second power. He walks with the glass and
> sometimes the ground gives him a trail. Each **new square** rolls once.
> Search mode is the eye on the job: **4%**. Ordinary walk: **1%**. A
> spoken clue starts a **90 second** real-time cooldown. A miss says
> nothing. Sprint, a vehicle, no glass, or a marked pack nearby yield no
> line. Radius is the same **30** as Investigate.

### Reference

- Investigate partner radius: 30 (same scan)
- Door 50% probe (retired 2026-08-17): replaced by this per-square chance
- Hook: `walk_clue.lua` on `OnPlayerUpdate`, square-change gate

## Urban specialisations — 10 across the board — shipped

> Trash, Junk, JunkWeapons, Ammunition, Medical: each at 10. The Detective
> finds man-made leftovers like a cop or a burglar — never like a repairman.
> Ten is the professional's floor, not the specialist's ceiling, and that is
> exactly where an investigator belongs. Nothing outdoor: no plants, no
> animals, no forest rarities.

### Reference

- Repairman / Mechanic: Trash 33, Junk 33 (the junk kings)
- Burglar / Police / Security: Trash 10, Junk 10, JunkWeapons 10, Ammunition 10
