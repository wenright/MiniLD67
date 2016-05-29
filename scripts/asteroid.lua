local Asteroid = Class {
	__includes = Transform,
	type = 'Asteroid',
	maxRadius = 20,
	maxSpeed = 200
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
		self.verts[i] = x + math.cos(rotation) * radius
		self.verts[i + 1] = y + math.sin(rotation) * radius
	end

	Transform.init(self, x, y, self.radius * 2, self.radius * 2)

	self.r = 0
	self.angularVelocity = love.math.random() * 8 - 4

	local vx = love.math.random() * self.maxSpeed * 2 - self.maxSpeed
	local vy = love.math.random() * self.maxSpeed * 2 - self.maxSpeed
	self:applyForce(vx, vy)

	-- Disallow collision so that the ball doesn't just coninuously destroy newly spawned asteroids
	Timer.after(0.2, function() self.canCollide = true end)
end

function Asteroid:update(dt)
	Transform.update(self, dt)

	self.r = self.r + self.angularVelocity * dt
end

function Asteroid:collide()
	--------------------------------
	-- Check for collision with ball
	for k, ball in pairs(Game.balls.pool) do
		if self.canCollide and self.worldVerts:contains(ball.x, ball.y) then
			if self.radius > 10 then
				Instantiate(Asteroid(self.x, self.y, self.radius / 2))
				Instantiate(Asteroid(self.x, self.y, self.radius / 2))
			else
				-- If the last one has been destroyed, end this game/level
				local count = 0
				for k, obj in pairs(Game.objects.pool) do
					if obj.type == 'Asteroid' then
						count = count + 1
					end
				end

				if count == 1 then
					print('Game over')
				end
			end

			if love.math.random() > 0.8 then
				Instantiate(Powerup(self.x, self.y))
			end

			ball:reflect(self.r - math.pi/2)

			-- TODO add to score

			Instantiate(Particles(self.x, self.y))

			Game.objects:remove(self)
		end
	end
end

function Asteroid:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon('fill', self.worldVerts:unpack())

	love.graphics.setColor(255, 255, 255)

	love.graphics.polygon('line', self.worldVerts:unpack())
end

return Asteroid