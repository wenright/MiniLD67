local Asteroid = Class {
	__includes = Transform,
	radius = 10
}

function Asteroid:init()
	-- TODO generate asteroid
	local x = love.math.random(-Game.w/2, Game.w/2)
	local y = love.math.random(-Game.h/2, Game.h/2)

	self.verts = {}
	local numVerts = 20
	for i = 1, numVerts, 2 do
		local radius = self.radius * (love.math.random() + 0.5)
		local rotation = i * math.pi / (numVerts / 2)
		self.verts[i] = math.cos(rotation) * radius
		self.verts[i + 1] = math.sin(rotation) * radius
	end

	self.r = 0
	self.angularVelocity = love.math.random() * 6 - 3

	Transform.init(self, x, y, self.radius * 2, self.radius * 2)
end

function Asteroid:update(dt)
	Transform.update(self, dt)

	self.r = self.r + self.angularVelocity * dt
end

function Asteroid:draw()
	love.graphics.push()

	love.graphics.translate(self.x, self.y)
	love.graphics.rotate(self.r)

	love.graphics.setColor(255, 255, 255)

	love.graphics.polygon('line', self.verts)

	love.graphics.pop()
end

return Asteroid