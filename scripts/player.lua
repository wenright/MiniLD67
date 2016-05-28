local Player = Class {
	__includes = Transform,
	verts = {
		0,-25,
		20, 25,
		0, 10,
		-20, 25
	}
}

function Player:init()
	Transform.init(self, 0, 0)

	self.r = 0
end

function Player:update(dt)
	Transform.update(self, dt)
end

function Player:draw()
	love.graphics.push()

	love.graphics.translate(self.x, self.y)

	love.graphics.setColor(255, 255, 255)
	love.graphics.polygon('line', self.verts)

	love.graphics.pop()
end

return Player