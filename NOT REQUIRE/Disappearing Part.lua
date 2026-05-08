p = script.Parent
touchy = false -- global

p.Touched:connect(function(hit)
	if touchy == false then -- not using not keyword
		touchy = true
		p.Transparency = 1
		p.CanCollide = false
		wait(2) -- old wait function
		p.Transparency = 0
		p.CanCollide = true
		touchy = false
	end
end)

-- no debounce per player, so if two people step on it the 2nd guy resets the timer lol
