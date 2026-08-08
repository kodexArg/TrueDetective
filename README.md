---
title: True Detective
description: Project Zomboid Build 42.20 mod — greenfield baseline v42.20-0.1
updated: 2026-08-08
---

# True Detective

**Project Zomboid** mod for **Build 42.20** · baseline tag **`v42.20-0.1`**.

| | |
|---|---|
| **Phase** | Greenfield hello-world mock + harness |
| **Owner** | kodexArg |
| **Mod id** | `TrueDetective` |
| **modversion** | `42.20-0.1` |
| **Load root** | `Contents/mods/TrueDetective/42.0/` |
| **Workshop id** | `3383387174` |
| **GitHub** | https://github.com/kodexArg/TrueDetective |

## What `main` contains

1. **Harness** — `docs/` (constitution, ADRs, assertions), `.mcp.json` vault, `AGENTS.md`
2. **Legacy** — `legacy/` full pre-reset archive (not installable)
3. **Mock mod** — B42.20 Workshop-shaped hello world under `Contents/mods/TrueDetective/`

## Quick start

```bash
./scripts/install-local.sh
steam steam://rungameid/108600
```

Mods → enable **True Detective** → Apply. Console / `~/Zomboid/console.txt`:

```text
[TrueDetective] Hello World (B42.20 mock) — OnGameBoot
```

## Layout

```text
Contents/mods/TrueDetective/   # live mod SSOT
docs/                          # harness law + living docs
legacy/                        # archived old product (read-only default)
scripts/install-local.sh
```

## Authority

1. [[PRD]] + constitution  
2. ADRs (`adr-01-greenfield-v42.20-0.1` for this baseline)  
3. Live `Contents/`  

Retired profession design: only under `legacy/`.
