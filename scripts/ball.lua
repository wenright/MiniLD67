local Ball = Class {
	__includes = Transform,
	type = 'Ball',
	speed = 300
}

function Ball:init(x, y, r)
	-- TODO this shouldn't need to be offset like this
	r = r - math.pi/2

	Transform.init(self, x, y)

	self.size = 4

	self.worldVerts = Game.world:circle(self.x, self.y, self.size)
	self.worldVerts.parent = self

	self.stuck = false
end

function Ball:update(dt)
	Transform.update(self, dt)
end

function Ball:collide()
	
end

function Ball:draw()
	love.graphics.setPointSize(self.size)

	love.graphics.setColor(255, 255, 255)
	love.graphics.points(self.worldVerts:center())
end

return Ball