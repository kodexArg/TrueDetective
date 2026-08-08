---
title: MOD-API
description: Current mod surface (hello-world only)
updated: 2026-08-08
---

## v42.20-0.1 surface

| Kind | Detail |
|------|--------|
| Events | `OnGameBoot`, `OnMainMenuEnter`, `OnGameStart` |
| Side effect | `print` to client console |
| Profession | **none** |
| Scripts / registries | **none** |

## Future (not in this tag)

B42.20 profession work must use **`CharacterProfession.register`** + script definitions — **not** B41 `ProfessionFactory`. Historical notes: `legacy/docs/MOD-API.md`.
