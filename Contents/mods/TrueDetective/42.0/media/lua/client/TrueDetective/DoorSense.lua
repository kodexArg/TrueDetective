local RoomScan = require "TrueDetective/RoomScan"
local Phrases = require "TrueDetective/Phrases"

local DoorSense = {}

DoorSense.COOLDOWN_HOURS = 5 / 60
DoorSense.CHASE_RADIUS = 10
DoorSense.CHANCE_SEARCH_MODE = 100
DoorSense.CHANCE_SNEAKING = 50
DoorSense.CHANCE_CASUAL = 25

local function alertChance(player)
    local manager = ISSearchManager and ISSearchManager.players and ISSearchManager.players[player]
    if manager and manager.isSearchMode then
        return DoorSense.CHANCE_SEARCH_MODE
    end
    if player:isSneaking() then
        return DoorSense.CHANCE_SNEAKING
    end
    return DoorSense.CHANCE_CASUAL
end

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

local function isChased(player)
    local origin = player:getSquare()
    if not origin then
        return false
    end
    local radius = DoorSense.CHASE_RADIUS
    local px, py, pz = origin:getX(), origin:getY(), origin:getZ()
    local cell = getCell()
    for x = px - radius, px + radius do
        for y = py - radius, py + radius do
            local square = cell:getGridSquare(x, y, pz)
            if square then
                local moving = square:getMovingObjects()
                if moving then
                    for i = 0, moving:size() - 1 do
                        local zombie = moving:get(i)
                        if instanceof(zombie, "IsoZombie") then
                            local ok, target = pcall(function()
                                return zombie:getTarget()
                            end)
                            if ok and target == player then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

local function cooldownKey(element)
    local square = element:getSquare()
    if not square then
        return nil
    end
    return tostring(square:getX()) .. "," .. tostring(square:getY()) .. "," .. tostring(square:getZ())
end

local function isOnCooldown(player, key)
    local list = player:getModData().tdDoorSenseCooldowns
    if not list or not list[key] then
        return false
    end
    return (getGameTime():getWorldAgeHours() - list[key]) < DoorSense.COOLDOWN_HOURS
end

local function startCooldown(player, key)
    local modData = player:getModData()
    modData.tdDoorSenseCooldowns = modData.tdDoorSenseCooldowns or {}
    modData.tdDoorSenseCooldowns[key] = getGameTime():getWorldAgeHours()
end

function DoorSense.shouldInterrupt(player, element)
    local function trace(reason)
        print("[TrueDetective] DoorSense gate: " .. reason)
    end
    if not isDetective(player) then
        return false
    end
    local chance = alertChance(player)
    if ZombRand(100) >= chance then
        trace("roll failed (chance " .. tostring(chance) .. ")")
        return false
    end
    if isChased(player) then
        trace("chased")
        return false
    end
    if element:IsOpen() then
        trace("element already open")
        return false
    end
    if instanceof(element, "IsoDoor") and element:isLocked() then
        trace("locked")
        return false
    end
    local key = cooldownKey(element)
    if key and isOnCooldown(player, key) then
        trace("cooldown")
        return false
    end
    local target = RoomScan.farSquare(element, player:getSquare())
    local undetected = RoomScan.undetectedZombies(target)
    if #undetected == 0 then
        trace("no undetected zombie in room")
        return false
    end
    for _, zombie in ipairs(undetected) do
        RoomScan.markDetected(zombie)
    end
    if key then
        startCooldown(player, key)
    end
    trace("ALERT, zombies: " .. tostring(#undetected))
    player:setHaloNote(Phrases.danger())
    return true
end

local originalDoorComplete = ISOpenCloseDoor.complete
function ISOpenCloseDoor:complete()
    print("[TrueDetective] door complete hook fired")
    if DoorSense.shouldInterrupt(self.character, self.item) then
        return true
    end
    return originalDoorComplete(self)
end
print("[TrueDetective] DoorSense hooks installed")

local originalWindowPerform = ISOpenCloseWindow.perform
function ISOpenCloseWindow:perform()
    print("[TrueDetective] window perform hook fired")
    if DoorSense.shouldInterrupt(self.character, self.object) then
        ISBaseTimedAction.perform(self)
        return
    end
    return originalWindowPerform(self)
end
