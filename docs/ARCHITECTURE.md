---
title: Architecture
description: B42.20 hello-world mock layout
updated: 2026-08-08
---

## Live mod tree

```text
Contents/mods/TrueDetective/
├── mod.info                 # id=TrueDetective, workshopID, modversion
├── icon.png / poster.png
└── 42.0/                    # B42 / 42.20 load root
    ├── mod.info
    └── media/
        └── lua/
            ├── client/TrueDetective/HelloWorld.lua
            └── shared/Translate/EN/UI_EN.txt
```

## Runtime

Steam launches native `ProjectZomboid64` → loads enabled mods from `~/Zomboid/mods` and Workshop. Version folder **`42.0`** is selected for Build 42.x clients.

## Hello world

`HelloWorld.lua` registers:

- `Events.OnGameBoot`
- `Events.OnMainMenuEnter`
- `Events.OnGameStart`

Each prints `[TrueDetective] Hello World (B42.20 mock) — <event>`.

## Archive

Full previous architecture (profession, forage, detection): `legacy/docs/ARCHITECTURE.md` and `legacy/Contents/`.
