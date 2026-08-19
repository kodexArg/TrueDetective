require "TrueDetective/investigate_lines"

TrueDetective_InvestigateLeads = TrueDetective_InvestigateLeads or {}

local RADIUS = 30

local function marked(zombie)
    return zombie:getModData().tdLead == true
end

local function mark(zombie)
    zombie:getModData().tdLead = true
end

local function nearest_partner(ox, oy, oz, exclude)
    local cell = getCell()
    if not cell then
        return nil
    end
    local best, best_d2 = nil, nil
    for x = math.floor(ox) - RADIUS, math.floor(ox) + RADIUS do
        for y = math.floor(oy) - RADIUS, math.floor(oy) + RADIUS do
            local d2 = (x - ox) * (x - ox) + (y - oy) * (y - oy)
            if d2 <= RADIUS * RADIUS then
                local square = cell:getGridSquare(x, y, oz)
                local moving = square and square:getMovingObjects()
                if moving then
                    for i = 0, moving:size() - 1 do
                        local obj = moving:get(i)
                        if instanceof(obj, "IsoZombie") and obj:isAlive()
                            and obj ~= exclude and not marked(obj) then
                            if not best_d2 or d2 < best_d2 then
                                best, best_d2 = obj, d2
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

function TrueDetective_InvestigateLeads.is_unalerted(zombie, player)
    if not zombie or not zombie:isAlive() then
        return false
    end
    if not zombie.getTarget then
        return true
    end
    local target = zombie:getTarget()
    return target == nil or target ~= player
end

function TrueDetective_InvestigateLeads.lead_from_subject(player, subject, is_corpse)
    local square = subject:getSquare() or subject.getCurrentSquare and subject:getCurrentSquare()
    local sx = square and square:getX() or subject:getX()
    local sy = square and square:getY() or subject:getY()
    local sz = square and square:getZ() or subject:getZ()
    local exclude = subject
    if is_corpse or (subject.isAlive and not subject:isAlive()) then
        exclude = nil
    end
    if subject == player then
        exclude = nil
    end
    local partner = nearest_partner(sx, sy, sz, exclude)
    if not partner then
        return TrueDetective_InvestigateLines.alone_line()
    end
    mark(partner)
    if is_corpse then
        return TrueDetective_InvestigateLines.corpse_line(player, partner)
    end
    return TrueDetective_InvestigateLines.partner_line(player, partner)
end

function TrueDetective_InvestigateLeads.lead_from_walk(player)
    local square = player:getSquare() or player:getCurrentSquare()
    if not square then
        return nil
    end
    local partner = nearest_partner(square:getX(), square:getY(), square:getZ(), nil)
    if not partner then
        return nil
    end
    mark(partner)
    return TrueDetective_InvestigateLines.walk_line(player, partner)
end
