---
title: Business logic for detective ability
description: Survey Sense — glass SearchBoost ×1.5 + Investigate on zombies + walk-up clues
updated: 2026-08-18
---

# Business logic for detective ability

Law: [[adr-10-survey-sense]].

## Passive loop — SearchBoost

1. Detective holds magnifying glass (either hand).
2. `SearchBoost` sets occupation forage `visionBonus` and specialisation
   weights to **base × 1.5**.
3. Unequip or wrong profession → restore base (1.75 / 10s).

## Passive loop — walk-up clue

1. Detective walks with glass in either hand.
2. Each new square rolls once ([[DETECTIVE-STATS]]: 4% search, 1% walk).
3. Hit → closest unmarked living zombie within 30, mark `tdLead`, whisper
   a footprint line (prints, drag, scuff + direction or the room they enter).
4. Miss or empty radius → silent.
5. Spoken clue starts a 90 s cooldown.
6. No roll while sprinting, in a vehicle, asleep, or without glass.

## Active loop — Investigate (only activable)

**This is the only player-triggered ability.** Glass in hand is a gate, not
a button. SearchBoost and walk-up clues are passive.

1. Profession gate for the menu; glass required only to succeed.
2. Right-click world object → context option **Investigate** when target is:
   - unalerted living zombie
   - dead zombie / corpse
   - self (stub)
3. Doors and windows never offer Investigate.
4. No glass in hand → whisper one of 6 “need a magnifying glass” lines; stop.
5. **Zombie / corpse:** find closest living partner within radius 30,
   skip `tdLead` partners; mark partner; whisper a mate line or a
   pack-origin line.
6. **Self:** crouch + primary glass → 2d6 wait phases with knight walks →
   search on: 1–2 closest leads (100%); search off: 75% one closest else
   nothing. Cancel / stand / drop glass → no lead.

## Files

| File | Role |
|------|------|
| `SearchBoost.lua` | Glass equip → forage def ×1.5 |
| `Investigate.lua` | Context menu + dispatch + Say |
| `investigate_leads.lua` | Partner scan, walk resolve, self resolve |
| `investigate_lines.lua` | Phrase pools |
| `walk_clue.lua` | Per-square chance while walking |
| `investigate_self_action.lua` | Self crouch channel (wait + knight walk) |

## Deleted (do not restore)

- `SurveySense.lua`, `survey_sense_action.lua`
- Aim residential + channel + area report
- Investigate on building doors / door probe

## Not in scope

- Self channeling design (TBD talk).
- Body bags as first-class targets.
- Custom revolver.
