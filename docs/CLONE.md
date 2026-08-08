---
title: Clone
description: First-run checklist for True Detective — harness, install, vault, delivery
updated: 2026-08-08
---

Operator steps after cloning this repo. Order matters where noted. Detail
lives in [[HARNESS]] and [[adr-04-issue-delivery]].

## 1. Confirm code root

There is **no** frontend/backend pick. Live product is:

```text
Contents/mods/TrueDetective/
```

Do not install from `legacy/`.

## 2. Wire the guardian safety net

```bash
ln -sfn ../../docs/hooks/khook-pre-commit .git/hooks/pre-commit
```

Warns at commit when guardians are owed ([[adr-03-guardians]]). Does not
block; the owner process still must dispatch.

Agent SSOT is **always** `docs/agents/`, `docs/skills/`, `docs/hooks/`.
Any runtime (Grok, Cursor, Kimi, Claude, …) discovers those paths by link or
prompt injection — no product-specific folder is required. Optional
projections under `.claude/` or similar are convenience only, never a second
copy of the law.

Fill the ADR-review nudge table in `docs/hooks/khook-dispatch-guardians.py`
as product ADRs appear ([[adr-02-harness]] rule 6).

## 3. Vault (recommended)

```bash
uv tool install markdown-vault-mcp
```

Config ships in `.mcp.json`. Reindex after large doc batches.

## 4. Fill and keep the constitution

- [[PRD]] is filled for the Detective profession product.
- Keep [[REQUIREMENTS]] and [[INFRASTRUCTURE]] current.
- Write product ADRs (mechanics) before shipping balance numbers.

## 5. Local game install

```bash
./scripts/install-local.sh
steam steam://rungameid/108600
```

Enable **True Detective** in Mods. Fully restart the client after install
if it was already running.

## 6. Skills

Law skills always in force:

- `docs/skills/kskill-assertion-review`
- `docs/skills/kskill-triage-and-fix`

Docs and orchestration skills ship under `docs/skills/`. Remap or delete
ported banners ([[adr-02-harness]] rule 5). No AWS/Django/Astro stack skills
in this clone.

Do **not** add product assertions until the owner reserves compute
([[assertion-00-discipline]]).

## 7. Issue delivery (triage-and-fix)

Cast and skill ship in-tree ([[adr-04-issue-delivery]]):

1. Operator (or agent) can read `docs/agents/kwf-*.md` by path.
2. Skill playbook `docs/skills/kskill-triage-and-fix/` is available to the session.
3. After plaza/bard, run `docs/hooks/khook-guardian-dispatch --bundle` and
   dispatch owed guardians; run `kskill-assertion-review` if assertions moved.

## Done when

Pre-commit linked, PRD objective clear (profession), install path works,
`docs/` tooling readable by the agent in use, and — if using issue delivery —
cast files are on the path.
