local Particle = Class {
	__includes = Transform,
	speed = 500
}

function Particle:init(x, y)
	Transform.init(self, x, y)

	self:applyForce(love.math.random(-self.speed, self.speed), love.math.random(-self.speed, self.speed))
end

function Particle:draw()
	love.graphics.setPointSize(1)

	love.graphics.setColor(255, 255, 255)
	love.graphics.points(self.x, self.y)
end

return Particle