---
title: True Detective
description: Project Zomboid Build 42.20 profession mod — the Detective occupation
updated: 2026-08-08
---

# True Detective

**Project Zomboid** mod for **Build 42.20**. Adds a fully integrated playable
profession: **the Detective** (display name **True Detective**).

| | |
|---|---|
| **Owner** | kodexArg |
| **Mod id** | `TrueDetective` |
| **Workshop id** | `3383387174` |
| **Load root** | `Contents/mods/TrueDetective/42.0/` |
| **Harness** | `kodexArg/harness-default` adapted |
| **GitHub** | https://github.com/kodexArg/TrueDetective |

## Product

Urban investigator fantasy: forage vision and junk/trash/ammo affinity, plus
**door-adjacent small-room zombie intuition** with spoken phrases. B42
registration uses **`CharacterProfession`** — never B41 `ProfessionFactory`.

Law and horizon: [docs/constitution/PRD.md](docs/constitution/PRD.md).  
Requirements: [docs/constitution/REQUIREMENTS.md](docs/constitution/REQUIREMENTS.md).  
ADRs: [docs/adrs/](docs/adrs/) (`adr-00`…`adr-09`).  
Structure [adr-05](docs/adrs/adr-05-project-zomboid-mod-structure.md) · Steam [adr-06](docs/adrs/adr-06-steam-configurations.md) ·  
Clean code [adr-07](docs/adrs/adr-07-clean-code.md) · Log [adr-08](docs/adrs/adr-08-logging-strategy.md) · Ship [adr-09](docs/adrs/adr-09-gh-deploy-and-versioning.md).

## Quick start

```bash
./scripts/install-local.sh
steam steam://rungameid/108600
```

Mods → enable **True Detective** → Apply. Fully restart the client after install.

## Layout

```text
Contents/mods/TrueDetective/   # live mod SSOT
docs/                          # constitution, ADRs, living docs, agent tooling
legacy/                        # archive only — not installable
scripts/install-local.sh
```

## Authority

1. PRD + constitution  
2. ADRs in `docs/adrs/`  
3. Other `docs/`  
4. Live `Contents/`  

## License

[MIT](LICENSE)
