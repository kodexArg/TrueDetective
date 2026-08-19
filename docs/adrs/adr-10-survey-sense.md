---
title: adr-10-survey-sense
type: adr
category: backend
use_case: changing Investigate activation, walk-up clue chance, glass search boost, lead marks, phrase pools, or any Survey Sense number; touching Investigate/SearchBoost/walk_clue Lua or UI strings
created: 2026-08-08
modified: 2026-08-18
tags: [adr, backend, project-zomboid, b42, mechanics, survey-sense, investigate, walk-clue, true-detective]
---

# ADR-10 — Survey Sense (Investigate)

## CONTEXT

> Survey Sense is the Detective's only special ability brand. The **player
> verb is Investigate**. The magnifying glass is a **gate and a search tool**,
> not an aim-to-fire activator. This ADR binds the profession gate, the glass
> requirement, Investigate targets, walk-up chance, and where copy and
> chance values live. This ADR does not set those numbers.

## ASSERTIONS

1. **Profession gate.** Only `truedetective` (`getName()`).
2. **Glass is mandatory.** Holding the magnifying glass in either hand
   raises the Detective's search stats. This ADR does not set those
   numbers. The glass is required to trigger any Survey Sense ability.
   Either hand is enough. The glass is mandatory by design.
3. **Investigate menu.** Right-click **Investigate** is visible only when
   a chance exists and the action is possible.
4. **Valid targets.** Valid Investigate targets may change. This ADR
   declares the current set. Declared now: (a) living zombie that is not
   alerted; (b) dead zombie / corpse; (c) self (own tile). Never a door.
   Never a window.
5. **Walk-up clue (passive).** While the Detective walks with the glass, a
   walk-up clue may trigger by chance. Stance and other modifiers can
   change that chance. This ADR does not set those numbers. Walk-up is
   not a button.
6. **Chance gate.** A passive ability fires only after its chance roll
   passes. A failed roll does nothing.
7. **Phrase engine.** Spoken lines live in a separate language file.
   Ability Lua does not own the copy.
8. **Configurable chances.** Chance values for passive and active
   abilities live in a dedicated config file. They are not hardcoded in
   ability Lua.

## FORBIDDEN

- **NEVER** add a second activable path (key, aim, channel, hotbar). Walk-up
  chance is the only allowed non-click observation, and it is not a button.
- **NEVER** start Investigate from aim, scope, or aim ray.
- **NEVER** ship `survey_sense_action` or aim-channel timed actions.
- **NEVER** treat SearchBoost as an activable skill.
- **NEVER** offer Investigate without the magnifying glass held.
- **NEVER** offer Investigate on windows.
- **NEVER** offer Investigate on doors. Door probe is rejected.
- **NEVER** report a second lead on a living zombie with `tdLead`.
- **NEVER** whisper a walk-up miss. Empty radius and failed rolls stay silent.
- **NEVER** fire a walk-up clue without the glass, while sprinting, or in a
  vehicle.
- **NEVER** use Spanish (or other) copy in v1 EN `UI.json` for leads.
- **NEVER** implement full self Investigate without amending this ADR.
- **NEVER** change these rules in code without amending this ADR first.

## REJECTED

- **Glass + aim residential + ~5 s channel + ≤5 zombie area report** —
  deleted 2026-08-10. Too passive-hostile (aim edge), repetitive compass
  lines, and wrong fantasy (investigate a subject, not scan the skyline).
- **Silent halo-only multi-line report as primary output** — replaced by
  whispered speech for a single lead.
- **Pre-filled aim activation “disabled but left in tree”** — rejected;
  dead code is deleted, not flagged off.
- **Absolute no-rolls on all paths** — line pick uses seeded index; walk-up
  chance uses a per-square roll.
- **Investigate on building doors (interior-face 100%/50% probe)** —
  dropped 2026-08-17. The subject is a zombie, live or dead, not a door.
  Walk-up chance replaces environmental discovery.
- **Blanket ban on any auto-tick lead** — dropped 2026-08-17 for a gated
  walk-up chance only (new square, glass, cooldown, silent miss). Key / aim
  / channel / hotbar stay forbidden.
- **Walk-up mate/pack two-beat voice** (*Picked up a trail. His pack
  comes from…*) — dropped 2026-08-18. Random clues detect **footprints**
  and a direction. Mate/pack stays on Investigate only.
- **Investigate menu without glass** — dropped 2026-08-18. Glass is
  mandatory to trigger any ability (rule 2).
- **ADR inlines SearchBoost, walk-up, and self-channel numbers** —
  dropped 2026-08-18. This ADR does not set those numbers (rules 2, 5, 8).
- **One-lead radius, mate/pack voice, `tdLead`, and self 2d6 knight
  channel as assertions** — dropped 2026-08-18. Targets stay declared
  (rule 4). Phrase copy and chance values leave this ADR (rules 7, 8).

## RELATED

### governed paths

- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/Investigate.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/investigate_leads.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/investigate_lines.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/walk_clue.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/TrueDetective/SearchBoost.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/TrueDetective/Chances.lua`
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
- [[assertion-01-investigate]]
