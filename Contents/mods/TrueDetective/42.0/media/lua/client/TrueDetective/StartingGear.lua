local GUARANTEED_GEAR = {
    "Base.Bullets357Box",
    "Base.MagnifyingGlass",
}

local OPTIONAL_GEAR = {
    "Base.SmokingPipe_Tobacco",
    "Base.CigarettePack",
    "Base.Lighter",
    "Base.Whiskey",
}

local OPTIONAL_CHANCE = 75

local function giveLoadedRevolver(inventory)
    local revolver = inventory:AddItem("Base.Revolver")
    if instanceof(revolver, "HandWeapon") then
        revolver:setCurrentAmmoCount(revolver:getMaxAmmo())
    end
end

local function giveStartingGear(player)
    if not player then
        return
    end
    local descriptor = player:getDescriptor()
    if not descriptor then
        return
    end
    local profession = descriptor:getCharacterProfession()
    if not profession or profession:getName() ~= "truedetective" then
        return
    end
    local inventory = player:getInventory()
    giveLoadedRevolver(inventory)
    for _, itemType in ipairs(GUARANTEED_GEAR) do
        inventory:AddItem(itemType)
    end
    for _, itemType in ipairs(OPTIONAL_GEAR) do
        if ZombRand(100) < OPTIONAL_CHANCE then
            inventory:AddItem(itemType)
        end
    end
end

Events.OnNewGame.Add(giveStartingGear)
