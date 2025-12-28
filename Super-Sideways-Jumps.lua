-- Universal Sideways Jumps Script - ULTIMATE BROKEN MODE v2
-- NO jump duration, NO tween, pure instant CFrame teleport
-- No checks, no cooldowns, maximum speed and chaos
-- Title: "Super's Sideways jumps"
-- Auto Dodge feature completely removed

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- SETTINGS - MAXIMUM BROKEN
local DEFAULT_JUMP_DIST    = 50
local MIN_JUMP_DIST        = 1
local DEFAULT_DASH_INTERVAL = 0.00    -- Zero delay = as fast as Heartbeat
local MIN_DASH_INTERVAL    = 0
local MAX_DASH_INTERVAL    = 0.03     -- Still insane

local isEnabled = true
local isAutoDashing = true            -- Starts ON
local nextDashDirection = "left"
local autoDashInterval = DEFAULT_DASH_INTERVAL
local minimized = false
local DISTANCE_STEP = 25

-- GUI (red chaos theme)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateBrokenJumps"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 380, 0, 360)
Frame.Position = UDim2.new(0.5, -190, 0.85, -180)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 0, 40)
Title.Position = UDim2.new(0.05, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Super's Sideways jumps"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 28
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -40, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "–"
MinimizeButton.TextSize = 24
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = Frame

-- Toggles (Auto Dodge button removed)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.45, 0, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "ENABLED"
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = Frame

local AutoDashButton = Instance.new("TextButton")
AutoDashButton.Size = UDim2.new(0.45, 0, 0, 50)
AutoDashButton.Position = UDim2.new(0.5, 0, 0.15, 0)
AutoDashButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
AutoDashButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDashButton.Text = "AUTO DASH: ON"
AutoDashButton.TextSize = 18
AutoDashButton.Font = Enum.Font.SourceSansBold
AutoDashButton.Parent = Frame

-- Jump Buttons
local LeftButton = Instance.new("TextButton")
LeftButton.Size = UDim2.new(0.45, 0, 0, 80)
LeftButton.Position = UDim2.new(0.05, 0, 0.75, 0)
LeftButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
LeftButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftButton.Text = "← LEFT"
LeftButton.TextSize = 28
LeftButton.Font = Enum.Font.SourceSansBold
LeftButton.Parent = Frame

local RightButton = Instance.new("TextButton")
RightButton.Size = UDim2.new(0.45, 0, 0, 80)
RightButton.Position = UDim2.new(0.5, 0, 0.75, 0)
RightButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
RightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RightButton.Text = "RIGHT →"
RightButton.TextSize = 28
RightButton.Font = Enum.Font.SourceSansBold
RightButton.Parent = Frame

-- Distance Controls
local DistanceLabel = Instance.new("TextLabel")
DistanceLabel.Size = UDim2.new(0.9, 0, 0, 20)
DistanceLabel.Position = UDim2.new(0.05, 0, 0.42, 0)
DistanceLabel.BackgroundTransparency = 1
DistanceLabel.Text = "Distance: 50 studs"
DistanceLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
DistanceLabel.TextSize = 18
DistanceLabel.Font = Enum.Font.SourceSansBold
DistanceLabel.Parent = Frame

local MinusDist = Instance.new("TextButton")
MinusDist.Size = UDim2.new(0.2, 0, 0, 30)
MinusDist.Position = UDim2.new(0.05, 0, 0.48, 0)
MinusDist.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinusDist.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusDist.Text = "-"
MinusDist.TextSize = 22
MinusDist.Parent = Frame

local PlusDist = Instance.new("TextButton")
PlusDist.Size = UDim2.new(0.2, 0, 0, 30)
PlusDist.Position = UDim2.new(0.75, 0, 0.48, 0)
PlusDist.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
PlusDist.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusDist.Text = "+"
PlusDist.TextSize = 22
PlusDist.Parent = Frame

-- Speed Controls
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.58, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: MAX"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
SpeedLabel.TextSize = 18
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.Parent = Frame

local MinusSpeed = Instance.new("TextButton")
MinusSpeed.Size = UDim2.new(0.2, 0, 0, 30)
MinusSpeed.Position = UDim2.new(0.05, 0, 0.64, 0)
MinusSpeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinusSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusSpeed.Text = "–"
MinusSpeed.TextSize = 22
MinusSpeed.Parent = Frame

local PlusSpeed = Instance.new("TextButton")
PlusSpeed.Size = UDim2.new(0.2, 0, 0, 30)
PlusSpeed.Position = UDim2.new(0.75, 0, 0.64, 0)
PlusSpeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
PlusSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusSpeed.Text = "+"
PlusSpeed.TextSize = 22
PlusSpeed.Parent = Frame

-- Trail (very visible)
local trail
local function createTrail()
    if trail then trail:Destroy() end
    trail = Instance.new("Trail")
    trail.Texture = "rbxassetid://446111271"
    trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0))
    trail.Lifetime = 0.6
    trail.Transparency = NumberSequence.new(0, 0.1)
    trail.WidthScale = NumberSequence.new(3, 0)
    trail.Attachment0 = Instance.new("Attachment", HumanoidRootPart)
    trail.Attachment1 = Instance.new("Attachment", HumanoidRootPart)
    trail.Attachment1.Position = Vector3.new(0, -2.5, 0)
    trail.Parent = HumanoidRootPart
end
createTrail()

-- Draggable GUI
local dragging, dragInput, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimize / Maximize
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Frame.Size = UDim2.new(0, 380, 0, 50)
        MinimizeButton.Text = "+"
        for _, child in ipairs(Frame:GetChildren()) do
            if child ~= Title and child ~= MinimizeButton then child.Visible = false end
        end
    else
        Frame.Size = UDim2.new(0, 380, 0, 360)
        MinimizeButton.Text = "–"
        for _, child in ipairs(Frame:GetChildren()) do
            if child ~= Title and child ~= MinimizeButton then child.Visible = true end
        end
    end
end)

-- Toggles
ToggleButton.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    ToggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(80, 80, 80)
    ToggleButton.Text = isEnabled and "ENABLED" or "DISABLED"
end)

AutoDashButton.MouseButton1Click:Connect(function()
    isAutoDashing = not isAutoDashing
    AutoDashButton.BackgroundColor3 = isAutoDashing and Color3.fromRGB(255, 150, 50) or Color3.fromRGB(80, 80, 80)
    AutoDashButton.Text = isAutoDashing and "AUTO DASH: ON" or "AUTO DASH: OFF"
end)

-- Distance
local jumpDist = DEFAULT_JUMP_DIST
local function updateDistanceLabel()
    DistanceLabel.Text = "Distance: " .. jumpDist .. " studs"
end

MinusDist.MouseButton1Click:Connect(function()
    jumpDist = math.max(MIN_JUMP_DIST, jumpDist - DISTANCE_STEP)
    updateDistanceLabel()
end)

PlusDist.MouseButton1Click:Connect(function()
    jumpDist = jumpDist + DISTANCE_STEP
    updateDistanceLabel()
end)
updateDistanceLabel()

-- Speed
local function updateSpeedLabel()
    local speedText = autoDashInterval <= 0.01 and "MAX" or "HIGH"
    SpeedLabel.Text = "Speed: " .. speedText
end

MinusSpeed.MouseButton1Click:Connect(function()
    autoDashInterval = math.min(MAX_DASH_INTERVAL, autoDashInterval + 0.005)
    updateSpeedLabel()
end)

PlusSpeed.MouseButton1Click:Connect(function()
    autoDashInterval = math.max(MIN_DASH_INTERVAL, autoDashInterval - 0.005)
    updateSpeedLabel()
end)
updateSpeedLabel()

-- INSTANT JUMP - NO DURATION, NO TWEEN
local function performJump(direction)
    if not isEnabled then return end

    local camera = Workspace.CurrentCamera
    local right = camera.CFrame.RightVector
    local dir = direction == "left" and -right or right
    local targetCFrame = HumanoidRootPart.CFrame + (dir * jumpDist)

    -- Pure instant teleport
    HumanoidRootPart.CFrame = targetCFrame

    if trail then 
        trail.Enabled = true
        task.delay(0.4, function() trail.Enabled = false end)
    end
end

-- Auto Dash - runs every Heartbeat (max speed)
RunService.Heartbeat:Connect(function()
    if not isEnabled or not isAutoDashing then return end
    performJump(nextDashDirection)
    nextDashDirection = nextDashDirection == "left" and "right" or "left"
    -- No wait() needed - Heartbeat is ~60 times per second
end)

-- Manual buttons
LeftButton.MouseButton1Click:Connect(function() performJump("left") end)
RightButton.MouseButton1Click:Connect(function() performJump("right") end)

-- Respawn handling
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
    createTrail()
end)

print("ULTIMATE BROKEN MODE LOADED!")
print("Zero jump duration - pure instant CFrame teleport")
print("Auto-dash runs at max Heartbeat speed")
print("Hold on tight - this is maximum chaos!")
