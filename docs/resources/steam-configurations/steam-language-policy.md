---
title: Steam configurations — language policy
description: ENGLISH ONLY for Steam/config identifiers; soft recommendation for prose
updated: 2026-08-08
---

# Language policy (Steam / config surface)

## Hard rule — configuration identifiers

For **perfect community compatibility**, use **ENGLISH ONLY** for everything
that is a Steam or game **configuration surface**:

- `mod.info` keys and Mod ID values (`id=TrueDetective`)
- `workshop.txt` keys (`title`, `tags`, `visibility`, …)
- Server `.ini` keys (`Mods`, `WorkshopItems`, …)
- Folder names required by the engine (`Contents`, `mods`, `common`, `media`,
  `lua`, `client`, `shared`, `server`, `scripts`, version folders `42.0`)
- Lua API names and registry resource ids (`CharacterProfession.register`,
  `truedetective:truedetective`)
- Event names (`OnGameBoot`, `OnGameStart`, …)
- Option keys in `options.ini`
- GitHub / path tokens that appear in configs

Do not translate these identifiers into Spanish or other languages.

## Soft rule — human prose

> **Text and prose are recommended in English, but the recommendation is soft:
> you may adapt prose to your language.**

This soft rule is written in English because the **harness documentation is
English**. Player-facing translation tables under
`media/lua/shared/Translate/<LOCALE>/` are the correct place for localized
UI strings (e.g. `UI_EN.txt`, future `UI_ES.txt`).
