---
title: adr-05-project-zomboid-mod-structure
type: adr
category: backend
use_case: adding or moving files under Contents/mods/TrueDetective, choosing 42.0 or common folders, writing media/lua or registries.lua or scripts, deciding B42 mod layout, porting from B41 or legacy/, reviewing how PZ loads this mod
created: 2026-08-08
modified: 2026-08-08
tags: [adr, backend, project-zomboid, b42, mod-structure, true-detective]
---

# ADR-05 — Project Zomboid mod structure (B42.20)

## CONTEXT

> This ADR is how True Detective is laid out and how Project Zomboid Build
> 42.20 reads that layout. It is the complex structural law for the live
> mod product under Contents/.

Rules only. ASCII trees, load-order detail, mod.info keys, Lua samples, and
registry/script examples live under `docs/resources/pz-mod-structure/` and
are reached from RELATED. Steam paths and Workshop package identity live in
[[adr-06-steam-configurations]].

Sources of truth for facts: PZwiki Mod structure / Registries (stable
42.20), live host workshop packs under AppID 108600, this repo’s
`Contents/` and `legacy/`, and successful load of `TrueDetective` on
client `version=42.20.x`.

## ASSERTIONS

1. **Product shape.** Live game content is only
   `Contents/mods/TrueDetective/`. Harness docs, `scripts/`, and `legacy/`
   are not game media. `legacy/` is never the install target.
2. **B42 package shape.** The mod follows Build 42 Workshop structure:
   `common/` plus at least one **version folder**. This project’s version
   folder is **`42.0/`** for Build **42.20** stable. Case-sensitive names:
   `common`, `media`, `42.0` — never alternate casing.
3. **Load order.** Engine loads `common/` first, then the closest version
   folder to the running client; version media overrides common at the same
   relative path. Detail: [[pz-load-order-and-media]].
4. **Mod ID.** `mod.info` must set `id=TrueDetective` at every active
   `mod.info` the client reads for this mod. Display name is
   `name=True Detective`. Trees and key tables: [[pz-mod-tree]],
   [[pz-mod-info]].
5. **Media namespaces.** Behaviour and data live under
   `…/media/`: `lua/{shared,client,server}/`, `scripts/`, `textures/`,
   optional `registries.lua`, sounds, models. Lua load order is shared →
   client → server (then alphabetical). Package Lua under
   `TrueDetective/` subfolders for this product.
6. **Profession API (structure).** When the Detective profession ships,
   registration is `media/registries.lua` via
   `CharacterProfession.register("truedetective:truedetective")` plus a
   `character_profession_definition` script — **never**
   `ProfessionFactory`. Examples: [[pz-lua-examples]],
   [[pz-registries-and-scripts]].
7. **Resources are the body of structure facts.** This ADR states rules;
   trees, examples, and tables live in
   `docs/resources/pz-mod-structure/` and may grow without renumbering
   this ADR. Agents open those files when implementing layout.
8. **Install surface.** Local runtime path is
   `~/Zomboid/mods/TrueDetective` as a **real directory** produced by
   `scripts/install-local.sh` (rsync). Symlinks outside the sandbox are
   rejected. Steam path law: [[adr-06-steam-configurations]].
9. **No dual load copies.** Do not run the same Mod ID from local
   `~/Zomboid/mods` and a subscribed Workshop download at once while
   developing.
10. **Scaffold vs product.** Hello-world under `42.0/media/lua/client/` is
    a temporary load proof. Profession systems replace or extend it under
    the same structure rules; balance numbers still need a mechanics ADR.

## FORBIDDEN

- **NEVER** put live product media only under `legacy/` or
  `references/` (rule 1).
- **NEVER** use B41 flat `media/` alone as the only B42 load path without
  `common/` / version folders (rule 2).
- **NEVER** register the occupation with `ProfessionFactory` on B42.20
  (rule 6).
- **NEVER** invent folder names that break case-sensitive hosts
  (`Common`, `Media`, `Lua`) (rule 2).
- **NEVER** inline large trees or multi-page examples into this ADR body
  (rule 7) — extend the resource files instead.
- **NEVER** change `id=` away from `TrueDetective` without owner + ADR
  amend (rule 4).

## REJECTED

- **Shipping only `42.20/` without `42.0`/`common` policy** — optional pin
  folders are fine; this project standardizes on **`42.0/`** as the
  primary version folder for 42.20 stable so one tree covers the 42.x
  line until a split is required.
- **Develop inside `steamapps/workshop/content/108600/…`** — rejected;
  Steam overwrites that cache. Develop in the repo + install-local.
- **B41 ProfessionFactory port as structure** — rejected; structure is
  B42 registries + scripts.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/` — live mod SSOT
- `Contents/mods/TrueDetective/42.0/` — primary version load root
- `Contents/mods/TrueDetective/common/` — shared B42 assets
- `scripts/install-local.sh` — install to `~/Zomboid/mods/TrueDetective`
- `docs/resources/pz-mod-structure/` — structural facts and examples

### resource index (open when implementing)

- [[pz-mod-tree]] — ASCII trees (Workshop + this repo + file type map)
- [[pz-load-order-and-media]] — common/version/lua load order
- [[pz-mod-info]] — `mod.info` keys and `default.txt`
- [[pz-lua-examples]] — HelloWorld, registries, client skeleton, UI_EN
- [[pz-registries-and-scripts]] — CharacterProfession + profession script

### related files

- [[adr-00-discipline]] — ADR shape
- [[adr-01-constitution]] — Contents is the code root
- [[adr-06-steam-configurations]] — Steam paths, Workshop IDs, language
- [[PRD]] — Detective profession product
- [[ARCHITECTURE]] — living tree summary
- [[MOD-API]] — current vs target surface
- [[HARNESS]] — tiers vs product root
