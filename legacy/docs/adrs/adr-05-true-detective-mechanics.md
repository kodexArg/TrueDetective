---
title: adr-05-true-detective-mechanics
type: adr
category: project
use_case: changing profession cost XP boosts forage bonuses detection chance room size phrases or clothing odds, balancing True Detective, editing Contents/mods/TrueDetective Lua for mechanics, porting numbers from references/original-mod, B42 CharacterProfession registration
created: 2026-08-05
modified: 2026-08-05
tags: [adr, project, mechanics, profession, forage, detection, B42]
---

# ADR-05 — True Detective mechanics

## CONTEXT

> These are the binding profession mechanics for True Detective on Build
> 42.20. Balance numbers and detection rules live here; code implements them.
> Facts and narratives live in the PRD, requirements, use cases, and mod API
> docs — this ADR only states rules.

Port baseline: B41 *Detective Profession* under `references/original-mod/`
(Workshop 3383387174). Product root: `Contents/mods/TrueDetective/` with live
media under **`42.0/`**.

B42.20 registration is **not** B41 `ProfessionFactory`. Pattern: early
`CharacterProfession.register` in `media/registries.lua` +
`character_profession_definition` in scripts. Full surface: [[MOD-API]].

**SOTO note:** third-party occupation packs (e.g. SOTO) may ship a simpler
`soto:detective`. This product is **True Detective**
(`truedetective:truedetective`) and uniquely owns **door-adjacent small-room
zombie intuition** with spoken phrases — SOTO does not.

## ASSERTIONS

1. **Profession identity (B42.20).** Resource id is
   **`truedetective:truedetective`**. `CharacterProfession:getName()` is
   **`truedetective`**. Display name is **True Detective**
   (`UI_prof_truedetective`). Registration is via
   `CharacterProfession.register` + script definition — **never**
   `ProfessionFactory`.
2. **Profession cost.** True Detective costs **−6** character-creation points.
3. **XP boosts.** True Detective grants exactly: Aiming **+1**, Lightfoot **+1**,
   Sneak **+2**. No other starting XP boosts ship without amending this ADR.
4. **Forage vision.** Occupation `visionBonus` is **2.2** (strictly better than
   Veteran’s 2.0 under vanilla comparison used by the original). Forage
   `def.name` **must equal** `getName()` → **`truedetective`**, registered with
   `forageSystem.addSkillDef`.
5. **Forage mitigation.** Occupation `weatherEffect` and `darknessEffect` are
   each **33** unless this ADR changes them.
6. **Forage specialisations.** Occupation specialisation weights are:

   | Category | Weight |
   |---|---|
   | Animals | 10 |
   | Insects | 5 |
   | Medical | 10 |
   | Ammunition | 50 |
   | JunkWeapons | 15 |
   | MedicinalPlants | 5 |
   | ForestRarities | 10 |
   | Trash | 20 |
   | Junk | 20 |
   | WildPlants | 5 |

   Category *names* may be remapped if B42 renames forage categories; weights
   stay. Urban junk/trash/ammo emphasis must remain the identity.
7. **Detection audience.** Zombie intuition and danger phrases run **only** for
   characters with the True Detective profession (`truedetective`). Runtime
   check prefers **`desc:getCharacterProfession()`**, not B41
   `getProfession()` as the primary API.
8. **Detection trigger.** Detection is considered only when the player’s
   **square changes** (not every tick while standing still).
9. **Detection chances.** On a qualifying square change, roll `ZombRand(100)`
   (or equivalent 0–99): succeed if **&lt; 66** while search mode is active,
   or **&lt; 10** while search mode is inactive (passive intuition).
10. **Door adjacency.** On a successful roll, inspect rooms reached through
    door edges on the **north, south, east, and west** of the current square
    (including doors owned by the adjacent square facing back).
11. **Room size gate.** A room with more than **50** squares never produces a
    danger phrase, regardless of zombies present.
12. **Live zombies only.** A danger phrase requires at least one object that is
    an `IsoZombie` and reports alive. Dead zombies and non-zombie movers do
    not count.
13. **Phrases — search.** Entering search mode causes True Detective to speak
    one line from the search phrase pool.
14. **Phrases — danger.** A successful room threat check causes True Detective
    to speak one line from the danger phrase pool (not a silent moodle-only
    cue as the sole feedback).
15. **Clothing.** Character-creation definitions key
    **`ClothingSelectionDefinitions.truedetective`** (must match `getName()`):
    - Hat: **75%** chance — fedora variants  
    - Jacket: **75%** chance — long jacket  
    - Pants: practical trousers (default texture and/or denim)  
    - Shoes: practical/random shoes  
    Concrete `Base.*` item ids may track B42 renames; chances and slots bind.
16. **No silent balance drift.** Any change to cost, XP, forage weights/vision,
    detection chances, room cap, profession gate, or clothing chances updates
    this ADR in the same change set as the code (or the code waits for the ADR).
17. **Reference tree is not law.** `references/original-mod/` may inform ports;
    if it disagrees with this ADR, **this ADR wins**. B41 `ProfessionFactory`
    and keys `prof_detective` / forage `detective` are historical only.

## FORBIDDEN

- **NEVER** use `ProfessionFactory` or `ProfessionFactory.addProfession` in
  live B42.20 code or docs as the registration path (rule 1).
- **NEVER** change detection chances, room size cap, profession cost, XP
  boosts, or forage vision/specialisation weights in code without amending
  this ADR (rules 2–6, 9, 11, 16). Silent “feel tweaks” are defects.
- **NEVER** grant door-adjacent zombie intuition to non–True Detective
  professions from this mod (rule 7).
- **NEVER** treat rooms larger than 50 squares as valid danger sources
  (rule 11).
- **NEVER** count dead zombies as threats for danger phrases (rule 12).
- **NEVER** ship balance as the sole authority inside chat or a PR description
  without the ADR body reflecting it (rule 16).
- **NEVER** conflate this occupation with SOTO (or other) `soto:detective` —
  door intuition is unique to True Detective.

## REJECTED

- **ESP / always-on full-map sense** — rejected; tile-change rolls and small
  rooms keep the fantasy tactical. Reopen only with owner + new ADR rules.
- **Matching Veteran vision exactly (2.0)** — rejected; original identity is
  *better than Veteran* at 2.2.
- **Passive chance equal to search chance** — rejected; search mode must feel
  meaningfully sharper (66% vs 10%).
- **B41 workshop id as the only product name** — rejected for the rebuild
  brand **True Detective**; continuity link retained in README/PRD only.
- **Reusing B41 `ProfessionFactory` on B42.20** — rejected; API is gone.
- **Forage/clothing key mismatch vs `getName()`** — rejected; all three bind
  to **`truedetective`**.

## RELATED

### governed paths

- `Contents/mods/TrueDetective/42.0/media/` — live implementation
- `Contents/mods/TrueDetective/42.0/media/registries.lua` — profession register
- `Contents/mods/TrueDetective/42.0/media/scripts/characters/TrueDetective_professions.txt`
- `references/original-mod/` — B41 baseline (non-authoritative)

### related files

- [[PRD]] — product objective
- [[REQUIREMENTS]] — FR/NFR enumeration
- [[MOD-API]] — registration and event surface
- [[ARCHITECTURE]] — module flow
- [[USE-CASES]] — UC-01…UC-09
- [[USER-STORIES]] — player wants
- [[adr-00-discipline]] — ADR shape
- [[adr-01-constitution]] — authority order
