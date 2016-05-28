local Ball = Class {
	__includes = Transform,
	speed = 4
}

function Ball:init(x, y, r)
	Transform.init(self, x, y)

	self:applyForce(math.cos(r) * self.speed, math.sin(r) * self.speed)
end

function Ball:update(dt)
	Transform.update(self, dt)
end

function Ball:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.points(self.x, self.y)
end

return Ball