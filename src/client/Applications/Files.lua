local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Configuration.Assets)

local Files = {
    Name = "Files",
    Icon = Assets["Files_Icon"],
    IsOnTaskbar = true,
    TaskbarOrder = 1,
}

return Files