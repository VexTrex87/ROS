local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local createElement = require(ReplicatedStorage.Rovis)
local Assets = require(ReplicatedStorage.Assets)

local localPlayer = Players.LocalPlayer
local applications = localPlayer.PlayerScripts:WaitForChild("Applications")
local Startup = {}

function Startup.createTaskbar()
    local taskbarChildren = {
        UICorner = createElement("UICorner", {
            CornerRadius = UDim.new(0, 5)
        })
    }

    for i, application in ipairs(applications:GetChildren()) do
        application = require(application)
        local button = createElement("ImageButton", {
            BackgroundTransparency = 1,
            Name = application.Name,
            Size = UDim2.new(0.8, 0, 0.8, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Image = application.Icon,
            ImageTransparency = 0.5,
        })
        
        button.MouseButton1Click:Connect(application.onClick)
        taskbarChildren[application.Name] = button
    end

    taskbarChildren["UIListLayout"] = createElement("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.Name,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })

    local taskbar = createElement("Frame", {
        Name = "Taskbar",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 0.3,
        Position = UDim2.new(0.5, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(30, 30, 40),
    }, taskbarChildren)

    local function taskbarUpdated()
        local applicationsCount = 0
        for i, application in ipairs(taskbar:GetChildren()) do
            if application:IsA("ImageButton") then
                applicationsCount += 1
            end
        end
        taskbar.Size = UDim2.new(0, applicationsCount * 30, 0, 30)
    end

    taskbarUpdated()
    taskbar.ChildAdded:Connect(taskbarUpdated)
    taskbar.ChildRemoved:Connect(taskbarUpdated)

    return taskbar
end

function Startup.createInterface()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

    local interface = createElement("ScreenGui", {
        Name = "Interface",
        IgnoreGuiInset = true,
    }, {
        Background = createElement("ImageLabel", {
            Name = "Background",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Image = Assets["Background"],
            ScaleType = Enum.ScaleType.Stretch
        }, {
            Taskbar = Startup.createTaskbar()
        })
    })

    interface.Parent = localPlayer.PlayerGui
end

function Startup.createStorage()
    local storage = Instance.new("Folder")
    storage.Name = "Storage"
    storage.Parent = localPlayer.PlayerScripts

    for i, child in ipairs({"Downloads", "Documents", "Pictures", "Videos", "Audio"}) do
        local library = Instance.new("Folder")
        library.Name = child
        library.Parent = storage
    end
end

function Startup.init()
    Startup.createStorage()
    Startup.createInterface()
end

return Startup