local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local createElement = require(ReplicatedStorage.Rovis)
local Assets = require(ReplicatedStorage.Assets)
local Helper = require(ReplicatedStorage.Helper)

local localPlayer = Players.LocalPlayer
local Files = {}
local FilesWindow = {}
FilesWindow.__index = FilesWindow

Files.Icon = Assets["Files_Icon"]
Files.Name = "Files"
Files.Windows = {}

function createTopRightButton(name, position, color)
    return createElement("ImageButton", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = color,
        Name = name,
        Position = position,
        Size = UDim2.new(0, 15, 0, 15),
    }, {
        CornerRadius = Helper.createUICorner(UDim.new(1, 0))
    })
end

function FilesWindow:createSidebarButton(name, layoutOrder)
    local button = createElement("TextButton", {
        Name = name,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 0, 30),
        LayoutOrder = layoutOrder,
        Font = Enum.Font.SourceSansSemibold,
        Text = name,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, {
        UICorner = Helper.createUICorner(UDim.new(0, 5))
    })

    button.MouseButton1Click:Connect(function()
        self:showFiles(name)
    end)

    button.MouseEnter:Connect(function()
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    button.MouseLeave:Connect(function()
        button.TextColor3 = Color3.fromRGB(100, 100, 100)
    end)

    return button
end

function FilesWindow:showFiles(directoryName)
    local directory = localPlayer.PlayerScripts.Files[directoryName]

    for i, button in ipairs(self.filesInterface.Grid:GetChildren()) do
        if button:IsA("ImageButton") then
            button:Destroy()
        end
    end

    for i, file in ipairs(directory:GetChildren()) do
        local source = require(file)
        local button = createElement("ImageButton", {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Name = file.Name,
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
            Icon = createElement("ImageLabel", {
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0.5, 0),
                Name = "Icon",
                Position = UDim2.new(0.5, 0, 0, 5),
                Size = UDim2.new(0, 40, 0, 40),
                Image = source.Icon or Assets[source["Type"] .. "_Type_Icon"] or Assets["No_Icon"],
            }, {
                UICorner = Helper.createUICorner(UDim.new(0, 3))
            }),
            Title = createElement("TextLabel", {
                BackgroundTransparency = 1,
                Name = "Title",
                Position = UDim2.new(0, 0, 0, 50),
                Size = UDim2.new(1, 0, 0, 10),
                Font = Enum.Font.SourceSansSemibold,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Text = source.Name,
                TextSize = 12,
            })
        })

        button.Parent = self.filesInterface.Grid
    end
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
        UICorner = Helper.createUICorner(UDim.new(0, 5)),
        Grid = createElement("Frame", {
            Name = "Grid",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 220, 0, 40),
            Size = UDim2.new(1, -235, 1, -70),
            ClipsDescendants = true,
        }, {
            UIGridLayout = createElement("UIGridLayout", {
                CellPadding = UDim2.new(0, 10, 0, 10),
                CellSize = UDim2.new(0, 85, 0, 65),
                SortOrder = Enum.SortOrder.Name,
            }),
        }), gridChildren,
        Sidebar = createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 200, 1, 0),
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 5)),
            Frame = createElement("Frame", {
                Name = "Sidebar",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 1, -40)
            }, {
                UIListLayout = createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }),
                Documents = self:createSidebarButton("Documents", 0),
                Pictures = self:createSidebarButton("Pictures", 1),
                Videos = self:createSidebarButton("Videos", 2),
                Audio = self:createSidebarButton("Audio", 3),
            })
        }),
        Close = createTopRightButton("Close", UDim2.new(1, -5, 0, 5), Color3.fromRGB(255, 0, 0)),
        SizeWindow = createTopRightButton("SizeWindow", UDim2.new(1, -25, 0, 5), Color3.fromRGB(255, 255, 0)),
        Minimize = createTopRightButton("Minimize", UDim2.new(1, -45, 0, 5), Color3.fromRGB(0, 255, 0)),
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
    
    self:showFiles("Pictures")
    self.filesInterface.Parent = localPlayer.PlayerGui.Interface.Background

    return self
end

function Files.onClick()
    if #Files.Windows > 0 then
        Files.Windows[1].filesInterface.Visible = not Files.Windows[1].filesInterface.Visible
    else
        local newWindow = FilesWindow.new()
        table.insert(Files.Windows, newWindow)
    end
end

return Files