---
title: MOD-API
description: Current and target mod surface for True Detective on B42.20
updated: 2026-08-09
---

## Live surface

| Kind | Detail |
|------|--------|
| Registration | `42.0/media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")` |
| Script | `42.0/media/scripts/characters/TrueDetective_professions.txt` (`Cost = -8`, `XPBoosts = Aiming=2`) |
| Forage | `shared/TrueDetective/ForageSkills.lua` → `forageSystem.addSkillDef` |
| Clothing | `ClothingSelectionDefinitions.truedetective` in `shared/TrueDetective/Outfit.lua` |
| Starting gear | `client/TrueDetective/StartingGear.lua` on `OnNewGame` — revolver loaded, glass guaranteed; pipe kit at 75% |
| Survey Sense | `SurveySense.lua` + `survey_sense_action.lua` — glass + aim residential + 5s channel → radius-30 report ([[adr-10-survey-sense]]) |
| Icon | `42.0/media/textures/profession_detective.png` |
| Strings | `UI_prof_*` + `UI_td_survey_*` / `UI_td_dir_*` / `UI_td_room_*` in Translate EN |

Loadout: [[OUTFIT]].

## Forbidden APIs

- B41 `ProfessionFactory` — gone on B42.20.
- Treating SOTO or other pack ids as this occupation.
