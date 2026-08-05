---
title: Infrastructure
description: Local Steam B42.20 runtime and paths for True Detective on debian-sid
updated: 2026-08-05
---

True Detective is a **local client mod**. There is no cloud control plane, no
hosted API, and no rootful daemon. Runtime is the player’s Project Zomboid
install plus user data under `~/Zomboid/`.

## Target runtime

| Fact | Value |
|---|---|
| Game | Project Zomboid (Steam) |
| AppID (client) | **108600** |
| AppID (dedicated server) | **380870** (optional; same mod folder rules) |
| Target build | **42.20 stable** (public branch) |
| Avoid for this product | Steam beta `legacy41` (B41); B41-only workshop stacks |
| Host OS | **debian-sid** (`debian-sid`) |
| Steam persona / account | KodexArg / account used for personal Steam on this host |
| Display note | Steam is often XWayland on this host (authorized gaming exception) |

Authoritative host skill: `~/Skills/steam-project-zomboid/`. Re-check live
`appmanifest_108600.acf` before claiming install/buildid state.

## Paths (this machine)

| Role | Path |
|---|---|
| Steam library | `~/.local/share/Steam` |
| Client install | `~/.local/share/Steam/steamapps/common/ProjectZomboid` |
| App manifest | `~/.local/share/Steam/steamapps/appmanifest_108600.acf` |
| Client launch script | `…/ProjectZomboid/projectzomboid.sh` → `ProjectZomboid64` |
| User data | `~/Zomboid/` |
| **User mods (dev install)** | `~/Zomboid/mods/` |
| Workshop content | `~/.local/share/Steam/steamapps/workshop/content/108600/<id>/` |
| Workshop subscriptions VDF | `~/.local/share/Steam/userdata/<steamid3>/ugc/108600_subscriptions.vdf` |
| Logs | `~/Zomboid/console.txt`, `~/Zomboid/Logs/` |
| SP saves | `~/Zomboid/Saves/<GameMode>/<World>/` |
| Server cfg (if hosting) | `~/Zomboid/Server/` |

## Dev install pattern

Product root in this repo:

```text
/home/kodex/Dev/Project-Zomboid/TrueDetective/Contents/mods/TrueDetective/
```

Link into user mods (idempotent):

```bash
mkdir -p ~/Zomboid/mods
ln -sfn /home/kodex/Dev/Project-Zomboid/TrueDetective/Contents/mods/TrueDetective \
  ~/Zomboid/mods/TrueDetective
```

Enable in the in-game **Mod Manager**, then restart the client if required.

## Workshop packaging shape

```text
<item root>/
  workshop.txt
  preview.png
  Contents/mods/TrueDetective/
    mod.info
    42.0/                 # B42 version folder (live media)
      mod.info
      media/
        registries.lua
        scripts/…
        lua/…
```

Workshop / continuity id: [3383387174](https://steamcommunity.com/sharedfiles/filedetails/?id=3383387174)
(B41 *Detective Profession* rebuild as **True Detective** for B42.20).

## Security / least privilege

- No root required for mod development or local play.  
- Do not store Steam session cookies, tokens, or passwords in this repo.  
- Do not open world-writable mod directories.  
- Dedicated server, if used, runs as the same unprivileged user that owns
  `~/Zomboid/` unless the owner explicitly designs otherwise.

## What this is not

- Not a Docker/K8s deployment  
- Not a CI-deployed web service  
- Not Proton-first (native Linux client expected on this host)
