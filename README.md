---
title: True Detective
description: Project Zomboid Build 42.20 profession mod — urban detective forage vision, junk/trash/ammo foraging, door-adjacent small-room zombie intuition
updated: 2026-08-05
---

# True Detective

**Project Zomboid** profession mod for **Build 42.20**. A meticulous urban detective: better indoor/urban forage vision than Veteran (2.2), high junk/trash/ammo foraging, and a unique **door-adjacent small-room zombie intuition** with spoken phrases — amplified in search mode.

| | |
|---|---|
| **Owner** | kodexArg (Gabriel) |
| **Target** | Project Zomboid **Build 42.20** stable (Steam app **108600**) |
| **Mod id** | `TrueDetective` (product root: `Contents/mods/TrueDetective/`) |
| **B42 load root** | `Contents/mods/TrueDetective/42.0/` |
| **Profession** | `truedetective:truedetective` · `getName()` = `truedetective` · UI **True Detective** |
| **Workshop** | [3383387174](https://steamcommunity.com/sharedfiles/filedetails/?id=3383387174) |
| **Continuity** | Rebuild of B41 *Detective Profession* (same workshop id) |
| **Original snapshot** | `references/original-mod/` (B41 mechanics preserved for port — **not** live code) |
| **License** | [MIT](LICENSE) |


## Quick start (this machine)

```bash
# re-link into local mods (idempotent)
./scripts/install-local.sh

# or launch via Steam
steam steam://rungameid/108600
```

Then: **Mods → enable True Detective → Apply → restart** if asked. New character → profession **True Detective**.

## Player fantasy

Play a careful urban investigator: better at reading indoor clutter and trash than outdoor specialists, quietly dangerous in tight rooms because the character *notices* when something is wrong behind a door.

This is **not** SOTO’s simpler `soto:detective` occupation. **True Detective** uniquely owns door-adjacent small-room zombie intuition and spoken search/danger phrases.

## Features (binding numbers in [[adr-05-true-detective-mechanics]])

| Area | Summary |
|---|---|
| Profession | Cost **−6**; Aiming **+1**, Lightfoot **+1**, Sneak **+2** |
| Registration | B42.20: `CharacterProfession.register` + script definition — **no ProfessionFactory** |
| Forage | Occupation `truedetective`; vision **2.2** (beats Veteran’s 2.0); strong Junk / Trash / Ammunition |
| Detection | On tile change: **66%** in search mode, **10%** passive; rooms **≤ 50** squares; live zombies only; True Detective only |
| Phrases | Spoken lines on search-mode start and on danger alert |
| Clothing | `ClothingSelectionDefinitions.truedetective` — Fedora (75%), long jacket (75%), practical pants/shoes |

Full product law: [docs/constitution/PRD.md](docs/constitution/PRD.md). Mechanics rules: [docs/adrs/adr-05-true-detective-mechanics.md](docs/adrs/adr-05-true-detective-mechanics.md). Mod surface: [docs/MOD-API.md](docs/MOD-API.md).

## Install (Linux / this host)

### Local dev (recommended while rebuilding)

1. Ensure the client is on **42.20** public branch (not `legacy41`).
2. Symlink the product root into user mods:

```bash
# User mods path (created after first client run)
mkdir -p ~/Zomboid/mods
ln -sfn /home/kodex/Dev/Project-Zomboid/TrueDetective/Contents/mods/TrueDetective \
  ~/Zomboid/mods/TrueDetective
```

3. Launch PZ → **Mods** → enable **True Detective** → restart if prompted.
4. Create a character with the **True Detective** profession (or load a save that already has it).

### Steam Workshop layout (publish path)

Workshop packages ship as:

```text
workshop item root/
  workshop.txt          # metadata (id, title, visibility, …)
  preview.png
  Contents/mods/<ModFolder>/
    mod.info
    42.0/               # B42 version folder
      mod.info
      media/…
```

This repo already uses that layout under `Contents/mods/TrueDetective/`. When publishing, the SteamCMD/Workshop upload root is the repository root (or a staging tree with the same shape).

### Host paths (debian-sid · account KodexArg)

| Role | Path |
|---|---|
| Steam library | `~/.local/share/Steam` |
| Client install | `~/.local/share/Steam/steamapps/common/ProjectZomboid` |
| User data | `~/Zomboid/` (saves, `mods/`, logs, `Server/`) |
| Dev symlink | `~/Zomboid/mods/TrueDetective` → `Contents/mods/TrueDetective` |
| Workshop content | `…/steamapps/workshop/content/108600/<id>/` |
| Original / continuity workshop | [3383387174](https://steamcommunity.com/sharedfiles/filedetails/?id=3383387174) |

Deeper host facts: host skill `steam-project-zomboid` (`~/Skills/steam-project-zomboid/`), constitution [[INFRASTRUCTURE]].

## Repository map

| Path | Role |
|---|---|
| `Contents/mods/TrueDetective/` | **Code SSOT** — `mod.info`, version folder `42.0/` |
| `Contents/mods/TrueDetective/42.0/media/` | Live registries, scripts, Lua, textures, translations |
| `docs/` | Law and living docs (vault root) |
| `docs/constitution/` | PRD, requirements, harness, infrastructure |
| `docs/adrs/` | Binding decisions — **adr-05** owns profession mechanics |
| `docs/MOD-API.md` | Registration + event surface (B42 CharacterProfession) |
| `references/original-mod/` | Frozen B41 source for the port (do not treat as live product) |
| `state/` | Local runtime scratch (gitignored contents) |

Agents: read [AGENTS.md](AGENTS.md) first. Harness shape: [docs/constitution/HARNESS.md](docs/constitution/HARNESS.md).

## Authority (short)

1. **PRD** — product objective  
2. **Constitution** + **ADRs** — how we run and what rules bind (where code and ADR disagree, **ADR wins**)  
3. **Living docs** — architecture, mod surface, use cases  
4. **Code** — `Contents/mods/TrueDetective/42.0/`

Do **not** invent balance numbers without amending [[adr-05-true-detective-mechanics]].  
Do **not** use `ProfessionFactory` on B42.20.

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

[MIT](LICENSE)
