---
title: Glossary
description: Canonical names for harness and True Detective domain concepts
updated: 2026-08-08
---

One name per concept, used everywhere — code, docs, conversation. The rows
below canonize the harness vocabulary and this mod's domain terms.

| Term | Meaning |
|---|---|
| tier | A sorting container for written knowledge: `docs/constitution/` or the loose documents directly in `docs/`. |
| family | A numbered, append-only line of files — ADRs, assertions — each ruled by its own `-00` discipline file. |
| constitution | The stable tier: foundational, binding documents read first and amended rarely. |
| ADR | Architecture Decision Record — presence in `docs/adrs/` makes it binding ([[adr-00-discipline]]). |
| assertion | Owner-reserved law with a proving path ([[assertion-00-discipline]], [[TDD]]). |
| TDD | Test-first method for assertion-driven work — [[TDD]]. |
| triage-and-fix | In-tree issue→PR party — [[adr-04-issue-delivery]]. |
| kwf-* | Delivery cast nodes — party members with a phase. |
| kskill-* / khook-* / kbot-* | Harness naming prefixes for skills, hooks, and non-party agents. |
| guardian | Agent that gates PRD or ADR health — `kbot-prd`, `kbot-adr` ([[adr-03-guardians]]). |
| owner | The human the project belongs to (kodexArg). |
| vault | `docs/` served wikilink-aware by markdown-vault-mcp. |
| code root | For this mod: `Contents/mods/TrueDetective/` (not frontend/backend). |
| use case | One behavior as Gherkin — `UC-NN` in [[USE-CASES]]. |
| user story | *As a, I want, so that* — `US-NN` in [[USER-STORIES]]. |
| True Detective | Product name and display profession name. |
| Detective | The playable occupation fantasy this mod adds. |
| `truedetective` | `CharacterProfession:getName()` and clothing/forage key. |
| `truedetective:truedetective` | B42 resource id for the profession. |
| `42.0/` | B42 version folder under the mod product root (serves 42.20). |
| CharacterProfession | B42 registration API — required. |
| ProfessionFactory | B41 registration API — forbidden on B42.20. |
| door-room intuition | Door-adjacent small-room living-zombie detection with spoken phrases. |
| legacy/ | Archive of retired trees — not live product. |
| version folder | B42 load pin under the mod (`42.0/`, `42.20/`, …) — [[adr-05-project-zomboid-mod-structure]]. |
| common/ | B42 shared media folder; loads before version folder. |
| Workshop ID | Steam item number (assigned at first publish; B41 legacy item is `3383387174`) — not Mod ID. |
| Mod ID | `mod.info` `id=` value (`TrueDetective`) — load lists and servers. |
| resources pack | Fact files under `docs/resources/` supporting heavy ADRs. |
