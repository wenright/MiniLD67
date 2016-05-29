local Paddle = Class {
	__includes = Transform,
	type = 'Paddle'
}

function Paddle:init()
	Transform.init(self, 0, 0, 80, 20)

	self.worldVerts = Game.world:rectangle(self.x, self.y, self.w, self.h)
	self.worldVerts.parent = self

	self.dist = -50
	self.r = 0

	self.canHit = true
end

function Paddle:update(dt)
	----------------------------------------------------------------
	-- Update the paddle's position by copying the player's position
	self.r = Game.player.r

	local cos, sin = math.cos(self.r + math.pi/2), math.sin(self.r + math.pi/2)
	local cx, cy = Game.player.worldVerts:center()
	self.worldVerts:moveTo(cx + self.dist * cos, cy + self.dist * sin)
	self.worldVerts:setRotation(self.r)
end

function Paddle:collide()
	------------------------------------------------
	-- Check the paddle for collisions with the ball
	for k, ball in pairs(Game.balls.pool) do
		if self.canHit and self.worldVerts:contains(ball.x, ball.y) then
			local n = love.math.random(1, 4)
			love.audio.newSource('sound/bounce' .. n .. '.wav'):play()

			ball:reflect(self.r - math.pi/2)

			self.canHit = false
			Timer.after(0.2, function()
				self.canHit = true
			end)

			return
		end
	end
end

function Paddle:draw()
	love.graphics.setColor(255, 255, 255)
	self.worldVerts:draw('fill')
end

return Paddle