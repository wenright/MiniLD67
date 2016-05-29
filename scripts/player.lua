local Player = Class {
	__includes = Transform,
	type = 'Player',
	rotationSpeed = 5,
	acceleration = 500,
	verts = {
		0,-25,
		20, 25,
		0, 10,
		-20, 25
	}
}

function Player:init()
	Transform.init(self, 0, 0, 40, 50)

	self.r = 0
	self.dr = 0

	self.paddle = Instantiate(Paddle())
end

function Player:update(dt)
	--------------------------------------------------
	-- Update the position using the player's velocity
	Transform.update(self, dt)

	self.r = self.worldVerts.r
	self.dr = 0

	-----------------------------------------------------------
	-- Take input from keyboard and apply a rotation or a force
	if love.keyboard.isDown('a', 'left') then
		self.dr = -self.rotationSpeed * dt
	end
	if love.keyboard.isDown('d', 'right') then
		self.dr = self.rotationSpeed * dt
	end

	self.worldVerts:rotate(self.dr)

	if love.keyboard.isDown('w', 'up') then
		self:applyForce(math.cos(self.r - math.pi/2) * self.acceleration * dt, math.sin(self.r - math.pi/2) * self.acceleration * dt)
	end
end

function Player:collide()
	--------------------------------
	-- Check for collision with ball
	for k, ball in pairs(Game.balls.pool) do
		if self.worldVerts:contains(ball.x, ball.y) then
			Instantiate(Particles(self.x, self.y))

			Game.objects:remove(self.paddle)
			Game.objects:remove(self)
		end
	end
end

function Player:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.worldVerts:unpack())

	love.graphics.setColor(255, 255, 255)
	love.graphics.polygon('line', self.worldVerts:unpack())
end

return Player