require "Foraging/forageSystem"

TrueDetective_SearchBoost = TrueDetective_SearchBoost or {}

local MULT = 1.5
local base_vision = nil
local base_specs = nil
local last_on = nil

local function is_detective(player)
    local d = player and player:getDescriptor()
    local p = d and d:getCharacterProfession()
    return p and p:getName() == "truedetective"
end

local function is_glass(item)
    if not item then
        return false
    end
    if item:getType() == "MagnifyingGlass" then
        return true
    end
    return item.getFullType and item:getFullType() == "Base.MagnifyingGlass"
end

function TrueDetective_SearchBoost.has_magnifier(player)
    if not player then
        return false
    end
    return is_glass(player:getPrimaryHandItem()) or is_glass(player:getSecondaryHandItem())
end

local function occupation_def()
    return forageSystem
        and forageSystem.skillDefs
        and forageSystem.skillDefs.occupation
        and forageSystem.skillDefs.occupation["truedetective"]
end

local function remember(def)
    if base_vision ~= nil then
        return
    end
    base_vision = def.visionBonus
    base_specs = {}
    if def.specialisations then
        for key, value in pairs(def.specialisations) do
            base_specs[key] = value
        end
    end
end

local function set_boost(on)
    local def = occupation_def()
    if not def then
        return
    end
    remember(def)
    if on then
        def.visionBonus = base_vision * MULT
        if def.specialisations then
            for key, value in pairs(base_specs) do
                def.specialisations[key] = value * MULT
            end
        end
        return
    end
    def.visionBonus = base_vision
    if def.specialisations then
        for key, value in pairs(base_specs) do
            def.specialisations[key] = value
        end
    end
end

local function on_player_update(player)
    if not player or player:isDead() or player ~= getSpecificPlayer(0) then
        return
    end
    local on = is_detective(player) and TrueDetective_SearchBoost.has_magnifier(player)
    if last_on == on then
        return
    end
    last_on = on
    set_boost(on)
end

Events.OnPlayerUpdate.Add(on_player_update)
