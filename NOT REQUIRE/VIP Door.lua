-- Script inside a door
door = script.Parent

-- they have a Gamepass for VIP
-- Gamepass ID: 12345678

door.Touched:connect(function(hit)
	local char = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(char)
	
	if player then
		local ownsPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, 12345678)
		
  if ownsPass then
			door.CanCollide = false
			wait(3)
			door.CanCollide = true
		else
			char.Humanoid.Health = 0
		end
	end
end)
