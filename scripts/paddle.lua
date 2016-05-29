local Paddle = Class {
	__includes = Transform,
	type = 'Paddle'
}

function Paddle:init()
	Transform.init(self, 0, 0, 80, 20)

	self.shape = Physics.rectangle(self.x, self.y, self.w, self.h)
	print(self.shape)

	self.dist = -50
	self.r = 0

	self.canHit = true
end

function Paddle:update(dt)
	----------------------------------------------------------------
	-- Update the paddle's position by copying the player's position
	self.r = Game.player.r

	local cos, sin = math.cos(self.r + math.pi/2), math.sin(self.r + math.pi/2)
	local c = Game.player.worldVerts.centroid
	self.shape:moveTo(c.x + self.dist * cos, c.y + self.dist * sin)
	self.shape:setRotation(self.r)
end

function Paddle:collide()
	------------------------------------------------
	-- Check the paddle for collisions with the ball
	if self.canHit and false --[[TODO]] then
		Game.ball:reflect(self.r - math.pi/2)

		self.canHit = false
		Timer.after(0.2, function()
			self.canHit = true
		end)
	end
end

function Paddle:draw()
	love.graphics.setColor(255, 255, 255)
	self.shape:draw('fill')
end

return Paddle