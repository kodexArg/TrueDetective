local RoomScan = {}

RoomScan.MAX_ROOM_SQUARES = 50

function RoomScan.farSquare(element, playerSquare)
    local square = element:getSquare()
    local opposite = element:getOppositeSquare()
    if not square then
        return opposite
    end
    if not opposite then
        return square
    end
    if not playerSquare then
        return opposite
    end
    if playerSquare == square then
        return opposite
    end
    if playerSquare == opposite then
        return square
    end
    local dx1 = square:getX() - playerSquare:getX()
    local dy1 = square:getY() - playerSquare:getY()
    local dx2 = opposite:getX() - playerSquare:getX()
    local dy2 = opposite:getY() - playerSquare:getY()
    if dx1 * dx1 + dy1 * dy1 >= dx2 * dx2 + dy2 * dy2 then
        return square
    end
    return opposite
end

function RoomScan.hasLiveZombie(square)
    if not square then
        return false
    end
    local room = square:getRoom()
    if not room then
        return false
    end
    local squares = room:getSquares()
    if not squares or squares:size() > RoomScan.MAX_ROOM_SQUARES then
        return false
    end
    for i = 0, squares:size() - 1 do
        local tile = squares:get(i)
        if tile then
            local moving = tile:getMovingObjects()
            if moving then
                for j = 0, moving:size() - 1 do
                    local obj = moving:get(j)
                    if instanceof(obj, "IsoZombie") and obj:isAlive() then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function RoomScan.isDetected(zombie)
    return zombie:getModData().tdLead == true
end

function RoomScan.markDetected(zombie)
    zombie:getModData().tdLead = true
end

function RoomScan.undetectedZombies(square)
    local found = {}
    if not square then
        return found
    end
    local room = square:getRoom()
    if not room then
        return found
    end
    local squares = room:getSquares()
    if not squares or squares:size() > RoomScan.MAX_ROOM_SQUARES then
        return found
    end
    for i = 0, squares:size() - 1 do
        local tile = squares:get(i)
        if tile then
            local moving = tile:getMovingObjects()
            if moving then
                for j = 0, moving:size() - 1 do
                    local obj = moving:get(j)
                    if instanceof(obj, "IsoZombie") and obj:isAlive() and not RoomScan.isDetected(obj) then
                        table.insert(found, obj)
                    end
                end
            end
        end
    end
    return found
end

return RoomScan
