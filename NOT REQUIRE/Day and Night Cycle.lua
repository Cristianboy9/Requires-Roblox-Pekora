-- Server script inside ServerScriptService
local lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- how long a full day takes in seconds
local dayLength = 120 -- 2 mins, change if you want
local currentTime = 0

-- skip the default roblox time and use our own
lighting.ClockTime = 6
lighting.GeographicLatitude = 41 -- makes nights darker

while true do
	-- daytime phase (6AM -> 6PM)
	local dayTweenInfo = TweenInfo.new(
		dayLength / 2, -- half the cycle
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out
	)
	
	local dayTween = TweenService:Create(
		lighting,
		dayTweenInfo,
		{ClockTime = 18} -- go to sunset
	)
	dayTween:Play()
	dayTween.Completed:Wait()
	
	-- nighttime phase (6PM -> 6AM)
	local nightTweenInfo = TweenInfo.new(
		dayLength / 2,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out
	)
	
	local nightTween = TweenService:Create(
		lighting,
		nightTweenInfo,
		{ClockTime = 6} -- back to sunrise
	)
	nightTween:Play()
	nightTween.Completed:Wait()
end
