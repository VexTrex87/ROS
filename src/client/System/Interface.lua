local Interface = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Helper = require(ReplicatedStorage.Modules.Helper)
local ColorPalette = require(ReplicatedStorage.Configuration.ColorPalette)
local Assets = require(ReplicatedStorage.Configuration.Assets)
local localPlayer = Players.LocalPlayer

function Interface.Create()
    local interface = Helper.createElement("ScreenGui", {
        IgnoreGuiInset = true,
        Name = "Interface",
    })
    interface.Parent = localPlayer.PlayerGui
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end

function Interface.CreateWindow(window)
    local topRightFrame = Helper.createElement("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Name = "TopRightFrame",
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 60, 0, 20),
    }, {
        Close = Helper.createElement("ImageButton", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = ColorPalette.Red,
            Name = "Close",
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 20, 0, 20),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
        }),
        Maximize = Helper.createElement("ImageButton", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = ColorPalette.Yellow,
            Name = "Maximize",
            Position = UDim2.new(1, -20, 0, 0),
            Size = UDim2.new(0, 20, 0, 20),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
        }),
        Minimize = Helper.createElement("ImageButton", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = ColorPalette.Green,
            Name = "Minimize",
            Position = UDim2.new(1, -40, 0, 0),
            Size = UDim2.new(0, 20, 0, 20),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
        }),
    })

    topRightFrame.Close.MouseButton1Click:Connect(function()
        window:Destroy()
    end)

    topRightFrame.Maximize.MouseButton1Click:Connect(function()
        local isMaximized = window:GetAttribute("IsMaximized")
        if isMaximized then
            window.Size = UDim2.new(0.8, 0, 0.8, 0)
        else
            window.Size = UDim2.new(1, 0, 1, 0)
        end
        window:SetAttribute("IsMaximized", not isMaximized)
    end)

    topRightFrame.Minimize.MouseButton1Click:Connect(function()
        window.Visible = not window.Visible
    end)

    window:SetAttribute("IsMaximized", false)
    topRightFrame.Parent = window

    localPlayer.PlayerGui.Interface.Taskbar[window.Name].Opened.Visible = true
    window.AncestryChanged:Connect(function(child, parent)
        if not parent then
            localPlayer.PlayerGui.Interface.Taskbar[window.Name].Opened.Visible = false
        end
    end)

    return window
end

return Interface