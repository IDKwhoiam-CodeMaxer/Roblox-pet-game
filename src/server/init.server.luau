local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create RemoteEvents so clients can find them
local clickEvent = Instance.new("RemoteEvent")
clickEvent.Name = "ClickEvent"
clickEvent.Parent = ReplicatedStorage

local updateMoneyEvent = Instance.new("RemoteEvent")
updateMoneyEvent.Name = "UpdateMoney"
updateMoneyEvent.Parent = ReplicatedStorage

local playerMoney = {}

Players.PlayerAdded:Connect(function(player)
	playerMoney[player.UserId] = 0
	-- Send starting amount to the client
	updateMoneyEvent:FireClient(player, 0)
end)

Players.PlayerRemoving:Connect(function(player)
	playerMoney[player.UserId] = nil
end)

clickEvent.OnServerEvent:Connect(function(player)
	local current = playerMoney[player.UserId] or 0
	current = current + 1
	playerMoney[player.UserId] = current
	updateMoneyEvent:FireClient(player, current)
end)
