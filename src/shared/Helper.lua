local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement = require(ReplicatedStorage.Rovis)
local Helper = {}

function Helper.createUICorner(cornerRadius)
    return createElement("UICorner", {
        CornerRadius = cornerRadius
    })
end

return Helper