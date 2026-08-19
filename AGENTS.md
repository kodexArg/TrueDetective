# AGENTS.md — True Detective

Project Zomboid **Build 42.20** profession mod. Mod id `TrueDetective`.

Naming law: **True Detective** is the *mod* name. The playable profession is
just **Detective**. Descriptions say "playable detective profession" — never
"True Detective profession".

The Detective's only special ability is **Survey Sense**: hold a
**magnifying glass** for SearchBoost ×1.5, right-click **Investigate** on
a live or dead zombie for a mate/pack whisper, and while walking with the
glass sometimes read footprints. Law: [[adr-10-survey-sense]].

## Read first — always, before any work

1. `docs/constitution/PRD.md`
2. **Every** ADR in `docs/adrs/` (`adr-00` … `adr-10`)
3. `docs/business-logic-for-detective-ability.md` when touching Survey Sense

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
