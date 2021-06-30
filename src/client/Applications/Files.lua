local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Assets)
local Files = {}

Files.Icon = Assets["Files_Icon"]
Files.Name = "Files"

function Files.OnClick()
    print("Files clicked")
end

return Files