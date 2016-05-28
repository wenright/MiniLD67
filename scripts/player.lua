local Player = Class {
	__includes = Transform,
	verts = {
		0,-25,
		20, 25,
		0, 10,
		-20, 25
	},
	rotationSpeed = 4,
	acceleration = 6
}

function Player:init()
	Transform.init(self, 0, 0, 40, 50)

	self.r = -math.pi/2
end

function Player:update(dt)
	Transform.update(self, dt)

	if love.keyboard.isDown('a', 'left') then
		self.r = self.r - dt * self.rotationSpeed
	end
	if love.keyboard.isDown('d', 'right') then
		self.r = self.r + dt * self.rotationSpeed
	end

	if love.keyboard.isDown('w', 'up') then
		self:applyForce(math.cos(self.r) * self.acceleration * dt, math.sin(self.r) * self.acceleration * dt)
	end
end

function Player:draw()
	love.graphics.push()

	love.graphics.translate(self.x, self.y)
	love.graphics.rotate(self.r + math.pi / 2)

	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.verts)

	love.graphics.setColor(255, 255, 255)

	-- Player
	love.graphics.polygon('line', self.verts)

	-- Paddle
	love.graphics.rectangle('fill', -25, -40, 50, 5, 2)

	love.graphics.pop()
end

return Player