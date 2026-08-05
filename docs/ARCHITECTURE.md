---
title: Architecture
description: True Detective mod components, B42.20 load path, and event boundaries
updated: 2026-08-05
---

## Shape

True Detective is a **single-folder PZ profession mod** for **Build 42.20**.
The client (or dedicated server) loads versioned media under
`Contents/mods/TrueDetective/42.0/`. There is no separate network API and no
web UI.

```text
Contents/mods/TrueDetective/
├── mod.info                              # root stub (id TrueDetective)
└── 42.0/                                 # B42 version folder (live load root)
    ├── mod.info
    ├── preview.png
    └── media/
        ├── registries.lua                # CharacterProfession.register
        ├── scripts/characters/
        │   └── TrueDetective_professions.txt
        ├── lua/
        │   ├── shared/TrueDetective/     # helper, forage, clothing, detection, phrases
        │   ├── shared/Translate/{EN,ES,AR}/
        │   └── client/TrueDetective/     # SearchActions (events)
        ├── textures/                     # profession icon, search motif
        └── shared/                       # poster / shared icon
```

Reference (not live): `references/original-mod/` mirrors the **B41** module set
used as the port baseline. B41 used `ProfessionFactory` — **do not reintroduce it**.

## Modules (logical)

| Module | Responsibility | Live path (under `42.0/media/`) |
|---|---|---|
| Profession registry | `CharacterProfession.register("truedetective:truedetective")` | `registries.lua` |
| Profession definition | cost −6, XP boosts, UI keys, icon | `scripts/characters/TrueDetective_professions.txt` |
| Profession helper | `getCharacterProfession()` gate; aliases | `lua/shared/TrueDetective/ProfessionHelper.lua` |
| Forage occupation | `forageSystem.addSkillDef` name = `truedetective` | `lua/shared/TrueDetective/ForageSkills.lua` |
| Clothing definitions | `ClothingSelectionDefinitions.truedetective` | `lua/shared/TrueDetective/ClothingSelectionDefinitions.lua` |
| Search mode bridge | search-mode flag on player modData; search-start phrase | `lua/client/TrueDetective/SearchActions.lua` |
| Door / room probe | On tile change, door-adjacent room scan | client + `ZombieDetection.lua` |
| Zombie detection | Room size gate (≤50), live `IsoZombie`, danger phrase | `lua/shared/TrueDetective/ZombieDetection.lua` |
| Phrases | Translation-driven pools (search + alert) | `lua/shared/TrueDetective/Phrases.lua` + Translate |

Binding numbers: [[adr-05-true-detective-mechanics]]. Surface detail: [[MOD-API]].

## Runtime flow

```text
Engine early load
  → media/registries.lua
       CharacterProfession.register("truedetective:truedetective")
  → scripts → character_profession_definition (cost, XP, UI)

OnGameBoot
  → forageSystem.addSkillDef({ name = "truedetective", type = "occupation", … })

OnGameStart (client)
  → wire onToggleSearchMode + OnPlayerMove

onToggleSearchMode(player, isSearchMode)
  → if TrueDetective profession (getCharacterProfession):
       modData.isSearchMode = …
       if searching: Say(search phrase)

OnPlayerMove(player)
  → if square changed AND profession is True Detective (truedetective):
       roll 66% (search) / 10% (passive)
       → for each door-adjacent room ≤ 50 squares:
            if live zombie present → Say(danger phrase)
```

## Boundaries

| Boundary | Rule |
|---|---|
| Profession gate | Detection and detective phrases only for **True Detective** (`truedetective`) |
| Check API | Prefer `desc:getCharacterProfession()` — not B41 `getProfession()` as primary |
| Room size | Rooms with more than 50 squares never alert |
| Liveness | Only `IsoZombie` that `isAlive()` counts |
| Square change | Detection roll only when the player’s square changes |
| Reference tree | `references/original-mod/` is not loaded by the game from this repo |
| Not SOTO | Distinct from any SOTO `soto:detective` occupation; door intuition is ours |

## Host integration

Install path and Steam layout: [[INFRASTRUCTURE]]. Agents: repo-root
`AGENTS.md` — code SSOT is `Contents/mods/TrueDetective/` (live code in `42.0/`).
