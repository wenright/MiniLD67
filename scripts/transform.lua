local Transform = Class {}

function Transform:init(x, y, w, h)
	self.x = x or 0
	self.y = y or 0

	self.w = w or 1
	self.h = h or 1

	self.vx, self.vy = 0, 0
end

function Transform:applyForce(dx, dy)
	self.vx = self.vx + dx or 0
	self.vy = self.vy + dy or 0
end

function Transform:update(dt)
	self.x = self.x + self.vx
	self.y = self.y + self.vy

	if self.x + self.w < -Game.w / 2 then
		self.x = Game.w / 2
	elseif self.x > Game.w / 2 then
		self.x = -Game.w / 2
	end

	if self.y + self.h < -Game.h / 2 then
		self.y = Game.h / 2
	elseif self.y > Game.h / 2 then
		self.y = -Game.h / 2
	end
end

return Transform