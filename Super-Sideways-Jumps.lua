-- SIDEWAYS JUMPS – LAG-FREE ULTRA EDITION
-- Auto = bulk teleport | Manual = exact distance | No loops | Mobile ready
-- Minimize: frame invisible, only Title + button visible

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ===== SPEED LEVELS – JUMPS PER FRAME (USED AS MULTIPLIER) =====
local SPEED_LEVELS = {
    {name = "SLOW",          jumpsPF = 1},
    {name = "FAST",          jumpsPF = 1},
    {name = "VERY FAST",     jumpsPF = 1},
    {name = "EXTREME",       jumpsPF = 1},
    {name = "MAX",           jumpsPF = 1},
    {name = "BEYOND MAX",    jumpsPF = 1},
    {name = "INFINITE",      jumpsPF = 1},
    {name = "BEYOND INF",    jumpsPF = 1},
    {name = "REALITY BRK",   jumpsPF = 2},
    {name = "CHAOS",         jumpsPF = 3},
    {name = "LUDICROUS",     jumpsPF = 5},
    {name = "QUANTUM",       jumpsPF = 8},
    {name = "DIMENSION",     jumpsPF = 12},
    {name = "PARADOX",       jumpsPF = 20},
    {name = "SINGULARITY",   jumpsPF = 50},
    {name = "OMNIPRESENCE",  jumpsPF = 999},
    {name = "Superskksksjsjsj", jumpsPF = 100000}
}

-- ===== STATE – ALL START DISABLED =====
local isEnabled = false
local isAuto = false
local jumpDist = 50
local speedIdx = 5          -- start at MAX
local nextDir = "left"

-- ===== MINIMAL MOBILE GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "SidewaysJumps"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 260, 0, 320)
main.Position = UDim2.new(0.5, -130, 1, -340)
main.AnchorPoint = Vector2.new(0.5, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Title bar – drag only from here
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundTransparency = 1
titleBar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SIDEWAYS"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0, 32, 0, 32)
minimize.Position = UDim2.new(1, -38, 0, 2)
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.Text = "−"
minimize.TextColor3 = Color3.fromRGB(220, 220, 220)
minimize.TextScaled = true
minimize.Font = Enum.Font.GothamBold
minimize.Parent = titleBar
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 6)

-- Toggle row
local toggleRow = Instance.new("Frame")
toggleRow.Size = UDim2.new(1, -20, 0, 40)
toggleRow.Position = UDim2.new(0, 10, 0, 45)
toggleRow.BackgroundTransparency = 1
toggleRow.Parent = main

local enableBtn = Instance.new("TextButton")
enableBtn.Size = UDim2.new(0.48, 0, 1, 0)
enableBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
enableBtn.Text = "ENABLE"
enableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enableBtn.TextScaled = true
enableBtn.Font = Enum.Font.GothamBold
enableBtn.Parent = toggleRow
Instance.new("UICorner", enableBtn).CornerRadius = UDim.new(0, 8)

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.48, 0, 1, 0)
autoBtn.Position = UDim2.new(0.52, 0, 0, 0)
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoBtn.Text = "AUTO"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.TextScaled = true
autoBtn.Font = Enum.Font.GothamBold
autoBtn.Parent = toggleRow
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 8)

-- Distance control
local distLabel = Instance.new("TextLabel")
distLabel.Size = UDim2.new(1, -20, 0, 20)
distLabel.Position = UDim2.new(0, 10, 0, 95)
distLabel.BackgroundTransparency = 1
distLabel.Text = "DISTANCE: 50"
distLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
distLabel.TextScaled = true
distLabel.Font = Enum.Font.GothamBold
distLabel.TextXAlignment = Enum.TextXAlignment.Left
distLabel.Parent = main

local distCtrl = Instance.new("Frame")
distCtrl.Size = UDim2.new(1, -20, 0, 36)
distCtrl.Position = UDim2.new(0, 10, 0, 117)
distCtrl.BackgroundTransparency = 1
distCtrl.Parent = main

local distMinus = Instance.new("TextButton")
distMinus.Size = UDim2.new(0.3, 0, 1, 0)
distMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
distMinus.Text = "−"
distMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
distMinus.TextScaled = true
distMinus.Font = Enum.Font.GothamBold
distMinus.Parent = distCtrl
Instance.new("UICorner", distMinus).CornerRadius = UDim.new(0, 6)

local distDisplay = Instance.new("TextLabel")
distDisplay.Size = UDim2.new(0.35, 0, 1, 0)
distDisplay.Position = UDim2.new(0.325, 0, 0, 0)
distDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
distDisplay.Text = "50"
distDisplay.TextColor3 = Color3.fromRGB(255, 150, 150)
distDisplay.TextScaled = true
distDisplay.Font = Enum.Font.GothamBold
distDisplay.Parent = distCtrl
Instance.new("UICorner", distDisplay).CornerRadius = UDim.new(0, 6)

local distPlus = Instance.new("TextButton")
distPlus.Size = UDim2.new(0.3, 0, 1, 0)
distPlus.Position = UDim2.new(0.7, 0, 0, 0)
distPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
distPlus.Text = "+"
distPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
distPlus.TextScaled = true
distPlus.Font = Enum.Font.GothamBold
distPlus.Parent = distCtrl
Instance.new("UICorner", distPlus).CornerRadius = UDim.new(0, 6)

-- Speed control
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 165)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "SPEED: MAX"
speedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = main

local speedCtrl = Instance.new("Frame")
speedCtrl.Size = UDim2.new(1, -20, 0, 36)
speedCtrl.Position = UDim2.new(0, 10, 0, 187)
speedCtrl.BackgroundTransparency = 1
speedCtrl.Parent = main

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0.3, 0, 1, 0)
speedMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedMinus.Text = "−"
speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedMinus.TextScaled = true
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Parent = speedCtrl
Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 6)

local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(0.35, 0, 1, 0)
speedDisplay.Position = UDim2.new(0.325, 0, 0, 0)
speedDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedDisplay.Text = "MAX"
speedDisplay.TextColor3 = Color3.fromRGB(150, 255, 150)
speedDisplay.TextScaled = true
speedDisplay.Font = Enum.Font.GothamBold
speedDisplay.Parent = speedCtrl
Instance.new("UICorner", speedDisplay).CornerRadius = UDim.new(0, 6)

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0.3, 0, 1, 0)
speedPlus.Position = UDim2.new(0.7, 0, 0, 0)
speedPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedPlus.TextScaled = true
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Parent = speedCtrl
Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 6)

-- Jump buttons
local jumpRow = Instance.new("Frame")
jumpRow.Size = UDim2.new(1, -20, 0, 60)
jumpRow.Position = UDim2.new(0, 10, 0, 240)
jumpRow.BackgroundTransparency = 1
jumpRow.Parent = main

local leftBtn = Instance.new("TextButton")
leftBtn.Size = UDim2.new(0.48, 0, 1, 0)
leftBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
leftBtn.Text = "←"
leftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
leftBtn.TextScaled = true
leftBtn.Font = Enum.Font.GothamBold
leftBtn.Parent = jumpRow
Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 16)

local rightBtn = Instance.new("TextButton")
rightBtn.Size = UDim2.new(0.48, 0, 1, 0)
rightBtn.Position = UDim2.new(0.52, 0, 0, 0)
rightBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
rightBtn.Text = "→"
rightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rightBtn.TextScaled = true
rightBtn.Font = Enum.Font.GothamBold
rightBtn.Parent = jumpRow
Instance.new("UICorner", rightBtn).CornerRadius = UDim.new(0, 16)

-- ===== CORE FUNCTIONS =====
local function updateUI()
    local cs = SPEED_LEVELS[speedIdx]
    speedLabel.Text = "SPEED: " .. cs.name
    speedDisplay.Text = cs.name
    distLabel.Text = "DISTANCE: " .. jumpDist
    distDisplay.Text = tostring(jumpDist)
end

-- Manual jump: EXACT distance, with visual feedback
local function manualJump(dir)
    if not isEnabled or not HumanoidRootPart or not HumanoidRootPart.Parent then return end
    local cam = workspace.CurrentCamera
    if not cam then return end

    local right = cam.CFrame.RightVector
    local offset = (dir == "left" and -right or right) * jumpDist
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + offset

    local btn = dir == "left" and leftBtn or rightBtn
    local tween = TweenService:Create(btn, TweenInfo.new(0.02), {Size = UDim2.new(0.46, 0, 0.96, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        btn.Size = UDim2.new(0.48, 0, 1, 0)
    end)
end

-- Auto jump: BULK movement = jumpDist * jumpsPF (one CFrame write, zero lag)
local function autoJump(dir, multiplier)
    if not isEnabled or not HumanoidRootPart or not HumanoidRootPart.Parent then return end
    local cam = workspace.CurrentCamera
    if not cam then return end

    local right = cam.CFrame.RightVector
    local offset = (dir == "left" and -right or right) * (jumpDist * multiplier)
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + offset
end

-- ===== EVENT CONNECTIONS =====
enableBtn.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    enableBtn.BackgroundColor3 = isEnabled and Color3.fromRGB(200,60,60) or Color3.fromRGB(60,60,60)
    enableBtn.Text = isEnabled and "DISABLE" or "ENABLE"
end)

autoBtn.MouseButton1Click:Connect(function()
    isAuto = not isAuto
    autoBtn.BackgroundColor3 = isAuto and Color3.fromRGB(60,120,200) or Color3.fromRGB(60,60,60)
    autoBtn.Text = isAuto and "AUTO" or "MANUAL"
end)

distMinus.MouseButton1Click:Connect(function()
    jumpDist = math.max(1, jumpDist - 25)
    updateUI()
end)

distPlus.MouseButton1Click:Connect(function()
    jumpDist = jumpDist + 25
    updateUI()
end)

speedMinus.MouseButton1Click:Connect(function()
    speedIdx = math.max(1, speedIdx - 1)
    updateUI()
end)

speedPlus.MouseButton1Click:Connect(function()
    speedIdx = math.min(#SPEED_LEVELS, speedIdx + 1)
    updateUI()
end)

-- Manual jumps
leftBtn.MouseButton1Click:Connect(function()
    manualJump("left")
end)

rightBtn.MouseButton1Click:Connect(function()
    manualJump("right")
end)

-- Minimize – frame becomes invisible, only Title + button visible
local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        main:TweenSize(UDim2.new(0, 170, 0, 36), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        main:TweenBackgroundTransparency(1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        minimize.Text = "+"
        for _,v in pairs(main:GetChildren()) do
            if v ~= titleBar then v.Visible = false end
        end
    else
        main:TweenSize(UDim2.new(0, 260, 0, 320), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        main:TweenBackgroundTransparency(0, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
        minimize.Text = "−"
        for _,v in pairs(main:GetChildren()) do v.Visible = true end
        updateUI()
    end
end)

-- ===== AUTO DASH – LAG-FREE BULK MOVEMENT =====
RunService.Heartbeat:Connect(function()
    if not isEnabled or not isAuto then return end
    local cs = SPEED_LEVELS[speedIdx]
    autoJump(nextDir, cs.jumpsPF)
    nextDir = nextDir == "left" and "right" or "left"
end)

-- ===== DRAGGABLE – ONLY FROM TITLE BAR =====
local dragActive, dragStart, frameStart
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragActive = true
        dragStart = input.Position
        frameStart = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragActive = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X,
                                  frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

-- ===== RESPAWN HANDLING =====
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- ===== INIT =====
updateUI()
