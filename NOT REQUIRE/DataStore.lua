-- Server script in ServerScriptService
-- Saves player cash and level using DataStore2-style logic but without the module

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- create our datastore, name it whatever
local cashStore = DataStoreService:GetDataStore("PlayerCash")
local levelStore = DataStoreService:GetDataStore("PlayerLevel")

local AUTO_SAVE_INTERVAL = 30 -- seconds between auto saves

-- session data so we can save without fetching again
local sessionData = {}

local function saveData(player)
	local data = sessionData[player]
	if not data then return end -- no data to save
	
	local userId = player.UserId
	
	-- wrap in pcall so a failed save doesn't break everything
	local success, err = pcall(function()
		cashStore:SetAsync(userId, data.Cash)
		levelStore:SetAsync(userId, data.Level)
	end)
	
	if success then
		print("Saved data for " .. player.Name)
	else
		warn("Failed to save for " .. player.Name .. ": " .. tostring(err))
	end
end

local function loadData(player)
	local userId = player.UserId
	local cash = 0
	local level = 1
	
	-- load with pcall, if datastore is down we just use defaults
	local success, err = pcall(function()
		cash = cashStore:GetAsync(userId) or 0
		level = levelStore:GetAsync(userId) or 1
	end)
	
	if not success then
		warn("Failed to load " .. player.Name .. "'s data: " .. tostring(err))
	end
	
	-- store in session
	sessionData[player] = {
		Cash = cash,
		Level = level
	}
	
	-- apply to leaderstats if they exist
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local cashVal = leaderstats:FindFirstChild("Cash")
		local levelVal = leaderstats:FindFirstChild("Level")
		if cashVal then cashVal.Value = cash end
		if levelVal then levelVal.Value = level end
	end
end

-- auto save loop
spawn(function()
	while true do
		wait(AUTO_SAVE_INTERVAL)
		for _, player in ipairs(Players:GetPlayers()) do
			-- sync data from leaderstats before saving
			local data = sessionData[player]
			local leaderstats = player:FindFirstChild("leaderstats")
			if data and leaderstats then
				local cashVal = leaderstats:FindFirstChild("Cash")
				local levelVal = leaderstats:FindFirstChild("Level")
				if cashVal then data.Cash = cashVal.Value end
				if levelVal then data.Level = levelVal.Value end
			end
			spawn(saveData, player)
		end
	end
end)

-- player added
Players.PlayerAdded:Connect(function(player)
	task.wait(1) -- tiny delay so character loads
	loadData(player)
end)

-- player leaving, last save
Players.PlayerRemoving:Connect(function(player)
	-- sync from leaderstats one last time
	local data = sessionData[player]
	local leaderstats = player:FindFirstChild("leaderstats")
	if data and leaderstats then
		local cashVal = leaderstats:FindFirstChild("Cash")
		local levelVal = leaderstats:FindFirstChild("Level")
		if cashVal then data.Cash = cashVal.Value end
		if levelVal then data.Level = levelVal.Value end
	end
	
	saveData(player)
	sessionData[player] = nil -- wipe session
end)

-- bind to close in case of game shutdown
game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		-- sync from leaderstats
		local data = sessionData[player]
		local leaderstats = player:FindFirstChild("leaderstats")
		if data and leaderstats then
			local cashVal = leaderstats:FindFirstChild("Cash")
			local levelVal = leaderstats:FindFirstChild("Level")
			if cashVal then data.Cash = cashVal.Value end
			if levelVal then data.Level = levelVal.Value end
		end
		saveData(player)
		sessionData[player] = nil
	end
end)
