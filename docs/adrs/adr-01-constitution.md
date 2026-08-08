---
title: adr-01-constitution
type: adr
category: harness
use_case: writing or amending constitution docs or the PRD, placing a document in a tier or family, deciding whether a promise belongs in an assertion or a requirement, settling authority between PRD ADRs and other markdown, reviewing whether written law still governs the project
created: 2026-08-08
modified: 2026-08-08
tags: [adr, harness, constitution, prd, assertions]
---

# ADR-01 — constitution (source markdown)

## CONTEXT

> This is the first and main ADR of the project law. It binds the source
> markdown: PRD, constitution, living docs, ADR and assertion families —
> what counts as written truth and in what order.

Rules only. How the pieces fit in prose lives in [[HARNESS]]; document
shape lives in [[CONVENTION]] and the family `-00` disciplines.

## ASSERTIONS

1. **Authority order.** [[PRD]] is the objective at the top. Beneath it
   sits the rest of `docs/constitution/` — how the project is run. Beneath
   that sit the ADRs in `docs/adrs/` — the binding decisions. Beneath those
   sit every other document under `docs/`. Where layers disagree, the higher
   layer wins; where an ADR and the code disagree, the ADR wins
   ([[adr-00-discipline]] rule 11).
2. **[[PRD]] is mandatory and short.** It states what the product is, who
   it serves, and the horizon. Behavior, stories, requirements, and
   assertion laws are not inlined there — they live with their owners and
   are reached by wikilink from the PRD's "What it must do" section. For
   this project the product **is** a B42.20 **profession mod** that adds
   the playable **Detective** occupation (**True Detective**).
3. **Constitution tier.** A file earns `docs/constitution/` only when it is
   both meaningful and stable. Changing the constitution is an event.
   Meaningful-but-volatile or stable-but-unimportant material lives
   directly under `docs/`.
4. **ADRs are load-bearing.** Presence in `docs/adrs/` is what makes a
   decision binding ([[adr-00-discipline]] rule 6). Complying with every ADR
   in force is a precondition for adding anything to the project (rule 9).
   This ADR (`adr-01`) is the entry point for the project's written law;
   later harness ADRs specialize themes beneath it. Product mechanics
   (cost, XP, forage, detection) require their own ADRs before code ships
   those numbers.
5. **Families accumulate; tiers sort.** `docs/adrs/` and `docs/assertions/`
   are numbered families ruled by their `-00` discipline files. They do not
   sort by stability — they append. Sorting by "meaningful and stable"
   applies only to constitution vs loose `docs/` documents.
6. **Assertions are laws.** Owner-reserved, kept few, optional as a set.
   Every assertion that exists must be met via proving tests ([[TDD]],
   `kskill-assertion-review`). They are the entry path for important features.
   When an assertion and the constitution disagree, the assertion is wrong
   ([[assertion-00-discipline]]).
7. **Knowledge under `docs/`.** Everything the project *knows* lives under
   `docs/`. The mod product root `Contents/mods/TrueDetective/`, `scripts/`,
   `legacy/`, and `state/` hold what the project *is* (or archives). Facts
   that an ADR rule stands on live in `docs/` documents and are reached by
   wikilink — never inlined into the ADR ([[adr-00-discipline]] rule 1).
8. **Live code root.** Product implementation lives only under
   `Contents/mods/TrueDetective/` with B42 load folder **`42.0/`**.
   `legacy/` is archival and not an install target. `scripts/install-local.sh`
   may only install the live Contents path.

## FORBIDDEN

- **NEVER** put product behavior, use cases, or assertion laws into the PRD
  body (rule 2). That duplicates owners and drifts.
- **NEVER** treat a document outside `docs/adrs/` as an ADR, or an ADR
  outside that directory as binding (rule 4).
- **NEVER** invent a product assertion without the owner (rule 6).
- **NEVER** re-activate `legacy/` as product SSOT or install target
  (rule 8).
- **NEVER** ship profession balance or detection numbers only in chat or
  Lua without a binding mechanics ADR in force (rule 4).

## REJECTED

- **Hello-world-only PRD as permanent objective** — the v42.20-0.1 greenfield
  brief treated load proof as the product. Rejected for the profession
  product: the Detective occupation is the objective from this constitution
  onward. Hello-world remains a temporary scaffold until mechanics land.
- **Web code-root pairs (frontend/backend or interfaces/services)** — harness
  template default. Rejected for this mod; the code root is
  `Contents/mods/TrueDetective/` ([[HARNESS]]).

## RELATED

### governed paths

- `docs/constitution/` — stable binding tier, [[PRD]] included
- `docs/` — loose documents that iterate with the code
- `docs/adrs/` — decision family
- `docs/assertions/` — law family
- `Contents/mods/TrueDetective/` — live mod product

### related files

- [[adr-00-discipline]] — ADR shape and lifecycle this ADR obeys
- [[adr-02-harness]] — how skills, hooks, and agents attach to this law
- [[HARNESS]] — tiers, families, vault, mod code root
- [[PRD]] — the objective
- [[CONVENTION]] — global frontmatter
- [[assertion-00-discipline]] — assertion family law
- [[TDD]] — proving path for assertions
