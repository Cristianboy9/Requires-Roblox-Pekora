-- Script in a giant zombie model or boss
boss = script.Parent
bossHumanoid = boss.Humanoid
bossHumanoid.MaxHealth = 5000
bossHumanoid.Health = 5000

-- attack phase
while true do
	wait(2)
	-- finds nearest player
	local nearest = nil
	local nearestDist = 100
	
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (boss.PrimaryPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
			if dist < nearestDist then
				nearest = plr
				nearestDist = dist
			end
		end
	end
	
	if nearest and nearest.Character then
		bossHumanoid:MoveTo(nearest.Character.HumanoidRootPart.Position)
		
	if nearestDist < 10 then
			nearest.Character.Humanoid.Health = nearest.Character.Humanoid.Health - 20
		end
	end
end
