---
title: Business logic for detective ability
description: Survey Sense — glass + aim residential dwelling + 5s channel + generous scan
updated: 2026-08-09
---

# Business logic for detective ability

Law: [[adr-10-survey-sense]].

## Loop

1. Detective holds magnifying glass (either hand).
2. Starts **aiming** (rising edge).
3. Aim ray (up to 40 squares along `getAimVector` / forward) hits an
   `IsoBuilding` with `isResidential() == true`.
4. Enqueue `survey_sense_action` (~5 s / maxTime 300, anim `Loot`).
5. Channel stays valid only while: glass held, still aiming, residential
   still under the ray.
6. On **complete**: scan living unmarked zombies within **radius 30**,
   take ≤5 closest, mark `tdSurvey`, queue silent halo lines.
7. On **cancel**: no report.

Chance: **always 100%** when the channel completes (no rolls).

## Files

| File | Role |
|------|------|
| `SurveySense.lua` | Gates, aim residential, report, whisper drain, `OnPlayerUpdate` |
| `survey_sense_action.lua` | Timed action channel |

## Not in scope

- Path history ("zombie passed here").
- Custom magnifier animation assets.
- Door/window open interruption (legacy only).
