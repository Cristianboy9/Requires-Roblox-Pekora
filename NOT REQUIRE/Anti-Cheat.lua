local player = game.Players.LocalPlayer

player.CharacterAdded:connect(function(char)
	while true do
		wait(0.01) -- runs 100 times a second, RIP performance
		if char.Humanoid.WalkSpeed ~= 16 then
			char.Humanoid.WalkSpeed = 16
		end
	end
end)

-- but wait, they also added this in a SERVER script:
game.Players.PlayerAdded:connect(function(plr)
	while true do
		wait(5)
		if plr.Character and plr.Character.Humanoid.WalkSpeed > 16 then
			plr:Kick("No exploiting!")
		end
	end
end)
