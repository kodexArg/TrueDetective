---
title: adr-10-survey-sense
type: adr
category: backend
use_case: changing the survey trigger, immobility window, radius, report cap, grouping, place naming, alert channel, or any detection number; touching SurveySense/StartingGear Lua or survey strings
created: 2026-08-08
modified: 2026-08-09
tags: [adr, backend, project-zomboid, b42, mechanics, survey-sense, true-detective]
---

# ADR-10 — True Detective mechanics: Survey Sense

## CONTEXT

> Survey Sense is the Detective's only special ability: with the
> magnifying glass he investigates on demand and whispers what he finds.
> This ADR is the binding law for its trigger, gates, report, and
> feedback. Stat numbers (cost, XP, forage) live as facts in
> [[DETECTIVE-STATS]]; this ADR governs behavior.

Owner decision 2026-08-08: the door/window interruption mechanics (Door
Sense, Lead Sense) are retired from `main` and archived on the `legacy`
branch. Survey Sense replaces them as the profession's single ability.

Owner decision 2026-08-09: the stillness trigger is retired. The survey
is on-demand only, activated through the magnifying glass; the exact
activation logic is TBD and binds nothing until the owner decides it.
Dropping the tick loop is expected to simplify the mechanic heavily
(KISS). Code written under the retired trigger still lives on `main` —
per adr-00 rule 11 that code is the defect until replaced.

## ASSERTIONS

1. **Trigger.** Survey Sense fires **on demand only**: an explicit player
   activation tied to the magnifying glass. The exact activation logic —
   target kinds, channel, timing — is TBD and binds nothing until the
   owner decides it. No part of the survey runs on a timer or polling
   loop.
2. **Tool gate.** The magnifying glass (`Base.MagnifyingGlass`, type
   `MagnifyingGlass`) must be equipped, in either hand. No glass,
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
11. **Re-arm.** Every on-demand activation is one full survey; nothing
    repeats on its own. Whether activation carries a cooldown is part of
    the TBD trigger logic.

## FORBIDDEN

- **NEVER** fire the survey from a tick, timer, or any passive polling
  loop — no `Events.OnTick` scanning, no automatic re-arm (rules 1, 11):
  the survey answers an explicit on-demand activation, and silence
  between activations means the player did not ask.
- **NEVER** reintroduce door/window open hooks or any activation
  interruption on `main` — that mechanic lives on the `legacy` branch.
- **NEVER** make the report audible or use `player:Say`; `setHaloNote` is
  the only channel.
- **NEVER** report the same zombie twice; the `tdSurvey` mark is final.
- **NEVER** alert on dead zombies or zombies outside the radius.
- **NEVER** add chance rolls to any part of this mechanic.
- **NEVER** change these rules in code without amending this ADR first.

## REJECTED

- **Stillness trigger (300 ticks unmoving, `Events.OnTick` throttled ×10)**
  — retired by owner 2026-08-09: passive auto-fire gave the player no
  agency and forced standing vulnerable to use the ability. Replaced by
  rule 1 (on-demand only). No reopen condition known.
- **Magnifier required in the primary hand specifically** — the
  primary-only gate served the hands-busy stillness channel; on-demand
  activation accepts either hand (rule 2).
- **Automatic 5-second re-arm while staying still** — died with the tick
  trigger; a repeat survey is a repeat activation (rule 11).
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
