---
title: Architecture
description: True Detective B42.20 mod layout — Contents, 42.0, common; structure law in adr-05
updated: 2026-08-09
---

## Binding law

- Structure: [[adr-05-project-zomboid-mod-structure]] + `docs/resources/pz-mod-structure/`
- Steam / paths: [[adr-06-steam-configurations]] + `docs/resources/steam-configurations/`
- Detection: [[adr-10-survey-sense]]

## Live mod tree (project standard)

```text
Contents/mods/TrueDetective/
├── mod.info                 # id=TrueDetective
├── icon.png / poster.png
├── common/                  # B42 shared assets
└── 42.0/                    # primary version root for Build 42.20
    ├── mod.info
    ├── poster.png / icon.png
    └── media/
        ├── registries.lua
        ├── lua/
        │   ├── client/TrueDetective/
        │   ├── shared/TrueDetective/
        │   └── server/…
        ├── scripts/characters/
        └── textures/
```

Full trees: [[pz-mod-tree]].

## Runtime

Steam AppID **108600** → native `ProjectZomboid64` → loads
`~/Zomboid/mods/TrueDetective` (local) and/or Workshop content.
Version folder **`42.0`** is this project’s pin for 42.20 stable.

Install: `scripts/install-local.sh` → real directory (not symlink).

## Systems

| System | Responsibility |
|--------|----------------|
| Profession | Register Detective (`CharacterProfession`) |
| Forage | Urban vision / junk-trash-ammo affinity |
| Detection | Survey Sense — glass + aim dwelling + 5s channel ([[adr-10-survey-sense]]) |
| Phrases | Deterministic survey lines (room / direction) |
| Clothing | Creation-time occupation clothing |

## Current surface

See [[MOD-API]] and [[OUTFIT]]. Code plan for ability activation:
[[business-logic-for-detective-ability]].
