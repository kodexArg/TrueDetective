# AGENTS.md — True Detective

Project Zomboid **Build 42.20** profession mod. Mod id `TrueDetective`.

Naming law: **True Detective** is the *mod* name. The playable profession is
just **Detective**. Descriptions say "playable detective profession" — never
"True Detective profession".

The Detective's only ability is **Survey Sense** (magnifying glass, 5s
immobile, whispered zombie report). Door/window senses are retired to the
`legacy` branch — never port them back to `main`.

## Read first — always, before any work

1. `docs/constitution/PRD.md`
2. **Every** ADR in `docs/adrs/` (`adr-00` … `adr-10`)

Where code and ADR disagree, **ADR wins**.

## Harness

This repo runs the kodexArg harness. Law and tooling map:
`docs/constitution/HARNESS.md`. Agent tooling SSOT lives only under
`docs/skills/`, `docs/hooks/`, `docs/agents/` — prefixes `kskill-*`,
`khook-*`, `kbot-*`, `kwf-*`.

## Skills

- `/steam-project-zomboid` (host) — B42.20 game + Steam facts. Load for any mod task.
- `docs/skills/kskill-triage-and-fix` — GitHub issue → PR delivery.
- `docs/skills/kskill-assertion-review` — assertion laws (owner-reserved).
- `docs/skills/kskill-triage`, `kskill-wf-triage-and-fix` — triage.
- `docs/skills/kskill-live-doc` — keep docs in sync with code.
- `docs/skills/kskill-markdown-vault`, `kskill-obsidian-markdown` — vault and wikilinks.
- `docs/skills/kskill-orchestrator` — multi-agent runs.
- `docs/skills/kskill-report`, `kskill-reporte` — reporting.
