-- Key System GUI + Load Aura Battles Script
-- Get Key & Join Discord buttons included

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUI if exists
if playerGui:FindFirstChild("AuraKeyGUI") then
    playerGui.AuraKeyGUI:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuraKeyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Helpers
local function makeUICorner(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, 12)
    corner.Parent = frame
end

local function addHoverEffect(button)
    local originalColor = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = originalColor:Lerp(Color3.fromRGB(150,150,150), 0.3)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
end

-- ===== KEY SYSTEM FRAME =====
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = UDim2.new(0, 350, 0, 250)
keyFrame.Position = UDim2.new(0.5, -175, -1, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyFrame.Parent = screenGui
makeUICorner(keyFrame)

-- Slide-in tween
local slideTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local slideTween = TweenService:Create(keyFrame, slideTweenInfo, {Position = UDim2.new(0.5, -175, 0.5, -125)})
slideTween:Play()

-- KeyBox
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 250, 0, 40)
keyBox.Position = UDim2.new(0.5, -125, 0, 20)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.ClearTextOnFocus = false
keyBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.Parent = keyFrame
makeUICorner(keyBox)

-- Verify Button
local verifyButton = Instance.new("TextButton")
verifyButton.Size = UDim2.new(0, 120, 0, 40)
verifyButton.Position = UDim2.new(0.5, -60, 0, 70)
verifyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
verifyButton.TextColor3 = Color3.fromRGB(255,255,255)
verifyButton.Text = "Verify Key"
verifyButton.TextScaled = true
verifyButton.Parent = keyFrame
makeUICorner(verifyButton)
addHoverEffect(verifyButton)

-- Get Key Button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0, 120, 0, 35)
getKeyButton.Position = UDim2.new(0.5, -60, 0, 120)
getKeyButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
getKeyButton.Text = "Get Key"
getKeyButton.TextColor3 = Color3.fromRGB(255,255,255)
getKeyButton.TextScaled = true
getKeyButton.Parent = keyFrame
makeUICorner(getKeyButton)
addHoverEffect(getKeyButton)

-- Join Discord Button
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0, 200, 0, 40)
discordButton.Position = UDim2.new(0.5, -100, 0, 165)
discordButton.Text = "Join Discord"
discordButton.TextScaled = true
discordButton.BackgroundColor3 = Color3.fromRGB(60,120,240)
discordButton.TextColor3 = Color3.fromRGB(255,255,255)
discordButton.Parent = keyFrame
makeUICorner(discordButton)
addHoverEffect(discordButton)

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 210)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
statusLabel.Text = ""
statusLabel.TextScaled = true
statusLabel.Parent = keyFrame

-- ===== BUTTON FUNCTIONALITY =====

-- Verify Key
verifyButton.MouseButton1Click:Connect(function()
    local enteredKey = string.upper(keyBox.Text)
    if enteredKey == "SENTRY" then
        statusLabel.Text = "Key verified!"
        -- bounce effect
        local bounceUp = TweenService:Create(keyFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = keyFrame.Position + UDim2.new(0,0,-0.02,0)})
        local bounceDown = TweenService:Create(keyFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = keyFrame.Position})
        bounceUp:Play()
        bounceUp.Completed:Connect(function()
            bounceDown:Play()
        end)
        task.wait(0.5)
        keyFrame.Visible = false
        -- Load Aura Battles Script
        loadstring(game:HttpGet('https://raw.githubusercontent.com/SentryHub1/Aura-battles/refs/heads/main/main%204.lua'))()
    else
        statusLabel.Text = "Wrong key!"
    end
end)

-- Get Key Button
getKeyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://rekonise.com/sentryhub-get-key-kehty")
        statusLabel.Text = "Copied to clipboard!"
    else
        statusLabel.Text = "Clipboard not supported."
    end
end)

-- Join Discord Button
discordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/X2WBMt2pS")
        statusLabel.Text = "Discord link copied!"
    else
        statusLabel.Text = "Clipboard not supported."
    end
end)