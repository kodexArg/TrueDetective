---
title: Requirements
description: Functional and non-functional ground for True Detective B42.20 greenfield
updated: 2026-08-08
---

## Functional (v42.20-0.1)

| ID | Requirement |
|----|-------------|
| F1 | Mod id is `TrueDetective` and appears in the B42 mod list when linked under `~/Zomboid/mods`. |
| F2 | Client load root is `42.0/` under the product folder. |
| F3 | On game boot / main menu / game start, client Lua prints a line containing `[TrueDetective] Hello World`. |
| F4 | `scripts/install-local.sh` links **root** `Contents/mods/TrueDetective`, never `legacy/`. |

## Non-functional

| ID | Requirement |
|----|-------------|
| N1 | No secrets in repo (tokens, Steam cookies, passwords). |
| N2 | Target runtime is **Build 42.20** public branch (not `legacy41`). |
| N3 | `legacy/` is archival; product work edits root `Contents/` and `docs/` only. |
| N4 | Version identity for this baseline: **v42.20-0.1** (git tag + `modversion`). |
