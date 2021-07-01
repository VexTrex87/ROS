local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Configuration.Assets)

local Calculator = {
    Name = "Calculator",
    Icon = Assets["Calculator_Icon"],
    IsOnTaskbar = true,
    TaskbarOrder = 3,
}

return Calculator