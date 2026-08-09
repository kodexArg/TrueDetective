---
title: PZ mod structure — trees
description: ASCII trees for B42.20 Workshop-shaped mods and this True Detective repo
updated: 2026-08-08
---

# Trees (B42.20)

Sources: PZwiki [Mod structure](https://pzwiki.net/wiki/Mod_structure) (stable 42.20), host workshop samples under `…/workshop/content/108600/`, this repo.

Case-sensitive hosts (Linux/macOS): folder names must match casing (`common`, not `Common`; `media`, not `Media`).

## Official Workshop-shaped package (B42)

```text
MyModWorkshop/                    # git root can live here
├── workshop.txt                  # Steam Workshop metadata (upload)
├── preview.png                   # Workshop preview (game expects 256×256)
├── Contents/                     # ONLY this tree is uploaded as content
│   └── mods/
│       └── MyModIdFolder/        # one activate-able mod (folder name free)
│           ├── mod.info          # root meta (id= is Mod ID)
│           ├── poster.png
│           ├── icon.png          # optional
│           ├── common/           # shared heavy assets; loads first
│           │   └── media/
│           │       ├── models_X/
│           │       ├── textures/
│           │       ├── anims_X/
│           │       └── …
│           ├── 42/               # version folder → treated as 42.0
│           │   ├── mod.info
│           │   ├── poster.png
│           │   └── media/
│           │       ├── registries.lua
│           │       ├── lua/
│           │       │   ├── shared/
│           │       │   ├── client/
│           │       │   └── server/
│           │       ├── scripts/
│           │       ├── textures/
│           │       └── …
│           ├── 42.0/             # explicit 42.0 pin (same class as 42/)
│           └── 42.20/            # optional pin closer to 42.20.x clients
└── (docs, tools, .git, …)        # NOT under Contents/ → not uploaded
```

## This project (True Detective) — binding shape

Repo root = product + harness. Live mod SSOT under `Contents/` only.

```text
TrueDetective/                          # git root · kodexArg/TrueDetective
├── AGENTS.md
├── README.md
├── workshop.txt                        # Workshop package (id blank until first publish)
├── scripts/
│   └── install-local.sh                # rsync → ~/Zomboid/mods/TrueDetective
├── docs/                               # harness law (not game media)
├── legacy/                             # archive only — never install
└── Contents/
    └── mods/
        └── TrueDetective/              # Mod ID folder · id=TrueDetective
            ├── mod.info
            ├── poster.png
            ├── icon.png
            ├── common/                 # B42 required presence; shared assets
            │   └── media/…
            └── 42.0/                   # load root for Build 42 / 42.20 stable
                ├── mod.info
                ├── poster.png
                ├── icon.png
                └── media/
                    ├── registries.lua  # (when profession lands)
                    ├── lua/
                    │   ├── client/TrueDetective/
                    │   └── shared/…
                    ├── scripts/…
                    └── textures/…
```

## Local install vs Workshop cache

```text
~/Zomboid/mods/TrueDetective/     # manual / install-local target (real dir)
~/Zomboid/Workshop/<name>/        # in-game uploader workspace (Contents/…)
…/steamapps/workshop/content/108600/<WorkshopID>/mods/<ModFolder>/
                                  # subscribed Workshop download (do not edit)
…/ProjectZomboid/projectzomboid/Workshop/ModTemplate/
                                  # official template (often B41-flat; not our SSOT)
```

Never keep two loaded copies of the same Mod ID (local + Workshop subscribe).

**Live scaffold note:** product still has HelloWorld only under `42.0/` (+
mirrored `common/`). Full profession tree exists under `legacy/Contents/` for
read-only port reference — not installable.

## File type map (high level)

| Path pattern | Kind |
|---|---|
| `mod.info` | Mod identity (`id`, `name`, `poster`, …) |
| `poster.png` / `icon.png` | UI art |
| `media/registries.lua` | Early B42 registries (`CharacterProfession.register`, …) |
| `media/lua/shared/**/*.lua` | Shared Lua (loads first among lua) |
| `media/lua/client/**/*.lua` | Client Lua (UI, local events) |
| `media/lua/server/**/*.lua` | Server Lua (MP authority) |
| `media/lua/shared/Translate/<LOCALE>/*.txt` | Translation tables |
| `media/scripts/**/*.txt` | Script definitions (items, professions, …) |
| `media/textures/**/*.png` | Textures |
| `media/models_X/**` | Models (`.fbx` / `.x`) |
| `media/sound/**` | Audio (`.ogg` / `.wav`) |
| `workshop.txt` | Steam Workshop package metadata (repo root / Workshop root) |
