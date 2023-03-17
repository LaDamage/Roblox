--[ Services ]--
local services = setmetatable({}, { __index = function(self, key) return game:GetService(key) end })
local client = services.Players.LocalPlayer

local request = request or http_request
if type(syn) == 'table' and type(syn.request) == 'function' then
	request = syn.request
end

local beginTick = tick()

--[ Function Managers ]--
local shorten = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaDamage/Roblox/main/number-library.lua"))()

--[ Data Libraries ]--
getgenv().Version = 1
getgenv().StatData = {}

task.spawn(function()
    while true do
        StatData["start_rebirths"] = client.leaderstats.Rebirths.Value

        task.wait(60)

        StatData["end_rebirths"] = client.leaderstats.Rebirths.Value
                    
        StatData["diff_rebirths"] = tonumber(StatData["end_rebirths"]) - StatData["start_rebirths"]
    end
end)

task.spawn(function()
    while task.wait(PostDelay * 60)
        local TrackData = {
            ["embeds"] = {{
                ["title"] = "Rebirth Tracker",
                ["color"] = 0x00ff36,
                ["fields"] = {{
                    ["name"] = "🔢 Current Rebirths Amount",
                    ["value"] = shorten.Abbreviate(client.leaderstats.Rebirths.Value),
                    ["inline"] = false
                },
                {
                    ["name"] = "⌛ Rebirths Pet Minute",
                    ["value"] = shorten.Abbreviate(StatData["diff_rebirths"]),
                    ["inline"] = false
                },
                {
                    ["name"] = "⌛ Rebirths Pet Hour",
                    ["value"] = shorten.Abbreviate(StatData["diff_rebirths"] * 60),
                    ["inline"] = false
                },
                {
                    ["name"] = "⌛ Rebirths Pet Day",
                    ["value"] = shorten.Abbreviate(StatData["diff_rebirths"] * 1440),
                    ["inline"] = false
                }
                },
                ["timestamp"] = DateTime.now():ToIsoDate()
            }}
        }

        request({Url= TrackHook, Body = game:GetService("HttpService"):JSONEncode(TrackData), Method = "POST", Headers = {["content-type"] = "application/json"}})
    end
end)

warn("[!] Free Hatchers Rebirth Tracker Loaded!")
warn("[!] Script took", tonumber(string.format("%." .. (0) .. "f", (tick() - beginTick)*10^3)), "ms to load.\n")
warn("[?] Script Version: v".. Version)
warn("[?] Provided & Made by: CollateralDamage\n")
print("__________________________________________________________")
