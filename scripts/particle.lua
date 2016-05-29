local Particle = Class {
	__includes = Transform,
	type = 'Particle',
	speed = 500,
	lifetime = 0.5
}

function Particle:init(x, y)
	Transform.init(self, x, y)

	self.color = {255, 255, 255, 255}
	Timer.tween(self.lifetime, self, {color = {255, 255, 255, 0}}, 'in-quad')

	self:applyForce(love.math.random(-self.speed, self.speed), love.math.random(-self.speed, self.speed))
end

function Particle:update(dt)
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt
end

function Particle:draw()
	love.graphics.setPointSize(2)

	love.graphics.setColor(self.color)
	love.graphics.points(self.x, self.y)
end

return Particle