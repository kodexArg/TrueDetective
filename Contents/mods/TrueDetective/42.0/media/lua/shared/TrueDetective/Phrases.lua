local Phrases = {}

Phrases.DANGER_POOL = {
    "UI_td_danger_1",
    "UI_td_danger_2",
    "UI_td_danger_3",
    "UI_td_danger_4",
    "UI_td_danger_5",
    "UI_td_danger_6",
    "UI_td_danger_7",
    "UI_td_danger_8",
    "UI_td_danger_9",
}

function Phrases.danger()
    return getText(Phrases.DANGER_POOL[ZombRand(#Phrases.DANGER_POOL) + 1])
end

return Phrases
