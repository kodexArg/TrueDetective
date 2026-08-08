# Changelog

## [42.20-0.1] — 2026-08-08 · tag `v42.20-0.1`

### Greenfield baseline

- **Harness** restored at repo root: `docs/constitution/`, `docs/adrs/` (adr-00, adr-01), `docs/assertions/`, `docs/ARCHITECTURE.md`, `docs/MOD-API.md`, `.mcp.json`.
- **Legacy:** entire pre-reset tree under `legacy/` (old Contents, docs, references, harness, …).
- **Mock:** B42.20 hello-world under `Contents/mods/TrueDetective/42.0/` (`HelloWorld.lua`).
- `modversion=42.20-0.1`; install script refuses `legacy/` install paths.
- Single worktree on `main`; prior profession product is archive-only.

### Notes

- Old mechanics and ADRs: `legacy/CHANGELOG.md`, `legacy/docs/`.
