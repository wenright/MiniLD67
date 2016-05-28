local Asteroid = Class {
	__includes = Transform,
	type = 'Asteroid',
	maxRadius = 20,
	maxSpeed = 2
}

function Asteroid:init(x, y, radius)
	-- TODO generate asteroid
	local x = x or love.math.random(-Game.w/2, Game.w/2)
	local y = y or love.math.random(-Game.h/2, Game.h/2)

	self.radius = radius or self.maxRadius

	self.verts = {}
	local numVerts = 20
	for i = 1, numVerts, 2 do
		local radius = self.radius * (love.math.random() + 0.5)
		local rotation = i * math.pi / (numVerts / 2)
		self.verts[i] = math.cos(rotation) * radius
		self.verts[i + 1] = math.sin(rotation) * radius
	end

	Transform.init(self, x, y, self.radius * 2, self.radius * 2)

	self.r = 0
	self.angularVelocity = love.math.random() * 6 - 3

	local vx = love.math.random() * self.maxSpeed * 2 - self.maxSpeed
	local vy = love.math.random() * self.maxSpeed * 2 - self.maxSpeed
	self:applyForce(vx, vy)

	-- Disallow collision so that the ball doesn't just coninuously destroy newly spawned asteroids
	Timer.after(0.2, function() self.canCollide = true end)
end

function Asteroid:update(dt)
	Transform.update(self, dt)

	self.r = self.r + self.angularVelocity * dt

	self:translateVertices()
end

function Asteroid:collide()
	--------------------------------
	-- Check for collision with ball
	if self.canCollide and pointInPolygon({Game.ball.x, Game.ball.y}, self.worldVerts) then
		if self.radius > 10 then
			Instantiate(Asteroid(self.x, self.y, self.radius / 2))
			Instantiate(Asteroid(self.x, self.y, self.radius / 2))
		end

		Game.ball:reflect(self.r - math.pi/2)

		-- TODO add to score

		Instantiate(Particles(self.x, self.y))

		Game.objects:remove(self)
	end
end

function Asteroid:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.worldVerts)

	love.graphics.setColor(255, 255, 255)

	love.graphics.polygon('line', self.worldVerts)
end

return Asteroid