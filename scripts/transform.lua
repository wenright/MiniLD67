local Transform = Class {}

function Transform:init(x, y)
	self.x = x or 0
	self.y = y or 0

	self.vx, self.vy = 0, 0
end

function Transform:applyForce(dx, dy)
	self.vx = self.vx + dx or 0
	self.vy = self.vy + dy or 0
end

function Transform:update(dt)
	self.x = self.x + self.vx
	self.y = self.y + self.vy
end

return Transform