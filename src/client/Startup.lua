local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local Assets = require(ReplicatedStorage.Assets)

local localPlayer = Players.LocalPlayer
local Startup = {}

function Startup.createInterface()
    print("Creating startup interface...")

    local interface = Roact.createElement("ScreenGui", {
        Name = "Interface",
        IgnoreGuiInset = true,
    }, {
        Background = Roact.createElement("ImageLabel", {
            Name = "Background",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Image = Assets["ios_blue"],
            ScaleType = Enum.ScaleType.Stretch
        }, {
            Taskbar = Roact.createElement("Frame", {
                Name = "Taskbar",
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 0.3,
                Position = UDim2.new(0.5, 0, 1, -50),
                Size = UDim2.new(0.3, 0, 0, 40),
                BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            }, {
                UICorner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 5)
                })
            })
        })
    })
    
    Roact.mount(interface, localPlayer.PlayerGui)

end

function Startup.init()
    print("Starting...")
    Startup.createInterface()
end

return Startup