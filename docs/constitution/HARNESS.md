---
title: Harness
description: Knowledge tiers, ADRs, assertions, and B42.20 mod code root
updated: 2026-08-08
---

This repository is a **Project Zomboid Build 42.20** mod on a **kodexArg harness** shape. Written knowledge lives under `docs/`. Outside `docs/` the project **is** the mod product root, local state, and the **legacy/** archive.

## Layout (binding)

| Path | Role |
|------|------|
| `Contents/mods/TrueDetective/` | **Live mod SSOT** — Workshop-shaped; B42 load root `42.0/` |
| `docs/` | Law and living docs (vault root for markdown-vault-mcp) |
| `docs/constitution/` | Stable product/process law |
| `docs/adrs/` | Append-only decisions (`adr-00` = discipline) |
| `docs/assertions/` | Few owner-reserved laws (`assertion-00` = discipline) |
| `legacy/` | Pre–v42.20-0.1 archive — **not** live, **not** install target |
| `scripts/` | Host helpers (`install-local.sh`) |
| `state/` | Local scratch (gitignored contents except keepers) |

## Tiers

1. **Constitution** (`docs/constitution/`) — meaningful **and** stable. Amend rarely.
2. **Living docs** (`docs/*.md`) — iterate with the code (e.g. [[MOD-API]]).
3. **ADRs** — rules with one theme each; facts live in docs via wikilink.
4. **Assertions** — few testable laws; none beyond discipline is healthy at hello-world.

## Authority

1. [[PRD]]  
2. Rest of constitution  
3. In-force ADRs  
4. Other `docs/`  
5. `Contents/mods/TrueDetective/` implementation  

Where code and ADR disagree, **ADR wins**.

## Legacy

`legacy/` holds the retired B41→B42 rebuild, old ADRs, and old media. Agents may **read** it. They must **not** symlink it into `~/Zomboid/mods` or treat it as product SSOT.

## Vault

`.mcp.json` registers `markdown-vault-harness` with `MARKDOWN_VAULT_MCP_SOURCE_DIR=docs`. Index under `.mvmcp/` (local).
