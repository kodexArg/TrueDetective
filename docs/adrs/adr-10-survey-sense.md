---
title: adr-10-survey-sense
type: adr
category: backend
use_case: changing Survey Sense activation, glass gate, radius, report cap, grouping, place naming, alert channel, or any detection number; touching SurveySense/StartingGear Lua or survey strings
created: 2026-08-08
modified: 2026-08-09
tags: [adr, backend, project-zomboid, b42, mechanics, survey-sense, true-detective]
---

# ADR-10 — Survey Sense

## CONTEXT

> Survey Sense is the Detective's only special ability. There is **one**
> method to use it: **hold a magnifying glass**, aim at a **residential
> building**, and complete a short channel. This ADR binds the gate,
> channel, report, and feedback. Stat numbers live in [[DETECTIVE-STATS]].

## ASSERTIONS

1. **One method.** Survey Sense only runs while a magnifying glass
   (`Base.MagnifyingGlass` / type `MagnifyingGlass`) is held in either
   hand. No glass → no survey. The glass is guaranteed starting gear.
2. **Profession gate.** Only `truedetective` (`getName()`).
3. **Dwelling aim.** Activation requires the player to **aim** so the aim
   ray hits a **residential** building (`IsoBuilding:isResidential()`).
   Non-dwellings never start a survey.
4. **Channel.** A successful aim starts an `ISBaseTimedAction` channel of
   **~5 seconds** (engine action time 300). The survey report fires only
   when the channel **completes**. Cancel (walk, drop aim, lose glass,
   lose dwelling under aim) yields no report.
5. **Radius.** On complete, scan living unmarked zombies in a circle of
   **30** squares on the player's z-level. Walls do not block the scan.
6. **Report cap.** At most **5** living unmarked zombies per survey,
   closest first (squared distance).
7. **Once per zombie.** Mark reported zombies in modData (`tdSurvey`).
   Never report the same zombie twice. Never report dead zombies in the
   area scan.
8. **Grouping.** Group by named room indoors, or compass direction
   outdoors. **3+** in one place → one group line; fewer → one line each.
9. **Place naming.** Indoors: `room:getName()` via `UI_td_room_<name>`;
   unknown rooms → "building". Outdoors: 8-way compass from the player.
10. **Feedback.** Silent `setHaloNote` only, one line at a time (queue if
    several lines). No sound, no `player:Say`.
11. **Determinism.** Same world state → same report. **No chance rolls.**

## FORBIDDEN

- **NEVER** offer Survey Sense without the magnifying glass held.
- **NEVER** start a survey without a residential building under aim.
- **NEVER** fire the report without completing the channel.
- **NEVER** add a second special ability or activation that bypasses the glass.
- **NEVER** drive the survey from a passive stillness / stand-still loop.
- **NEVER** make the report audible.
- **NEVER** report the same zombie twice; `tdSurvey` is final.
- **NEVER** change these rules in code without amending this ADR first.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/SurveySense.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/survey_sense_action.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/StartingGear.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/Translate/EN/UI.json`

### related files

- [[business-logic-for-detective-ability]]
- [[adr-05-project-zomboid-mod-structure]]
- [[adr-07-clean-code]]
- [[DETECTIVE-STATS]]
- [[OUTFIT]]
- [[MOD-API]]
- [[PRD]]
