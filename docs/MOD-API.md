---
title: MOD-API
description: Current and target mod surface for True Detective on B42.20
updated: 2026-08-17
---

## Live surface

| Kind | Detail |
|------|--------|
| Registration | `42.0/media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")` |
| Script | `42.0/media/scripts/characters/TrueDetective_professions.txt` (`Cost = -8`, `XPBoosts = Aiming=2`) |
| Forage | `shared/TrueDetective/ForageSkills.lua` → `forageSystem.addSkillDef` |
| Clothing | `ClothingSelectionDefinitions.truedetective` in `shared/TrueDetective/Outfit.lua` |
| Starting gear | `client/TrueDetective/StartingGear.lua` on `OnNewGame` — revolver loaded, 36× loose `.357`, glass guaranteed; pipe kit (pipe+tobacco+lighter) at 75% |
| SearchBoost | `client/TrueDetective/SearchBoost.lua` — glass either hand → forage occupation stats ×1.5 |
| Investigate | `Investigate.lua` + `investigate_leads.lua` + `investigate_lines.lua` — RMB leads on live/dead zombie; self stub ([[adr-10-survey-sense]]) |
| Walk-up clue | `walk_clue.lua` — per-square chance while walking with glass |
| Deleted | `SurveySense.lua`, `survey_sense_action.lua` — aim/channel removed |
| Icon | `42.0/media/textures/profession_detective.png` |
| Strings | `UI_prof_*` + `UI_td_survey_*` / `UI_td_dir_*` / `UI_td_room_*` in Translate EN |

Loadout: [[OUTFIT]].

## Forbidden APIs

- B41 `ProfessionFactory` — gone on B42.20.
- Treating SOTO or other pack ids as this occupation.
