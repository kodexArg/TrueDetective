---
title: PZ mod structure — Lua examples
description: Minimal B42.20 Lua patterns for True Detective (events, profession register, phrases)
updated: 2026-08-08
---

# Lua examples (B42.20)

Examples are **illustrative**. Binding numbers (cost, chances) require a
mechanics ADR before shipping as product truth.

## 1. Hello / load proof (current scaffold)

Path: `42.0/media/lua/client/TrueDetective/HelloWorld.lua`

```lua
--[[ True Detective — load proof ]]
local TAG = "[TrueDetective]"

local function hello(where)
    print(TAG .. " Hello World (B42.20) — " .. tostring(where))
end

Events.OnGameBoot.Add(function()
    hello("OnGameBoot")
end)

Events.OnMainMenuEnter.Add(function()
    hello("OnMainMenuEnter")
end)

Events.OnGameStart.Add(function()
    hello("OnGameStart")
end)
```

## 2. Early profession register (`registries.lua`)

Path: `42.0/media/registries.lua`  
Loaded before scripts and ordinary Lua. From PZwiki Registries + legacy TD.

```lua
-- True Detective — B42 CharacterProfession registry
TrueDetective = TrueDetective or {}

TrueDetective.PROFESSION_ID = "truedetective"
TrueDetective.PROFESSION_RESOURCE = "truedetective:truedetective"

-- Path component becomes getName() → "truedetective"
TrueDetective.ProfessionType = CharacterProfession.register(
    TrueDetective.PROFESSION_RESOURCE
)
```

**Never** on B42.20:

```lua
-- FORBIDDEN
ProfessionFactory.addProfession(...)
```

## 3. Shared module table pattern

Path: `42.0/media/lua/shared/TrueDetective/Constants.lua`

```lua
TrueDetective = TrueDetective or {}
TrueDetective.Constants = TrueDetective.Constants or {}

TrueDetective.Constants.TAG = "[TrueDetective]"
TrueDetective.Constants.PROFESSION_NAME = "truedetective"
```

## 4. Client event: square-change detection skeleton

Path: `42.0/media/lua/client/TrueDetective/ZombieDetection.lua`  
Logic only — chances live in a mechanics ADR.

```lua
require "TrueDetective/Constants"

local function isTrueDetective(player)
    if not player then return false end
    local desc = player:getDescriptor()
    if not desc then return false end
    local prof = desc:getCharacterProfession()
    if not prof then return false end
    return prof:getName() == TrueDetective.Constants.PROFESSION_NAME
end

-- Wire to the event the design chooses (tile change / move).
-- Example placeholder — replace with the actual B42 event used in product code.
local function onPlayerMove(player)
    if not isTrueDetective(player) then return end
    -- door-adjacent small-room living-zombie check goes here
end
```

## 5. English UI string table

Path: `42.0/media/lua/shared/Translate/EN/UI.json`  
Build 42.20 reads **JSON** translation files (`<Context>.json` per language
folder). The B41 `UI_EN.txt` table format is ignored.

```json
{
    "UI_prof_truedetective": "Detective",
    "UI_profdesc_truedetective": "A hard-boiled urban investigator. Walks into the apocalypse wearing a fedora and a leather coat, with a trusty revolver and spare rounds."
}
```

Locale codes use the game’s Translate folders (`EN`, `ES`, …). Config keys and
identifiers stay English (see [[adr-06-steam-configurations]] language rule).
