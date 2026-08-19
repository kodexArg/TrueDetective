---
title: Requirements
description: Functional and non-functional ground for True Detective B42.20 profession mod
updated: 2026-08-17
---

## Functional

| ID | Requirement |
|----|-------------|
| F1 | Mod id is `TrueDetective` and appears in the B42 mod list when installed under `~/Zomboid/mods`. |
| F2 | Client load root is `42.0/` under `Contents/mods/TrueDetective/`. |
| F3 | Profession **True Detective** registers on B42.20 via `CharacterProfession` + script definition — never `ProfessionFactory`. |
| F4 | Resource id is `truedetective:truedetective`; `getName()` is `truedetective`; display name is True Detective. |
| F5 | Profession cost, starting XP boosts, forage vision/specialisations, detection rules, phrases, and clothing odds match the binding mechanics ADR (when that ADR is in force). |
| F6 | Mate / pack-origin Investigate lines and walk-up clues run **only** for True Detective characters. |
| F7 | `scripts/install-local.sh` installs **root** `Contents/mods/TrueDetective` as a real directory under `~/Zomboid/mods` — never `legacy/`. |
| F8 | English UI strings for the profession and phrases load via Translate tables under the mod media tree. |

## Non-functional

| ID | Requirement |
|----|-------------|
| N1 | No secrets in repo (tokens, Steam cookies, passwords). |
| N2 | Target runtime is **Build 42.20** public branch (not `legacy41`). |
| N3 | `legacy/` is archival; product work edits root `Contents/` and `docs/` only. |
| N4 | Version identity uses tags `v42.20-N.M` and matching `modversion` in `mod.info`. |
| N5 | Balance and detection numbers never land in code without an ADR amend in the same change set (or code waits for the ADR). |
| N6 | Distinct from third-party `soto:detective` — mate / pack-origin whispers and walk-up clues are owned by this mod only. |
