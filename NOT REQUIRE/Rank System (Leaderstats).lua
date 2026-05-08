-- Script in ServerScriptService
game.Players.PlayerAdded:connect(function(plr)
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	
	local xp = Instance.new("IntValue", leaderstats)
	xp.Name = "XP"
	xp.Value = 0
	
	local rank = Instance.new("StringValue", leaderstats)
	rank.Name = "Rank"
	rank.Value = "Noob" -- starting rank
	
	-- they want rank to update automatically
	xp.Changed:connect(function(val)
		-- the math zone begins
		if val >= 100 then
			rank.Value = "Beginner"
		end
		if val >= 500 then
			rank.Value = "Intermediate"
		end
		if val >= 1000 then
			rank.Value = "Pro"
		end
		if val >= 5000 then
			rank.Value = "Legend"
		end
		if val >= 10000 then
			rank.Value = "GOD"
		end
	end)
end)

-- also no way to actually GIVE xp in the game
-- "the ranking system is done just need to add the rest"
