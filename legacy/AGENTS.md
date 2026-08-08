# AGENTS.md — True Detective

Contract for every agent working in this repository. Human-facing product summary: [README.md](README.md).

## Product

- **Name:** True Detective  
- **Kind:** Project Zomboid **Build 42.20** profession mod (Lua + media)  
- **Owner:** kodexArg (Gabriel)  
- **Repo path:** `/home/kodex/Dev/Project-Zomboid/TrueDetective`  
- **Mod id:** `TrueDetective` · Workshop **3383387174**  
- **Profession resource:** `truedetective:truedetective` · `getName()` = **`truedetective`**

## Source of truth

| Layer | Path | Rule |
|---|---|---|
| **Code SSOT** | `Contents/mods/TrueDetective/` | Only place live mod files are authored. **B42 load root:** `42.0/` (`42.0/media/…`). |
| **Law** | `docs/` (especially `docs/constitution/` + `docs/adrs/`) | Written truth. Where code and ADR disagree, the **ADR is right**. |
| **Mechanics** | `docs/adrs/adr-05-true-detective-mechanics.md` | Binding profession / forage / detection / phrase / clothing rules. |
| **Mod surface** | `docs/MOD-API.md` | Registration, events, keys — **B42.20 CharacterProfession**, not B41 factory. |
| **B41 reference** | `references/original-mod/` | Historical snapshot for the port. **Not** the live product; do not edit as if it were shipping. |

## B42.20 profession rules (agents — mandatory)

1. **`ProfessionFactory` is GONE.** Never call it, document it as live, or port B41 `addProfession` into `42.0/`.
2. **Register:** `media/registries.lua` → `CharacterProfession.register("truedetective:truedetective")`.
3. **Define:** `media/scripts/characters/TrueDetective_professions.txt` → `character_profession_definition`.
4. **Keys that must match `getName()` (`truedetective`):** forage `def.name`, `ClothingSelectionDefinitions.truedetective`.
5. **Runtime check:** prefer `desc:getCharacterProfession()` — not `getProfession()` as primary.
6. **Not SOTO:** SOTO may ship a simpler `soto:detective`. Ours is **True Detective** with unique door-room intuition; do not merge or rename into SOTO’s occupation.
7. **Detection balance (adr-05):** 66% search / 10% passive; rooms ≤ 50; profession-only; live zombies only.

## Do / do not

1. **Do** read [[PRD]] and [[adr-05-true-detective-mechanics]] before changing balance, detection chances, room size, forage tables, or profession cost/XP.
2. **Do not invent balance** (costs, chances, bonuses, room caps, clothing odds) without an ADR amend — normally **adr-05**.
3. **Do** keep `mod.info` id/name aligned with Workshop packaging under `Contents/mods/TrueDetective/`.
4. **Do not** treat this as a fullstack webapp. There is no `frontend/` or `backend/` product root; those docs are stubs pointing at the mod tree.
5. **Do not** touch unrelated host Steam credentials, tokens, or paste secrets into docs/commits.
6. **Do** target **B42.20** APIs and events; B41-only calls from `references/original-mod/` must be revalidated before use — **especially never reintroduce ProfessionFactory**.
7. **Do** prefer inspect → change → verify (in-game or scripted checks) over silent balance tweaks.
8. **Do** install via symlink: `~/Zomboid/mods/TrueDetective` → `Contents/mods/TrueDetective`.

## Authority order

1. `docs/constitution/PRD.md`  
2. Rest of `docs/constitution/`  
3. `docs/adrs/*` (in force)  
4. Other `docs/*`  
5. `Contents/mods/TrueDetective/` implementation  

## Harness notes

- Knowledge vault root: `docs/` (markdown-vault-mcp via `.mcp.json`).  
- Assertions: optional; none required for a healthy project beyond discipline file.  
- Issue delivery cast (`docs/agents/kwf-*`, `triage-and-fix`) remains available; product work is still mod Lua/media.  
- Host PZ paths and 42.20 facts: skill `steam-project-zomboid` + [[INFRASTRUCTURE]].  
- Scaffolding origin: `kodexArg/harness-default` (no first commit yet at rebuild start).

## Out of scope for casual edits

- `references/original-mod/` media/Lua (except deliberate reference updates)  
- Publishing Workshop credentials or automated workshop upload without explicit owner ask  
- Changing harness guardian/cast law without the owning ADR (`adr-02` / `adr-03` / `adr-04`)
