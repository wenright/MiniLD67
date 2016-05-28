local Player = Class {
	__includes = Transform,
	rotationSpeed = 4,
	acceleration = 6,
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

function Player:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.worldVerts)

	love.graphics.setColor(255, 255, 255)

	-- Player
	love.graphics.polygon('line', self.worldVerts)

	-- TODO move paddle with player
	-- TODO move paddle to separate file
	-- Paddle
	love.graphics.rectangle('fill', -25, -40, 50, 5, 2)
end

return Player