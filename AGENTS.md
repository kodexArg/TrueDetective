# AGENTS.md — True Detective

## Product

- **Name:** True Detective  
- **Kind:** Project Zomboid **Build 42.20** **profession mod**  
- **Occupation:** playable **Detective** (display **True Detective**)  
- **Repo:** `/home/kodex/Dev/personal/Project-Zomboid/TrueDetective`  
- **GitHub:** `kodexArg/TrueDetective`  
- **Mod id:** `TrueDetective`  
- **Workshop:** `3383387174`  
- **Baseline tag:** `v42.20-0.1` (harness + hello-world scaffold)  
- **Harness:** adapted from `kodexArg/harness-default`  
- **Structure law:** `adr-05-project-zomboid-mod-structure`  
- **Steam law:** `adr-06-steam-configurations`  
- **Clean code:** `adr-07-clean-code` (no comments; KISS > DRY)  
- **Logging:** `adr-08-logging-strategy` → `log/YYYYMMDD-NNN.log`  
- **Ship:** `adr-09-gh-deploy-and-versioning` (locked `main`, ISSUE→PR)  
- **Workshop ID / Mod ID:** `3383387174` / `TrueDetective`

## Source of truth

| Layer | Path |
|-------|------|
| Objective | `docs/constitution/PRD.md` |
| Law | `docs/constitution/`, `docs/adrs/` (`adr-00`…`adr-09`) |
| Debug logs | `log/YYYYMMDD-NNN.log` (gitignored files) |
| Structure facts | `docs/resources/pz-mod-structure/` |
| Steam facts | `docs/resources/steam-configurations/` |
| Live code | `Contents/mods/TrueDetective/` · load **`42.0/`** |
| Local install | `~/Zomboid/mods/TrueDetective` (real dir) |
| Archive | `legacy/` — do not install or ship as live |

## Authority

1. `docs/constitution/PRD.md`  
2. Constitution + in-force ADRs  
3. Other `docs/`  
4. `Contents/` implementation  

Where code and ADR disagree, **ADR wins**.

## Standing rules

1. No `ProfessionFactory` — B42 `CharacterProfession` only.  
2. Install: `scripts/install-local.sh` → root Contents only (real dir →
   `~/Zomboid/mods/TrueDetective`).  
3. Layout: [[adr-05-project-zomboid-mod-structure]] + resources; Steam paths:
   [[adr-06-steam-configurations]].  
4. Product balance requires a **mechanics** ADR before Lua numbers ship.  
5. Do not re-activate `legacy/` as product SSOT.  
6. Assertions are optional and owner-reserved; none is healthy.  
7. Harness tooling SSOT: `docs/skills|hooks|agents` only — kind prefixes
   `kskill-*` / `khook-*` / `kbot-*` / `kwf-*`. Runtime-agnostic.  
8. Config identifiers ENGLISH ONLY (Mod ID, paths, API); prose soft-English.  
9. No code comments by default; KISS over DRY; snake_case / kebab-case.  
10. Failures → `log/YYYYMMDD-NNN.log`. Ship via PR to locked `main`.

## Host

- Game: native Linux Steam app **108600**, target **42.20**  
- Local mod: `~/Zomboid/mods/TrueDetective`  
- Skill: `/steam-project-zomboid` · host docs `~/Skills/steam-project-zomboid`
