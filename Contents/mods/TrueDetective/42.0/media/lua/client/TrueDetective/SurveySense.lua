local SurveySense = {}

SurveySense.STILL_TICKS = 300
SurveySense.CHECK_INTERVAL_TICKS = 10
SurveySense.RADIUS = 15
SurveySense.MAX_ZOMBIES = 5
SurveySense.GROUP_MIN = 3

local tickCount = 0
local stillTicks = 0
local lastSquare = nil

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

local function hasMagnifier(player)
    local item = player:getPrimaryHandItem()
    return item ~= nil and item:getType() == "MagnifyingGlass"
end

local function isMarked(zombie)
    return zombie:getModData().tdSurvey == true
end

local function mark(zombie)
    zombie:getModData().tdSurvey = true
end

local function directionKey(dx, dy)
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

local function placeOf(zombie, player)
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
    return getText("UI_td_dir_" .. directionKey(dx, dy)), false
end

local function findZombies(player)
    local origin = player:getSquare()
    if not origin then
        return {}
    end
    local px, py, pz = origin:getX(), origin:getY(), origin:getZ()
    local radius = SurveySense.RADIUS
    local cell = getCell()
    local found = {}
    for x = px - radius, px + radius do
        for y = py - radius, py + radius do
            local dx, dy = x - px, y - py
            if dx * dx + dy * dy <= radius * radius then
                local square = cell:getGridSquare(x, y, pz)
                if square then
                    local moving = square:getMovingObjects()
                    if moving then
                        for i = 0, moving:size() - 1 do
                            local zombie = moving:get(i)
                            if instanceof(zombie, "IsoZombie") and zombie:isAlive() and not isMarked(zombie) then
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

local function report(player)
    local found = findZombies(player)
    if #found == 0 then
        return
    end
    local groups = {}
    local order = {}
    local taken = math.min(#found, SurveySense.MAX_ZOMBIES)
    for i = 1, taken do
        local zombie = found[i].zombie
        mark(zombie)
        local place, isRoom = placeOf(zombie, player)
        local key = (isRoom and "room:" or "dir:") .. place
        if not groups[key] then
            groups[key] = { place = place, isRoom = isRoom, count = 0 }
            table.insert(order, key)
        end
        groups[key].count = groups[key].count + 1
    end
    print("[TrueDetective] SurveySense report, zombies: " .. tostring(taken))
    for _, key in ipairs(order) do
        local group = groups[key]
        if group.count >= SurveySense.GROUP_MIN then
            local phrase = group.isRoom and "UI_td_survey_group_room" or "UI_td_survey_group_dir"
            player:setHaloNote(getText(phrase, group.count, group.place))
        else
            for _ = 1, group.count do
                local phrase = group.isRoom and "UI_td_survey_one_room" or "UI_td_survey_one_dir"
                player:setHaloNote(getText(phrase, group.place))
            end
        end
    end
end

local function onTick()
    tickCount = tickCount + 1
    if tickCount < SurveySense.CHECK_INTERVAL_TICKS then
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
    local square = player:getSquare()
    if not square or not hasMagnifier(player) then
        stillTicks = 0
        lastSquare = square
        return
    end
    if square ~= lastSquare then
        stillTicks = 0
        lastSquare = square
        return
    end
    stillTicks = stillTicks + SurveySense.CHECK_INTERVAL_TICKS
    if stillTicks < SurveySense.STILL_TICKS then
        return
    end
    stillTicks = 0
    report(player)
end

Events.OnTick.Add(onTick)
