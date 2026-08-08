---
title: Steam configurations — paths
description: Absolute and ~ paths for Project Zomboid AppID 108600 on this host and defaults
updated: 2026-08-08
---

# Paths (Steam + Zomboid)

**AppID:** `108600`  
**Dedicated server AppID:** `380870`  
**This host Steam library:** `~/.local/share/Steam`  
**Install dir name:** `ProjectZomboid`  

## Required paths for this project to run and load the mod

| Role | Path | Default / note |
|---|---|---|
| Steam library | `~/.local/share/Steam` | Only libraryfolder on this host |
| Game install | `~/.local/share/Steam/steamapps/common/ProjectZomboid` | From `appmanifest_108600.acf` `installdir` |
| Native binary tree | `…/ProjectZomboid/projectzomboid/` | `ProjectZomboid64`, `media/`, `steam_appid.txt` |
| Launch script | `…/ProjectZomboid/projectzomboid.sh` | Preferred Steam launch |
| steam_appid.txt | `…/projectzomboid/steam_appid.txt` | Contents: `108600` |
| User cache (Linux) | `~/Zomboid/` | Created after first run |
| **Local mod install (project)** | `~/Zomboid/mods/TrueDetective` | **Required load path** for local dev |
| Mod enable list | `~/Zomboid/mods/default.txt` | Must list `mod = TrueDetective` |
| B42 reset marker | `~/Zomboid/mods/reset-mods-42_00.txt` | If missing, client may wipe default mods |
| Workshop subscriptions cache | `~/.local/share/Steam/steamapps/workshop/content/108600/<WorkshopID>/` | Do not develop here |
| Workshop subscriptions VDF | `~/.local/share/Steam/userdata/<SteamID3>/ugc/108600_subscriptions.vdf` | |
| App manifest | `~/.local/share/Steam/steamapps/appmanifest_108600.acf` | `buildid`, `StateFlags` |
| In-game Workshop workspace | `~/Zomboid/Workshop/` | Upload package shape |
| Console log | `~/Zomboid/console.txt` | Load / Lua prints |
| Session logs | `~/Zomboid/Logs/` | |
| Options | `~/Zomboid/options.ini` | Client options |
| SP saves | `~/Zomboid/Saves/<GameMode>/<World>/` | |
| Server config (host) | `~/Zomboid/Server/` | `servertest.ini`, sandbox, spawn |

## Project repo path (this machine)

```text
/home/kodex/Dev/personal/Project-Zomboid/TrueDetective
```

Live game media SSOT inside repo:

```text
Contents/mods/TrueDetective/
```

Install command:

```bash
./scripts/install-local.sh
# rsync → ~/Zomboid/mods/TrueDetective  (real directory, not symlink)
```

## Windows defaults (community reference)

| Role | Typical default |
|---|---|
| Cache | `%UserProfile%\Zomboid\` |
| Local mods | `%UserProfile%\Zomboid\mods\` |
| Workshop package | `%UserProfile%\Zomboid\Workshop\` |
| Steam library | `C:\Program Files (x86)\Steam\steamapps\` |

Linux is the authority for this host; Windows paths are community defaults only.
