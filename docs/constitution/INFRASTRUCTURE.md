---
title: Infrastructure
description: Host paths for True Detective on debian-sid — Steam, Zomboid, install
updated: 2026-08-08
---

## This machine (kodex · debian-sid)

| Role | Path |
|------|------|
| Dev repo | `/home/kodex/Dev/personal/Project-Zomboid/TrueDetective` |
| GitHub | `kodexArg/TrueDetective` |
| Steam library | `~/.local/share/Steam` |
| Client (native Linux) | `~/.local/share/Steam/steamapps/common/ProjectZomboid` |
| User data | `~/Zomboid/` |
| Local mod install | `~/Zomboid/mods/TrueDetective` (real directory via rsync; not a symlink) — **required path** [[adr-06-steam-configurations]] |
| Workshop ID / Mod ID | `3383387174` / `TrueDetective` |
| Structure law | [[adr-05-project-zomboid-mod-structure]] |
| Console / logs | `~/Zomboid/console.txt`, `~/Zomboid/Logs/` |
| Steam console capture | `~/Documents/System/logs/steam/` (`/kdx-this-computer-steam`, `/kdx-log`) |
| Host PZ skill | `~/Skills/steam-project-zomboid` |
| Workshop id | `3383387174` |

## Install

```bash
./scripts/install-local.sh
# fully restart Project Zomboid so it rescans mods
# Mods → enable True Detective → Apply
```

Target game: **Build 42.20** public branch (verify live `buildid` / console
`version=` after launch).

## Out of scope

Work cloud/credentials mixed with personal Steam; Steam credential paste;
publishing Workshop uploads without explicit owner ask; treating `legacy/`
as install source.
