local Paddle = Class {
	__includes = Transform,
	type = 'Paddle',
	verts = {
		-80, -50,
		-80, -60,
		0, -60,
		0, -50
	}
}

function Paddle:init()
	Transform.init(self, 0, 0, 40, 50)

	self.dist = 40
	self.r = 0

	self.canHit = true
end

function Paddle:update(dt)
	----------------------------------------------------------------
	-- Update the paddle's position by copying the player's position
	self.r = Game.player.r

	local cos, sin = math.cos(self.r), math.sin(self.r)

	self.x = Game.player.x + cos * self.dist
	self.y = Game.player.y + sin * self.dist

	Transform.translateVertices(self)
end

function Paddle:collide()
	------------------------------------------------
	-- Check the paddle for collisions with the ball
	if self.canHit and pointInPolygon({Game.ball.x, Game.ball.y}, self.worldVerts) then
		Game.ball:reflect(self.r - math.pi/2)

		self.canHit = false
		Timer.after(0.2, function()
			self.canHit = true
		end)
	end
end

function Paddle:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.polygon('fill', self.worldVerts)
end

return Paddle