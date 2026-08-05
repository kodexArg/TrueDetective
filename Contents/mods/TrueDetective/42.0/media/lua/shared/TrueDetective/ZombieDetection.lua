-- True Detective — inspect adjacent room for live zombies (shared helper)
-- Cap: rooms larger than 50 tiles are ignored (original balance).

local phrases = require("TrueDetective/Phrases")

--- Check a square's room for live IsoZombie; return alert phrase or nil.
---@param square IsoGridSquare|nil
---@return string|nil
local function checkRoomForZombies(square)
    if not square then
        return nil
    end

    local room = square:getRoom()
    if not room then
        return nil
    end

    local squares = room:getSquares()
    if not squares or not squares.size then
        return nil
    end

    local squareSize = squares:size()
    -- Never scan rooms larger than 50 tiles (original)
    if squareSize > 50 then
        return nil
    end

    local hasZombies = false

    for i = 0, squareSize - 1 do
        local tile = squares:get(i)
        if not tile then
            return nil
        end

        local zombies = tile:getMovingObjects()
        if zombies then
            for j = 0, zombies:size() - 1 do
                local obj = zombies:get(j)
                if instanceof(obj, "IsoZombie") and obj.isAlive and obj:isAlive() then
                    hasZombies = true
                    break
                end
            end
        end

        if hasZombies then
            break
        end
    end

    if hasZombies then
        return phrases.zombieAlert()
    end

    return nil
end

return checkRoomForZombies
