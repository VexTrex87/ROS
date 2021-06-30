local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local createElement = require(ReplicatedStorage.Rovis)
local Assets = require(ReplicatedStorage.Assets)

local localPlayer = Players.LocalPlayer
local Files = {}

Files.Icon = Assets["Files_Icon"]
Files.Name = "Files"

function createUICorner(cornerRadius)
    return createElement("UICorner", {
        CornerRadius = cornerRadius
    })
end

function createTopRightButton(name, position, color)
    return createElement("ImageButton", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = color,
        Name = name,
        Position = position,
        Size = UDim2.new(0, 20, 0, 20),
    }, {
        CornerRadius = createUICorner(UDim.new(0, 5))
    })
end

function createSidebarButton(name, layoutOrder)
    return createElement("TextButton", {
        Name = name,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 0, 30),
        LayoutOrder = layoutOrder,
        Font = Enum.Font.GothamBold,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, {
        UICorner = createUICorner(UDim.new(0, 5))
    })
end

function Files.createInterface()
    gridChildren = {
        UIGridLayout = createElement("UIGridLayout", {
            CellPadding = UDim2.new(0, 10, 0, 10),
            CellSize = UDim2.new(0, 85, 0, 75),
            SortOrder = Enum.SortOrder.Name,
        })
    }    

    local filesInterface = createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.3,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Name = "Files",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.8, 0, 0.8, 0),
    }, {
        UICorner = createUICorner(UDim.new(0, 5)),
        Grid = createElement("Frame", {
            Name = "Grid",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 220, 0, 40),
            Size = UDim2.new(1, -235, 1, -70),
            ClipsDescendants = true,
        }, {
            UIGridLayout = createElement("UIGridLayout", {
                CellPadding = UDim2.new(0, 10, 0, 10),
                CellSize = UDim2.new(0, 85, 0, 75),
                SortOrder = Enum.SortOrder.Name,
            }),
        }), gridChildren,
        Sidebar = createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 200, 1, 0),
        }, {
            UICorner = createUICorner(UDim.new(0, 5)),
            Frame = createElement("Frame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 1, -40)
            }, {
                UIListLayout = createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                }),
                Downloads = createSidebarButton("Downloads", 0),
                Documents = createSidebarButton("Documents", 1),
                Pictures = createSidebarButton("Pictures", 2),
                Videos = createSidebarButton("Videos", 3),
                Audio = createSidebarButton("Audio", 4),
            })
        }),
        Close = createTopRightButton("Close", UDim2.new(1, -5, 0, 5), Color3.fromRGB(255, 0, 0)),
        Size = createTopRightButton("Size", UDim2.new(1, -30, 0, 5), Color3.fromRGB(255, 255, 0)),
        Minimize = createTopRightButton("Minimize", UDim2.new(1, -55, 0, 5), Color3.fromRGB(0, 255, 0)),
    })

    filesInterface.Parent = localPlayer.PlayerGui.Interface.Background
end

function Files.onClick()
    Files.createInterface()
end

return Files