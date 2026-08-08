---
title: Mod API
description: B42.20 CharacterProfession registry, forage occupation, events, and phrase surface for True Detective
updated: 2026-08-05
---

This document is the **mod surface** (what the package registers and hooks).
It is not an HTTP API. Numbers that must not drift without review are owned
by [[adr-05-true-detective-mechanics]].

## Package identity

| Field | Value |
|---|---|
| Folder | `Contents/mods/TrueDetective/` |
| B42 version folder | **`42.0/`** (live media under `42.0/media/`) |
| `mod.info` id | `TrueDetective` |
| Workshop id | **3383387174** |
| Continuity | B41 id was `detectiveProfession` / `prof_detective` — B42 product is **True Detective** |

### Load path (B42.20)

```text
Contents/mods/TrueDetective/
├── mod.info                          # root stub
└── 42.0/
    ├── mod.info                      # versioned load root
    └── media/
        ├── registries.lua            # CharacterProfession.register
        ├── scripts/characters/
        │   └── TrueDetective_professions.txt
        ├── lua/shared/TrueDetective/ # forage, clothing, detection, phrases, helper
        ├── lua/client/TrueDetective/ # search + move events
        ├── lua/shared/Translate/…    # EN / ES / AR
        ├── textures/
        └── shared/
```

Local install: `~/Zomboid/mods/TrueDetective` → this folder (symlink).

## Profession registration — B42.20 (no ProfessionFactory)

> **Agents: never use `ProfessionFactory`.** It is **gone** in B42.20.
> Profession mods follow the **SOTO-style** pattern: early registry + script
> definition. Do not port B41 `ProfessionFactory.addProfession` code.

| Step | File | API / content |
|---|---|---|
| 1. Register type | `42.0/media/registries.lua` | `CharacterProfession.register("truedetective:truedetective")` |
| 2. Define profession | `42.0/media/scripts/characters/TrueDetective_professions.txt` | `character_profession_definition truedetective:truedetective` |

| Field | Value |
|---|---|
| Resource id | `truedetective:truedetective` |
| `getName()` | **`truedetective`** (path component; used for forage + clothing keys) |
| Display name | Translation `UI_prof_truedetective` → **True Detective** |
| Description | Translation `UI_profdesc_truedetective` |
| Icon | `profession_detective` texture |
| Cost | **−6** |
| XP boosts | Aiming **+1**, Lightfoot **+1**, Sneak **+2** |

### Profession check (runtime)

```text
desc:getCharacterProfession()   -- B42.20 preferred
-- NOT desc:getProfession() as the primary path (B41 leftover)
```

Helper: `TrueDetective.isProfession(player)` in
`media/lua/shared/TrueDetective/ProfessionHelper.lua` — prefers
`getCharacterProfession():getName()` / type equality; may accept legacy
aliases for port safety.

### Not SOTO’s detective

**SOTO** (Survive the Outskirts / similar occupation packs) may ship a simpler
`soto:detective` occupation. **This mod is not that.** Ours is **True Detective**
(`truedetective:truedetective`) with unique **door-adjacent small-room zombie
intuition** and spoken phrases — SOTO does not provide that fantasy.

## Forage occupation

Registered on `Events.OnGameBoot` via `forageSystem.addSkillDef`.

| Field | Value |
|---|---|
| `def.name` | **`truedetective`** — **must equal** `CharacterProfession:getName()` |
| `type` | `occupation` |
| `visionBonus` | **2.2** |
| `weatherEffect` | **33** |
| `darknessEffect` | **33** |

Specialisations (baseline):

| Category | Weight |
|---|---|
| Animals | 10 |
| Insects | 5 |
| Medical | 10 |
| Ammunition | 50 |
| JunkWeapons | 15 |
| MedicinalPlants | 5 |
| ForestRarities | 10 |
| Trash | 20 |
| Junk | 20 |
| WildPlants | 5 |

B42 forage category names must be revalidated if vanilla renames categories;
weights stay as above unless adr-05 changes.

## Events

| Event | Handler role |
|---|---|
| Engine early load | `registries.lua` → `CharacterProfession.register` |
| Script load | `TrueDetective_professions.txt` → cost / XP / UI keys |
| `Events.OnGameBoot` | `forageSystem.addSkillDef` for occupation `truedetective` |
| `Events.OnGameStart` | Attach search-mode + player-move handlers (client) |
| `Events.onToggleSearchMode` | Set `player:getModData().isSearchMode`; search phrase when entering search |
| `Events.OnPlayerMove` | Tile-change detection roll + door-adjacent room checks |

### Player modData keys

| Key | Meaning |
|---|---|
| `isSearchMode` | boolean — last known search-mode state |
| `lastSquare` | last processed square for change detection |

## Detection surface

Callable conceptual API (implementation may stay local functions):

```text
checkRoomForZombies(square) → string|nil
  -- nil if no room, room > 50 squares, or no live zombies
  -- else danger phrase string

checkDoors(player, currentSquare)
  -- inspect N/S/E/W door edges; Say() on message

onPlayerMove(player)
  -- profession-gated (True Detective only); 66% search / 10% passive on square change
```

Profession gate, chances, and room cap: [[adr-05-true-detective-mechanics]].

## Phrases

| Pool | Translation key pattern | When |
|---|---|---|
| Search start | `UI_phrase_<n>` | Entering search mode |
| Danger | `UI_zombie_alert_<n>` | Successful room threat detection |

Pools load via `getTextOrNull` until keys end. Random pick with `ZombRand`.

## Clothing selection

`ClothingSelectionDefinitions.truedetective` (Male/Female) — key must match
`getName()`:

| Slot | Chance | Items (baseline) |
|---|---|---|
| Hat | 75% | `Base.Hat_Fedora`, `Base.Hat_Fedora_Delmonte` |
| Jacket | 75% | `Base.JacketLong_Random` |
| Pants | always | `Base.Trousers_DefaultTEXTURE_TINT`, `Base.Trousers_Denim` |
| Shoes | always | `Base.Shoes_Random` |

Item names revalidated against B42.20 item scripts at implement time.

## Forbidden (API)

- **`ProfessionFactory` / `ProfessionFactory.addProfession`** — does not exist on B42.20.
- Primary profession gate via **`getProfession()`** alone — use **`getCharacterProfession()`**.
- Forage or clothing keys `prof_detective` / `detective` as the live product id — live key is **`truedetective`**.
- Treating SOTO `soto:detective` as this mod’s occupation.

## Related

- [[ARCHITECTURE]] — module map and flow  
- [[REQUIREMENTS]] — FR/NFR enumeration  
- [[USE-CASES]] — player-visible behavior  
- [[adr-05-true-detective-mechanics]] — binding rules  
