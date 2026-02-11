-- ULTIMATE SIDEWAYS JUMPS - BEYOND INFINITE SPEED
-- Advanced Mobile-Friendly GUI | Reality Breaking Mode
-- By Super | Superskksksjsjsj

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- SPEED LEVELS (BEYOND TIME AND SPACE) - Optimized for performance
local SPEED_LEVELS = {
    {name = "SLOW", interval = 0.1, jumpsPerFrame = 1, color = Color3.fromRGB(100, 150, 255)},
    {name = "FAST", interval = 0.05, jumpsPerFrame = 1, color = Color3.fromRGB(100, 255, 100)},
    {name = "VERY FAST", interval = 0.02, jumpsPerFrame = 1, color = Color3.fromRGB(255, 255, 100)},
    {name = "EXTREME", interval = 0.01, jumpsPerFrame = 1, color = Color3.fromRGB(255, 150, 50)},
    {name = "MAX", interval = 0.005, jumpsPerFrame = 1, color = Color3.fromRGB(255, 80, 80)},
    {name = "BEYOND MAX", interval = 0.002, jumpsPerFrame = 1, color = Color3.fromRGB(255, 50, 150)},
    {name = "INFINITE", interval = 0.001, jumpsPerFrame = 1, color = Color3.fromRGB(200, 100, 255)},
    {name = "BEYOND INFINITE", interval = 0, jumpsPerFrame = 1, color = Color3.fromRGB(255, 100, 255)},
    {name = "REALITY BROKEN", interval = 0, jumpsPerFrame = 2, color = Color3.fromRGB(255, 255, 255)},
    {name = "CHAOS MODE", interval = 0, jumpsPerFrame = 3, color = Color3.fromRGB(255, 0, 100)},
    {name = "LUDICROUS SPEED", interval = 0, jumpsPerFrame = 5, color = Color3.fromRGB(0, 255, 255)},
    {name = "QUANTUM FLUX", interval = 0, jumpsPerFrame = 8, color = Color3.fromRGB(255, 0, 255)},
    {name = "DIMENSIONAL RIFT", interval = 0, jumpsPerFrame = 12, color = Color3.fromRGB(100, 255, 255)},
    {name = "TIME PARADOX", interval = 0, jumpsPerFrame = 20, color = Color3.fromRGB(255, 255, 0)},
    {name = "SINGULARITY", interval = 0, jumpsPerFrame = 50, color = Color3.fromRGB(255, 255, 255)},
    {name = "OMNIPRESENCE", interval = 0, jumpsPerFrame = 999, color = Color3.fromRGB(0, 0, 0), isOmni = true}
}

-- STATE
local isEnabled = true
local isAutoDashing = true
local nextDashDirection = "left"
local jumpDistance = 50
local speedLevel = 5
local minimized = false
local lastDashTime = 0
local performanceCap = 100  -- Max jumps per frame to prevent crashes (adjustable)

-- GUI CREATION - Smaller, mobile-friendly (250x350 base size)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateSidewaysJumps"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame - Compact size
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Header - Touch-friendly
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Super's Sideways Jumps"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = HeaderFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -40, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 24
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = HeaderFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Chaos Warning Banner (compact)
local ChaosWarning = Instance.new("Frame")
ChaosWarning.Name = "ChaosWarning"
ChaosWarning.Size = UDim2.new(1, -10, 0, 40)
ChaosWarning.Position = UDim2.new(0, 5, 0, 45)
ChaosWarning.BackgroundColor3 = Color3.fromRGB(150, 0, 50)
ChaosWarning.Visible = false
ChaosWarning.Parent = MainFrame

local ChaosCorner = Instance.new("UICorner")
ChaosCorner.CornerRadius = UDim.new(0, 8)
ChaosCorner.Parent = ChaosWarning

local ChaosText = Instance.new("TextLabel")
ChaosText.Size = UDim2.new(1, 0, 0.6, 0)
ChaosText.BackgroundTransparency = 1
ChaosText.Text = "🔥 CHAOS MODE ACTIVE 🔥"
ChaosText.TextColor3 = Color3.fromRGB(255, 255, 255)
ChaosText.TextSize = 14
ChaosText.Font = Enum.Font.GothamBold
ChaosText.Parent = ChaosWarning

local ChaosSubtext = Instance.new("TextLabel")
ChaosSubtext.Size = UDim2.new(1, 0, 0.4, 0)
ChaosSubtext.Position = UDim2.new(0, 0, 0.6, 0)
ChaosSubtext.BackgroundTransparency = 1
ChaosSubtext.Text = "Reality.exe has stopped working"
ChaosSubtext.TextColor3 = Color3.fromRGB(255, 200, 200)
ChaosSubtext.TextSize = 10
ChaosSubtext.Font = Enum.Font.Gotham
ChaosSubtext.Parent = ChaosWarning

-- Toggle Buttons Container - Horizontal layout
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(1, -10, 0, 40)
ToggleContainer.Position = UDim2.new(0, 5, 0, 90)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.Parent = MainFrame

local EnableBtn = Instance.new("TextButton")
EnableBtn.Size = UDim2.new(0.48, 0, 1, 0)
EnableBtn.Position = UDim2.new(0, 0, 0, 0)
EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
EnableBtn.Text = "ENABLED"
EnableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBtn.TextSize = 14
EnableBtn.Font = Enum.Font.GothamBold
EnableBtn.Parent = ToggleContainer

local EnableCorner = Instance.new("UICorner")
EnableCorner.CornerRadius = UDim.new(0, 8)
EnableCorner.Parent = EnableBtn

local AutoDashBtn = Instance.new("TextButton")
AutoDashBtn.Size = UDim2.new(0.48, 0, 1, 0)
AutoDashBtn.Position = UDim2.new(0.52, 0, 0, 0)
AutoDashBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
AutoDashBtn.Text = "AUTO: ON"
AutoDashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDashBtn.TextSize = 14
AutoDashBtn.Font = Enum.Font.GothamBold
AutoDashBtn.Parent = ToggleContainer

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 8)
AutoCorner.Parent = AutoDashBtn

-- Distance Control - Compact
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(1, -10, 0, 20)
DistLabel.Position = UDim2.new(0, 5, 0, 135)
DistLabel.BackgroundTransparency = 1
DistLabel.Text = "Distance: 50 studs"
DistLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
DistLabel.TextSize = 14
DistLabel.Font = Enum.Font.GothamBold
DistLabel.Parent = MainFrame

local DistControls = Instance.new("Frame")
DistControls.Size = UDim2.new(1, -10, 0, 40)
DistControls.Position = UDim2.new(0, 5, 0, 155)
DistControls.BackgroundTransparency = 1
DistControls.Parent = MainFrame

local DistMinus = Instance.new("TextButton")
DistMinus.Size = UDim2.new(0.3, 0, 1, 0)
DistMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DistMinus.Text = "-"
DistMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistMinus.TextSize = 24
DistMinus.Font = Enum.Font.GothamBold
DistMinus.Parent = DistControls

local DistMinusCorner = Instance.new("UICorner")
DistMinusCorner.CornerRadius = UDim.new(0, 8)
DistMinusCorner.Parent = DistMinus

local DistDisplay = Instance.new("TextLabel")
DistDisplay.Size = UDim2.new(0.35, 0, 1, 0)
DistDisplay.Position = UDim2.new(0.325, 0, 0, 0)
DistDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DistDisplay.Text = "50"
DistDisplay.TextColor3 = Color3.fromRGB(255, 100, 100)
DistDisplay.TextSize = 20
DistDisplay.Font = Enum.Font.GothamBold
DistDisplay.Parent = DistControls

local DistDisplayCorner = Instance.new("UICorner")
DistDisplayCorner.CornerRadius = UDim.new(0, 8)
DistDisplayCorner.Parent = DistDisplay

local DistPlus = Instance.new("TextButton")
DistPlus.Size = UDim2.new(0.3, 0, 1, 0)
DistPlus.Position = UDim2.new(0.7, 0, 0, 0)
DistPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DistPlus.Text = "+"
DistPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistPlus.TextSize = 24
DistPlus.Font = Enum.Font.GothamBold
DistPlus.Parent = DistControls

local DistPlusCorner = Instance.new("UICorner")
DistPlusCorner.CornerRadius = UDim.new(0, 8)
DistPlusCorner.Parent = DistPlus

-- Speed Control - Compact
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 5, 0, 200)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: MAX"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Parent = MainFrame

local SpeedControls = Instance.new("Frame")
SpeedControls.Size = UDim2.new(1, -10, 0, 40)
SpeedControls.Position = UDim2.new(0, 5, 0, 220)
SpeedControls.BackgroundTransparency = 1
SpeedControls.Parent = MainFrame

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Size = UDim2.new(0.3, 0, 1, 0)
SpeedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedMinus.Text = "-"
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.TextSize = 24
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.Parent = SpeedControls

local SpeedMinusCorner = Instance.new("UICorner")
SpeedMinusCorner.CornerRadius = UDim.new(0, 8)
SpeedMinusCorner.Parent = SpeedMinus

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0.35, 0, 1, 0)
SpeedDisplay.Position = UDim2.new(0.325, 0, 0, 0)
SpeedDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedDisplay.Text = "MAX"
SpeedDisplay.TextColor3 = Color3.fromRGB(255, 80, 80)
SpeedDisplay.TextSize = 12
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextScaled = true
SpeedDisplay.Parent = SpeedControls

local SpeedDisplayCorner = Instance.new("UICorner")
SpeedDisplayCorner.CornerRadius = UDim.new(0, 8)
SpeedDisplayCorner.Parent = SpeedDisplay

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Size = UDim2.new(0.3, 0, 1, 0)
SpeedPlus.Position = UDim2.new(0.7, 0, 0, 0)
SpeedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedPlus.Text = "+"
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.TextSize = 24
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.Parent = SpeedControls

local SpeedPlusCorner = Instance.new("UICorner")
SpeedPlusCorner.CornerRadius = UDim.new(0, 8)
SpeedPlusCorner.Parent = SpeedPlus

-- Warning Label (compact)
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, -10, 0, 15)
WarningLabel.Position = UDim2.new(0, 5, 0, 265)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = ""
WarningLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
WarningLabel.TextSize = 10
WarningLabel.Font = Enum.Font.GothamBold
WarningLabel.Visible = false
WarningLabel.Parent = MainFrame

-- Jump Buttons - Larger for mobile touch
local JumpContainer = Instance.new("Frame")
JumpContainer.Size = UDim2.new(1, -10, 0, 60)
JumpContainer.Position = UDim2.new(0, 5, 0, 285)
JumpContainer.BackgroundTransparency = 1
JumpContainer.Parent = MainFrame

local LeftBtn = Instance.new("TextButton")
LeftBtn.Name = "LeftBtn"
LeftBtn.Size = UDim2.new(0.48, 0, 1, 0)
LeftBtn.Position = UDim2.new(0, 0, 0, 0)
LeftBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
LeftBtn.Text = "← LEFT"
LeftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftBtn.TextSize = 20
LeftBtn.Font = Enum.Font.GothamBold
LeftBtn.Parent = JumpContainer

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 12)
LeftCorner.Parent = LeftBtn

local LeftGradient = Instance.new("UIGradient")
LeftGradient.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 100, 100))
LeftGradient.Rotation = 45
LeftGradient.Parent = LeftBtn

local RightBtn = Instance.new("TextButton")
RightBtn.Name = "RightBtn"
RightBtn.Size = UDim2.new(0.48, 0, 1, 0)
RightBtn.Position = UDim2.new(0.52, 0, 0, 0)
RightBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
RightBtn.Text = "RIGHT →"
RightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RightBtn.TextSize = 20
RightBtn.Font = Enum.Font.GothamBold
RightBtn.Parent = JumpContainer

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 12)
RightCorner.Parent = RightBtn

local RightGradient = Instance.new("UIGradient")
RightGradient.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 100, 100))
RightGradient.Rotation = 45
RightGradient.Parent = RightBtn

-- TRAIL EFFECT - Optimized
local trail
local function createTrail()
    if trail then trail:Destroy() end
    trail = Instance.new("Trail")
    trail.Texture = "rbxassetid://446111271"  -- Valid trail texture
    trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0))
    trail.Lifetime = 0.5  -- Shorter for performance
    trail.Transparency = NumberSequence.new(0, 1)
    trail.WidthScale = NumberSequence.new(2, 0)  -- Smaller
    trail.MinLength = 0.1
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = HumanoidRootPart
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = HumanoidRootPart
    attachment1.Position = Vector3.new(0, -2, 0)
    
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Parent = HumanoidRootPart
    trail.Enabled = false
end
createTrail()

-- UPDATE FUNCTIONS - Optimized
local function updateSpeedDisplay()
    local currentSpeed = SPEED_LEVELS[speedLevel]
    SpeedLabel.Text = "Speed: " .. currentSpeed.name
    SpeedDisplay.Text = currentSpeed.name
    SpeedDisplay.TextColor3 = currentSpeed.color
    
    -- Update warnings
    if speedLevel == 16 then
        WarningLabel.Text = "∞ OMNIPRESENT - YOU ARE EVERYWHERE ∞"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
        LeftGradient.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 255))
        RightGradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 255))
    elseif speedLevel >= 11 then
        WarningLabel.Text = "⚠️ " .. math.min(currentSpeed.jumpsPerFrame, performanceCap) .. " JUMPS/FRAME - PHYSICS DESTROYED ⚠️"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        LeftGradient.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255))
        RightGradient.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255))
    elseif speedLevel >= 8 then
        WarningLabel.Text = "⚠️ WARNING: REALITY UNSTABLE ⚠️"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(50, 0, 30)
        LeftGradient.Color = ColorSequence.new(Color3.fromRGB(200, 50, 200), Color3.fromRGB(255, 50, 100))
        RightGradient.Color = ColorSequence.new(Color3.fromRGB(200, 50, 200), Color3.fromRGB(255, 50, 100))
    else
        WarningLabel.Visible = false
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        LeftGradient.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 100, 100))
        RightGradient.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 100, 100))
    end
    
    -- Chaos mode updates
    if speedLevel == 16 then
        ChaosWarning.Visible = true
        ChaosText.Text = "∞ ∞ ∞ OMNIPRESENCE ∞ ∞ ∞"
        ChaosSubtext.Text = "YOU EXIST EVERYWHERE"
        LeftBtn.Text = "∞ ALL ∞"
        RightBtn.Text = "∞ ALL ∞"
        Title.TextColor3 = Color3.fromRGB(0, 0, 0)
        Title.BackgroundTransparency = 0
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    elseif speedLevel >= 15 then
        ChaosWarning.Visible = true
        ChaosText.Text = "🌌 SINGULARITY ACHIEVED 🌌"
        ChaosSubtext.Text = "50 JUMPS/FRAME - EXISTENCE DELETED"
        LeftBtn.Text = "💫 LEFT 💫"
        RightBtn.Text = "💫 RIGHT 💫"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1
    elseif speedLevel >= 13 then
        ChaosWarning.Visible = true
        ChaosText.Text = "⚡ DIMENSIONAL ANOMALY ⚡"
        ChaosSubtext.Text = currentSpeed.jumpsPerFrame .. " jumps/frame - Space-time fractured"
        LeftBtn.Text = "🌈 LEFT 🌈"
        RightBtn.Text = "🌈 RIGHT 🌈"
        Title.TextColor3 = Color3.fromRGB(255, 255, 0)
        Title.BackgroundTransparency = 1
    elseif speedLevel >= 11 then
        ChaosWarning.Visible = true
        ChaosText.Text = "⚡ QUANTUM STATE ACTIVE ⚡"
        ChaosSubtext.Text = currentSpeed.jumpsPerFrame .. " jumps/frame - Probability broken"
        LeftBtn.Text = "⚡ LEFT ⚡"
        RightBtn.Text = "⚡ RIGHT ⚡"
        Title.TextColor3 = Color3.fromRGB(0, 255, 255)
        Title.BackgroundTransparency = 1
    elseif speedLevel == 10 then
        ChaosWarning.Visible = true
        ChaosText.Text = "🔥 CHAOS MODE ACTIVE 🔥"
        ChaosSubtext.Text = "Reality.exe has stopped working"
        LeftBtn.Text = "⚡ LEFT ⚡"
        RightBtn.Text = "⚡ RIGHT ⚡"
        Title.TextColor3 = Color3.fromRGB(255, 100, 255)
        Title.BackgroundTransparency = 1
    else
        ChaosWarning.Visible = false
        LeftBtn.Text = "← LEFT"
        RightBtn.Text = "RIGHT →"
        Title.TextColor3 = Color3.fromRGB(255, 50, 50)
        Title.BackgroundTransparency = 1
    end
    
    -- Adjust positions if chaos warning is visible
    local offset = ChaosWarning.Visible and 45 or 0
    ToggleContainer.Position = UDim2.new(0, 5, 0, 45 + offset)
    DistLabel.Position = UDim2.new(0, 5, 0, 90 + offset)
    DistControls.Position = UDim2.new(0, 5, 0, 110 + offset)
    SpeedLabel.Position = UDim2.new(0, 5, 0, 155 + offset)
    SpeedControls.Position = UDim2.new(0, 5, 0, 175 + offset)
    WarningLabel.Position = UDim2.new(0, 5, 0, 220 + offset)
    JumpContainer.Position = UDim2.new(0, 5, 0, 240 + offset)
end

local function updateDistanceDisplay()
    DistLabel.Text = "Distance: " .. jumpDistance .. " studs"
    DistDisplay.Text = tostring(jumpDistance)
end

-- JUMP FUNCTION - Optimized for performance, cap jumps
local function performJump(direction)
    if not isEnabled or not HumanoidRootPart or not HumanoidRootPart.Parent then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local currentSpeed = SPEED_LEVELS[speedLevel]
    
    -- OMNIPRESENCE MODE - Optimized with fewer clones
    if currentSpeed.isOmni then
        local directions = {
            {vec = camera.CFrame.RightVector},
            {vec = -camera.CFrame.RightVector},
            {vec = camera.CFrame.LookVector},
            {vec = -camera.CFrame.LookVector},
            {vec = Vector3.new(0, 1, 0)},
            {vec = Vector3.new(0, -1, 0)},
        }
        
        -- Create fewer visual clones (max 6)
        for i, dir in ipairs(directions) do
            local offset = dir.vec * jumpDistance * math.random(1, 2)
            local targetCFrame = HumanoidRootPart.CFrame + offset
            
            local clone = Instance.new("Part")
            clone.Size = Vector3.new(1, 1, 0.5)
            clone.CFrame = targetCFrame
            clone.Anchored = true
            clone.CanCollide = false
            clone.Material = Enum.Material.Neon
            clone.Color = Color3.fromHSV(math.random(), 1, 1)
            clone.Transparency = 0.5
            clone.Parent = workspace
            Debris:AddItem(clone, 0.05)  -- Shorter lifetime
        end
        
        -- Teleport to random position
        local randomDir = directions[math.random(1, #directions)]
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + (randomDir.vec * jumpDistance * math.random(1, 3))
    else
        -- Normal jump
        local rightVector = camera.CFrame.RightVector
        local dir = (direction == "left") and -rightVector or rightVector
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + (dir * jumpDistance)
    end
    
    -- Trail effect - Brief
    if trail then
        trail.Enabled = true
        task.delay(0.2, function() if trail then trail.Enabled = false end end)
    end
    
    -- Button feedback - Tween for smoothness
    local btn = (direction == "left") and LeftBtn or RightBtn
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local shrink = TweenService:Create(btn, tweenInfo, {Size = UDim2.new(btn.Size.X.Scale * 0.95, 0, btn.Size.Y.Scale * 0.95, 0)})
    local expand = TweenService:Create(btn, tweenInfo, {Size = btn.Size})
    shrink:Play()
    shrink.Completed:Wait()
    expand:Play()
end

-- BUTTON CONNECTIONS - Touch-friendly
EnableBtn.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    EnableBtn.BackgroundColor3 = isEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)
    EnableBtn.Text = isEnabled and "ENABLED" or "DISABLED"
end)

AutoDashBtn.MouseButton1Click:Connect(function()
    isAutoDashing = not isAutoDashing
    AutoDashBtn.BackgroundColor3 = isAutoDashing and Color3.fromRGB(255, 150, 50) or Color3.fromRGB(60, 60, 60)
    AutoDashBtn.Text = isAutoDashing and "AUTO: ON" or "AUTO: OFF"
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 250, 0, 40) or UDim2.new(0, 250, 0, 350)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
    MinimizeBtn.Text = minimized and "+" or "-"
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child \~= HeaderFrame then
            child.Visible = not minimized
        end
    end
    if not minimized then updateSpeedDisplay() end
end)

DistMinus.MouseButton1Click:Connect(function()
    jumpDistance = math.max(1, jumpDistance - 25)
    updateDistanceDisplay()
end)

DistPlus.MouseButton1Click:Connect(function()
    jumpDistance = jumpDistance + 25
    updateDistanceDisplay()
end)

SpeedMinus.MouseButton1Click:Connect(function()
    speedLevel = math.max(1, speedLevel - 1)
    updateSpeedDisplay()
end)

SpeedPlus.MouseButton1Click:Connect(function()
    speedLevel = math.min(#SPEED_LEVELS, speedLevel + 1)
    updateSpeedDisplay()
end)

LeftBtn.MouseButton1Click:Connect(function() performJump("left") end)
RightBtn.MouseButton1Click:Connect(function() performJump("right") end)

-- AUTO DASH SYSTEM - Optimized with cap
RunService.Heartbeat:Connect(function(delta)
    if not isEnabled or not isAutoDashing then return end
    
    local currentSpeed = SPEED_LEVELS[speedLevel]
    local currentTime = tick()
    
    if currentSpeed.interval > 0 then
        if (currentTime - lastDashTime) >= currentSpeed.interval then
            performJump(nextDashDirection)
            nextDashDirection = (nextDashDirection == "left") and "right" or "left"
            lastDashTime = currentTime
        end
    else
        -- Cap jumps to prevent crash
        local effectiveJumps = math.min(currentSpeed.jumpsPerFrame, performanceCap)
        for i = 1, effectiveJumps do
            performJump(nextDashDirection)
            nextDashDirection = (nextDashDirection == "left") and "right" or "left"
            if speedLevel >= 11 and math.random() > 0.8 then  -- Increased threshold for less randomness
                nextDashDirection = math.random() > 0.5 and "left" or "right"
            end
        end
        lastDashTime = currentTime
    end
end)

-- CHAOS MODE VISUAL EFFECTS - Optimized, less intensive
local lastRenderTime = 0
RunService.RenderStepped:Connect(function(delta)
    local currentTime = tick()
    if (currentTime - lastRenderTime) < 0.05 then return end  -- Throttle to \~20 FPS for effects
    lastRenderTime = currentTime
    
    local pulse = math.sin(currentTime * 10) * 0.5 + 0.5
    if speedLevel == 16 then
        -- OMNIPRESENCE - Mild effects
        ChaosWarning.BackgroundColor3 = Color3.fromHSV(currentTime % 1, 1, 1)
        Title.Rotation = math.sin(currentTime * 5) * 5
        local shake = math.random(-2, 2)
        MainFrame.Position = UDim2.new(0.5, -125 + shake, 0.5, -175 + shake)
    elseif speedLevel >= 15 then
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(200 + pulse * 55, 200 + pulse * 55, 200 + pulse * 55)
        Title.Rotation = math.sin(currentTime * 5) * 3
    elseif speedLevel >= 13 then
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(100 + pulse * 155, pulse * 100, 100 + pulse * 155)
        Title.Rotation = math.sin(currentTime * 4) * 2
    elseif speedLevel >= 11 then
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(pulse * 255, 100 + pulse * 155, 200 + pulse * 55)
        Title.Rotation = math.sin(currentTime * 3) * 2
    elseif speedLevel >= 9 then
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(150 + pulse * 100, 0, 50 + pulse * 50)
        if speedLevel == 10 then Title.Rotation = math.sin(currentTime * 2) * 1 end
    else
        Title.Rotation = 0
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
    end
    
    -- Mild shake
    if speedLevel >= 13 and speedLevel < 16 then
        local shake = math.random(-1, 1)
        MainFrame.Position = UDim2.new(0.5, -125 + shake, 0.5, -175 + shake)
    end
end)

-- DRAGGABLE GUI - Supports touch
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

HeaderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

HeaderFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(updateInput)

-- RESPAWN HANDLING
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
    createTrail()
end)

-- Initialize
updateSpeedDisplay()
updateDistanceDisplay()

print("════════════════════════════════════════")
print("ULTIMATE SIDEWAYS JUMPS - ENHANCED!")
print("════════════════════════════════════════")
print("✓ Advanced Mobile-Friendly GUI")
print("✓ Compact Size & Touch-Optimized")
print("✓ Performance Caps to Prevent Crashes")
print("✓ Smoother Animations & Effects")
print("✓ 16 Speed Levels with Omni Mode")
print("════════════════════════════════════════")
print("SPEED LEVELS:")
print("1-7: Normal → Infinite")
print("8-10: Reality Broken (2-3 jumps/frame)")
print("11-12: Quantum (5-8 jumps/frame)")
print("13-14: Dimensional (12-20 jumps/frame)")
print("15: SINGULARITY (50 jumps/frame)")
print("16: OMNIPRESENCE (∞ ALL DIRECTIONS)")
print("════════════════════════════════════════")
print("⚠️ WARNING: High Levels May Still Lag!")
print("⚠️ Jumps Capped at " .. performanceCap .. "/frame")
print("════════════════════════════════════════")
