---
title: Glossary
description: Canonical names for True Detective domain concepts and harness vocabulary
updated: 2026-08-05
---

One name per concept, used everywhere — code, docs, conversation.

## Product domain

| Term | Meaning |
|---|---|
| True Detective | This mod product **and** the playable profession UI name (B42.20); folder `Contents/mods/TrueDetective/`. |
| `truedetective` | Profession `getName()` / forage / clothing key. Resource id: `truedetective:truedetective`. |
| CharacterProfession | B42.20 profession API — `CharacterProfession.register` in `media/registries.lua`. **Not** B41 `ProfessionFactory`. |
| ProfessionFactory | **Removed in B42.20.** Historical B41 only; never use in live code or docs as current API. |
| profession cost | Character-creation point cost of True Detective: **−6** ([[adr-05-true-detective-mechanics]]). |
| forage occupation | `forageSystem.addSkillDef` entry with `name = "truedetective"` (must match `getName()`). |
| vision bonus | Forage vision magnitude; True Detective **2.2** (beats Veteran 2.0). |
| search mode | Vanilla search/forage focus mode; amplifies detection chance to **66%**. |
| passive intuition | Out-of-search detection chance: **10%** on tile change. |
| tile change / square change | Player moved to a different `IsoGridSquare`; gates detection rolls. |
| door-adjacent | Room reached by checking door edges on N/S/E/W of the current square. |
| small room | Room whose square count is **≤ 50**; only these can trigger danger alerts. |
| danger phrase | Spoken line from the zombie-alert phrase pool when a live threat is detected. |
| search phrase | Spoken line when True Detective enters search mode. |
| live zombie | `IsoZombie` with `isAlive()` true; corpses do not alert. |
| SOTO detective | Unrelated simpler occupation (`soto:detective`) some packs ship — **not** this mod; no door-room intuition. |
| B41 original | Workshop **3383387174** *Detective Profession* (`prof_detective`); snapshot in `references/original-mod/`. |
| product root | `Contents/mods/TrueDetective/` — code SSOT; live load under **`42.0/`**. |
| Workshop layout | `Contents/mods/<Mod>/` (+ version folder `42.0/`) under an item root with `workshop.txt` + `preview.png`. |

## Harness vocabulary

| Term | Meaning |
|---|---|
| tier | Sorting container: `docs/constitution/` or loose `docs/`. Meaningful **and** stable → constitution. |
| family | Numbered append-only line — ADRs, assertions — ruled by `-00` discipline. |
| constitution | Stable binding tier; changing it is an event. |
| ADR | Binding decision in `docs/adrs/`; where code disagrees, ADR wins ([[adr-00-discipline]]). |
| assertion | Optional owner-reserved law with proving tests ([[assertion-00-discipline]]). |
| TDD | Test-first path for assertion-driven work — [[TDD]]. |
| triage-and-fix | Issue→PR party — `docs/skills/triage-and-fix/`, cast `kwf-*` ([[adr-04-issue-delivery]]). |
| guardian | Agent gating PRD or ADR health — never dispatches ([[adr-03-guardians]]). |
| vault | `docs/` as wikilink vault via markdown-vault-mcp; basenames unique ([[HARNESS]]). |
| use case | Gherkin behavior chapter `UC-NN` in [[USE-CASES]]. |
| user story | Want chapter `US-NN` in [[USER-STORIES]]. |
| open/close list | Chapters that open/close over the product life; presence = current. |
