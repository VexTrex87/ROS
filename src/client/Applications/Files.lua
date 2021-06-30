local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local createElement = require(ReplicatedStorage.Rovis)
local Assets = require(ReplicatedStorage.Assets)

local localPlayer = Players.LocalPlayer
local Files = {}
local FilesWindow = {}
FilesWindow.__index = FilesWindow

Files.Icon = Assets["Files_Icon"]
Files.Name = "Files"
Files.Windows = {}

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

function FilesWindow:onCloseClicked()
    self.filesInterface:Destroy()
    table.remove(Files.Windows, table.find(Files.Windows, self))
end

function FilesWindow:onSizeWindowClicked()
    local isMinimized = self.filesInterface:GetAttribute("IsMinimized")
    if isMinimized then
        self.filesInterface.Size = UDim2.new(1, 0, 1, 0)
    else
        self.filesInterface.Size = UDim2.new(0.8, 0, 0.8, 0)
    end
    self.filesInterface:SetAttribute("IsMinimized", not isMinimized)
end

function FilesWindow:onMinimizeClicked()
    self.filesInterface.Visible = false
end

function FilesWindow.new()
    local self = setmetatable({}, FilesWindow)

    local gridChildren = {
        UIGridLayout = createElement("UIGridLayout", {
            CellPadding = UDim2.new(0, 10, 0, 10),
            CellSize = UDim2.new(0, 85, 0, 75),
            SortOrder = Enum.SortOrder.Name,
        })
    }    

    self.filesInterface = createElement("Frame", {
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
        SizeWindow = createTopRightButton("SizeWindow", UDim2.new(1, -30, 0, 5), Color3.fromRGB(255, 255, 0)),
        Minimize = createTopRightButton("Minimize", UDim2.new(1, -55, 0, 5), Color3.fromRGB(0, 255, 0)),
    })

    self.filesInterface:SetAttribute("IsMinimized", true)

    self.filesInterface.Close.MouseButton1Click:Connect(function()
        self:onCloseClicked()
    end)

    self.filesInterface.SizeWindow.MouseButton1Click:Connect(function()
        self:onSizeWindowClicked()
    end)

    self.filesInterface.Minimize.MouseButton1Click:Connect(function()
        self:onMinimizeClicked()
    end)
    
    self.filesInterface.Parent = localPlayer.PlayerGui.Interface.Background

    return self
end

function Files.onClick()
    if #Files.Windows > 0 then
        Files.Windows[1].filesInterface.Visible = true
    else
        local newWindow = FilesWindow.new()
        table.insert(Files.Windows, newWindow)
    end
end

return Files