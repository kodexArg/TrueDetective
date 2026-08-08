---
title: adr-07-clean-code
type: adr
category: backend
use_case: writing or editing Lua under Contents, naming files or functions, deciding whether to extract a shared helper, adding comments, placing documentation, reviewing code style for True Detective
created: 2026-08-08
modified: 2026-08-08
tags: [adr, backend, clean-code, lua, kiss, dry, naming]
---

# ADR-07 — clean code (Lua and project code)

## CONTEXT

> This ADR is how code is written in True Detective. Agents and tools own
> the code; humans read the harness. Style stays small, plain, and
> Unix-named. Documentation does not live in source comments.

Rules only. Layout of folders under `Contents/` is [[adr-05-project-zomboid-mod-structure]].
Logging is [[adr-08-logging-strategy]]. Ship process is
[[adr-09-gh-deploy-and-versioning]].

## ASSERTIONS

1. **No comments in code.** Source carries no comments (`--`, block
   comments, or decorative banners) unless the owner explicitly requires a
   comment in the change, or a third-party format forces a marker. Intent
   lives in names, structure, tests, and harness docs — not in line noise.
2. **Documentation is the harness.** Durable explanation lives under
   `docs/` (constitution, ADRs, living docs, resources). Every markdown
   note uses YAML frontmatter for quick index (`title`, `description`,
   `updated` or the seven ADR fields). Future ADRs keep that frontmatter
   contract ([[adr-00-discipline]], [[CONVENTION]]). Code does not
   duplicate harness prose.
3. **KISS over DRY.** Prefer the smaller whole program. If avoiding
   repetition needs extra modules, indirection, or import graph that costs
   more than a short second copy of a minimal function, **repeat the
   function**. DRY is a tool, not a goal. KISS wins the fight.
4. **Minimal functions.** Each function does one job, stays short, and
   takes only the data it needs. No framework layer “for later.” No empty
   wrappers.
5. **Lua package layout.** Live Lua stays under
   `Contents/mods/TrueDetective/42.0/media/lua/{shared,client,server}/TrueDetective/`
   (and `common/` only when shared assets belong there per adr-05). One
   concern per file. `require` paths use the package path without `.lua`
   (example: `require "TrueDetective/hello_world"`).
6. **Naming: Unix over JavaScript.** Prefer **snake_case** for Lua files,
   locals, and functions. Prefer **kebab-case** for docs, ADR slugs, and
   harness paths. Do not use camelCase or JS-style module export patterns.
   Engine-locked names stay as the game requires (`CharacterProfession`,
   `OnGameBoot`, `TrueDetective` package folder, Mod ID). Registry ids stay
   English path form (`truedetective:truedetective`).
7. **Less verbose Lua.** Prefer: `local` everything; small module tables
   only when shared state is real; direct `Events.*.Add` at file bottom or
   one init function; no metatable sugar unless required; no unused
   abstractions. Match the thinner of community/vanilla patterns when
   both work.
8. **Globals.** Do not pollute `_G`. If a shared table is needed,
   `TrueDetective = TrueDetective or {}` once, then attach fields.
9. **Balance and product numbers** still require a mechanics ADR before
   they appear in code ([[adr-01-constitution]]). Clean code does not
   invent balance.

## FORBIDDEN

- **NEVER** leave explanatory comments in Lua or scripts by default
  (rule 1).
- **NEVER** put product or process law only inside a comment or skill
  prompt (rule 2) — harness ADRs own law.
- **NEVER** build a shared layer whose only job is to avoid a few lines of
  duplication (rule 3).
- **NEVER** use camelCase for new identifiers we control (rule 6).
- **NEVER** add a file whose only content is re-export boilerplate
  (rule 4).

## REJECTED

- **Comment-heavy “readable for humans” source** — rejected; harness is
  the human surface.
- **DRY at any cost** — rejected; KISS over DRY (rule 3).
- **JavaScript/TypeScript naming and barrel files** — rejected for this
  Lua mod.
- **PascalCase file names for new Lua we add** — rejected when we control
  the name; vanilla/IS* names stay when calling the engine. Existing
  scaffold `HelloWorld.lua` may be renamed to snake_case when next
  touched.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/**/media/lua/` — Lua source
- `Contents/mods/TrueDetective/**/media/scripts/` — script text (no
  comment style either)
- `docs/` — documentation and frontmatter index

### related files

- [[adr-00-discipline]] — frontmatter and ADR shape for all future ADRs
- [[adr-05-project-zomboid-mod-structure]] — folders and load order
- [[CONVENTION]] — base frontmatter
- [[adr-08-logging-strategy]] — errors and iteration logs
- [[PRD]] — product objective
