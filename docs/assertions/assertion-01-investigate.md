---
title: assertion-01-investigate
type: assertion
status: open
updated: 2026-08-18
---

# Assertion 01 — Investigate + glass search

While the player is profession `truedetective` and holds `MagnifyingGlass` in
either hand, forage/search vision and occupation specialisation weights are
multiplied by **1.5** (passive SearchBoost only). The **only activable**
ability is **right-click Investigate** on allowed objects. There is **no**
aim-based survey, **no** second button, and **no** `survey_sense_action` in
the live tree. **Investigate** appears only for: unalerted living zombies,
dead zombies, and self. **Doors and windows never offer Investigate.**
Investigate on a living or dead zombie produces **one** whispered English
lead about the **closest other living** zombie within radius **30** (or an
alone-pool line). The lead is a **mate** line or a **pack-origin** line.
The partner is marked with modData `tdLead` so it cannot receive a second
lead. While walking with the glass, each new square may whisper one
**footprint** walk-up clue (direction / room / building the prints enter)
at the chances in [[DETECTIVE-STATS]]; a miss is silent; a hit marks
`tdLead`. Self Investigate is a stub (TBD).

## RELATED

### Tests

- T-struct-1: `rg` live `Contents/` — zero `survey_sense_action`,
  `TrueDetective_SurveySense`, `aim_residential`, `was_aiming`,
  `try_start_survey`; both old files absent.
- T-struct-2: `OnFillWorldObjectContextMenu` in `Investigate.lua`.
- T-struct-3: no `find_door` / `lead_from_door` in live Lua.
- T-struct-4: `walk_clue.lua` exists; `UI.json` has `UI_td_investigate`
  and ≥6 lines per pool family (mate, pack, walk, alone, nothing, need-glass).
- T-inst-1: `scripts/install-local.sh` exits 0; install tree matches repo.
- S-* smoke matrix in plan / `log/YYYYMMDD-NNN.log` after in-game pass.

### Law

- [[adr-10-survey-sense]]
- [[business-logic-for-detective-ability]]
- [[TDD]]
