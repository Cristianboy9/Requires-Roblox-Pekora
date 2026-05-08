-- Script in ServerScriptService
players = game.Players:GetPlayers()
timeWithoutMove = {}

game.Players.PlayerAdded:connect(function(plr)
	timeWithoutMove[plr.UserId] = 0
	plr.CharacterAdded:connect(function(char)
		char.Humanoid.Running:connect(function(speed)
			timeWithoutMove[plr.UserId] = 0 -- reset on ANY movement
			-- but Running event fires every frame if moving, so this works kinda
		end)
	end)
end)

while wait(1) do
	for _, plr in pairs(game.Players:GetPlayers()) do
		timeWithoutMove[plr.UserId] = timeWithoutMove[plr.UserId] + 1
		if timeWithoutMove[plr.UserId] >= 20 then
			plr:Kick("afk")
		end
	end
end
