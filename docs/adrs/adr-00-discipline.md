---
title: adr-00-discipline
type: adr
category: harness
use_case: writing, editing, retiring or reviewing any ADR
created: 2026-08-08
modified: 2026-08-08
tags: [adr, discipline, harness]
---

# ADR-00 — the ADR discipline

## CONTEXT

> Every ADR here has one shape and one theme. This file is that shape.

## ASSERTIONS

1. An ADR states **rules**. Supporting facts live in `docs/` (including constitution) and are reached by wikilink.
2. ADRs live in `docs/adrs/`, named `adr-NN-slug.md`. `adr-00` is this discipline.
3. Frontmatter fields: `title`, `type` (`adr`), `category`, `use_case`, `created`, `modified`, `tags`.
4. Categories for this mod project: `harness`, `mod`, `process`, `host`, `security`.
5. Superseding an ADR: mark old status in body; do not rewrite history silently.
6. Product balance (costs, chances, XP) requires an ADR — never invent into Lua alone.
7. `legacy/docs/adrs/` is historical and **not** in force for the greenfield tree.

## DECISION

Adopt this discipline for all ADRs after **v42.20-0.1**.
