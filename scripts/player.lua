local Player = Class {
	__includes = Transform,
	type = 'Player',
	rotationSpeed = 5,
	acceleration = 7,
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

	self.paddle = Instantiate(Paddle())
end

function Player:update(dt)
	--------------------------------------------------
	-- Update the position using the player's velocity
	Transform.update(self, dt)

	-----------------------------------------------------------
	-- Take input from keyboard and apply a rotation or a force
	if love.keyboard.isDown('a', 'left') then
		self.r = self.r - dt * self.rotationSpeed
	end
	if love.keyboard.isDown('d', 'right') then
		self.r = self.r + dt * self.rotationSpeed
	end

	if love.keyboard.isDown('w', 'up') then
		self:applyForce(math.cos(self.r - math.pi/2) * self.acceleration * dt, math.sin(self.r - math.pi/2) * self.acceleration * dt)
	end

	self:translateVertices()
end

function Player:collide()
	--------------------------------
	-- Check for collision with ball

	if pointInPolygon({Game.ball.x, Game.ball.y}, self.worldVerts) then
		Instantiate(Particles(self.x, self.y))

		Game.objects:remove(self.paddle)
		Game.objects:remove(self)
	end
end

function Player:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.worldVerts)

	love.graphics.setColor(255, 255, 255)

	love.graphics.polygon('line', self.worldVerts)
end

return Player