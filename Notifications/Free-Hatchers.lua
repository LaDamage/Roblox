--[ Debugging ]--
repeat wait() until game:IsLoaded()

if notifications_loaded then warn("[!] Free Hatchers Hatch Notifications Already Loaded!") return end
pcall(function() getgenv().notifications_loaded = true end)

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
getgenv().ScriptData = {
    Version = "1.0.0"
}

--[ Webhook Data Collecter & Sender ]--
client.Pets.ChildAdded:Connect(function(pet)
    task.wait(2)
    
    local WebhookData = {
        ["embeds"] = {{
            ["title"] = client.Name .." hatched a ".. pet._Name.Value,
            ["color"] = 0x00ff36,
            ["footer"] = {
                ["text"] = '🥚 '.. shorten.Comma(client.leaderstats.Eggs.Value)
            },
                
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }

    request({Url= getgenv().Webhook, Body = game:GetService("HttpService"):JSONEncode(WebhookData), Method = "POST", Headers = {["content-type"] = "application/json"}})
end)

warn("[!] Free Hatchers Hatch Notifications Loaded!")
warn("[!] Script took", tonumber(string.format("%." .. (0) .. "f", (tick() - beginTick)*10^3)), "ms to load.\n")
warn("[?] Script Version: v".. ScriptData.Version)
warn("[?] Provided & Made by: CollateralDamage\n")
print("[*] Anti AFK is Enabled\n__________________________________________________________")

for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do v:Disable() end
