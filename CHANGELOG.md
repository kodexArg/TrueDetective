# Changelog

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
