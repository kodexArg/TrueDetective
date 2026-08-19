require "TrueDetective/Chances"
require "TrueDetective/investigate_leads"
require "TrueDetective/investigate_lines"
require "TrueDetective/SearchBoost"

local function is_detective(player)
    local d = player and player:getDescriptor()
    local p = d and d:getCharacterProfession()
    return p and p:getName() == "truedetective"
end

local function walk_objects(worldobjects, fn)
    if not worldobjects then
        return
    end
    for i = 1, #worldobjects do
        fn(worldobjects[i])
    end
end

local function is_door_or_window(obj)
    if not obj then
        return false
    end
    if instanceof(obj, "IsoDoor") or instanceof(obj, "IsoWindow") then
        return true
    end
    if obj.isDoor and obj:isDoor() then
        return true
    end
    if obj.isWindow and obj:isWindow() then
        return true
    end
    return false
end

local function has_door_or_window(worldobjects)
    local hit = false
    walk_objects(worldobjects, function(obj)
        if is_door_or_window(obj) then
            hit = true
        end
    end)
    return hit
end

local function find_zombie(worldobjects)
    local found
    walk_objects(worldobjects, function(obj)
        if not found and instanceof(obj, "IsoZombie") and obj:isAlive() then
            found = obj
        end
    end)
    return found
end

local function find_corpse(worldobjects)
    local found
    walk_objects(worldobjects, function(obj)
        if found or not obj then
            return
        end
        if instanceof(obj, "IsoDeadBody") then
            found = obj
        elseif instanceof(obj, "IsoZombie") and not obj:isAlive() then
            found = obj
        end
    end)
    return found
end

local function find_self(player, worldobjects)
    local psq = player:getSquare() or player:getCurrentSquare()
    if not psq then
        return false
    end
    local hit = false
    walk_objects(worldobjects, function(obj)
        if hit or not obj then
            return
        end
        if obj == player then
            hit = true
            return
        end
        if is_door_or_window(obj) then
            return
        end
        local osq = obj.getSquare and obj:getSquare()
        if osq and osq:getX() == psq:getX() and osq:getY() == psq:getY() and osq:getZ() == psq:getZ() then
            hit = true
        end
    end)
    return hit
end

local function action_possible(player)
    return is_detective(player) and TrueDetective_SearchBoost.has_magnifier(player)
end

local function run_investigate(player, subject, is_corpse)
    if not TrueDetective_Chances.passed(TrueDetective_Chances.investigate) then
        player:Say(TrueDetective_InvestigateLines.nothing_line())
        return
    end
    local text = TrueDetective_InvestigateLeads.lead_from_subject(player, subject, is_corpse)
    if text then
        player:Say(text)
    end
end

local function add_option(context, worldobjects, player, subject, is_corpse)
    context:addOption(getText("UI_td_investigate"), worldobjects, function()
        if not action_possible(player) then
            return
        end
        run_investigate(player, subject, is_corpse)
    end)
end

local function on_fill(playerNum, context, worldobjects, test)
    if test then
        return
    end
    local player = getSpecificPlayer(playerNum)
    if not action_possible(player) then
        return
    end
    if not TrueDetective_Chances.exists(TrueDetective_Chances.investigate) then
        return
    end

    local zombie = find_zombie(worldobjects)
    if zombie and TrueDetective_InvestigateLeads.is_unalerted(zombie, player) then
        add_option(context, worldobjects, player, zombie, false)
        return
    end

    local corpse = find_corpse(worldobjects)
    if corpse then
        add_option(context, worldobjects, player, corpse, true)
        return
    end

    if has_door_or_window(worldobjects) then
        return
    end

    if find_self(player, worldobjects) then
        add_option(context, worldobjects, player, player, false)
    end
end

Events.OnFillWorldObjectContextMenu.Add(on_fill)
