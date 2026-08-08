---
title: PZ mod structure — registries and scripts
description: CharacterProfession registry + character_profession_definition for B42.20
updated: 2026-08-08
---

# Registries and scripts (profession)

Official system (Build 42.13+): [PZwiki Registries](https://pzwiki.net/wiki/Registries).

## registries.lua

- Path under loaded media: **`media/registries.lua`** (exact name)
- Loaded **before** Lua under `media/lua/` and before scripts
- Registers identifiers such as `CharacterProfession`, `CharacterTrait`, `ItemTag`, …

True Detective resource id (product identity):

```text
truedetective:truedetective
```

`getName()` path component: `truedetective` (forage key, clothing key, runtime gate).

## Vanilla reference (game install)

```text
…/projectzomboid/media/scripts/generated/characters/character_professions.txt
```

Uses `character_profession_definition base:…`. Mods add their own script
files; they do not edit that generated vanilla file.

## character_profession_definition (script)

Path example:

```text
42.0/media/scripts/characters/TrueDetective_professions.txt
```

Shape from legacy product + wiki:

```text
module TrueDetective
{

character_profession_definition truedetective:truedetective
{
    CharacterProfession = truedetective:truedetective,
    Cost = -6,
    UIName = UI_prof_truedetective,
    UIDescription = UI_profdesc_truedetective,
    IconPathName = profession_detective,
    XPBoosts = Aiming=1;Lightfoot=1;Sneak=2,
}

}
```

Cost / XPBoosts shown are **historical product intent** from the prior rebuild.
They are **not** binding until a mechanics ADR re-states them under
`docs/adrs/`. Code may not invent new balance without that ADR.

## Icon textures

| Use | Typical path |
|---|---|
| Profession icon | `media/textures/profession_detective.png` (or name in `IconPathName`) |
| Poster / list | `poster.png` at mod / version root |

## B41 baseline (reference only)

Workshop package `3383387174` still ships B41-shaped
`…/mods/DetectiveProfession/media/` with `ProfessionFactory`-era layout.
`legacy/references/original-mod/` and that workshop tree inform ports;
**B42 law is CharacterProfession + this structure**, not ProfessionFactory.
