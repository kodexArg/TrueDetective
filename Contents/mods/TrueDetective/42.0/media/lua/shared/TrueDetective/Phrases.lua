-- True Detective — phrase pools from Translate tables
-- Loads UI_phrase_* and UI_zombie_alert_* via getTextOrNull (same pattern as original).

local phrases = {
    searching = {},
    zombieAlert = {},
    initialized = false,
}

local function initializeSearchingPhrases()
    phrases.searching = {}
    local i = 1
    while true do
        local textKey = "UI_phrase_" .. i
        local phrase = getTextOrNull(textKey)
        if not phrase then
            break
        end
        table.insert(phrases.searching, phrase)
        i = i + 1
    end
end

local function initializeZombieAlertPhrases()
    phrases.zombieAlert = {}
    local j = 1
    while true do
        local textKey = "UI_zombie_alert_" .. j
        local phrase = getTextOrNull(textKey)
        if not phrase then
            break
        end
        table.insert(phrases.zombieAlert, phrase)
        j = j + 1
    end
end

local function ensureInitialized()
    if phrases.initialized and #phrases.searching > 0 and #phrases.zombieAlert > 0 then
        return
    end
    initializeSearchingPhrases()
    initializeZombieAlertPhrases()
    phrases.initialized = true
end

local function detectiveIsSearchingPhrase()
    ensureInitialized()
    local n = #phrases.searching
    if n < 1 then
        return getText("UI_phrase_1") or "Search time."
    end
    local randomIndex = ZombRand(n) + 1
    return phrases.searching[randomIndex]
end

local function detectiveZombieAlertPhrase()
    ensureInitialized()
    local n = #phrases.zombieAlert
    if n < 1 then
        return getText("UI_zombie_alert_1") or "Danger nearby."
    end
    local randomIndex = ZombRand(n) + 1
    return phrases.zombieAlert[randomIndex]
end

-- Re-init after translations are ready
Events.OnGameStart.Add(function()
    phrases.initialized = false
    ensureInitialized()
end)

return {
    searching = detectiveIsSearchingPhrase,
    zombieAlert = detectiveZombieAlertPhrase,
    ensureInitialized = ensureInitialized,
}
