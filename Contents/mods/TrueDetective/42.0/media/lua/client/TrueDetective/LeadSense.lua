local RoomScan = require "TrueDetective/RoomScan"
local Phrases = require "TrueDetective/Phrases"

local LeadSense = {}

LeadSense.SCAN_INTERVAL_TICKS = 45

local tickCount = 0

local function isDetective(player)
    if not player then
        return false
    end
    local descriptor = player:getDescriptor()
    if not descriptor then
        return false
    end
    local profession = descriptor:getCharacterProfession()
    if not profession then
        return false
    end
    return profession:getName() == "truedetective"
end

local function isSearchModeActive(player)
    local manager = ISSearchManager and ISSearchManager.players and ISSearchManager.players[player]
    return manager and manager.isSearchMode or false
end

local function leadRadius(player)
    local perk = player:getPerkLevel(Perks.PlantScavenging)
    local radius = forageSystem.maxVisionRadius
        + forageSystem.getProfessionVisionBonus(player)
        + forageSystem.getTraitVisionBonus(player)
        + forageSystem.getLevelVisionBonus(perk)
    return math.min(radius, forageSystem.visionRadiusCap)
end

local function canSee(player, zombie)
    local ok, seen = pcall(function()
        return player:CanSee(zombie)
    end)
    return ok and seen or false
end

local function scan(player)
    local origin = player:getSquare()
    if not origin then
        return
    end
    local radius = leadRadius(player)
    local px, py, pz = origin:getX(), origin:getY(), origin:getZ()
    local box = math.ceil(radius)
    local cell = getCell()
    local leads = 0
    for x = px - box, px + box do
        for y = py - box, py + box do
            local dx, dy = x - px, y - py
            if dx * dx + dy * dy <= radius * radius then
                local square = cell:getGridSquare(x, y, pz)
                if square then
                    local moving = square:getMovingObjects()
                    if moving then
                        for i = 0, moving:size() - 1 do
                            local zombie = moving:get(i)
                            if instanceof(zombie, "IsoZombie") and zombie:isAlive() and not RoomScan.isDetected(zombie) then
                                RoomScan.markDetected(zombie)
                                if not canSee(player, zombie) then
                                    leads = leads + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if leads > 0 then
        player:setHaloNote(Phrases.lead())
    end
end

local function onTick()
    tickCount = tickCount + 1
    if tickCount < LeadSense.SCAN_INTERVAL_TICKS then
        return
    end
    tickCount = 0
    local player = getSpecificPlayer(0)
    if not player or player:isDead() then
        return
    end
    if not isDetective(player) then
        return
    end
    if not isSearchModeActive(player) then
        return
    end
    scan(player)
end

Events.OnTick.Add(onTick)
