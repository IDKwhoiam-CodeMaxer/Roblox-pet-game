local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for the RemoteEvents created by the server
local clickEvent = ReplicatedStorage:WaitForChild("ClickEvent")
local updateMoneyEvent = ReplicatedStorage:WaitForChild("UpdateMoney")

-- Build the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoneyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Position = UDim2.new(0.5, -100, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "💰 Money: 0"
label.TextColor3 = Color3.fromRGB(255, 215, 0)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

-- Update label whenever the server sends a new money value
updateMoneyEvent.OnClientEvent:Connect(function(amount)
	label.Text = "💰 Money: " .. amount
end)

-- Fire the server on every mouse click (not on UI)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		clickEvent:FireServer()
	end
end)
