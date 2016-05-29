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

	if self.attachedBall then
		self.attachedBall.worldVerts:moveTo(cx + (self.dist - 25) * cos, cy + (self.dist - 25) * sin)
		self.attachedBall.worldVerts:setRotation(self.r)

		if love.keyboard.isDown('space') then
			-- TODO shooting sound
			love.audio.newSource('sound/bounce1.wav', 'static'):play()

			self.sticky = false

			self.attachedBall.vx = 0
			self.attachedBall.vy = 0
			
			self.attachedBall:applyForce(-Ball.speed * cos, -Ball.speed * sin)
			self.attachedBall.canCollide = true
			self.attachedBall = nil
		end
	end
end

function Paddle:collide()
	------------------------------------------------
	-- Check the paddle for collisions with the ball
	for shape, delta in pairs(Game.world:collisions(self.worldVerts)) do
		if self.canHit and shape.parent.type == 'Ball' then
			local ball = shape.parent			

			local n = love.math.random(1, 3)
			love.audio.newSource('sound/bounce' .. n .. '.wav'):play()

			if self.sticky then
				self.attachedBall = ball
				ball.canCollide = false
			else
				ball:reflect(self.r - math.pi/2)

				ball:applyForce(-ball.vx/2, -ball.vy/2)
				ball:applyForce(Game.player.vx, Game.player.vy)
			end

			-- By launching player back, we can prevent ball teleporting through paddle
			Game.player:applyForce(-Game.player.vx, -Game.player.vy)

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

	if self.sticky then
		love.graphics.setColor(200, 200, 200)
	end

	self.worldVerts:draw('fill')
end

return Paddle