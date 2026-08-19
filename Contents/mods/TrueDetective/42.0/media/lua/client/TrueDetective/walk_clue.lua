require "TrueDetective/Chances"
require "TrueDetective/investigate_leads"
require "TrueDetective/SearchBoost"

local last_x, last_y, last_z
local last_hit_ms = 0

local function is_detective(player)
    local d = player and player:getDescriptor()
    local p = d and d:getCharacterProfession()
    return p and p:getName() == "truedetective"
end

local function searching(player)
    if ISSearchManager and ISSearchManager.players and ISSearchManager.players[player] then
        return ISSearchManager.players[player].isSearchMode and true or false
    end
    return false
end

local function walk_stance(player)
    if searching(player) then
        return "search"
    end
    if player.isSneaking and player:isSneaking() then
        return "sneak"
    end
    return "walk"
end

local function on_player_update(player)
    if not player or player:isDead() or player ~= getSpecificPlayer(0) then
        return
    end
    if not is_detective(player) then
        return
    end
    if not TrueDetective_SearchBoost.has_magnifier(player) then
        return
    end
    if player:getVehicle() then
        return
    end
    if player.isSprinting and player:isSprinting() then
        return
    end
    if player:isAsleep() then
        return
    end
    local square = player:getCurrentSquare() or player:getSquare()
    if not square then
        return
    end
    local x, y, z = square:getX(), square:getY(), square:getZ()
    if last_x == x and last_y == y and last_z == z then
        return
    end
    last_x, last_y, last_z = x, y, z
    local walk = TrueDetective_Chances.walk
    local cooldown = walk and walk.cooldown_ms or 0
    local now = getTimestampMs()
    if cooldown > 0 and now - last_hit_ms < cooldown then
        return
    end
    local chance = TrueDetective_Chances.walk_for_stance(walk_stance(player))
    if not TrueDetective_Chances.passed(chance) then
        return
    end
    local text = TrueDetective_InvestigateLeads.lead_from_walk(player)
    if not text then
        return
    end
    last_hit_ms = now
    player:Say(text)
end

Events.OnPlayerUpdate.Add(on_player_update)
