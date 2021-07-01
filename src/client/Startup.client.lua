local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local Helper = require(ReplicatedStorage.Modules.Helper)
local Interface = require(Helper.waitForPath(localPlayer, "PlayerScripts.System.Interface"))
local Taskbar = require(Helper.waitForPath(localPlayer, "PlayerScripts.System.Taskbar"))

Interface.Create()
Taskbar.Create()