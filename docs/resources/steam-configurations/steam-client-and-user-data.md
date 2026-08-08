---
title: Steam configurations — client and user data
description: options.ini, launch, default mods, logs — keys with observed defaults
updated: 2026-08-08
---

# Client and user data

## Launch (Steam)

| Method | Value |
|---|---|
| Steam URI | `steam steam://rungameid/108600` |
| Direct (post-install) | `…/common/ProjectZomboid/projectzomboid.sh` |
| AppID file | `108600` in `steam_appid.txt` |

Steam may run under **XWayland** on this host (authorized gaming exception).
Do not force pure Wayland flags without owner ask.

## options.ini (sample keys + defaults from this host)

Path: `~/Zomboid/options.ini`  
File starts with `version=8` on this install. Partial defaults observed:

| Key | Observed default / value |
|---|---|
| `version` | `8` |
| `language` | `EN` |
| `fullScreen` | `true` |
| `frameRate` | `60` |
| `height` | (display-dependent) |
| `borderless` | `false` |
| `musicVolume` | `0` … `10` scale in UI |
| `ambientVolume` | `5` |
| `clock24Hour` | `true` |
| `measurementsFormat` | `Metric` |
| `contentTranslationsEnabled` | `true` |
| `gamepadBindingPreset` | `Original` |
| `maxActiveRagdolls` | `20` |
| `fogQuality` | `0` |
| `3DGroundItem` | `true` |

Full file is large; treat unknown keys as client-owned. Do not invent keys.

## default.txt (mod load list)

Path: `~/Zomboid/mods/default.txt`

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

Empty `mods { }` means no local mods forced on. Missing
`reset-mods-42_00.txt` can reset this file on B42 clients.

## Logs (read-only diagnostics)

| File | Use |
|---|---|
| `~/Zomboid/console.txt` | Boot, mod load, Lua `print` |
| `~/Zomboid/Logs/*_DebugLog.txt` | Session debug |
| `~/Zomboid/projectzomboid.sh.log` | Launcher |

Success signal for scaffold: line containing `[TrueDetective]` after
`loading TrueDetective`.

## version.txt / runtime

After launch, console reports e.g. `version=42.20.2 …`. Prefer console /
`~/Zomboid/version.txt` over skill tables when claiming runtime version.
