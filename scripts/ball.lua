local Ball = Class {
	__includes = Transform
}

function Ball:init(x, y, r)
	Transform.init(self, x, y)

	self:applyForce(math.cos(r) * 100, math.sin(r) * 100)
end

function Ball:update(dt)
	Transform.update(self, dt)
end

function Ball:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.points(self.x, self.y)
end

return Ball