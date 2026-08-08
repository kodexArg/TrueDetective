# Changelog


## [Unreleased]

### Added
- Local install helper `scripts/install-local.sh` and `~/Zomboid/mods/TrueDetective` symlink.
- Version folders `42.0/` and `42.20/`, root `poster.png` / `icon.png` for mod selector.
- `SECURITY.md` for public-repo hygiene.
- Public GitHub: `kodexArg/TrueDetective`.

### Changed
- Clothing definitions live under `media/lua/shared/Definitions/`.
- Workshop / mod.info URLs point at the public repository.


All notable changes to **True Detective** are documented here.

## [Unreleased]

### Rebuild — B41 Detective Profession → B42.20 True Detective

- Re-homed the product as **True Detective** under harness-default scaffolding at
  `/home/kodex/Dev/Project-Zomboid/TrueDetective`.
- Product root: `Contents/mods/TrueDetective/` with B42 version folder **`42.0/`**
  (Workshop-shaped layout). Live media: `42.0/media/`.
- Preserved B41 *Detective Profession* (Workshop **3383387174**) mechanics snapshot
  under `references/original-mod/` for the port baseline.
- Target runtime: Project Zomboid **Build 42.20** stable (Steam app **108600**).
- **B42.20 profession API (SOTO-style):**
  - **No `ProfessionFactory`** (removed in B42.20).
  - Register: `media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")`.
  - Define: `media/scripts/characters/TrueDetective_professions.txt`.
  - `getName()` = **`truedetective`**; forage + clothing keys match.
  - Runtime check: `desc:getCharacterProfession()` (not B41 `getProfession()` primary).
- Binding mechanics in `docs/adrs/adr-05-true-detective-mechanics.md`:
  profession cost −6; Aiming +1 / Lightfoot +1 / Sneak +2; forage vision 2.2;
  detection **66% search / 10% passive**; rooms **≤ 50** squares; live zombies only;
  door-adjacent intuition (unique vs SOTO’s simpler detective occupation); phrases;
  clothing odds.
- Distinct from SOTO `soto:detective` — True Detective owns door-room danger intuition.
- Filled constitution (PRD, REQUIREMENTS, HARNESS, INFRASTRUCTURE) for a mod
  project — not fullstack frontend/backend.
- Replaced template API/frontend/backend framing with [[MOD-API]] + thin stubs.
- Docs patch: agents never document or reintroduce ProfessionFactory; paths use `42.0/`.
- Repo `AGENTS.md`: code SSOT = `Contents/mods/TrueDetective/`; law = `docs/`;
  no invented balance without ADR.
- Install path: symlink `~/Zomboid/mods/TrueDetective` → `Contents/mods/TrueDetective`.

### Notes for implementers

- Live code lives under `Contents/mods/TrueDetective/42.0/media/`.
- B41 APIs in `references/original-mod/` are historical only — revalidate against B42.20.
