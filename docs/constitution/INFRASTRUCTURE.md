---
title: Infrastructure
description: Host paths for True Detective on debian-sid
updated: 2026-08-08
---

## This machine (kodex · debian-sid)

| Role | Path |
|------|------|
| Dev repo | `/home/kodex/Dev/personal/Project-Zomboid/TrueDetective` |
| GitHub | `kodexArg/TrueDetective` |
| Steam library | `~/.local/share/Steam` |
| Client | `~/.local/share/Steam/steamapps/common/ProjectZomboid` |
| User data | `~/Zomboid/` |
| Local mod link | `~/Zomboid/mods/TrueDetective` → repo `Contents/mods/TrueDetective` |
| Steam console capture | `~/Documents/System/logs/steam/` (`/kdx-this-computer-steam`, `/kdx-log`) |
| Host PZ skill | `~/Skills/steam-project-zomboid` |

## Install

```bash
./scripts/install-local.sh
# then enable in-game Mods → True Detective
```

## Out of scope

Work AWS/Claude accounts; Steam credential paste; publishing Workshop uploads without explicit owner ask.
