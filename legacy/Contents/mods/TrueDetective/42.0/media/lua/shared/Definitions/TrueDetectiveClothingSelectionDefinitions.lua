-- True Detective — character-creation clothing
-- Key must match CharacterProfession:getName() = "truedetective"

ClothingSelectionDefinitions = ClothingSelectionDefinitions or {}

local outfit = {
    Female = {
        Hat = {
            chance = 75,
            items = { "Base.Hat_Fedora", "Base.Hat_Fedora_Delmonte" },
        },
        Jacket = {
            chance = 75,
            items = { "Base.JacketLong_Random" },
        },
        Pants = {
            items = { "Base.Trousers_DefaultTEXTURE_TINT", "Base.Trousers_Denim" },
        },
        Shoes = {
            items = { "Base.Shoes_Random" },
        },
    },
    Male = {
        Hat = {
            chance = 75,
            items = { "Base.Hat_Fedora", "Base.Hat_Fedora_Delmonte" },
        },
        Jacket = {
            chance = 75,
            items = { "Base.JacketLong_Random" },
        },
        Pants = {
            items = { "Base.Trousers_DefaultTEXTURE_TINT", "Base.Trousers_Denim" },
        },
        Shoes = {
            items = { "Base.Shoes_Random" },
        },
    },
}

ClothingSelectionDefinitions.truedetective = outfit
