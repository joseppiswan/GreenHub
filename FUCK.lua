local replicatedStorage = game:GetService("ReplicatedStorage")
-- services

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

-- locals

local toolName = player["weapon"].Value
local backpack = player.Backpack
local module = require(player.Character:FindFirstChildOfClass("Tool"))

-- ui locals

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local MainWindow = Library.CreateLib("GreenHub v.1", "Serpent")
local LocalPLayerTab = MainWindow:NewTab("LocalPlayer")
local GunModsSection = LocalPLayerTab:NewSection("Gun Mods")

-- general functions

local function Notify(Title, Text)
    local uisound = Instance.new("Sound")
    uisound.Volume = 0.5
    uisound.SoundId = "rbxassetid://2668759868"
    uisound.Parent = game.Workspace
    uisound:Play()
    game.StarterGui:SetCore("SendNotification",  {
        Title = Title;
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10491706008";
        Duration = 2.5;
    })
end

local function InfAmmo()
    local gun = player.Character:FindFirstChildOfClass("Tool")
    local args = {
        [1] = math.huge,
        [2] = 0,
        [3] = gun
    }

    replicatedStorage.Assets.Remotes.syncAmmo:FireServer(unpack(args))

    if gun then
        Notify("Inf Ammo", "Re-equip the gun!")
    else
        Notify("Error!", "Equip a gun first!")
    end
end

-- ui functions

GunModsSection:NewButton("Inf Ammo","Adds inf ammo, equip a gun first.", function()
    InfAmmo()
end)

GunModsSection:NewSlider("Firing RPM", "SliderInfo", 9999, 0, function(s)
    module.FiringRPM = s
end)
