local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local createElement = require(ReplicatedStorage.Rovis)
local Assets = require(ReplicatedStorage.Assets)
local Helper = require(ReplicatedStorage.Helper)

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
            Size = UDim2.new(0.6, 0, 0.6, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Image = application.Icon,
            ImageTransparency = 0.5,
            ScaleType = Enum.ScaleType.Crop
        })
        
        button.MouseButton1Click:Connect(application.onClick)

        button.MouseEnter:Connect(function()
            button.ImageTransparency = 0
        end)

        button.MouseLeave:Connect(function()
            button.ImageTransparency = 0.5
        end)

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
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    }, taskbarChildren)

    local function taskbarUpdated()
        local applicationsCount = 0
        for i, application in ipairs(taskbar:GetChildren()) do
            if application:IsA("ImageButton") then
                applicationsCount += 1
            end
        end
        taskbar.Size = UDim2.new(0, applicationsCount * 40, 0, 40)
    end

    taskbarUpdated()
    taskbar.ChildAdded:Connect(taskbarUpdated)
    taskbar.ChildRemoved:Connect(taskbarUpdated)

    return taskbar
end

function Startup.createLockScreen()
    local playerIcon, isReady = Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    local lockScreen = createElement("ImageLabel", {
        Name = "LockScreen",
        Size = UDim2.new(1, 0, 1, 0),
        Image = Assets["LockScreen"],
        ScaleType = Enum.ScaleType.Crop,
    }, {
        Profile = createElement("Frame", {
            Name = "Profile",
            Size = UDim2.new(0, 200, 0, 250),
            Position = UDim2.new(0.5, 0, 0.5, -200),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1
        }, {
            Icon = createElement("ImageLabel", {
                Name = "Icon",
                Size = UDim2.new(0, 200, 0, 200),
                BackgroundColor3 = Color3.fromRGB(85, 170, 255),
                Image = playerIcon,
            }, {
                UICorner = Helper.createUICorner(UDim.new(1, 0))
            }),
            Username = createElement("TextLabel", {
                Name = "Username",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 1, -40),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 40,
                Font = Enum.Font.SourceSansSemibold,
                Text = localPlayer.DisplayName,
            })
        }),
        SignIn = createElement("TextButton", {
            Name = "SignIn",
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0.5, 70),
            Size = UDim2.new(0, 200, 0, 50),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.3,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 30,
            Text = "Sign In",
            Font = Enum.Font.SourceSans,
        }, {
            UICorner = Helper.createUICorner(UDim.new(0, 3)),
        })
    })
    return lockScreen
end

function Startup.createInterface()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

    local interface = createElement("ScreenGui", {
        Name = "Interface",
        IgnoreGuiInset = true,
    }, {
        LockScreen = Startup.createLockScreen(),
        Background = createElement("ImageLabel", {
            Name = "Background",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Image = Assets["Background"],
            ScaleType = Enum.ScaleType.Crop,
            Visible = false
        }, {
            Taskbar = Startup.createTaskbar()
        })
    })

    interface.Parent = localPlayer.PlayerGui

    interface.LockScreen.SignIn.MouseButton1Click:Wait()
    interface.LockScreen.Visible = false
    interface.Background.Visible = true
end

function Startup.createFiles()
    local files = localPlayer.PlayerScripts:FindFirstChild("Files")
    if not files then
        files = Instance.new("Folder")
        files.Name = "Files"
        files.Parent = localPlayer.PlayerScripts
    end

    for i, child in ipairs({"Documents", "Pictures", "Videos", "Audio"}) do
        local library = files:FindFirstChild(child)
        if not library then
            library = Instance.new("Folder")
            library.Name = child
            library.Parent = files
        end
    end
end

function Startup.init()
    Startup.createLockScreen()
    Startup.createFiles()
    Startup.createInterface()
end

return Startup