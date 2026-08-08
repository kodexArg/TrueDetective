require "Foraging/forageSystem"

local function addTrueDetectiveForageSkills()
    if not forageSystem or not forageSystem.addSkillDef then
        return
    end

    forageSystem.addSkillDef({
        name = "truedetective",
        type = "occupation",
        visionBonus = 1.75,
        weatherEffect = 0,
        darknessEffect = 15,
        specialisations = {
            ["Trash"] = 10,
            ["Junk"] = 10,
            ["JunkWeapons"] = 10,
            ["Ammunition"] = 10,
            ["Medical"] = 10,
        },
    }, true)
end

Events.OnGameBoot.Add(addTrueDetectiveForageSkills)
