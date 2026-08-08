---
title: MOD-API
description: Current and target mod surface for True Detective on B42.20
updated: 2026-08-08
---

## Current scaffold (v42.20-0.1 tree)

| Kind | Detail |
|------|--------|
| Events | `OnGameBoot`, `OnMainMenuEnter`, `OnGameStart` (HelloWorld print) |
| Side effect | `print` to client console |
| Profession | **not yet** in live `Contents/` (target below) |
| Scripts / registries | **not yet** in live `Contents/` |

Hello-world proof is a temporary load scaffold. It is not the product.

## Target product surface

| Kind | Detail |
|------|--------|
| Registration | `CharacterProfession.register` + `character_profession_definition` scripts |
| Resource id | `truedetective:truedetective` |
| `getName()` | `truedetective` |
| Display name | True Detective (`UI_prof_truedetective`) |
| Forage | occupation skill def keyed to `truedetective` via `forageSystem.addSkillDef` |
| Detection | client/shared Lua for door-adjacent small-room living-zombie checks |
| Phrases | search-start and danger pools; Translate / in-character speech |
| Clothing | `ClothingSelectionDefinitions.truedetective` |

## Forbidden APIs

- B41 `ProfessionFactory` / `ProfessionFactory.addProfession` — gone on B42.20.
- Treating SOTO or other pack ids as this occupation.

## Historical notes

Port baseline and older surface notes: `legacy/docs/MOD-API.md` and
`legacy/references/original-mod/`. Not law.
