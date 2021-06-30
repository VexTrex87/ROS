local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local Startup = require(localPlayer.PlayerScripts:WaitForChild("Startup"))

Startup.init()