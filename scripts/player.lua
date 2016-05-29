local Player = Class {
	__includes = Transform,
	type = 'Player',
	rotationSpeed = 5,
	acceleration = 500,
	verts = {
		0,-25,
		20, 25,
		0, 10,
		-20, 25
	}
}

function Player:init()
	Transform.init(self, 0, 0, 40, 50)

	self.r = 0
	self.dr = 0

	self.color = {255, 255, 255}

	self.invincible = true
	local handler = Timer.every(0.5, function()
		self.color = {255, 255, 255, 0}

		Timer.after(0.25, function()
			self.color = {255, 255, 255, 255}
		end)
	end)

	Timer.after(3, function()
		self.invincible = false
		Timer.cancel(handler)
	end)

	self.paddle = Instantiate(Paddle())

	self.fireSound = love.audio.newSource('sound/noise1.wav', 'static')
	self.fire = self:newFire()
end

function Player:update(dt)
	--------------------------------------------------
	-- Update the position using the player's velocity
	Transform.update(self, dt)

	self.dr = 0

	-----------------------------------------------------------
	-- Take input from keyboard and apply a rotation or a force
	if love.keyboard.isDown('a', 'left') then
		self.dr = -self.rotationSpeed * dt
	end
	if love.keyboard.isDown('d', 'right') then
		self.dr = self.rotationSpeed * dt
	end

	self.r = self.r + self.dr
	self.worldVerts:rotate(self.dr)

	if love.keyboard.isDown('w', 'up') then
		self:applyForce(math.cos(self.r - math.pi/2) * self.acceleration * dt, math.sin(self.r - math.pi/2) * self.acceleration * dt)

		self.fire = self:newFire()
	else
		self.fire = nil
		self.fireSound:stop()
	end
end

function Player:collide()
	--------------------------------
	-- Check for collision with ball
	if not self.invincible then
		for k, ball in pairs(Game.balls.pool) do
			if self.worldVerts:contains(ball.x, ball.y) then
				Instantiate(Particles(self.x, self.y))

				local sound = self.fireSound
				Timer.after(1, function()
					if Game.lives > 0 then
						Game.lives = Game.lives - 1
						Game.player = Instantiate(Player())
					else
						Game.over = true

						Timer.after(4, function()
							Game.restart()
						end)
					end

					sound:stop()
				end)


				love.audio.newSource('sound/expl1.wav', 'static'):play()

				sound:stop()

				Game.objects:remove(self.paddle)
				Game.objects:remove(self)
			end
		end
	end
end

function Player:newFire()
	local fire = {-10, 0}
	local num_verts = 10
	for i = 1, num_verts, 2 do
		table.insert(fire, -5 + (10 / num_verts) * i)
		table.insert(fire, love.math.random(5, 25))
	end

	table.insert(fire, 10)
	table.insert(fire, 0)

	-- Play a fire sound

	if not self.fireSound:isPlaying() then
		self.fireSound:play()
	end

	return fire
end

function Player:attachBall(ball)
	self.paddle.attachedBall = ball	
	self.paddle.sticky = true
	ball.stuck = true
end

function Player:draw()
	-- Draw some fire if the player moved this frame
	if self.fire then
		love.graphics.push()

		love.graphics.translate(self.x, self.y)
		love.graphics.rotate(self.r)

		love.graphics.setColor(self.color)
		love.graphics.polygon('line', self.fire)

		love.graphics.pop()
	end

	love.graphics.setColor(0, 0, 0)
	self.worldVerts:draw('fill')

	love.graphics.setColor(self.color)
	self.worldVerts:draw('line')
end

return Player