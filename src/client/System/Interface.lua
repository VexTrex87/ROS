local Interface = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Helper = require(ReplicatedStorage.Modules.Helper)
local localPlayer = Players.LocalPlayer

function Interface.Create()
    local interface = Helper.createElement("ScreenGui", {
        IgnoreGuiInset = true,
        Name = "Interface",
    })
    interface.Parent = localPlayer.PlayerGui
end

return Interface