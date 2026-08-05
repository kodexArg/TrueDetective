-- True Detective — profession identity helpers (shared)
-- B42 getName() for registry truedetective:truedetective → "truedetective"
-- Do NOT alias bare "detective" (collides with SOTO soto:detective).

TrueDetective = TrueDetective or {}

TrueDetective.PROFESSION_ID = TrueDetective.PROFESSION_ID or "truedetective"

-- Accept own id + original B41 id for save migration only
TrueDetective.PROFESSION_ALIASES = {
    truedetective = true,
    prof_detective = true, -- original B41 Detective Profession id
}

--- Return true if the player is the True Detective profession.
--- Prefers B42 getCharacterProfession():getName(); falls back to B41 getProfession().
---@param player IsoGameCharacter|IsoPlayer|nil
---@return boolean
function TrueDetective.isProfession(player)
    if not player then
        return false
    end

    local desc = player:getDescriptor and player:getDescriptor() or nil
    if not desc then
        return false
    end

    -- B42: CharacterProfession object
    if desc.getCharacterProfession then
        local ok, prof = pcall(function()
            return desc:getCharacterProfession()
        end)
        if ok and prof then
            if TrueDetective.ProfessionType and prof == TrueDetective.ProfessionType then
                return true
            end
            if prof.getName then
                local name = prof:getName()
                if name and TrueDetective.PROFESSION_ALIASES[name] then
                    return true
                end
            end
            -- full resource id comparison via toString (namespace:path)
            if prof.toString then
                local full = prof:toString()
                if full and (full == "truedetective:truedetective" or full:find("truedetective", 1, true)) then
                    return true
                end
            end
        end
    end

    -- B41 / fallback string profession
    if desc.getProfession then
        local ok, p = pcall(function()
            return desc:getProfession()
        end)
        if ok and p and TrueDetective.PROFESSION_ALIASES[p] then
            return true
        end
    end

    return false
end

return TrueDetective
