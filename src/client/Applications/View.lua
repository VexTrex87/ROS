local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Configuration.Assets)

local View = {
    Name = "View",
    Icon = Assets["View_Icon"],
    IsOnTaskbar = false,
    TaskbarOrder = 2
}

return View