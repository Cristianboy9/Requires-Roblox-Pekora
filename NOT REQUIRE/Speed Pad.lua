brick = script.Parent -- global variable yessir

function onTouch(part) -- part? hit? who cares
	pp = game.Players:GetPlayerFromCharacter(part.Parent) -- another global let's go
	if pp then
		pp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0) -- only goes UP, not even caring about brick rotation
		-- also no check if HumanoidRootPart exists, it just explodes if something else touches it
	end
end

brick.Touched:connect(onTouch) -- old connect again
