TrueDetective_Chances = TrueDetective_Chances or {}

TrueDetective_Chances.investigate = 100

TrueDetective_Chances.walk = {
    search = 4,
    sneak = 1,
    walk = 1,
    cooldown_ms = 90000,
}

function TrueDetective_Chances.exists(chance)
    return type(chance) == "number" and chance > 0
end

function TrueDetective_Chances.passed(chance)
    if not TrueDetective_Chances.exists(chance) then
        return false
    end
    if chance >= 100 then
        return true
    end
    return ZombRand(100) < chance
end

function TrueDetective_Chances.walk_for_stance(stance)
    local walk = TrueDetective_Chances.walk
    if not walk then
        return 0
    end
    return walk[stance] or walk.walk or 0
end
