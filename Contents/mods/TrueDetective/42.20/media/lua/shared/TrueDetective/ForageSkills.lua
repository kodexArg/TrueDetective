-- True Detective — occupation forage specialisation (B42)
-- Forage def.name MUST equal CharacterProfession:getName().
-- Registry: truedetective:truedetective → getName() = "truedetective"

require "Foraging/forageSystem"

local function occupationName()
    if TrueDetective and TrueDetective.ProfessionType and TrueDetective.ProfessionType.getName then
        return TrueDetective.ProfessionType:getName()
    end
    return "truedetective"
end

local function addTrueDetectiveForageSkills()
    if not forageSystem or not forageSystem.addSkillDef then
        return
    end

    local def = {
        name = occupationName(),
        type = "occupation",
        visionBonus = 2.2,
        weatherEffect = 33,
        darknessEffect = 33,
        specialisations = {
            ["Animals"] = 10,
            ["Insects"] = 5,
            ["Medical"] = 10,
            ["Ammunition"] = 50,
            ["JunkWeapons"] = 15,
            ["MedicinalPlants"] = 5,
            ["ForestRarities"] = 10,
            ["Trash"] = 20,
            ["Junk"] = 20,
            ["WildPlants"] = 5,
        },
    }

    forageSystem.addSkillDef(def, true)
end

Events.OnGameBoot.Add(addTrueDetectiveForageSkills)
