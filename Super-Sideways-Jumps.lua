-- ULTIMATE SIDEWAYS JUMPS - BEYOND INFINITE SPEED
-- Mobile Optimized | Reality Breaking Mode
-- By Super

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- SPEED LEVELS (BEYOND TIME AND SPACE)
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
    {name = "LUDICROUS SPEED", interval = -1, jumpsPerFrame = 5, color = Color3.fromRGB(0, 255, 255)},
    {name = "QUANTUM FLUX", interval = -1, jumpsPerFrame = 8, color = Color3.fromRGB(255, 0, 255)},
    {name = "DIMENSIONAL RIFT", interval = -1, jumpsPerFrame = 12, color = Color3.fromRGB(100, 255, 255)},
    {name = "TIME PARADOX", interval = -1, jumpsPerFrame = 20, color = Color3.fromRGB(255, 255, 0)},
    {name = "SINGULARITY", interval = -1, jumpsPerFrame = 50, color = Color3.fromRGB(255, 255, 255)},
    {name = "OMNIPRESENCE", interval = -1, jumpsPerFrame = 999, color = Color3.fromRGB(0, 0, 0), isOmni = true}
}

-- STATE
local isEnabled = true
local isAutoDashing = true
local nextDashDirection = "left"
local jumpDistance = 50
local speedLevel = 5
local minimized = false
local lastDashTime = 0

-- GUI CREATION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateSidewaysJumps"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 1, -500)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Header
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Super's Sideways Jumps"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = HeaderFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -50, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "âˆ’"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 28
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = HeaderFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- Chaos Warning Banner (hidden by default)
local ChaosWarning = Instance.new("Frame")
ChaosWarning.Name = "ChaosWarning"
ChaosWarning.Size = UDim2.new(1, -20, 0, 50)
ChaosWarning.Position = UDim2.new(0, 10, 0, 60)
ChaosWarning.BackgroundColor3 = Color3.fromRGB(150, 0, 50)
ChaosWarning.Visible = false
ChaosWarning.Parent = MainFrame

local ChaosCorner = Instance.new("UICorner")
ChaosCorner.CornerRadius = UDim.new(0, 10)
ChaosCorner.Parent = ChaosWarning

local ChaosText = Instance.new("TextLabel")
ChaosText.Size = UDim2.new(1, 0, 0.6, 0)
ChaosText.BackgroundTransparency = 1
ChaosText.Text = "ðŸ”¥ CHAOS MODE ACTIVE ðŸ”¥"
ChaosText.TextColor3 = Color3.fromRGB(255, 255, 255)
ChaosText.TextSize = 18
ChaosText.Font = Enum.Font.GothamBold
ChaosText.Parent = ChaosWarning

local ChaosSubtext = Instance.new("TextLabel")
ChaosSubtext.Size = UDim2.new(1, 0, 0.4, 0)
ChaosSubtext.Position = UDim2.new(0, 0, 0.6, 0)
ChaosSubtext.BackgroundTransparency = 1
ChaosSubtext.Text = "Reality.exe has stopped working"
ChaosSubtext.TextColor3 = Color3.fromRGB(255, 200, 200)
ChaosSubtext.TextSize = 12
ChaosSubtext.Font = Enum.Font.Gotham
ChaosSubtext.Parent = ChaosWarning

-- Toggle Buttons Container
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(1, -20, 0, 60)
ToggleContainer.Position = UDim2.new(0, 10, 0, 120)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.Parent = MainFrame

local EnableBtn = Instance.new("TextButton")
EnableBtn.Size = UDim2.new(0.48, 0, 1, 0)
EnableBtn.Position = UDim2.new(0, 0, 0, 0)
EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
EnableBtn.Text = "ENABLED"
EnableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBtn.TextSize = 18
EnableBtn.Font = Enum.Font.GothamBold
EnableBtn.Parent = ToggleContainer

local EnableCorner = Instance.new("UICorner")
EnableCorner.CornerRadius = UDim.new(0, 12)
EnableCorner.Parent = EnableBtn

local AutoDashBtn = Instance.new("TextButton")
AutoDashBtn.Size = UDim2.new(0.48, 0, 1, 0)
AutoDashBtn.Position = UDim2.new(0.52, 0, 0, 0)
AutoDashBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
AutoDashBtn.Text = "AUTO DASH: ON"
AutoDashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDashBtn.TextSize = 16
AutoDashBtn.Font = Enum.Font.GothamBold
AutoDashBtn.Parent = ToggleContainer

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 12)
AutoCorner.Parent = AutoDashBtn

-- Distance Control
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(1, -20, 0, 25)
DistLabel.Position = UDim2.new(0, 10, 0, 195)
DistLabel.BackgroundTransparency = 1
DistLabel.Text = "Distance: 50 studs"
DistLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
DistLabel.TextSize = 16
DistLabel.Font = Enum.Font.GothamBold
DistLabel.Parent = MainFrame

local DistControls = Instance.new("Frame")
DistControls.Size = UDim2.new(1, -20, 0, 50)
DistControls.Position = UDim2.new(0, 10, 0, 225)
DistControls.BackgroundTransparency = 1
DistControls.Parent = MainFrame

local DistMinus = Instance.new("TextButton")
DistMinus.Size = UDim2.new(0.3, 0, 1, 0)
DistMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DistMinus.Text = "âˆ’"
DistMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistMinus.TextSize = 28
DistMinus.Font = Enum.Font.GothamBold
DistMinus.Parent = DistControls

local DistMinusCorner = Instance.new("UICorner")
DistMinusCorner.CornerRadius = UDim.new(0, 10)
DistMinusCorner.Parent = DistMinus

local DistDisplay = Instance.new("TextLabel")
DistDisplay.Size = UDim2.new(0.35, 0, 1, 0)
DistDisplay.Position = UDim2.new(0.325, 0, 0, 0)
DistDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DistDisplay.Text = "50"
DistDisplay.TextColor3 = Color3.fromRGB(255, 100, 100)
DistDisplay.TextSize = 24
DistDisplay.Font = Enum.Font.GothamBold
DistDisplay.Parent = DistControls

local DistDisplayCorner = Instance.new("UICorner")
DistDisplayCorner.CornerRadius = UDim.new(0, 10)
DistDisplayCorner.Parent = DistDisplay

local DistPlus = Instance.new("TextButton")
DistPlus.Size = UDim2.new(0.3, 0, 1, 0)
DistPlus.Position = UDim2.new(0.7, 0, 0, 0)
DistPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DistPlus.Text = "+"
DistPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistPlus.TextSize = 28
DistPlus.Font = Enum.Font.GothamBold
DistPlus.Parent = DistControls

local DistPlusCorner = Instance.new("UICorner")
DistPlusCorner.CornerRadius = UDim.new(0, 10)
DistPlusCorner.Parent = DistPlus

-- Speed Control
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 25)
SpeedLabel.Position = UDim2.new(0, 10, 0, 290)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: MAX"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
SpeedLabel.TextSize = 16
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Parent = MainFrame

local SpeedControls = Instance.new("Frame")
SpeedControls.Size = UDim2.new(1, -20, 0, 50)
SpeedControls.Position = UDim2.new(0, 10, 0, 320)
SpeedControls.BackgroundTransparency = 1
SpeedControls.Parent = MainFrame

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Size = UDim2.new(0.3, 0, 1, 0)
SpeedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedMinus.Text = "âˆ’"
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.TextSize = 28
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.Parent = SpeedControls

local SpeedMinusCorner = Instance.new("UICorner")
SpeedMinusCorner.CornerRadius = UDim.new(0, 10)
SpeedMinusCorner.Parent = SpeedMinus

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0.35, 0, 1, 0)
SpeedDisplay.Position = UDim2.new(0.325, 0, 0, 0)
SpeedDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedDisplay.Text = "MAX"
SpeedDisplay.TextColor3 = Color3.fromRGB(255, 80, 80)
SpeedDisplay.TextSize = 14
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextScaled = true
SpeedDisplay.Parent = SpeedControls

local SpeedDisplayCorner = Instance.new("UICorner")
SpeedDisplayCorner.CornerRadius = UDim.new(0, 10)
SpeedDisplayCorner.Parent = SpeedDisplay

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Size = UDim2.new(0.3, 0, 1, 0)
SpeedPlus.Position = UDim2.new(0.7, 0, 0, 0)
SpeedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedPlus.Text = "+"
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.TextSize = 28
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.Parent = SpeedControls

local SpeedPlusCorner = Instance.new("UICorner")
SpeedPlusCorner.CornerRadius = UDim.new(0, 10)
SpeedPlusCorner.Parent = SpeedPlus

-- Warning Label (for extreme speeds)
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, -20, 0, 20)
WarningLabel.Position = UDim2.new(0, 10, 0, 375)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = ""
WarningLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
WarningLabel.TextSize = 12
WarningLabel.Font = Enum.Font.GothamBold
WarningLabel.Visible = false
WarningLabel.Parent = MainFrame

-- Jump Buttons
local JumpContainer = Instance.new("Frame")
JumpContainer.Size = UDim2.new(1, -20, 0, 90)
JumpContainer.Position = UDim2.new(0, 10, 0, 400)
JumpContainer.BackgroundTransparency = 1
JumpContainer.Parent = MainFrame

local LeftBtn = Instance.new("TextButton")
LeftBtn.Name = "LeftBtn"
LeftBtn.Size = UDim2.new(0.48, 0, 1, 0)
LeftBtn.Position = UDim2.new(0, 0, 0, 0)
LeftBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
LeftBtn.Text = "â† LEFT"
LeftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftBtn.TextSize = 24
LeftBtn.Font = Enum.Font.GothamBold
LeftBtn.Parent = JumpContainer

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 16)
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
RightBtn.Text = "RIGHT â†’"
RightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RightBtn.TextSize = 24
RightBtn.Font = Enum.Font.GothamBold
RightBtn.Parent = JumpContainer

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 16)
RightCorner.Parent = RightBtn

local RightGradient = Instance.new("UIGradient")
RightGradient.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 100, 100))
RightGradient.Rotation = 45
RightGradient.Parent = RightBtn

-- TRAIL EFFECT
local trail
local function createTrail()
    if trail then trail:Destroy() end
    trail = Instance.new("Trail")
    trail.Texture = "rbxassetid://446111271"
    trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0))
    trail.Lifetime = 0.8
    trail.Transparency = NumberSequence.new(0, 1)
    trail.WidthScale = NumberSequence.new(3, 0)
    
    local attachment0 = Instance.new("Attachment", HumanoidRootPart)
    local attachment1 = Instance.new("Attachment", HumanoidRootPart)
    attachment1.Position = Vector3.new(0, -2.5, 0)
    
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Parent = HumanoidRootPart
    trail.Enabled = false
end
createTrail()

-- UPDATE FUNCTIONS
local function updateSpeedDisplay()
    local currentSpeed = SPEED_LEVELS[speedLevel]
    SpeedLabel.Text = "Speed: " .. currentSpeed.name
    SpeedDisplay.Text = currentSpeed.name
    SpeedDisplay.TextColor3 = currentSpeed.color
    
    -- Update warnings based on speed level
    if speedLevel == 16 then
        -- OMNIPRESENCE - THE ULTIMATE LEVEL
        WarningLabel.Text = "âˆž OMNIPRESENT - YOU ARE EVERYWHERE âˆž"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Rainbow gradient for buttons
        LeftGradient.Color = ColorSequence.new(
            Color3.fromRGB(255, 0, 0), 
            Color3.fromRGB(255, 255, 255)
        )
        RightGradient.Color = ColorSequence.new(
            Color3.fromRGB(0, 0, 255), 
            Color3.fromRGB(255, 255, 255)
        )
        
    elseif speedLevel >= 11 then
        -- QUANTUM LEVELS (11-15)
        WarningLabel.Text = "âš ï¸ " .. currentSpeed.jumpsPerFrame .. " JUMPS PER FRAME - PHYSICS DESTROYED âš ï¸"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        
        -- Extreme gradient
        LeftGradient.Color = ColorSequence.new(
            Color3.fromRGB(0, 255, 255), 
            Color3.fromRGB(255, 0, 255)
        )
        RightGradient.Color = ColorSequence.new(
            Color3.fromRGB(0, 255, 255), 
            Color3.fromRGB(255, 0, 255)
        )
    elseif speedLevel >= 8 then
        -- REALITY BROKEN LEVELS (8-10)
        WarningLabel.Text = "âš ï¸ WARNING: REALITY UNSTABLE âš ï¸"
        WarningLabel.Visible = true
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(50, 0, 30)
        
        LeftGradient.Color = ColorSequence.new(
            Color3.fromRGB(200, 50, 200), 
            Color3.fromRGB(255, 50, 100)
        )
        RightGradient.Color = ColorSequence.new(
            Color3.fromRGB(200, 50, 200), 
            Color3.fromRGB(255, 50, 100)
        )
    else
        WarningLabel.Visible = false
        SpeedDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        LeftGradient.Color = ColorSequence.new(
            Color3.fromRGB(255, 80, 80), 
            Color3.fromRGB(255, 100, 100)
        )
        RightGradient.Color = ColorSequence.new(
            Color3.fromRGB(255, 80, 80), 
            Color3.fromRGB(255, 100, 100)
        )
    end
    
    -- Chaos mode and beyond
    if speedLevel == 16 then
        -- OMNIPRESENCE
        ChaosWarning.Visible = true
        ChaosText.Text = "âˆž âˆž âˆž OMNIPRESENCE âˆž âˆž âˆž"
        ChaosSubtext.Text = "YOU EXIST EVERYWHERE - ALL DIRECTIONS - INFINITE CLONES"
        LeftBtn.Text = "âˆž ALL âˆž"
        RightBtn.Text = "âˆž ALL âˆž"
        Title.TextColor3 = Color3.fromRGB(0, 0, 0)
        Title.BackgroundTransparency = 0
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        
    elseif speedLevel >= 15 then
        -- SINGULARITY
        ChaosWarning.Visible = true
        ChaosText.Text = "ðŸŒŒ SINGULARITY ACHIEVED ðŸŒŒ"
        ChaosSubtext.Text = "50 JUMPS PER FRAME - EXISTENCE.EXE DELETED"
        LeftBtn.Text = "ðŸ’« LEFT ðŸ’«"
        RightBtn.Text = "ðŸ’« RIGHT ðŸ’«"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1
        
    elseif speedLevel >= 13 then
        -- DIMENSIONAL RIFT / TIME PARADOX
        ChaosWarning.Visible = true
        ChaosText.Text = "âš¡ DIMENSIONAL ANOMALY âš¡"
        ChaosSubtext.Text = currentSpeed.jumpsPerFrame .. " jumps per frame - Space-time fractured"
        LeftBtn.Text = "ðŸŒ€ LEFT ðŸŒ€"
        RightBtn.Text = "ðŸŒ€ RIGHT ðŸŒ€"
        Title.TextColor3 = Color3.fromRGB(255, 255, 0)
        Title.BackgroundTransparency = 1
        
    elseif speedLevel >= 11 then
        -- LUDICROUS / QUANTUM
        ChaosWarning.Visible = true
        ChaosText.Text = "âš¡ QUANTUM STATE ACTIVE âš¡"
        ChaosSubtext.Text = currentSpeed.jumpsPerFrame .. " jumps per frame - Probability broken"
        LeftBtn.Text = "âš¡ LEFT âš¡"
        RightBtn.Text = "âš¡ RIGHT âš¡"
        Title.TextColor3 = Color3.fromRGB(0, 255, 255)
        Title.BackgroundTransparency = 1
        
    elseif speedLevel == 10 then
        ChaosWarning.Visible = true
        ChaosText.Text = "ðŸ”¥ CHAOS MODE ACTIVE ðŸ”¥"
        ChaosSubtext.Text = "Reality.exe has stopped working"
        LeftBtn.Text = "âš¡ LEFT âš¡"
        RightBtn.Text = "âš¡ RIGHT âš¡"
        Title.TextColor3 = Color3.fromRGB(255, 100, 255)
        Title.BackgroundTransparency = 1
        
    else
        ChaosWarning.Visible = false
        LeftBtn.Text = "â† LEFT"
        RightBtn.Text = "RIGHT â†’"
        Title.TextColor3 = Color3.fromRGB(255, 50, 50)
        Title.BackgroundTransparency = 1
    end
end

local function updateDistanceDisplay()
    DistLabel.Text = "Distance: " .. jumpDistance .. " studs"
    DistDisplay.Text = tostring(jumpDistance)
end

-- JUMP FUNCTION
local function performJump(direction)
    if not isEnabled then return end
    if not HumanoidRootPart or not HumanoidRootPart.Parent then return end
    
    local camera = workspace.CurrentCamera
    local currentSpeed = SPEED_LEVELS[speedLevel]
    
    -- OMNIPRESENCE MODE - Jump in ALL directions simultaneously
    if currentSpeed.isOmni then
        local directions = {
            {name = "right", vec = camera.CFrame.RightVector},
            {name = "left", vec = -camera.CFrame.RightVector},
            {name = "forward", vec = camera.CFrame.LookVector},
            {name = "back", vec = -camera.CFrame.LookVector},
            {name = "up", vec = Vector3.new(0, 1, 0)},
            {name = "down", vec = Vector3.new(0, -1, 0)},
        }
        
        -- Create clone effect parts for omnipresence
        for i, dir in ipairs(directions) do
            local offset = dir.vec * jumpDistance * math.random(1, 3)
            local targetCFrame = HumanoidRootPart.CFrame + offset
            
            -- Create visual clone at each position
            local clone = Instance.new("Part")
            clone.Size = Vector3.new(2, 2, 1)
            clone.CFrame = targetCFrame
            clone.Anchored = true
            clone.CanCollide = false
            clone.Material = Enum.Material.Neon
            clone.Color = Color3.fromRGB(
                math.random(0, 255),
                math.random(0, 255),
                math.random(0, 255)
            )
            clone.Transparency = 0.3
            clone.Parent = workspace
            
            -- Destroy clone after brief moment
            game:GetService("Debris"):AddItem(clone, 0.1)
        end
        
        -- Actual teleport to random position
        local randomDir = directions[math.random(1, #directions)]
        local finalPos = HumanoidRootPart.CFrame + (randomDir.vec * jumpDistance * math.random(1, 5))
        HumanoidRootPart.CFrame = finalPos
        
    else
        -- Normal jump behavior
        local rightVector = camera.CFrame.RightVector
        local dir = direction == "left" and -rightVector or rightVector
        local targetCFrame = HumanoidRootPart.CFrame + (dir * jumpDistance)
        
        -- Instant teleport
        HumanoidRootPart.CFrame = targetCFrame
    end
    
    -- Trail effect
    if trail then
        trail.Enabled = true
        task.delay(0.5, function()
            if trail then trail.Enabled = false end
        end)
    end
    
    -- Visual button feedback
    local btn = direction == "left" and LeftBtn or RightBtn
    local originalSize = btn.Size
    btn.Size = UDim2.new(originalSize.X.Scale * 0.95, 0, originalSize.Y.Scale * 0.95, 0)
    task.wait(0.05)
    btn.Size = originalSize
end

-- BUTTON CONNECTIONS
EnableBtn.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    EnableBtn.BackgroundColor3 = isEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)
    EnableBtn.Text = isEnabled and "ENABLED" or "DISABLED"
end)

AutoDashBtn.MouseButton1Click:Connect(function()
    isAutoDashing = not isAutoDashing
    AutoDashBtn.BackgroundColor3 = isAutoDashing and Color3.fromRGB(255, 150, 50) or Color3.fromRGB(60, 60, 60)
    AutoDashBtn.Text = isAutoDashing and "AUTO DASH: ON" or "AUTO DASH: OFF"
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 380, 0, 50)
        MinimizeBtn.Text = "+"
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child ~= HeaderFrame then
                child.Visible = false
            end
        end
    else
        MainFrame.Size = UDim2.new(0, 380, 0, 480)
        MinimizeBtn.Text = "âˆ’"
        for _, child in ipairs(MainFrame:GetChildren()) do
            child.Visible = true
        end
        updateSpeedDisplay()
    end
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

LeftBtn.MouseButton1Click:Connect(function()
    performJump("left")
end)

RightBtn.MouseButton1Click:Connect(function()
    performJump("right")
end)

-- AUTO DASH SYSTEM (BEYOND INFINITE SPEED - MULTIPLE JUMPS PER FRAME)
RunService.Heartbeat:Connect(function()
    if not isEnabled or not isAutoDashing then return end
    
    local currentSpeed = SPEED_LEVELS[speedLevel]
    local currentTime = tick()
    
    -- For speeds with interval > 0, use time-based checking
    if currentSpeed.interval > 0 then
        if (currentTime - lastDashTime) >= currentSpeed.interval then
            performJump(nextDashDirection)
            nextDashDirection = nextDashDirection == "left" and "right" or "left"
            lastDashTime = currentTime
        end
    else
        -- For interval = 0 or negative (quantum speeds), perform multiple jumps per frame
        for i = 1, currentSpeed.jumpsPerFrame do
            performJump(nextDashDirection)
            nextDashDirection = nextDashDirection == "left" and "right" or "left"
            
            -- At quantum levels, add slight randomness for chaos
            if speedLevel >= 11 and math.random() > 0.7 then
                nextDashDirection = math.random() > 0.5 and "left" or "right"
            end
        end
        lastDashTime = currentTime
    end
end)

-- CHAOS MODE VISUAL EFFECTS (INCLUDING QUANTUM LEVELS)
RunService.RenderStepped:Connect(function()
    if speedLevel == 16 then
        -- OMNIPRESENCE - COMPLETE VISUAL DESTRUCTION
        local time = tick()
        local pulse = math.sin(time * 30) * 0.5 + 0.5
        local pulse2 = math.cos(time * 25) * 0.5 + 0.5
        
        -- Rainbow pulsing on warning
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(
            math.floor(128 + 127 * math.sin(time * 5)),
            math.floor(128 + 127 * math.sin(time * 5 + 2)),
            math.floor(128 + 127 * math.sin(time * 5 + 4))
        )
        
        -- Extreme rotation and shake
        Title.Rotation = math.sin(time * 15) * 10
        local shake = math.random(-5, 5)
        MainFrame.Position = UDim2.new(0.5, -190 + shake, 1, -500 + shake)
        
        -- Invert colors periodically
        if math.floor(time * 10) % 2 == 0 then
            MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        end
        
        -- Strobe effect on buttons
        LeftBtn.BackgroundColor3 = Color3.fromRGB(
            math.floor(255 * pulse),
            math.floor(255 * pulse2),
            math.floor(255 * (1 - pulse))
        )
        RightBtn.BackgroundColor3 = Color3.fromRGB(
            math.floor(255 * pulse2),
            math.floor(255 * (1 - pulse)),
            math.floor(255 * pulse)
        )
        
    elseif speedLevel >= 15 then
        -- SINGULARITY - Complete visual chaos
        local pulse = math.sin(tick() * 20) * 0.5 + 0.5
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(
            200 + pulse * 55,
            200 + pulse * 55,
            200 + pulse * 55
        )
        Title.Rotation = math.sin(tick() * 10) * 5
        MainFrame.BackgroundColor3 = Color3.fromRGB(
            15 + pulse * 20,
            15 + pulse * 20,
            15 + pulse * 20
        )
        
    elseif speedLevel >= 13 then
        -- DIMENSIONAL RIFT / TIME PARADOX
        local pulse = math.sin(tick() * 15) * 0.5 + 0.5
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(
            100 + pulse * 155,
            pulse * 100,
            100 + pulse * 155
        )
        Title.Rotation = math.sin(tick() * 8) * 4
        
    elseif speedLevel >= 11 then
        -- QUANTUM FLUX / LUDICROUS SPEED
        local pulse = math.sin(tick() * 12) * 0.5 + 0.5
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(
            pulse * 255,
            100 + pulse * 155,
            200 + pulse * 55
        )
        Title.Rotation = math.sin(tick() * 6) * 3
        
    elseif speedLevel >= 9 then
        -- REALITY BROKEN / CHAOS MODE
        local pulse = math.sin(tick() * 10) * 0.5 + 0.5
        ChaosWarning.BackgroundColor3 = Color3.fromRGB(150 + pulse * 100, 0, 50 + pulse * 50)
        
        if speedLevel == 10 then
            Title.Rotation = math.sin(tick() * 5) * 2
        end
    else
        Title.Rotation = 0
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        MainFrame.Position = UDim2.new(0.5, -190, 1, -500)
    end
    
    -- Add screen shake at extreme speeds
    if speedLevel >= 13 and speedLevel < 16 then
        local shake = math.random(-2, 2)
        MainFrame.Position = UDim2.new(0.5, -190 + shake, 1, -500 + shake)
    end
end)

-- DRAGGABLE GUI
local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and dragInput and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

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

print("â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
print("ULTIMATE SIDEWAYS JUMPS - LOADED!")
print("â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
print("âœ“ 16 Speed Levels")
print("âœ“ Beyond 0ms - NEGATIVE TIME")
print("âœ“ Up to âˆž JUMPS PER FRAME")
print("âœ“ Mobile Optimized GUI")
print("âœ“ Reality Completely Destroyed")
print("â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
print("SPEED LEVELS:")
print("1-7: Normal â†’ Infinite")
print("8-10: Reality Broken (2-3 jumps/frame)")
print("11-12: Quantum (5-8 jumps/frame)")
print("13-14: Dimensional (12-20 jumps/frame)")
print("15: SINGULARITY (50 jumps/frame)")
print("16: OMNIPRESENCE (âˆž ALL DIRECTIONS)")
print("â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
print("âš ï¸  WARNING: Level 16 = COMPLETE CHAOS")
print("âš ï¸  YOU WILL EXIST EVERYWHERE AT ONCE")
print("âš ï¸  CLONES IN ALL 6 DIRECTIONS")
print("âš ï¸  999 JUMPS PER FRAME = 59,940/SEC")
print("âš ï¸  MAY CRASH GAME/SERVER!")
print("â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
