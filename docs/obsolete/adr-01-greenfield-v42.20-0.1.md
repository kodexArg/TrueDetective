---
title: adr-01-greenfield-v42.20-0.1
type: adr
category: process
use_case: understanding repo baseline after the 2026-08-08 reset
created: 2026-08-08
modified: 2026-08-08
tags: [adr, process, greenfield, b42]
---

# ADR-01 — Greenfield baseline v42.20-0.1

## CONTEXT

> The B41→B42 profession rebuild and its harness docs were retired as the live product. A new plan will replace them. We need a clean `main` with harness, archive, and a loadable mock.

## ASSERTIONS

1. All pre-reset root content lives under **`legacy/`** and is not the install target.
2. Live mod code is only under **`Contents/mods/TrueDetective/`** with B42 folder **`42.0/`**.
3. Release identity for this baseline is git tag **`v42.20-0.1`** and `modversion=42.20-0.1`.
4. Hello-world console proof is the only gameplay-facing behavior until new ADRs add more.
5. Old mechanics ADRs under `legacy/docs/adrs/` (e.g. adr-05) are **not** in force.

## DECISION

Ship **v42.20-0.1** as the greenfield baseline: harness + legacy + B42.20 hello-world mock.
