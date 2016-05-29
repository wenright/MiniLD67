local Asteroid = Class {
	__includes = Transform,
	type = 'Asteroid',
	maxRadius = 25,
	maxSpeed = 100
}

function Asteroid:init(x, y, radius)
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
	-- for k, ball in pairs(Game.balls.pool) do
		-- if self.canCollide and self.worldVerts:contains(ball.x, ball.y) then
	for shape, delta in pairs(Game.world:collisions(self.worldVerts)) do
		if self.canCollide and shape.parent.type == 'Ball' then
			if self.radius == self.maxRadius then
				Instantiate(Asteroid(self.x, self.y, self.radius / 2))
				Instantiate(Asteroid(self.x, self.y, self.radius / 2))
			else
				-- If the last one has been destroyed, end this game/level
				Game.checkForWin()
			end

			if love.math.random() > 0.6 then
				Instantiate(Powerup(self.x, self.y))
			end

			shape.parent:reflect(self.r - math.pi/2)

			-- TODO add to score
			Game.score = Game.score + math.floor(1000 * (1 / self.radius)) * Game.scoreMultiplier

			Instantiate(Particles(self.x, self.y))

			-- Play a random explosion sound
			local n = love.math.random(1, 3)
			love.audio.newSource('sound/astr' .. n .. '.wav', 'static'):play()

			Game.objects:remove(self)
		end
	end
end

function Asteroid:draw()
	love.graphics.setColor(0, 0, 0)
	self.worldVerts:draw('fill')

	love.graphics.setColor(255, 255, 255)
	self.worldVerts:draw('line')
end

return Asteroid