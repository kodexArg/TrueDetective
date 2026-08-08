---
title: Product Requirements Document
description: True Detective B42.20 — greenfield objective at v42.20-0.1
updated: 2026-08-08
---

**True Detective** is a **Project Zomboid Build 42.20** mod (Steam app **108600**).

## Horizon at v42.20-0.1

**Done for this tag:** greenfield repository with harness, `legacy/` archive of the previous tree, and a **hello-world mock** that loads under B42 (`Contents/mods/TrueDetective/42.0/`) and prints `[TrueDetective] Hello World` on boot / main menu / game start.

**Beyond this tag:** a new product plan (profession / systems TBD). Balance and features land only through new ADRs and constitution amendments — not by re-activating `legacy/` as live code.

## Who it serves

- **Owner (kodexArg)** — ships and iterates one Workshop-shaped mod.
- **Player** — enables True Detective in Mods; at 0.1 only console proof of load.

## What it must do (now)

- Load on **42.20** stable (version folder **`42.0/`**).
- Install via `scripts/install-local.sh` → `~/Zomboid/mods/TrueDetective`.
- Prove load with Hello World console lines (see [[USE-CASES]] when expanded; currently [[ARCHITECTURE]] + `HelloWorld.lua`).

Retired goals (urban forage, door-room detection, old profession rebuild) remain documented only under `legacy/docs/`.
