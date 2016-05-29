local Powerup = Class {
	type = 'Powerup'
}

function Powerup:init(x, y)
	Transform.init(self, x, y)

	-- Pick random powerup type
	self.kind = love.math.random(1, 5)

	self.color = {255, 255, 255, 255}

	self.radius = 1

	Timer.tween(0.4, self, {radius = 55}, 'in-out-quad', function()
		local grow, shrink
		grow = function()
			Timer.tween(1.5, self, {radius = 50}, 'in-out-quad', shrink)
		end
		shrink = function()
			Timer.tween(1.5, self, {radius = 55}, 'in-out-quad', grow)
		end
		grow()
	end)
end

function Powerup:collide()
	if not self.used and dist(Game.player.x, Game.player.y, self.x, self.y) < 100 then
		if self.kind == 1 then
			-- Spawn an extra ball
			Instantiate(Ball(self.x, self.y, love.math.random() * math.pi * 4 - math.pi * 2))
		elseif self.kind == 2 then
			-- Enlarge paddle
			Game.player.paddle.worldVerts:scale(1.5)
			Timer.after(10, function()
				Game.player.paddle.worldVerts:scale(0.75)
			end)
		elseif self.kind == 3 then
			-- Add a bunch of points to score
			Game.score = Game.score + 500 * Game.scoreMultiplier
		elseif self.kind == 4 then
			-- Add a score multiplier for a few seconds
			Game.scoreMultiplier = Game.scoreMultiplier * 2

			Timer.after(10, function()
				Game.scoreMultiplier = Game.scoreMultiplier / 2
			end)
		elseif self.kind == 5 then
			Game.lives = Game.lives + 1
		end

		local n = love.math.random(1, 2)
		love.audio.newSource('sound/pup' .. n .. '.wav', 'static'):play()

		self.used = true
		Timer.tween(0.2, self, {color = {255, 255, 255, 0}})
		Timer.tween(0.2, self, {radius = 100}, 'in-quad', function()
			Game.objects:remove(self)
		end)
	end
end

function Powerup:draw()
	-- TODO flashy animations and stuff
	love.graphics.setColor(self.color)
	love.graphics.circle('line', self.x, self.y, self.radius)

	if self.kind == 1 then
		love.graphics.circle('fill', self.x, self.y, self.radius / 10)
	elseif self.kind == 2 then
		love.graphics.rectangle('fill', self.x - self.radius/2, self.y - self.radius / 5, self.radius, self.radius/2)
	elseif self.kind == 3 then
		love.graphics.print('+500', self.x - 50, self.y - 25)
	elseif self.kind == 4 then
		love.graphics.print('x2', self.x - 25, self.y - 25)
	elseif self.kind == 5 then
		love.graphics.push()

		love.graphics.translate(self.x, self.y)
		love.graphics.scale(self.radius / 50)

		love.graphics.polygon('fill', Player.verts)

		love.graphics.pop()
	end
end

return Powerup