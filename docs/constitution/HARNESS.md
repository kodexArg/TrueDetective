---
title: Harness
description: What this harness is for True Detective — tiers, families, vault, mod code root, agent tooling
updated: 2026-08-08
---

This repository is a **Project Zomboid Build 42.20 profession mod** on a
**kodexArg harness** shape (cloned from `kodexArg/harness-default`). Everything
the project **knows** lives under `docs/`. Outside `docs/` the project **is**
the mod product root, local state, install scripts, and the optional
`legacy/` archive. Written knowledge is served as a wikilink-aware vault by
`markdown-vault-mcp` — see [The vault](#the-vault) below.

## Tiers and families

Written knowledge comes in two kinds of containers inside `docs/`.
`docs/constitution/` and the documents sitting directly in `docs/` are
**tiers**: every document sorts into one of them by a single question — **is
this both meaningful and stable?** `docs/adrs/` and `docs/assertions/` are
**families**: numbered, append-only files that do not sort — they
accumulate, each ruled by its own `-00` discipline file.

### docs/constitution/

The constitution holds what the project does not expect to change. These
documents are foundational and binding: they are read first, they settle
arguments, and they are amended rarely and deliberately. Changing the
constitution is an event, not routine upkeep.

A document earns its place here only by being both things at once — meaningful
*and* stable. Meaningful but volatile belongs one level up, directly in
`docs/`; stable but unimportant belongs there too.

### docs/ — the loose documents

Everything else sits directly in `docs/`, which covers two kinds of material:

- **Documents that iterate with the code.** [[MOD-API]] is the clearest case:
  the surface it describes moves with the Lua and scripts.
- **Documentation that is stable but not load-bearing.** Useful reference,
  kept current, but a change to it would not alter how the project is run.

### How the current files sort

| File | Tier | Why |
|---|---|---|
| `INFRASTRUCTURE.md` | constitution | Host paths, Steam, install — set once; barely varies. |
| `ARCHITECTURE.md` | docs | Expected to vary as systems grow. |
| `MOD-API.md` | docs | Iterates constantly with the mod surface. |
| `docs/resources/**` | docs | Fact packs for ADRs (trees, Steam tables, Lua samples). |
| `GLOSSARY.md` | docs | Grows for the life of the product. |
| `USE-CASES.md` / `USER-STORIES.md` | docs | Open/close lists — churn with the product. |
| `TDD.md` | docs | Working method for assertion-driven delivery. |
| `CLONE.md` | docs | First-run operator checklist. |

When a new document appears, apply the same two tests: *would changing this
alter how the project is run?* and *do we expect it to change again soon?*
Only a yes to the first and a no to the second puts it in the constitution.

## docs/adrs/

Architecture Decision Records: the memory of the why, not just the what. An
ADR is attached to a *theme* and states numbered rules; its policy may change
many times in place — each displaced policy recorded in the ADR's own
`REJECTED` section — without the file ever moving. Presence in `docs/adrs/`
is what makes a rule binding, and a whole file retires to `docs/obsolete/`
only when its theme ends. Discipline and template in
[adr-00](../adrs/adr-00-discipline.md). Standing order of the harness ADRs:

| ADR | Theme |
|---|---|
| [[adr-01-constitution]] | Source markdown — PRD, constitution, families, authority |
| [[adr-02-harness]] | Skills, hooks, agents — tooling that serves the law |
| [[adr-03-guardians]] | Guardian agents and the dispatch safety net |
| [[adr-04-issue-delivery]] | triage-and-fix cast and skill |
| [[adr-05-project-zomboid-mod-structure]] | B42.20 mod tree, load order, Lua/scripts layout |
| [[adr-06-steam-configurations]] | Steam paths, Workshop/Mod IDs, config language |
| [[adr-07-clean-code]] | No comments; KISS over DRY; snake/kebab Lua layout |
| [[adr-08-logging-strategy]] | `log/YYYYMMDD-NNN.log` harness debug |
| [[adr-09-gh-deploy-and-versioning]] | Locked main, ISSUE→PR, tags, minimal GHA |

Product **mechanics** (profession cost, forage, detection numbers) still
need a later ADR — never silent Lua balance.

## docs/assertions/

Assertions are the harness's **novel piece**: owner-reserved **laws** that a
skill must pass. Everything else in this tree is ordinary scaffolding plus
opinionated PRD and ADRs-as-rules; assertions are the entry path for
solutions that manifest first as proving tests ([[TDD]]) and then as code.

The family is completely optional — a project with none is healthy. They
stay few because each one costs real compute (interpret, demand tests,
implement, re-verify). Presence is what binds: every assertion that exists
must be met.

A single paragraph defines the law — every rule it imposes, concrete enough
to check. Each assertion lives in its own file in `docs/assertions/`, states
its rules first, and ends with a `## RELATED` open/close list. The `### Tests`
chapter must link runnable proofs that **demonstrate** the law (console
checks, layout checks, or automated tests when they exist). The
`kskill-assertion-review` skill interprets the paragraph, demands those proofs
via [[TDD]], drives the fix or feature, and stamps `verified` only when the
proofs pass.

Assertions are always aligned with `PRD.md` and this constitution. When an
assertion and the constitution disagree, the assertion is the one that is
wrong. Boundary with `REQUIREMENTS.md`: requirements *enumerate* what must
hold; an assertion makes one promise a law with a proving path. Discipline:
[assertion-00](../assertions/assertion-00-discipline.md).

## Code root — the mod product

This project is **not** a web fullstack template. It does **not** use
`frontend/` + `backend/` or `interfaces/` + `services/`.

| Path | Role |
|------|------|
| `Contents/mods/TrueDetective/` | **Live mod SSOT** — Workshop-shaped; B42 load root **`42.0/`** |
| `scripts/` | Host helpers (`install-local.sh` → real dir under `~/Zomboid/mods`) |
| `legacy/` | Pre-reset / retired trees — **not** install target, **not** product SSOT |
| `state/` | Local scratch (gitignored contents except keepers) |
| `workshop.txt` | Workshop metadata for publish |

Architecture sentence: **client and shared Lua talk to Project Zomboid; the
mod owns profession registration, forage, and detection behavior under
`Contents/`.**

## Issue delivery — triage-and-fix

This harness owns the **law** and the **delivery cast**. Taking one GitHub
issue to a PR is the in-tree party: skill `docs/skills/kskill-triage-and-fix/`,
cast `docs/agents/kwf-*.md`. Binding rules: [[adr-04-issue-delivery]].
Operator steps: [[CLONE]]. Runtime spawn map (optional per host):
`docs/skills/kskill-triage-and-fix/references/runtimes.md`.

Phases: forest → tavern → camp → stalking → plaza → post-bard. After plaza,
the owner process runs `guardian-dispatch --bundle`, pastes that payload
into each owed guardian ([[adr-03-guardians]] rule 9), dispatches them in
parallel on the cheap tier, and runs `kskill-assertion-review` when assertions
were touched. Important features enter as assertion laws ([[TDD]]), not as
silent code.

## Agent tooling

**Runtime-agnostic.** The SSOT is always under `docs/`. Grok, Cursor, Kimi,
Claude, or any other host **reads or links that tree** — none of them is the
source of truth, and none is required.

Every artifact is prefixed by what it is — `kskill-*` skills, `khook-*` hooks,
`kbot-*` agents, `kwf-*` the delivery party ([[adr-02-harness]] rule 8).

- **`docs/skills/`** — law skills (`kskill-assertion-review`,
  `kskill-triage-and-fix`) plus docs and orchestration utilities. Stack skills
  for Astro/Django/AWS from the web template **do not ship** in this mod
  clone. Ported skills still wear a banner until remapped
  ([[adr-02-harness]] rule 5).
- **`docs/hooks/`** — LLM-agnostic scripts (guardian dispatch, pre-commit
  voice). Optional host-specific lifecycle wiring may call them; the scripts
  themselves do not depend on one product. ADR-review nudge table fills as
  this project writes ADRs ([[adr-02-harness]] rule 6).
- **`docs/agents/`** — guardians (`kbot-prd`, `kbot-adr`), `kwf-*` cast,
  orchestration `kbot-*` workers. One real copy here; runtimes may symlink
  or inject prompts from this path.

## The vault

The vault root is `docs/`: everything documental is indexed, except the
tooling folders above. Config ships in `.mcp.json`; local index under
`.mvmcp/` (gitignored).

```
uv tool install markdown-vault-mcp
```

Working rules:

- **Query the vault first** for documentation questions before grepping
  markdown by hand.
- **Basenames are unique vault-wide.** Wikilinks resolve by basename.
- **Wikilinks are welcome** between notes: `[[adr-00-discipline]]`,
  `[[HARNESS]]`, `[[MOD-API]]`.
- **Reindex after a batch of edits** before trusting link queries again.

## Authority (summary)

1. [[PRD]]  
2. Rest of constitution  
3. In-force ADRs  
4. Other `docs/`  
5. `Contents/mods/TrueDetective/` implementation  

Where code and ADR disagree, **ADR wins** ([[adr-00-discipline]] rule 11).
