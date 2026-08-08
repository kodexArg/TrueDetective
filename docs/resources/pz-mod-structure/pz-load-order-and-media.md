---
title: PZ mod structure — load order and media
description: How B42 loads common/version folders and media/lua/scripts
updated: 2026-08-08
---

# Load order and media (B42)

## Version + common folders

Introduced in Build 42. At least **one** of `common/` or a version folder is
required for the client to recognize a B42 mod.

**Load order:**

1. `common/` (if present)
2. Closest **versioning** folder to the running game version (overwrites
   same-relative paths from common)

**Version folder naming** (wiki rules):

| Folder name | Treated as |
|---|---|
| `42` | `42.0` |
| `42.0` | `42.0` |
| `42.20` | `42.20` |
| `42.1.5` | `42.1` (minor ignored in naming) |

**This project:** ship live code under **`42.0/`** for Build **42.20** stable.
Optional extra pins (`42.20/`) only when a game-version split is required.

**Host workshop practice (observed, not engine source):**

| Pattern | Example packs |
|---|---|
| Broad B42 bucket `42.0/` | KillCount, CommonSense, True Detective live |
| Early B42 folder `42/` | More Traits (plus finer pins) |
| Fine pins `42.13`…`42.20` | More Traits (partial override trees) |
| `common/` = UI/assets only | More Traits |
| `common/` = full shared media | KillCount |

**Unknown (not in readable game media):** exact Java algorithm for “closest”
version among many pins. PZwiki states common → closest version; re-verify
in-game if a multi-pin pack misbehaves. Do not invent resolution rules beyond
wiki + project convention (`42.0/` primary).

## Lua load order (inside a loaded media tree)

Within `media/lua/`, fixed sequence (then alphabetical within each folder):

1. `shared/` — client and server
2. `client/` — UI, client events, local TimedActions UI
3. `server/` — server authority (MP)

`media/registries.lua` is special: loaded **before** normal Lua and scripts
(see registries resource). Exact filename required; does not clash across mods
by basename the same way ordinary Lua does.

## How the game uses media

| Area | Role |
|---|---|
| `lua/` | Behaviour (Events, UI, systems) |
| `scripts/` | Data definitions (items, professions, recipes, …) |
| `textures/` | PNG textures; relative path can override vanilla |
| `models_X/` | Mesh assets |
| `sound/` | Sound files (not FMOD bank overwrite) |
| `ui/` | UI images |
| `maps/` | Map mods |
| `clothing/` | Clothing XML + outfits |

Mods merge into the same virtual media namespace as vanilla
`…/ProjectZomboid/projectzomboid/media/`. Same relative path overrides.

## Runtime discovery surfaces

| Surface | Path | Notes |
|---|---|---|
| Local mods | `~/Zomboid/mods/<ModFolder>/` | Install target for this repo |
| Workshop dev | `~/Zomboid/Workshop/<Pkg>/Contents/mods/…` | In-game uploader |
| Subscribed | `…/workshop/content/108600/<id>/mods/…` | Steam download; read-only for us |
| Vanilla media | `…/common/ProjectZomboid/projectzomboid/media/` | Reference only |

## Profession-mod reading order (target product)

When True Detective lands full profession code, intended early chain:

1. Version folder selected (`42.0` for this project on 42.20)
2. `media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")`
3. `media/scripts/…/TrueDetective_professions.txt` → `character_profession_definition`
4. Shared Lua (forage helpers, constants)
5. Client Lua (detection, phrases, events)
6. Translate tables for UI strings

Do **not** use B41 `ProfessionFactory` on B42.20.
