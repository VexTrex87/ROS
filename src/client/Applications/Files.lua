local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Assets = require(ReplicatedStorage.Configuration.Assets)
local ColorPalette = require(ReplicatedStorage.Configuration.ColorPalette)
local Helper = require(ReplicatedStorage.Modules.Helper)

local localPlayer = Players.LocalPlayer
local Interface = require(Helper.waitForPath(localPlayer, "PlayerScripts.System.Interface"))

local Files = {
    Name = "Files",
    Icon = Assets["Files_Icon"],
    IsOnTaskbar = true,
    TaskbarOrder = 1,
}
Files.__index = Files

function Files.New()
    local self = setmetatable({}, Files)
    local sidebarChildren = {
        UIListLayout = Helper.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
        }),
    }

    for i, library in ipairs(ReplicatedStorage.Files:GetChildren()) do
        local configuration = require(library._Configuration)
        local libraryButton = Helper.createElement("ImageButton", {
            AutoButtonColor = false,
            BackgroundColor3 = ColorPalette.LighterBlack,
            BackgroundTransparency = 1,
            Name = library.Name,
            Size = UDim2.new(1, 0, 0, 40),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
            Icon = Helper.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Name = "Icon",
                Position = UDim2.new(0, 15, 0.5, 0),
                Size = UDim2.new(0, 25, 0, 25),
                Image = configuration["Icon"],
                ScaleType = Enum.ScaleType.Crop,
            }),
            TextLabel = Helper.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 50, 0.5, 0),
                Size = UDim2.new(1, -40, 0.7, 0),
                Font = Enum.Font.SourceSans,
                Text = library.Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 20,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
        })

        libraryButton.MouseEnter:Connect(function()
            libraryButton.BackgroundTransparency = 0
        end)

        libraryButton.MouseLeave:Connect(function()
            libraryButton.BackgroundTransparency = 1
        end)

        table.insert(sidebarChildren, libraryButton)
    end

    self.Window = Helper.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = ColorPalette.Black,
        Name = "Files",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.8, 0, 0.8, 0),
    }, {
        UICorner = Helper.createUICorner(UDim.new(0, 3)),
        Sidebar = Helper.createElement("Frame", {
            BackgroundColor3 = ColorPalette.LightBlack,
            Name = "Sidebar",
            Size = UDim2.new(0, 200, 1, 0),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
            Frame = Helper.createElement("Frame", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(1, 0, 1, -40),
                Image = nil,
            }, sidebarChildren)
        })
    })
    self.Window = Interface.CreateWindow(self.Window)
    self.Window.Parent = localPlayer.PlayerGui.Interface

    return self
end

return Files