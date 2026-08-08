---
title: Convention
description: Naming and file conventions for the greenfield tree
updated: 2026-08-08
---

- Mod product root: `Contents/mods/TrueDetective/`.
- B42 version folder: **`42.0/`** (serves Build 42 / 42.20 stable).
- Lua package under `media/lua/{client,shared}/TrueDetective/`.
- Release tags: `v42.20-N.M` (semver after the game version prefix).
- `modversion` in `mod.info` matches the tag without the leading `v` when possible (`42.20-0.1`).
- Docs: English; wikilinks `[[Name]]` for vault titles.
- Never commit `.mvmcp/` index blobs if large — prefer local only (see `.gitignore`).
