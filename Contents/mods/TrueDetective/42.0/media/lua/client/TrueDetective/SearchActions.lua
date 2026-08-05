-- True Detective — client events: search-mode toggle + door-room danger intuition
-- Profession-only. Detection balance (original code, not the misleading 75% comment):
--   search mode ON  → 66% chance per tile change to inspect adjacent doors
--   search mode OFF → 10% passive chance
-- Never claims >75% detection; coded ceiling is 66% while searching.

require "TrueDetective/ProfessionHelper"
local phrases = require("TrueDetective/Phrases")
local checkRoomForZombies = require("TrueDetective/ZombieDetection")

local SEARCH_DETECT_CHANCE = 66 -- search mode; original code used 66 (comment wrongly said 75)
local PASSIVE_DETECT_CHANCE = 10 -- not searching
-- Cap documentation: never use a roll > 75. Active balance is 66 / 10.

local function onToggleSearchMode(player, isSearchMode)
    if not TrueDetective.isProfession(player) then
        return
    end

    local modData = player:getModData()
    modData.isSearchMode = isSearchMode
    if isSearchMode then
        player:Say(phrases.searching())
    end
end

local function checkSearchMode(player)
    return player:getModData().isSearchMode or false
end

local function getAdjacentSquare(square, dx, dy)
    if not square then
        return nil
    end
    local x = square:getX() + dx
    local y = square:getY() + dy
    local z = square:getZ()
    return getCell():getGridSquare(x, y, z)
end

local function checkDoors(player, currentSquare)
    if not currentSquare then
        return
    end

    local northSquare = getAdjacentSquare(currentSquare, 0, -1)
    local southSquare = getAdjacentSquare(currentSquare, 0, 1)
    local eastSquare = getAdjacentSquare(currentSquare, 1, 0)
    local westSquare = getAdjacentSquare(currentSquare, -1, 0)

    if currentSquare:hasDoorOnEdge(IsoDirections.N, true)
        or (northSquare and northSquare:hasDoorOnEdge(IsoDirections.S, true))
    then
        local message = checkRoomForZombies(northSquare)
        if message then
            player:Say(message)
        end
    end

    if currentSquare:hasDoorOnEdge(IsoDirections.S, true)
        or (southSquare and southSquare:hasDoorOnEdge(IsoDirections.N, true))
    then
        local message = checkRoomForZombies(southSquare)
        if message then
            player:Say(message)
        end
    end

    if currentSquare:hasDoorOnEdge(IsoDirections.E, true)
        or (eastSquare and eastSquare:hasDoorOnEdge(IsoDirections.W, true))
    then
        local message = checkRoomForZombies(eastSquare)
        if message then
            player:Say(message)
        end
    end

    if currentSquare:hasDoorOnEdge(IsoDirections.W, true)
        or (westSquare and westSquare:hasDoorOnEdge(IsoDirections.E, true))
    then
        local message = checkRoomForZombies(westSquare)
        if message then
            player:Say(message)
        end
    end
end

local function onPlayerMove(player)
    if not player then
        return
    end
    if not TrueDetective.isProfession(player) then
        return
    end

    local currentSquare = player:getSquare()
    if not currentSquare then
        return
    end

    local modData = player:getModData()

    -- Only on tile change
    if modData.lastSquare ~= currentSquare then
        local isSearchMode = checkSearchMode(player)
        local random = ZombRand(100)

        -- Balance: 66% search / 10% passive (NOT 75 — original comment bug)
        -- SEARCH_DETECT_CHANCE=66, PASSIVE_DETECT_CHANCE=10
        if (isSearchMode and random < 66) or (not isSearchMode and random < 10) then
            checkDoors(player, currentSquare)
        end

        modData.lastSquare = currentSquare
    end
end

local function onGameStart()
    Events.onToggleSearchMode.Add(onToggleSearchMode)
    Events.OnPlayerMove.Add(onPlayerMove)
end

Events.OnGameStart.Add(onGameStart)
