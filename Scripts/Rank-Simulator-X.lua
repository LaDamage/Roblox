for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do v:Disable() end

local Atlas = loadstring(game:HttpGet("https://raw.githubusercontent.com/VisualRoblox/Roblox/main/UI-Libraries/Visual%20UI%20Library/Source.lua"))()
local Window = Atlas:CreateWindow("Atlas", "Rank Simulator X", "Project Atlas", "rbxassetid://10618928818", true, "VisualUIConfigs", "Default")

local Credentials = {"Scripting: CollateralDamage#2848"}

local Libraries = {
    Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaDamage/Roblox/main/number-library.lua"))()
}

local Tabs = {
    Automation = Window:CreateTab("Automation", true, "rbxassetid://3926305904", Vector2.new(524, 44), Vector2.new(36, 36)),
    Settings = Window:CreateTab("Settings", false, "rbxassetid://3926305904", Vector2.new(524, 44), Vector2.new(36, 36))
}

local FarmingSection = Tabs.Automation:CreateSection("💰 Farming Section")
local AutoStars = FarmingSection:CreateToggle("Auto Collect Stars", false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    getgenv().AutoStars = bool

    local players = game:GetService("Players")
    local lp = players.LocalPlayer
    local rootpart = lp.Character.HumanoidRootPart

    function nearest()
        local Closest
        local Distance = math.huge
        local shit = game:GetService("Workspace").SpawnZones[lp.World.Value]:GetChildren()
        for i = 1, #shit do 
            local v = shit[i]
            if v.MainPart.Transparency == 0 then
                local newDistance = game.Players.LocalPlayer:DistanceFromCharacter(v.MainPart.Position)
                if newDistance < Distance then
                    Closest = v
                    Distance = newDistance
                end
            end
        end
        return Closest
    end

    while AutoStars and task.wait() do
        local thing = nearest()
        if thing then
            rootpart.CFrame = thing.MainPart.CFrame
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
    end
end)

local AutoRankUp = FarmingSection:CreateToggle("Auto Rank Up", false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    getgenv().AutoRankUp = bool

    while AutoRankUp and task.wait(1) do
        local players =game:GetService("Players")
        local lp = players.LocalPlayer

        local rem = game:GetService("ReplicatedStorage").Remotes

        if lp.PlayerGui["Rank Simulator X"].HUD.Left.RankDisplay.Percent.Text == "100%" then
            local rank = lp.Data.Rank
            rem.BuyRank:FireServer(rank.Value + 1)
        end
    end
end)

local Settings = Tabs.Settings:CreateSection("User Interface")
local DestroyButton = Settings:CreateButton("Destroy UI", function()
    Atlas:DestroyUI()
end)
local ToggleKeybind = Settings:CreateKeybind("Toggle UI", "RightControl", function()
    Atlas:ToggleUI()
end)

local Credits = Tabs.Settings:CreateSection("Credits")
for _, v in pairs(Credentials) do
    Credits:CreateLabel(v)
end
