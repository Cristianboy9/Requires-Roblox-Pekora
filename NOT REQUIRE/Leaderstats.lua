-- Server script in ServerScriptService
-- Sets up leaderstats when a player joins

local Players = game:GetService("Players")

local function setupPlayer(player)
	-- wait for character just in case something needs it later
	-- not strictly needed for leaderstats but a habit lol
	local function onCharacterAdded(character)
		-- you can hook into this later for death handling etc
	end
	
	-- create the leaderstats folder if it doesn't exist
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	-- cash stat
	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 0 -- starting cash
	cash.Parent = leaderstats
	
	-- level stat (just an example, make whatever you want)
	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = 1
	level.Parent = leaderstats
	
	-- if you want to save/load these later, hook into DataStore here
	
	player.CharacterAdded:Connect(onCharacterAdded)
	
	-- connect character if they already have one (edge case)
	if player.Character then
		onCharacterAdded(player.Character)
	end
end

-- hook up existing players (incase the script was added mid-game)
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(setupPlayer, player)
end

-- new players
Players.PlayerAdded:Connect(setupPlayer)
