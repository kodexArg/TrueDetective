# Legacy archive

Everything that lived at the repository root **before the 2026-08-08 greenfield reset** was moved here.

## Why

- The old B41→B42.20 rebuild and its docs/harness are **retired for active development**.
- Product direction is a **new plan**; old Lua, ADRs, and Workshop-shaped product tree are kept only as reference.
- Do **not** treat `legacy/Contents/` as the live mod. Live code is at the repo root: `Contents/mods/TrueDetective/`.

## What is here

| Path | Was |
|------|-----|
| `Contents/` | Full True Detective B42 product (profession, forage, detection, …) |
| `docs/` | Constitution, ADRs (including adr-05 mechanics), MOD-API, … |
| `references/original-mod/` | Frozen B41 Detective Profession snapshot |
| `AGENTS.md`, `README.md`, `CHANGELOG.md`, … | Old agent/product surface |
| `scripts/`, `.mcp.json`, `workshop.txt`, … | Old tooling and Workshop metadata |

## Rule

- **Read-only by default.** Copy ideas if useful; do not re-enable this tree as the install target.
- Local play symlink must point at **root** `Contents/mods/TrueDetective`, never `legacy/Contents/...`.
