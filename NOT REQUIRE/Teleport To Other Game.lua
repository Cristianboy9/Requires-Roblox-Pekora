-- in a LocalScript inside a part
teleporter = script.Parent
gameId = 123456789 -- wrong game id probably

teleporter.Touched:connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		game:GetService("TeleportService"):Teleport(gameId)
	end
end)
