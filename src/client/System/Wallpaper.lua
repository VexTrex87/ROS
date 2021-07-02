local Wallpaper = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Assets = require(ReplicatedStorage.Configuration.Assets)
local Helper = require(ReplicatedStorage.Modules.Helper)

local localPlayer = Players.LocalPlayer

function Wallpaper.Create()
    local wallpaper = Helper.createElement("ImageLabel", {
        Name = "Wallpaper",
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 0,
        Image = Assets["Background"],
        ScaleType = Enum.ScaleType.Crop,
    })
    wallpaper.Parent = localPlayer.PlayerGui:WaitForChild("Interface")
end

return Wallpaper