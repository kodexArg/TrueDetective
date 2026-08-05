-- True Detective — B42 CharacterProfession registry
-- Loaded early by the engine (media/registries.lua) before scripts/lua.
-- getName() returns the path component: "truedetective"

TrueDetective = TrueDetective or {}

TrueDetective.PROFESSION_ID = "truedetective"
TrueDetective.PROFESSION_RESOURCE = "truedetective:truedetective"

-- Register custom occupation type (namespace:path). Path becomes getName().
TrueDetective.ProfessionType = CharacterProfession.register(TrueDetective.PROFESSION_RESOURCE)
