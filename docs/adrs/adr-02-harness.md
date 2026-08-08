---
title: adr-02-harness
type: adr
category: harness
use_case: adding or editing a skill hook or agent, naming a harness artifact with its kind prefix, wiring runtime discovery to docs/agents or docs/skills, changing guardian-dispatch or pre-commit, deciding whether tooling may invent law, closing a batch that touched agent tooling
created: 2026-08-08
modified: 2026-08-08
tags: [adr, harness, skills, hooks, agents, naming]
---

# ADR-02 — harness tooling (skills, hooks, agents)

## CONTEXT

> The harness is the agent surface that serves the written law. Skills,
> hooks, and agents live under `docs/` beside that law — they do not replace
> it, invent it, or keep a second copy of it.

Rules only. What each tool does in detail lives in its own file; guardian
and delivery themes have their own ADRs.

## ASSERTIONS

1. **Tooling homes.** Skills live in `docs/skills/`, hooks in `docs/hooks/`,
   agent definitions in `docs/agents/`. These folders are part of the
   harness, excluded from the vault index (filename conventions would
   collide), and reached by path — not as vault notes.
2. **Law first.** Every skill, hook, and agent **obeys** [[adr-01-constitution]]
   and every ADR in force. Tooling may interpret and enforce the law; it
   must not silently redefine the objective, invent constitution policy, or
   invent product assertions. When tooling and law disagree, the law is
   right and the tooling is the defect.
3. **Explicit links.** Agent and skill bodies that act on written law name
   the governing documents by wikilink or path: [[PRD]], constitution files,
   the ADR set, [[TDD]], assertion files as relevant. A tool that gates a
   surface without pointing at its governing ADR or doc is incomplete.
4. **One real copy of agents.** SSOT for agent definitions is
   `docs/agents/`. Any runtime (Grok, Cursor, Kimi, Claude, or other) links
   or injects that tree by path — it does not duplicate it
   ([[adr-03-guardians]] rule 2 for guardians; same rule for the `kwf-*`
   cast). Optional host folders (for example `.claude/agents`) are
   projections only.
5. **Skills are playbooks.** A skill is an instruction package under
   `docs/skills/<name>/SKILL.md` (plus its local `references/`, `bin/`,
   tests). Wire each into the runtime's skill discovery. Standing residents:
   `kskill-assertion-review` (laws → tests → code) and `kskill-triage-and-fix`
   (issue → PR). Delivery mechanics: [[adr-04-issue-delivery]]. Everything
   else under `docs/skills/` is a **stack or utility skill** — it serves the
   law like any other tool and carries no authority of its own. **Every**
   skill ported from another clone declares that in a banner at the top —
   no exceptions. The banner covers both what the body cites (ADRs and docs
   that may not exist here) and what it hardcodes (cloud accounts, profiles,
   project slugs, template paths). Neither is in force on adoption. The
   banner comes off when the body is remapped to this project, or the skill
   goes. This mod clone does **not** ship Astro/Django/AWS stack skills from
   the web template.
6. **Hooks are automation.** Hooks are LLM-agnostic scripts attached to
   agent or git lifecycle events. The dispatch safety net
   (`docs/hooks/khook-guardian-dispatch`, voiced by `docs/hooks/khook-pre-commit`)
   belongs here; its binding duty is [[adr-03-guardians]]. A hook may cite only
   ADRs that exist in this clone: a wikilink to an ADR the project never wrote
   is invented law (rule 2), so a nudge table with nothing honest to point at
   ships empty until this project fills it.
7. **Guardians are agents, not a separate tier.** `kbot-prd` and
   `kbot-adr` live under `docs/agents/` with the rest of the cast.
   Their verdicts and watchlists are governed by [[adr-03-guardians]].
8. **Names carry their kind.** Every harness artifact is prefixed by what it
   is, so a name read cold says which tree owns it and which contract applies:
   `kskill-*` for skills, `khook-*` for hooks, `kbot-*` for agents, and
   `kwf-*` for the workflow cast that runs the delivery party
   ([[adr-04-issue-delivery]]). `kwf-` is the one prefix that also carries a
   role: an agent named `kwf-*` is a party member with a phase, a `kbot-*` is
   any other agent. The stem after the prefix names the role, never the stack
   or the project (`kbot-adr`, not `truedetective-adr`). `.git/hooks/pre-commit`
   keeps its git-mandated filename and links to `docs/hooks/khook-pre-commit`.
9. **Souls are optional personality sidecars.** Voice/posture for an agent
   may live in `docs/agents/souls/<name>.md`, declared as `soul:` in the
   agent's frontmatter. Soul never invents law; contracts and ADRs outrank
   voice.

## FORBIDDEN

- **NEVER** keep a second SSOT for agent definitions outside `docs/agents/`
  (rule 4).
- **NEVER** let a skill or agent stamp or invent product law without the
  owner and the proving path in [[adr-01-constitution]] rule 6 (rule 2).
- **NEVER** put durable project decisions only inside a skill prompt with
  no ADR (rule 2). Decisions belong in `docs/adrs/`.
- **NEVER** name a harness artifact after the stack or the project it happens
  to serve, and never ship an artifact without its kind prefix (rule 8).
- **NEVER** cite an ADR a hook or agent cannot resolve in this clone (rule 6).
- **NEVER** ship a ported skill without its banner, however generic the body
  looks (rule 5).

## REJECTED

- **Shipping full harness-default AWS/Django/Astro skill set** — noise for a
  Project Zomboid mod. Rejected; keep law, docs, and orchestration skills
  only. Reopen only if this repo grows a separate web surface.
- **Banner only the ported skills that cite a missing ADR** — incomplete
  signal when origin-specific paths remain. Same rejection as harness-default
  rule 5 history: banner on every ported skill until remapped.

## RELATED

### governed paths

- `docs/skills/` — skill packages (`kskill-*`) — SSOT
- `docs/hooks/` — lifecycle automation (`khook-*`) — SSOT
- `docs/agents/` — agent definitions (`kbot-*` + the `kwf-*` party) — SSOT
- `docs/agents/souls/` — personality sidecars (`soul:` frontmatter)
- optional host projections that only link or reference the paths above

### related files

- [[adr-01-constitution]] — the written law this tooling serves
- [[adr-03-guardians]] — guardian agents and dispatch safety net
- [[adr-04-issue-delivery]] — triage-and-fix skill and cast
- [[HARNESS]] — tooling section in prose
- [[CLONE]] — runtime wiring checklist
