---
title: adr-10-survey-sense
type: adr
category: backend
use_case: changing the survey trigger, immobility window, radius, report cap, grouping, place naming, alert channel, or any detection number; touching SurveySense/StartingGear Lua or survey strings
created: 2026-08-08
modified: 2026-08-08
tags: [adr, backend, project-zomboid, b42, mechanics, survey-sense, true-detective]
---

# ADR-10 — True Detective mechanics: Survey Sense

## CONTEXT

> Survey Sense is the Detective's only special ability: standing still with
> a magnifying glass in hand, he reads the surroundings and whispers what
> he sees. This ADR is the binding law for its trigger, gates, report, and
> feedback. Stat numbers (cost, XP, forage) live as facts in
> [[DETECTIVE-STATS]]; this ADR governs behavior.

Owner decision 2026-08-08: the door/window interruption mechanics (Door
Sense, Lead Sense) are retired from `main` and archived on the `legacy`
branch. Survey Sense replaces them as the profession's single ability.

## ASSERTIONS

1. **Trigger.** Survey Sense fires after the detective stands on the same
   square, unmoving, for **300 ticks (~5 real seconds)**. Movement resets
   the count; so does losing the magnifier gate. Implemented on
   `Events.OnTick`, throttled to one check every **10 ticks**.
2. **Tool gate.** The magnifying glass (`Base.MagnifyingGlass`, type
   `MagnifyingGlass`) must be equipped as **primary hand item**. No glass,
   no survey. The glass is guaranteed starting gear for this reason.
3. **Profession gate.** Only `truedetective` (`getName()`). Other
   professions never survey.
4. **Radius.** The scan covers a circle of **15 squares** on the player's
   z-level. Walls do not block it — the detective reads the building, not
   the view.
5. **Report cap.** At most **5** zombies per survey, closest first
   (squared distance, no sqrt).
6. **Once per zombie.** A reported zombie is marked in its modData
   (`tdSurvey`) and never reported again. Dead zombies are never reported.
7. **Grouping.** Reported zombies are grouped by place: same named room,
   or same compass direction outdoors. A place holding **3 or more**
   reported zombies yields one group line ("A group of 4 zombies in the
   kitchen."); smaller places yield one line per zombie.
8. **Place naming.** Indoors: the room's engine name (`room:getName()`)
   through `UI_td_room_<name>` translations; untranslated rooms fall back
   to "building". Outdoors: an 8-way compass direction from the player
   ("to the north-east").
9. **Feedback.** Every line is a silent `setHaloNote` — the whisper. No
   sound, no zombie attraction, nothing audible to other players.
10. **Determinism.** Given the same world state the report is always the
    same: no chance rolls anywhere in the trigger, scan, grouping, or
    wording. Distance sort is a pure function of zombie positions.
11. **Re-arm.** After a survey the stillness count resets; a detective who
    keeps watching surveys again every 5 seconds, reporting only newly
    arrived (unmarked) zombies. Silence means nothing new.

## FORBIDDEN

- **NEVER** reintroduce door/window open hooks or any activation
  interruption on `main` — that mechanic lives on the `legacy` branch.
- **NEVER** make the report audible or use `player:Say`; `setHaloNote` is
  the only channel.
- **NEVER** report the same zombie twice; the `tdSurvey` mark is final.
- **NEVER** alert on dead zombies or zombies outside the radius.
- **NEVER** add chance rolls to any part of this mechanic.
- **NEVER** change these rules in code without amending this ADR first.

## REJECTED

- **Door/window interruption (Door Sense, Lead Sense)** — retired by owner
  2026-08-08; preserved on the `legacy` branch, never on `main`.
- **`player:Say` for reports** — audible to nearby players in MP and
  implies sound; `setHaloNote` whispers.
- **Room-size caps** — the magnifier survey reports places by name; a
  large room is a valid place, unlike the retired door read.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/SurveySense.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/StartingGear.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/Translate/EN/UI.json`

### related files

- [[adr-05-project-zomboid-mod-structure]] — tree law
- [[adr-07-clean-code]] — code shape
- [[DETECTIVE-STATS]] — stat facts (cost, XP, forage)
- [[OUTFIT]] — loadout facts (glass guaranteed, pipe, loaded revolver)
- [[MOD-API]] — live surface
- [[PRD]] — product fantasy
