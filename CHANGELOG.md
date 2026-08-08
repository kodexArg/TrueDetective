# Changelog

## [42.20-0.2] — 2026-08-08 · tag `v42.20-0.2` — True Detective profession

### Product

- Playable profession registered via `CharacterProfession.register`
  (`truedetective:truedetective`) + `character_profession_definition` script
  (`Cost = 0`, neutral — mechanics ADR pending).
- Creation outfit (`shared/TrueDetective/Outfit.lua`): fedora + leather long
  coat, always worn (`chance = 100`), random vanilla textures. Facts: `docs/OUTFIT.md`.
- Starting gear on new game (`client/TrueDetective/StartingGear.lua`):
  `Base.Revolver` + `Base.Bullets357Box` (no speedloader item exists in 42.20).
- Hello-world scaffold removed; `common/media` dropped; `modversion=42.20-0.2`.
- Display name is **Detective**; UI strings moved to 42.20 JSON format
  (`Translate/EN/UI.json` — the B41 `UI_EN.txt` table format is ignored by the
  engine and showed raw keys).
- Pants join the mandatory outfit (`chance = 100`): random-tint trousers or
  denim jeans.
- Starting gear gains the noir extras, 75% chance each (owner call):
  `Base.MagnifyingGlass`, `Base.CigarettePack`, `Base.Lighter`, `Base.Whiskey`.
- First mechanics ship (owner facts, `docs/DETECTIVE-STATS.md`): `Cost = -8`,
  `XPBoosts = Aiming=2`, forage skill def (vision 1.75, darkness 15,
  weather 0, Trash/Junk/JunkWeapons/Ammunition/Medical 10).
- **Door Sense** ([adr-10](docs/adrs/adr-10-true-detective-mechanics.md)):
  opening a door/window onto a small closed room with a live zombie gets the
  opening interrupted and a silent halo warning; chance by attention —
  search mode 100%, sneaking 50%, casual 25%; 5 in-game minute cooldown per
  element lets the second try straight through.
- **Lead Sense** (adr-10 rules 13-16): in search mode, a throttled
  full-radius scan detects zombies through walls as silent "lead" lines;
  each zombie is detected once ever, via a shared `tdLead` mark honored by
  Door Sense too.
- README rewritten player-facing; AGENTS.md cut to read-first + skills + harness.

## [unreleased] — harness + structure/steam ADRs

### Harness

- Adapted **`kodexArg/harness-default`**: constitution shape, ADRs `adr-00`…`adr-04`,
  assertion discipline, guardians, triage-and-fix cast, vault `.mcp.json`.
  Agent tooling SSOT under `docs/` — runtime-agnostic (Grok and any host).
- **PRD** restated as B42.20 **profession mod** — playable **Detective**
  (True Detective), not hello-world-as-product.
- Retired greenfield ADR to `docs/obsolete/adr-01-greenfield-v42.20-0.1.md`.
- Code root is `Contents/mods/TrueDetective/` (no frontend/backend pair).
- Stack skills (Astro/Django/AWS) not shipped.

### Structure & Steam (product orientation)

- **`adr-05-project-zomboid-mod-structure`** + `docs/resources/pz-mod-structure/`
  (trees, load order, mod.info, Lua examples, registries).
- **`adr-06-steam-configurations`** + `docs/resources/steam-configurations/`
  (paths, workshop.txt, options samples, betas, ENGLISH ONLY config / soft prose).

### Clean code, logging, ship

- **`adr-07-clean-code`** — no comments; KISS over DRY; snake/kebab; docs in harness + frontmatter.
- **`adr-08-logging-strategy`** — `log/YYYYMMDD-NNN.log` mandatory for failures.
- **`adr-09-gh-deploy-and-versioning`** — locked `main`, ISSUE→PR, `v42.20-N.M`, minimal GHA.
- `.github/workflows/pr-minimal.yml` path gate; `log/.gitkeep`.

- Product still empty of profession systems; scaffold + law only.

## [42.20-0.1] — 2026-08-08 · tag `v42.20-0.1`

### Greenfield baseline

- Harness skeleton, `legacy/` archive, hello-world mock under `42.0/`.
- `modversion=42.20-0.1`; install script refuses `legacy/` install paths.
