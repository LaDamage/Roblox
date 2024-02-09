repeat task.wait() until game:IsLoaded()
print("Current Time; ".. os.date("%H:%M").."\n")

local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

local window = DrRayLibrary:Load("I <3 BOOBS", "Default")
local tab1 = DrRayLibrary.newTab("Stuff", "ImageIdHere")

tab1.newToggle("Auto Exchange", "Exchanges all gems to tokens.", false, function(bool)
    _G.Exhange = bool
    
    while _G.Exhange and task.wait() do
        game:GetService("ReplicatedStorage").Remotes.Exchange:FireServer("ALL")
    end
end)

tab1.newToggle("Auto Exp", "Collect all exp orbs", false, function(bool)
    _G.AutoExp = bool
    
    while _G.AutoExp and task.wait() do
        for _, v in pairs(game.Workspace.Collectable["Exp"]:GetChildren()) do
            v:WaitForChild("Touch").Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        end
    end
end)

tab1.newToggle("Auto Stars", "Collect all stars orbs (event)", false, function(bool)
    _G.AutoStars = bool
    
    while _G.AutoStars and task.wait() do
        if game.Workspace.Collectable["Purple Star"] then
            for _, v in pairs(game.Workspace.Collectable["Purple Star"]:GetChildren()) do
                v:WaitForChild("Touch").Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            end
        end
    end
end)
