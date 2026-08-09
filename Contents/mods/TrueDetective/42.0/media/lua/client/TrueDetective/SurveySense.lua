require "TrueDetective/survey_sense_action"

TrueDetective_SurveySense = TrueDetective_SurveySense or {}

local RADIUS = 30
local MAX_ZOMBIES = 5
local GROUP_MIN = 3
local AIM_RANGE = 40

local was_aiming = false
local busy = false
local whisper_queue = {}

function TrueDetective_SurveySense.set_busy(value)
    busy = value and true or false
end

function TrueDetective_SurveySense.has_magnifier(player)
    local primary = player:getPrimaryHandItem()
    if primary and primary:getType() == "MagnifyingGlass" then
        return true
    end
    local secondary = player:getSecondaryHandItem()
    if secondary and secondary:getType() == "MagnifyingGlass" then
        return true
    end
    return false
end

local function is_detective(player)
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

local function residential_from_square(square)
    if not square then
        return nil
    end
    local building = square:getBuilding()
    if not building then
        local room = square:getRoom()
        if room then
            building = room:getBuilding()
        end
    end
    if building and building:isResidential() then
        return building
    end
    return nil
end

function TrueDetective_SurveySense.aim_residential(player)
    local cell = getCell()
    if not cell then
        return nil, nil
    end
    local z = player:getZ()
    local px = player:getX()
    local py = player:getY()
    local aim = player:getAimVector(Vector2.new())
    local ax = aim:getX()
    local ay = aim:getY()
    local len2 = ax * ax + ay * ay
    if len2 < 0.0001 then
        local fwd = player:getForwardDirection()
        ax = fwd:getX()
        ay = fwd:getY()
        len2 = ax * ax + ay * ay
    end
    if len2 < 0.0001 then
        return nil, nil
    end
    local inv = 1 / math.sqrt(len2)
    ax = ax * inv
    ay = ay * inv
    for step = 1, AIM_RANGE do
        local x = math.floor(px + ax * step)
        local y = math.floor(py + ay * step)
        local square = cell:getGridSquare(x, y, z)
        local building = residential_from_square(square)
        if building then
            return building, square
        end
    end
    return nil, nil
end

local function is_marked(zombie)
    return zombie:getModData().tdSurvey == true
end

local function mark(zombie)
    zombie:getModData().tdSurvey = true
end

local function direction_key(dx, dy)
    if dx == 0 and dy == 0 then
        return "here"
    end
    local ns, ew = "", ""
    if dy * dy > 4 * dx * dx then
        ns = dy < 0 and "n" or "s"
    elseif dx * dx > 4 * dy * dy then
        ew = dx < 0 and "w" or "e"
    else
        ns = dy < 0 and "n" or (dy > 0 and "s" or "")
        ew = dx < 0 and "w" or (dx > 0 and "e" or "")
    end
    return ns .. ew
end

local function place_of(zombie, player)
    local square = zombie:getSquare()
    local room = square and square:getRoom()
    if room then
        local name = getTextOrNull("UI_td_room_" .. room:getName())
        if name then
            return name, true
        end
        return getText("UI_td_room_building"), true
    end
    local dx = zombie:getX() - player:getX()
    local dy = zombie:getY() - player:getY()
    return getText("UI_td_dir_" .. direction_key(dx, dy)), false
end

local function find_zombies(player)
    local origin = player:getSquare()
    if not origin then
        return {}
    end
    local px, py, pz = origin:getX(), origin:getY(), origin:getZ()
    local cell = getCell()
    local found = {}
    for x = px - RADIUS, px + RADIUS do
        for y = py - RADIUS, py + RADIUS do
            local dx, dy = x - px, y - py
            if dx * dx + dy * dy <= RADIUS * RADIUS then
                local square = cell:getGridSquare(x, y, pz)
                if square then
                    local moving = square:getMovingObjects()
                    if moving then
                        for i = 0, moving:size() - 1 do
                            local zombie = moving:get(i)
                            if instanceof(zombie, "IsoZombie") and zombie:isAlive() and not is_marked(zombie) then
                                table.insert(found, { zombie = zombie, dist2 = dx * dx + dy * dy })
                            end
                        end
                    end
                end
            end
        end
    end
    table.sort(found, function(a, b)
        return a.dist2 < b.dist2
    end)
    return found
end

local function enqueue_whisper(player, text)
    table.insert(whisper_queue, text)
end

function TrueDetective_SurveySense.report(player)
    local found = find_zombies(player)
    if #found == 0 then
        print("[TrueDetective] SurveySense report, zombies: 0")
        return
    end
    local groups = {}
    local order = {}
    local taken = math.min(#found, MAX_ZOMBIES)
    for i = 1, taken do
        local zombie = found[i].zombie
        mark(zombie)
        local place, is_room = place_of(zombie, player)
        local key = (is_room and "room:" or "dir:") .. place
        if not groups[key] then
            groups[key] = { place = place, is_room = is_room, count = 0 }
            table.insert(order, key)
        end
        groups[key].count = groups[key].count + 1
    end
    print("[TrueDetective] SurveySense report, zombies: " .. tostring(taken))
    for _, key in ipairs(order) do
        local group = groups[key]
        if group.count >= GROUP_MIN then
            local phrase = group.is_room and "UI_td_survey_group_room" or "UI_td_survey_group_dir"
            enqueue_whisper(player, getText(phrase, group.count, group.place))
        else
            for _ = 1, group.count do
                local phrase = group.is_room and "UI_td_survey_one_room" or "UI_td_survey_one_dir"
                enqueue_whisper(player, getText(phrase, group.place))
            end
        end
    end
end

local function drain_whispers()
    if #whisper_queue == 0 then
        return
    end
    local player = getSpecificPlayer(0)
    if not player or player:isDead() then
        whisper_queue = {}
        return
    end
    if player:getHaloTimerCount() <= 0 then
        player:setHaloNote(table.remove(whisper_queue, 1))
    end
end

local function try_start_survey(player)
    if busy then
        return
    end
    if not is_detective(player) then
        return
    end
    if not TrueDetective_SurveySense.has_magnifier(player) then
        return
    end
    local building, square = TrueDetective_SurveySense.aim_residential(player)
    if not building or not square then
        return
    end
    local action = survey_sense_action:new(player, square:getX(), square:getY())
    ISTimedActionQueue.add(action)
end

local function on_player_update(player)
    if not player or player:isDead() then
        was_aiming = false
        return
    end
    if player ~= getSpecificPlayer(0) then
        return
    end
    local aiming = player:isAiming()
    if aiming and not was_aiming then
        try_start_survey(player)
    end
    was_aiming = aiming
    drain_whispers()
end

Events.OnPlayerUpdate.Add(on_player_update)
