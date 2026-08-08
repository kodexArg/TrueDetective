--[[
  True Detective — B42.20 hello-world mock

  Greenfield scaffold. No profession, forage, or detection yet.
  Success signal: console lines starting with [TrueDetective] Hello World.
]]

local TAG = "[TrueDetective]"

local function hello(where)
    print(TAG .. " Hello World (B42.20 mock) — " .. tostring(where))
end

Events.OnGameBoot.Add(function()
    hello("OnGameBoot")
end)

Events.OnMainMenuEnter.Add(function()
    hello("OnMainMenuEnter")
end)

Events.OnGameStart.Add(function()
    hello("OnGameStart")
end)
