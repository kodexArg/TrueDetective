---
title: MOD-API
description: Current and target mod surface for True Detective on B42.20
updated: 2026-08-08
---

## Current surface (v42.20-0.3 tree)

| Kind | Detail |
|------|--------|
| Registration | `42.0/media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")` |
| Script | `42.0/media/scripts/characters/TrueDetective_professions.txt` (`Cost = -8`, `XPBoosts = Aiming=2`) |
| Forage | `shared/TrueDetective/ForageSkills.lua` → `forageSystem.addSkillDef` (vision 1.75, darkness 15, weather 0; Trash/Junk/JunkWeapons/Ammunition/Medical 10) |
| Clothing | `ClothingSelectionDefinitions.truedetective` in `shared/TrueDetective/Outfit.lua` — fedora + leather long coat, chance 100 |
| Starting gear | `client/TrueDetective/StartingGear.lua` on `OnNewGame` — `Base.Revolver` (loaded, 6/6) + `Base.Bullets357Box` + `Base.MagnifyingGlass` guaranteed; pipe with tobacco, cigarette pack, lighter, whiskey at 75% each |
| Survey Sense | `client/TrueDetective/SurveySense.lua` on `OnTick` — 5s immobile + glass in primary hand → whispered report of ≤5 closest zombies, once per zombie, grouped by room/direction. Law: [[adr-10-survey-sense]] |
| Icon | `42.0/media/textures/profession_detective.png` |
| Strings | `UI_prof_truedetective` / `UI_profdesc_truedetective` + `UI_td_survey_*` / `UI_td_dir_*` / `UI_td_room_*` in Translate EN |

Loadout facts and item evidence: [[OUTFIT]]. Hello-world scaffold removed.
Retired Door Sense / Lead Sense: `legacy` branch, archive only.

## Target product surface

| Kind | Detail |
|------|--------|
| Registration | `CharacterProfession.register` + `character_profession_definition` scripts |
| Resource id | `truedetective:truedetective` |
| `getName()` | `truedetective` |
| Display name | Detective (`UI_prof_truedetective`) |
| Forage | occupation skill def keyed to `truedetective` via `forageSystem.addSkillDef` |
| Detection | Survey Sense: immobile 5s + magnifying glass → whispered zombie report |
| Phrases | Deterministic `UI_td_survey_*` lines; Translate / silent halo notes |
| Clothing | `ClothingSelectionDefinitions.truedetective` |

## Forbidden APIs

- B41 `ProfessionFactory` / `ProfessionFactory.addProfession` — gone on B42.20.
- Treating SOTO or other pack ids as this occupation.

## Historical notes

Port baseline and older surface notes: `legacy/docs/MOD-API.md` and
`legacy/references/original-mod/`. Not law.
