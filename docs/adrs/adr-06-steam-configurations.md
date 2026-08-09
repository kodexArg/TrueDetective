---
title: adr-06-steam-configurations
type: adr
category: devops
use_case: installing or launching Project Zomboid, wiring local mod path, editing workshop.txt, setting Mods or WorkshopItems, reading appmanifest or options.ini, choosing Steam beta branch, documenting Steam or Zomboid paths for True Detective
created: 2026-08-08
modified: 2026-08-08
tags: [adr, devops, steam, project-zomboid, workshop, true-detective]
---

# ADR-06 — Steam configurations (Project Zomboid)

## CONTEXT

> This ADR is the Steam and runtime configuration law for True Detective on
> Project Zomboid AppID 108600. It covers what must exist for the game to
> run and load this mod, and the broader configurable surface with defaults
> where known.

Rules only. Path tables, workshop.txt keys, client options samples, betas,
and language policy live under
`docs/resources/steam-configurations/`. In-mod folder structure is
[[adr-05-project-zomboid-mod-structure]].

## ASSERTIONS

1. **App identity.** The game is Steam AppID **`108600`**. Dedicated server
   AppID is **`380870`**. `steam_appid.txt` contains `108600`. This host
   uses the native Linux client under
   `~/.local/share/Steam/steamapps/common/ProjectZomboid`.
2. **Required path for this project’s mod.** Local development loads from
   **`~/Zomboid/mods/TrueDetective`**, a real directory mirroring
   `Contents/mods/TrueDetective/`, installed by `scripts/install-local.sh`.
   The enable list `~/Zomboid/mods/default.txt` must include
   `mod = TrueDetective` (Mod ID, not Workshop id).
3. **Two IDs, English names.** **Workshop ID** assigned by Steam at first
   publish (`workshop.txt` `id=` stays blank until then; `3383387174` is
   the retired B41 item). **Mod ID**
   `TrueDetective` (`mod.info` `id=` / `Mods=` / `default.txt`). Never
   swap them.
4. **Target branch.** Product targets the **public** Steam branch —
   Build **42.20** stable. `legacy41` and `42.19` betas are out of product
   scope unless the owner reopens them. Re-read `appmanifest_108600.acf`
   for live `buildid`.
5. **ENGLISH ONLY for configuration identifiers.** All Steam/game
   configuration keys, folder names required by the engine, Mod IDs,
   Workshop keys, server `.ini` keys, Lua API names, and registry resource
   ids are **English only** for community compatibility. Detail:
   [[steam-language-policy]].
6. **Soft prose rule (English harness).** Text and prose are recommended
   in English, but the recommendation is soft: you may adapt prose to your
   language. Localized player UI goes in Translate tables, not in config
   key names.
7. **Configurable surface is documented in resources.** Paths, workshop
   upload keys, client `options.ini` samples, logs, and betas live under
   `docs/resources/steam-configurations/` and exemplify defaults when
   known. This ADR does not restate every key.
8. **Launch.** Preferred launch is Steam (`steam://rungameid/108600`) so
   Workshop and overlay work. Direct `projectzomboid.sh` is allowed after
   install without overlay guarantees.
9. **No secrets.** Never commit Steam tokens, session cookies, or passwords.
   Reference path locations only.

## FORBIDDEN

- **NEVER** use Workshop ID where Mod ID is required, or the reverse
  (rule 3).
- **NEVER** translate configuration keys or engine folder names into
  non-English identifiers (rule 5).
- **NEVER** treat `legacy41` / `42.19` as the default product branch
  (rule 4).
- **NEVER** document secrets or paste Steam credentials into the repo
  (rule 9).
- **NEVER** invent absolute Steam library paths that are not verified on
  the host (rule 7) — re-read live files when state may have changed.

## REJECTED

- **Symlink-only local mod install** — rejected on this host; use rsync
  real directory under `~/Zomboid/mods/TrueDetective` (see install script
  and [[adr-05-project-zomboid-mod-structure]]).
- **Developing inside the Workshop content cache** — rejected; Steam
  overwrites `steamapps/workshop/content/108600/`.
- **Proton as default on this host** — rejected; native Linux client is
  the path unless the owner forces Windows depot.

## RELATED

### governed paths

- `workshop.txt` — package Workshop metadata
- `scripts/install-local.sh` — install to required local mod path
- `~/Zomboid/mods/TrueDetective` — required local load path
- `~/Zomboid/mods/default.txt` — enable list
- `~/.local/share/Steam/steamapps/appmanifest_108600.acf` — live install
- `docs/resources/steam-configurations/` — full config tables

### resource index

- [[steam-paths]] — absolute/~ paths; required project path
- [[steam-workshop-and-upload]] — `workshop.txt`, two IDs, server lines
- [[steam-client-and-user-data]] — launch, `options.ini` samples, logs
- [[steam-betas-and-app]] — public / `legacy41` / `42.19`, appmanifest keys
- [[steam-language-policy]] — ENGLISH ONLY config; soft prose rule

### related files

- [[adr-05-project-zomboid-mod-structure]] — in-mod tree and load rules
- [[adr-01-constitution]] — Contents code root
- [[INFRASTRUCTURE]] — host table summary
- [[PRD]] — product on B42.20
- [[CLONE]] — operator install steps
