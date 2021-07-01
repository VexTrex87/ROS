local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Configuration.Assets)

local Web = {
    Name = "Web",
    Icon = Assets["Web_Icon"],
    IsOnTaskbar = true,
    TaskbarOrder = 0,
}

return Web