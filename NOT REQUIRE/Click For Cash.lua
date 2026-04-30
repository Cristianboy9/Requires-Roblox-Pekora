-- Put this in a Script inside a Part with a ClickDetector
-- Increases cash in leaderstats when clicked

local clickPart = script.Parent

-- make sure it has a clickdetector
local clickDetector = clickPart:FindFirstChildWhichIsA("ClickDetector")
if not clickDetector then
	clickDetector = Instance.new("ClickDetector")
	clickDetector.Parent = clickPart
end

local CASH_PER_CLICK = 1 -- change this for upgrades later
local debounceTime = 0.1 -- stops macros from spamming too hard

local canClick = true

clickDetector.MouseClick:Connect(function(player)
	if not canClick then return end
	canClick = false
	
	-- find leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local cash = leaderstats:FindFirstChild("Cash")
		if cash then
			cash.Value = cash.Value + CASH_PER_CLICK
		end
	end
	
	-- tiny visual feedback (scale bounce)
	spawn(function()
		local originalSize = clickPart.Size
		clickPart.Size = originalSize * 1.1
		wait(0.05)
		clickPart.Size = originalSize
	end)
	
	task.wait(debounceTime)
	canClick = true
end)
