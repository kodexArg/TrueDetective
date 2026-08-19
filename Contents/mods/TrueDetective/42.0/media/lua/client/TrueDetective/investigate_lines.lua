TrueDetective_InvestigateLines = TrueDetective_InvestigateLines or {}

local function pick(keys, arg1)
    local key = keys[ZombRand(#keys) + 1]
    if arg1 then
        return getText(key, arg1)
    end
    return getText(key)
end

local MATE_DIR = {
    "UI_td_lead_mate_dir_1", "UI_td_lead_mate_dir_2", "UI_td_lead_mate_dir_3",
    "UI_td_lead_mate_dir_4", "UI_td_lead_mate_dir_5", "UI_td_lead_mate_dir_6",
}
local MATE_ROOM = {
    "UI_td_lead_mate_room_1", "UI_td_lead_mate_room_2", "UI_td_lead_mate_room_3",
    "UI_td_lead_mate_room_4", "UI_td_lead_mate_room_5", "UI_td_lead_mate_room_6",
}
local MATE_BUILDING = {
    "UI_td_lead_mate_building_1", "UI_td_lead_mate_building_2", "UI_td_lead_mate_building_3",
    "UI_td_lead_mate_building_4", "UI_td_lead_mate_building_5", "UI_td_lead_mate_building_6",
}
local PACK_DIR = {
    "UI_td_lead_pack_dir_1", "UI_td_lead_pack_dir_2", "UI_td_lead_pack_dir_3",
    "UI_td_lead_pack_dir_4", "UI_td_lead_pack_dir_5", "UI_td_lead_pack_dir_6",
}
local PACK_ROOM = {
    "UI_td_lead_pack_room_1", "UI_td_lead_pack_room_2", "UI_td_lead_pack_room_3",
    "UI_td_lead_pack_room_4", "UI_td_lead_pack_room_5", "UI_td_lead_pack_room_6",
}
local PACK_BUILDING = {
    "UI_td_lead_pack_building_1", "UI_td_lead_pack_building_2", "UI_td_lead_pack_building_3",
    "UI_td_lead_pack_building_4", "UI_td_lead_pack_building_5", "UI_td_lead_pack_building_6",
}
local ALONE = {
    "UI_td_lead_alone_1", "UI_td_lead_alone_2", "UI_td_lead_alone_3",
    "UI_td_lead_alone_4", "UI_td_lead_alone_5", "UI_td_lead_alone_6",
}
local CORPSE_MATE_DIR = {
    "UI_td_lead_corpse_mate_dir_1", "UI_td_lead_corpse_mate_dir_2", "UI_td_lead_corpse_mate_dir_3",
    "UI_td_lead_corpse_mate_dir_4", "UI_td_lead_corpse_mate_dir_5", "UI_td_lead_corpse_mate_dir_6",
}
local CORPSE_MATE_ROOM = {
    "UI_td_lead_corpse_mate_room_1", "UI_td_lead_corpse_mate_room_2", "UI_td_lead_corpse_mate_room_3",
    "UI_td_lead_corpse_mate_room_4", "UI_td_lead_corpse_mate_room_5", "UI_td_lead_corpse_mate_room_6",
}
local CORPSE_MATE_BUILDING = {
    "UI_td_lead_corpse_mate_building_1", "UI_td_lead_corpse_mate_building_2", "UI_td_lead_corpse_mate_building_3",
    "UI_td_lead_corpse_mate_building_4", "UI_td_lead_corpse_mate_building_5", "UI_td_lead_corpse_mate_building_6",
}
local CORPSE_PACK_DIR = {
    "UI_td_lead_corpse_pack_dir_1", "UI_td_lead_corpse_pack_dir_2", "UI_td_lead_corpse_pack_dir_3",
    "UI_td_lead_corpse_pack_dir_4", "UI_td_lead_corpse_pack_dir_5", "UI_td_lead_corpse_pack_dir_6",
}
local CORPSE_PACK_ROOM = {
    "UI_td_lead_corpse_pack_room_1", "UI_td_lead_corpse_pack_room_2", "UI_td_lead_corpse_pack_room_3",
    "UI_td_lead_corpse_pack_room_4", "UI_td_lead_corpse_pack_room_5", "UI_td_lead_corpse_pack_room_6",
}
local CORPSE_PACK_BUILDING = {
    "UI_td_lead_corpse_pack_building_1", "UI_td_lead_corpse_pack_building_2", "UI_td_lead_corpse_pack_building_3",
    "UI_td_lead_corpse_pack_building_4", "UI_td_lead_corpse_pack_building_5", "UI_td_lead_corpse_pack_building_6",
}
local WALK_DIR = {
    "UI_td_lead_walk_dir_1", "UI_td_lead_walk_dir_2", "UI_td_lead_walk_dir_3",
    "UI_td_lead_walk_dir_4", "UI_td_lead_walk_dir_5", "UI_td_lead_walk_dir_6",
    "UI_td_lead_walk_dir_7", "UI_td_lead_walk_dir_8",
}
local WALK_ROOM = {
    "UI_td_lead_walk_room_1", "UI_td_lead_walk_room_2", "UI_td_lead_walk_room_3",
    "UI_td_lead_walk_room_4", "UI_td_lead_walk_room_5", "UI_td_lead_walk_room_6",
}
local WALK_BUILDING = {
    "UI_td_lead_walk_building_1", "UI_td_lead_walk_building_2", "UI_td_lead_walk_building_3",
    "UI_td_lead_walk_building_4", "UI_td_lead_walk_building_5", "UI_td_lead_walk_building_6",
}
local NOTHING = {
    "UI_td_lead_nothing_1", "UI_td_lead_nothing_2", "UI_td_lead_nothing_3",
    "UI_td_lead_nothing_4", "UI_td_lead_nothing_5", "UI_td_lead_nothing_6",
}

local function dir_key(dx, dy)
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

local function place_line(player, partner, room_keys, building_keys, dir_keys, dir_prefix)
    local square = partner:getSquare()
    local room = square and square:getRoom()
    if room then
        local name = room:getName()
        local place = (name and getTextOrNull("UI_td_room_" .. name)) or getText("UI_td_room_building")
        return pick(room_keys, place)
    end
    if square and square:getBuilding() then
        return pick(building_keys)
    end
    local dx = partner:getX() - player:getX()
    local dy = partner:getY() - player:getY()
    return pick(dir_keys, getText(dir_prefix .. dir_key(dx, dy)))
end

local function mate_or_pack(player, partner, mate_room, mate_building, mate_dir, pack_room, pack_building, pack_dir)
    if ZombRand(2) == 0 then
        return place_line(player, partner, mate_room, mate_building, mate_dir, "UI_td_dir_")
    end
    return place_line(player, partner, pack_room, pack_building, pack_dir, "UI_td_from_")
end

function TrueDetective_InvestigateLines.partner_line(player, partner)
    return mate_or_pack(
        player, partner,
        MATE_ROOM, MATE_BUILDING, MATE_DIR,
        PACK_ROOM, PACK_BUILDING, PACK_DIR
    )
end

function TrueDetective_InvestigateLines.corpse_line(player, partner)
    return mate_or_pack(
        player, partner,
        CORPSE_MATE_ROOM, CORPSE_MATE_BUILDING, CORPSE_MATE_DIR,
        CORPSE_PACK_ROOM, CORPSE_PACK_BUILDING, CORPSE_PACK_DIR
    )
end

function TrueDetective_InvestigateLines.walk_line(player, partner)
    return place_line(player, partner, WALK_ROOM, WALK_BUILDING, WALK_DIR, "UI_td_dir_")
end

function TrueDetective_InvestigateLines.alone_line()
    return pick(ALONE)
end

function TrueDetective_InvestigateLines.nothing_line()
    return pick(NOTHING)
end
