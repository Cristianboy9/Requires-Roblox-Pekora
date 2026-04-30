-- Put this in a Script inside the part you want to be deadly

local killPart = script.Parent

-- make it easier to spot visually (optional)
killPart.BrickColor = BrickColor.new("Really red")
killPart.Material = Enum.Material.Neon

local debounce = {} -- stops double-killing the same player

killPart.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	
	if not humanoid then
		-- might've touched a tool or something, ignore
		return
	end
	
	-- debounce check so we don't spam kill a dead body
	if debounce[character] then return end
	debounce[character] = true
	
	-- kill em
	humanoid.Health = 0
	
	-- reset the debounce after a second in case they respawn on the same spot
	wait(1)
	debounce[character] = nil
end)

-- also damage over time instead of instant kill if you prefer
-- just swap the humanoid.Health = 0 with a loop that subtracts health
