# AGENTS.md — True Detective (v42.20-0.1)

## Product

- **Name:** True Detective  
- **Runtime:** Project Zomboid **Build 42.20**  
- **Baseline tag:** `v42.20-0.1` · `modversion=42.20-0.1`  
- **Phase:** harness + legacy archive + hello-world mock  
- **Repo:** `/home/kodex/Dev/personal/Project-Zomboid/TrueDetective`  
- **GitHub:** `kodexArg/TrueDetective`  
- **Mod id:** `TrueDetective`

## Main must keep three pillars

| Pillar | Path |
|--------|------|
| Harness | `docs/`, `.mcp.json`, this file |
| Legacy | `legacy/` |
| Mock | `Contents/mods/TrueDetective/42.0/` |

## Source of truth

| Layer | Path |
|-------|------|
| Live code | `Contents/mods/TrueDetective/` · load **`42.0/`** |
| Law | `docs/constitution/`, `docs/adrs/` |
| Archive | `legacy/` — do not install or ship as live |

## Standing rules

1. No `ProfessionFactory` if professions return — B42 `CharacterProfession` only.  
2. Install: `scripts/install-local.sh` → root Contents only.  
3. Hello-world proof: `[TrueDetective] Hello World` in console.  
4. Do not invent balance without a new ADR.  
5. Do not re-activate `legacy/Contents` as product SSOT.

## Authority

1. `docs/constitution/PRD.md`  
2. Constitution + in-force ADRs (`adr-00`, `adr-01`, …)  
3. Other `docs/`  
4. `Contents/` implementation  
