---
title: PZ mod structure — mod.info keys
description: Keys used in mod.info for B42 True Detective and community samples
updated: 2026-08-08
---

# mod.info

Plain `key=value` lines. File must be named exactly `mod.info`.

## Keys in active use (host + community samples)

| Key | Required | Example | Notes |
|---|---|---|---|
| `name` | yes (display) | `True Detective` | Mod list title |
| `id` | **yes** | `TrueDetective` | **Mod ID** — load order, `default.txt`, server `Mods=` |
| `description` | recommended | free text | Multi-line via repeated keys in some tools |
| `poster` | recommended | `poster.png` | Relative path |
| `icon` | optional | `icon.png` | Small icon |
| `author` / `Authors` | optional | `kodexArg` | Both spellings appear in Workshop packs |
| `modversion` | optional | `42.20-0.1` | Display / packaging |
| `url` | optional | GitHub URL | |
| `require` | optional | `\OtherModId` or `OtherModId` | Dependency Mod IDs (backslash form seen) |
| `versionMin` | optional | `42.0.0` | B42 packs (e.g. KillCount, More Traits) |
| `workshopID` | optional | `3383387174` | Often blank on older packs |

**Wild `id=` forms:** most mods use a short id (`TrueDetective`, `KillCount`). Some version
folders use a compound form (`1299328280/ToadTraits`). **This project always uses
`id=TrueDetective` only** — never a Workshop-id prefix in `id=`.

## True Detective root mod.info (project)

```text
name=True Detective
id=TrueDetective
poster=poster.png
icon=icon.png
author=kodexArg
modversion=42.20-0.1
description=True Detective B42.20 profession mod (Detective occupation).
```

## Version folder mod.info

Each version folder (`42.0/`, `common/` if used as load surface) may carry its
own `mod.info`. Keep **`id=TrueDetective`** identical so load identity does
not split.

## default.txt (enable list)

Format under `~/Zomboid/mods/default.txt` (ActiveModsFile style on this host):

```text
VERSION = 1,

mods
{
	mod = TrueDetective,
}

maps
{
}
```

`mod =` value is the **Mod ID** from `id=`, not the Workshop numeric id.
