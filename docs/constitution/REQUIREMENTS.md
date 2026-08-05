---
title: Requirements
description: Functional and non-functional requirements for the True Detective B42.20 profession mod
updated: 2026-08-05
---

Requirements enumerate what the implementation must satisfy. Binding *numbers* and detection rules live in [[adr-05-true-detective-mechanics]]; this file lists the ground those rules sit on. Behavior scenarios: [[USE-CASES]].

## Functional

| ID | Requirement |
|---|---|
| FR-01 | Register a playable **True Detective** profession on Project Zomboid **Build 42.20** via `CharacterProfession.register("truedetective:truedetective")` in `media/registries.lua` + `character_profession_definition` script — **not** B41 `ProfessionFactory`. |
| FR-02 | Profession **point cost** and **XP boosts** match [[adr-05-true-detective-mechanics]] (cost −6; Aiming +1; Lightfoot +1; Sneak +2). |
| FR-03 | Register **forage occupation** bonuses with `forageSystem.addSkillDef`, `name = "truedetective"` (equals `getName()`): vision, weather/darkness mitigation, and specialisation weights per adr-05 (urban/junk/trash/ammo emphasis; vision **2.2**). |
| FR-04 | **Zombie intuition** runs only for characters with True Detective; gate via `desc:getCharacterProfession()` (not B41 `getProfession()` as primary). |
| FR-05 | On **tile change**, roll detection: **66%** while search mode is active, **10%** when passive (adr-05). |
| FR-06 | Detection inspects **door-adjacent** rooms; rooms larger than **50** squares are ignored. |
| FR-07 | Only **living** zombies count as threats; dead/corpse objects do not trigger danger phrases. |
| FR-08 | On successful threat detection, the character **says** a danger phrase from the mod phrase set. |
| FR-09 | Entering **search mode** triggers a search-start phrase for True Detective. |
| FR-10 | Character creation clothing definitions under `ClothingSelectionDefinitions.truedetective` include fedora, long jacket, practical pants/shoes per adr-05 odds. |
| FR-11 | English UI strings (profession name/description, phrases) ship with the mod; additional locales may extend without breaking EN. |
| FR-12 | Mod loads as a self-contained folder under `Contents/mods/TrueDetective/` with B42 version folder **`42.0/`** (Workshop-compatible layout). |
| FR-13 | Remain distinct from third-party occupations such as SOTO `soto:detective`; door-room intuition is unique to True Detective. |

## Non-functional

| ID | Requirement |
|---|---|
| NFR-01 | Target runtime: **B42.20** stable client (and matching dedicated server when used). B41-only APIs (including **`ProfessionFactory`**) are out of contract. |
| NFR-02 | Detection must not spam every tick: rolls gate on **square change**, not continuous per-frame polling. |
| NFR-03 | No external dependencies beyond vanilla PZ + this mod’s media/Lua (no required third-party mods). |
| NFR-04 | Fail closed: missing square/room/cell returns no phrase; never throw uncaught Lua that breaks the session. |
| NFR-05 | Balance and chance changes require ADR amend ([[adr-05-true-detective-mechanics]]), not silent code drift. |
| NFR-06 | Secrets (Steam tokens, workshop credentials) never appear in repo docs or commits. |
| NFR-07 | Host install documentation assumes Linux Steam paths on **debian-sid** ([[INFRASTRUCTURE]]). |

## Out of scope (this rebuild)

- New traits, multi-profession packs, or overhaul frameworks  
- Map/world edits, items beyond clothing selection definitions  
- Dedicated anti-cheat or server-only authority rewrites beyond vanilla event hooks  
- Guaranteeing B41 save compatibility
