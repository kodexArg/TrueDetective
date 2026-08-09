---
title: Outfit
description: True Detective starting loadout — fedora, leather long coat, revolver; item ids, config files, and why
updated: 2026-08-08
---

# Outfit — True Detective starting loadout

The Detective **always** spawns with the same look and the same gun. Colors
stay undefined on purpose: every chosen item rolls a random texture, so no
two detectives need to match.

## Worn at character creation

| Slot | Item id | What it is | Color |
|------|---------|------------|-------|
| Hat | `Base.Hat_Fedora` | Fedora | Random: grey / brown (`IconsForTexture`) |
| Jacket | `Base.JacketLong_Random` | **Leather** long coat (`FabricType = Leather`) | Random: black / brown / green |
| Pants | `Base.Trousers_DefaultTEXTURE_TINT`, `Base.Trousers_Denim` | Trousers or jeans | Random tint / denim |

- Config: `Contents/mods/TrueDetective/42.0/media/lua/shared/TrueDetective/Outfit.lua`
- `chance = 100` on both slots — the game engine dresses the profession,
  so the look holds at spawn without extra code.
- `JacketLong_Random` is the vanilla long coat with random texture. It is
  leather, **not** a raincoat. Only the `Female` table is defined; vanilla
  applies it to both sexes.
- The fedora uses vanilla `ChanceToFall = 40`: it always spawns on the head,
  but it can fall off during play like any vanilla hat. Verified in-game
  2026-08-08 — spawned worn, later found on the ground at the spawn point.

## In the inventory on a new game

Guaranteed:

| Item id | Why |
|---------|-----|
| `Base.Revolver` | The revolver. Never a pistol. .357, spawned **loaded 6/6** (`setCurrentAmmoCount(getMaxAmmo())`). |
| `Base.Bullets357Box` | The spare "magazine". Build 42.20 has **no speedloader item**; a box of matching .357 rounds is the closest real thing. |
| `Base.MagnifyingGlass` | The investigator's tool — guaranteed because it gates Survey Sense ([[adr-10-survey-sense]]). |

75% chance each (owner call — "that's how our detective is"):

| Item id | What it is |
|---------|------------|
| `Base.SmokingPipe_Tobacco` | Smoking Pipe with Tobacco |
| `Base.CigarettePack` | Cigarette Pack |
| `Base.Lighter` | Lighter |
| `Base.Whiskey` | Bottle of Whiskey, full (fluid container, 1.0) |

- Config: `Contents/mods/TrueDetective/42.0/media/lua/client/TrueDetective/StartingGear.lua`
- Fires on `Events.OnNewGame`, gated on
  `getDescriptor():getCharacterProfession():getName() == "truedetective"`.
- Optional rolls use `ZombRand(100) < 75`.

## Item facts checked against the installed game

Source: `…/ProjectZomboid/projectzomboid/media/scripts/generated/items/`
on Build 42.20 (buildid 24574865).

- `Hat_Fedora` — `IconsForTexture = FedoraGrey;FedoraBrown`.
- `JacketLong_Random` — `FabricType = Leather`,
  `IconsForTexture = JacketLongBlack;JacketLongBrown;JacketGreen`.
- `Revolver` — `AmmoType = base:bullets_357`, `AmmoBox = Base.Bullets357Box`,
  `MaxAmmo = 6`.
- `MagnifyingGlass`, `SmokingPipe`, `SmokingPipe_Tobacco` — all present in
  `generated/items/normal.txt`.
- No `Speedloader*` item exists in 42.20 scripts.

## Not defined here (on purpose)

- Shirt, shoes — left to the vanilla `default` clothing pool.
- Profession `Cost` stays the neutral `0`; XP boosts, traits, and recipes
  wait for the binding mechanics ADR ([[REQUIREMENTS]] N5).
