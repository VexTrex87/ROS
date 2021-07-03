local Taskbar = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ColorPalette = require(ReplicatedStorage.Configuration.ColorPalette)
local Assets = require(ReplicatedStorage.Configuration.Assets)
local Helper = require(ReplicatedStorage.Modules.Helper)
local localPlayer = Players.LocalPlayer

function Taskbar.Create()
    local icons = {
        UIListLayout = Helper.createElement("UIListLayout", {
            Padding = UDim.new(0, 5),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.Name,
            VerticalAlignment = Enum.VerticalAlignment.Center,
        }),
    }

    for i, application in ipairs(localPlayer.PlayerScripts.Applications:GetChildren()) do
        local source = require(application)
        local icon = Helper.createElement("ImageButton", {
            AutoButtonColor = false,
            BackgroundColor3 = ColorPalette.Black,
            BackgroundTransparency = 0.2,
            Name = application.Name,
            Visible = source.IsOnTaskbar,
            Size = UDim2.new(1, 0, 1, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
            Icon = Helper.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Name = "Icon",
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0.7, 0, 0.7, 0),
                Image = source.Icon or Assets.No_Icon,
                ScaleType = Enum.ScaleType.Crop
            }),
            Opened = Helper.createElement("Frame", {
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.3,
                Name = "Opened",
                Position = UDim2.new(0, 0, 1, 2),
                Size = UDim2.new(1, 0, 0, 4),
                Visible = false,
            }, {
                UICorner = Helper.createUICorner(UDim.new(0, 3))
            })
        })

        icon.MouseEnter:Connect(function()
            icon.BackgroundTransparency = 0.4
        end)

        icon.MouseLeave:Connect(function()
            icon.BackgroundTransparency = 0.2
        end)

        icon.MouseButton1Down:Connect(function()
            icon.BackgroundTransparency = 0.6
        end)

        icon.MouseButton1Up:Connect(function()
            icon.BackgroundTransparency = 0.4
        end)

        icon.MouseButton1Click:Connect(function()
            local currentWindow = localPlayer.PlayerGui.Interface:FindFirstChild(application.Name)
            if currentWindow then
                currentWindow.Visible = true
            else
                source.New()
            end
        end)

        table.insert(icons, icon)
    end

    local taskbar = Helper.createElement("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Name = "Taskbar",
        Position = UDim2.new(0, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 40),
        ZIndex = 10,
    }, icons)
    taskbar.Parent = localPlayer.PlayerGui.Interface
end

return Taskbar