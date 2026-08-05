---
title: Harness
description: How this project's knowledge tiers, ADRs, assertions, and mod code root fit together
updated: 2026-08-05
---

This repository is a **Project Zomboid profession mod** scaffolded on
kodexArg/harness-default. Everything the project **knows** lives under
`docs/` — the constitution, living documents, ADR and assertion families,
and agent tooling. Outside `docs/` there is only what the project **is**:
the **mod product root** and local state. Written knowledge is served as a
wikilink-aware vault by `markdown-vault-mcp` — see [The vault](#the-vault).

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

- **Documents that iterate with the code.** [[MOD-API]] is the clearest
  case: the mod surface moves with Lua events and profession registration.
- **Documentation that is stable but not load-bearing.** Useful reference,
  kept current, but a change to it would not alter how the project is run.

### How the current files sort

| File | Tier | Why |
|---|---|---|
| `INFRASTRUCTURE.md` | constitution | Host Steam/PZ paths and B42.20 runtime — set once; barely varies. |
| `ARCHITECTURE.md` | docs | Mod module layout evolves with the port. |
| `MOD-API.md` (`API.md` pointer) | docs | Profession registration, events, forage hooks — iterates with code. |
| `FRONTEND.md` / `BACKEND.md` | docs | Stubs — no web pair; product root is the mod folder. |
| `INTERFACES.md` / `SERVICES.md` | docs | Unused pair retained as harness leftovers; not product code roots. |
| `GLOSSARY.md` | docs | Domain + harness vocabulary grows over the project life. |
| `USE-CASES.md` / `USER-STORIES.md` | docs | Open/close lists — behavior and wants. |
| `TDD.md` | docs | Assertion-driven method when laws are proven by tests. |
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
[adr-00](../adrs/adr-00-discipline.md). Standing order:

| ADR | Theme |
|---|---|
| [[adr-01-constitution]] | Source markdown — PRD, constitution, families, authority |
| [[adr-02-harness]] | Skills, hooks, agents — tooling that serves the law |
| [[adr-03-guardians]] | Guardian agents and the dispatch safety net |
| [[adr-04-issue-delivery]] | triage-and-fix cast and skill |
| [[adr-05-true-detective-mechanics]] | Profession mechanics — cost, XP, forage, detection, phrases, clothing |

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
to check. For this mod, a future assertion might bind a detection chance or
profession registration invariant; until then, mechanics are enforced by
[[adr-05-true-detective-mechanics]] and manual/in-game verification.

Each assertion lives in its own file in `docs/assertions/`, states its rules
first, and ends with a `## RELATED` open/close list. The `### Tests` chapter
must link runnable tests that **demonstrate** the law. The `assertion-review`
skill interprets the paragraph, demands those tests via [[TDD]], drives the
fix or feature, and stamps `verified` only when the tests pass.

Assertions are always aligned with `PRD.md` and this constitution. When an
assertion and the constitution disagree, the assertion is the one that is
wrong. Boundary with `REQUIREMENTS.md`: requirements *enumerate*; an
assertion takes one promise and makes it a law with a proving path.
Discipline: [assertion-00](../assertions/assertion-00-discipline.md).

## Code root — Contents/mods (product root)

This project does **not** use the fullstack `frontend/` + `backend/` pair or
the multi-service `interfaces/` + `services/` pair. The single product root
is the Workshop-shaped mod tree:

```text
Contents/mods/TrueDetective/     ← code SSOT (product root)
  mod.info
  42.0/                          ← B42 version folder (live load root)
    mod.info
    media/
      registries.lua             ← CharacterProfession.register (not ProfessionFactory)
      scripts/characters/…       ← character_profession_definition
      lua/shared|client/…        ← forage, clothing, detection, phrases
      textures/…
      shared/…
references/original-mod/         ← B41 snapshot (reference only, not SSOT)
state/                           ← local scratch; contents gitignored
```

| Path | Role |
|---|---|
| `Contents/mods/TrueDetective/` | **Only** live mod implementation (root + `42.0/`) |
| `Contents/mods/TrueDetective/42.0/media/` | Registries, scripts, Lua, textures, translations |
| `references/original-mod/` | Frozen B41 port source — do not ship as the product |
| `state/` | Local runtime/debug artifacts (gitignored contents) |

Stack documents:

- Living mod surface: [[MOD-API]] (and thin pointer [[API]])  
- Layout and event flow: [[ARCHITECTURE]]  
- `FRONTEND.md` / `BACKEND.md`: stubs → see `Contents/mods`  

**Interfaces talk to services** in the original harness duality becomes here:
**game client loads the mod; Lua hooks own state on the player/modData.**

## Issue delivery — triage-and-fix

This harness owns the **law** and the **delivery cast**. Taking one GitHub
issue to a PR is the in-tree party: skill `docs/skills/triage-and-fix/`,
cast `docs/agents/kwf-*.md`. Binding rules: [[adr-04-issue-delivery]].
Operator steps: [[CLONE]]. Runtime spawn map (Kimi / Claude / Cursor-Grok):
`docs/skills/triage-and-fix/references/runtimes.md`.

Phases: forest → tavern → camp → stalking → plaza → post-bard. After plaza,
the owner process runs `guardian-dispatch --bundle`, pastes that payload
into each owed guardian ([[adr-03-guardians]] rule 9), dispatches them in
parallel on the cheap tier, and runs `assertion-review` when assertions
were touched. Important features enter as assertion laws ([[TDD]]), not as
silent code. Balance features enter by amending [[adr-05-true-detective-mechanics]]
first.

## Agent tooling

- **`docs/skills/`** — skills agnostic to the LLM but useful for this
  project: `assertion-review` and `triage-and-fix`. Wire each into the
  runtime's skill discovery (symlink or reference). Host PZ skill:
  `~/Skills/steam-project-zomboid/` (not duplicated in-tree).
- **`docs/hooks/`** — `guardian-dispatch` and `pre-commit` safety net
  ([[adr-03-guardians]]). Wire once:
  `ln -s ../../docs/hooks/pre-commit .git/hooks/pre-commit`.
- **`docs/agents/`** — guardians and `kwf-*` cast. Project contract for
  agents also lives at repo-root `AGENTS.md`.

Tooling lives under `docs/` with the knowledge it belongs to, but the vault
excludes it: tooling conventions fix their filenames (a skill is always a
`SKILL.md`), which would collide with the vault's naming rule below.

## The vault

The vault root is `docs/`: everything documental is indexed, except the
tooling folders above. It is served as an Obsidian-style vault by
[markdown-vault-mcp](https://github.com/pvliesdonk/markdown-vault-mcp)
(recommended). The server config ships in `.mcp.json`; the local index lives
in `.mvmcp/` and is gitignored, so each clone builds its own.

```
uv tool install markdown-vault-mcp
```

Working rules:

- **Query the vault first** for any documentation question — search, read,
  backlinks, similarity — before grepping the markdown by hand.
- **Basenames are unique vault-wide.** A wikilink resolves by basename;
  duplicates make it resolve to the wrong file. This is why folders are kept
  alive with `.gitkeep`, never with placeholder readmes, and why the
  repository's only `README.md` sits at the root, outside the vault.
- **Wikilinks are welcome** between notes: `[[adr-00-discipline]]`,
  `[[HARNESS]]`. The vault tracks them as a graph — backlinks, orphans,
  broken links are all queryable.
- **Reindex after a batch of edits** before trusting link queries again.
