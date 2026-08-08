---
title: Steam configurations — branches, betas, appmanifest
description: Public 42.20 vs legacy41 / 42.19 betas; appmanifest keys
updated: 2026-08-08
---

# Steam branches and appmanifest

## Game Versions & Betas (Steam UI)

Library → Project Zomboid → Properties → **Game Versions & Betas**.

| Branch (beta code) | Purpose | Default? |
|---|---|---|
| *(none)* / public | **Build 42.20 stable** | **Yes** for this project |
| `legacy41` | Stay on Build 41 | No — B41 mods/saves only |
| `42.19` | Continue Unstable 42.19 worlds | No — map incompatible with 42.20 |

**Save rules:** B41 ↛ B42; Unstable 42.19 ↛ 42.20.

## appmanifest_108600.acf (selected keys)

Path: `~/.local/share/Steam/steamapps/appmanifest_108600.acf`

| Key | Example (this host) | Meaning |
|---|---|---|
| `appid` | `108600` | Steam AppID |
| `name` | `Project Zomboid` | |
| `installdir` | `ProjectZomboid` | Under `steamapps/common/` |
| `StateFlags` | `4` | Installed / ready (live values change) |
| `buildid` | `24574865` | Current depot build (live) |
| `TargetBuildID` | same when idle | Target while updating |
| `LastPlayed` | unix time | |
| `LastOwner` | SteamID64 | |

Always re-read the file; do not hardcode buildids in product code.

## Native vs Proton

This host: **native Linux** client (`ProjectZomboid64`). Proton prefix not
expected. Windows depot only if the owner forces it.

## Dedicated server (optional)

| Item | Value |
|---|---|
| AppID | `380870` |
| SteamCMD | `+app_update 380870` (public = B42 after 42.20 stable) |
| B41 server | beta `legacy41` (confirm live depot names before use) |
| Data dir | still under the running user’s `~/Zomboid/` |
