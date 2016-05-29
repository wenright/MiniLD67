local Powerup = Class {
	__includes = Transform,
	type = 'Powerup'
}

function Powerup:init(x, y)
	Transform.init(self, x, y)

	-- TODO pick random powerup type
	self.kind = 1
end

function Powerup:collide()
	if dist(Game.player.x, Game.player.y, self.x, self.y) < 50 then
		if self.kind == 1 then
			Instantiate(Ball(self.x, self.y, love.math.random() * math.pi * 4 - math.pi * 2))
			Instantiate(Ball(self.x, self.y, love.math.random() * math.pi * 4 - math.pi * 2))
		end

		print('Got a powerup!')
		Game.objects:remove(self)
	end
end

function Powerup:draw()
	-- TODO flashy animations and stuff
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle('line', self.x, self.y, 50)
end

return Powerup