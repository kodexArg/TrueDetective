---
title: adr-10-true-detective-mechanics
type: adr
category: backend
use_case: changing door sense trigger, interruption, sneak or chase filters, room cap, cooldown, alert channel, or any detection number; touching DoorSense/RoomScan/Phrases Lua
created: 2026-08-08
modified: 2026-08-08
tags: [adr, backend, project-zomboid, b42, mechanics, door-sense, true-detective]
---

# ADR-10 — True Detective mechanics: Door Sense

## CONTEXT

> Door Sense is the Detective's special ability: reading a room through a
> door or window before opening it. This ADR is the binding law for its
> trigger, filters, interruption, and feedback. Stat numbers (cost, XP,
> forage) live as facts in [[DETECTIVE-STATS]]; this ADR governs behavior.

Supersedes the detection parts of
`legacy/docs/adrs/adr-05-true-detective-mechanics.md` (square-change trigger,
66/10 chances). Legacy is archive, never law. Owner decision 2026-08-08:
deterministic pattern, no chance rolls.

## ASSERTIONS

1. **Trigger.** Door Sense runs when the player activates a door or window
   (E, click, or context menu). Implementation wraps
   `ISOpenCloseDoor:complete()` and `ISOpenCloseWindow:perform()` — the
   funnel every open path uses on B42.20.
2. **Execution point.** The check runs **before** the element activates.
   On a positive read the activation is **interrupted**: `ToggleDoor` /
   `openWindow` never run and the element stays closed.
3. **Profession gate.** Only `truedetective` (`getName()`). Other
   professions open elements untouched.
4. **Attention levels.** The read is a chance roll by player state:
   **search mode active → 100%**, **sneaking → 50%**, otherwise **25%**.
   Search mode state is `ISSearchManager.players[player].isSearchMode`.
5. **Chase filter.** If any live zombie within 10 squares currently targets
   the player, Door Sense stays silent — a chased detective has no focus.
6. **Open-state filter.** Closing an element never triggers a read; only
   opening (element currently closed) does.
7. **Locked filter.** A locked door cannot open, so it cannot expose the
   player: no read, no interruption.
8. **Valid room.** The far side of the element must resolve to a room
   (`square:getRoom()` non-nil) of at most **50** squares. Larger or
   undefined spaces never alert.
9. **Threat check.** An alert requires at least one live `IsoZombie` among
   the room squares' moving objects. Dead bodies never alert.
10. **Feedback.** On interruption the detective speaks a silent line:
    `setHaloNote` with a random entry from the danger phrase pool. No sound,
    no zombie attraction.
11. **Cooldown.** An interrupted element enters a **5 in-game minute**
    cooldown (stored per element coordinates in player modData). During
    cooldown the element opens normally — the second activation goes
    straight through. Safe openings never start a cooldown.
12. **Alert chance by attention.** Only the attention roll of rule 4
    decides whether the read happens. Given a successful read, detection is
    deterministic: filters + room + zombie.

## FORBIDDEN

- **NEVER** reintroduce the legacy square-change trigger or its 66/10
  search-toggle chances (owner replaced them with the attention levels of
  rule 4).
- **NEVER** change the attention chances (100 / 50 / 25) without amending
  this ADR.
- **NEVER** poll per tick or on player move for this feature.
- **NEVER** alert on rooms over 50 squares, dead zombies, or non-room spaces.
- **NEVER** make the alert audible to zombies or emit sound.
- **NEVER** change these rules in code without amending this ADR first.

## REJECTED

- **Square-change trigger (legacy)** — rejected by owner; the read belongs
  to the moment of opening, not to walking past.
- **66% search / 10% passive chances (legacy)** — rejected; replaced first
  by a deterministic sneak gate, then by the 100/50/25 attention levels.
- **Sneak-only deterministic gate (first cut)** — rejected by owner; search
  mode is the deliberate-investigation state, chances reward attention.
- **`player:Say` for alerts** — rejected; audible speech to nearby players
  in MP. `setHaloNote` is the silent channel.
- **Interrupting locked doors** — rejected; a door that cannot open exposes
  no one.
- **Climbing through broken windows** — v2; different action
  (`ISClimbThroughWindow`), not an open activation.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/DoorSense.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/TrueDetective/RoomScan.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/TrueDetective/Phrases.lua`
- `Contents/mods/TrueDetective/42.0/media/lua/shared/Translate/EN/UI.json`

### related files

- [[adr-05-project-zomboid-mod-structure]] — tree law
- [[adr-07-clean-code]] — code shape
- [[DETECTIVE-STATS]] — stat facts (cost, XP, forage)
- [[MOD-API]] — live surface
- [[PRD]] — product fantasy
