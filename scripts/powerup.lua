local Powerup = Class {
	type = 'Powerup'
}

function Powerup:init(x, y)
	Transform.init(self, x, y)

	-- TODO pick random powerup type
	self.kind = love.math.random(1, 2)

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
			Instantiate(Ball(self.x, self.y, love.math.random() * math.pi * 4 - math.pi * 2))
		elseif self.kind == 2 then
			Game.player.paddle.worldVerts:scale(1.5)
			Timer.after(10, function()
				Game.player.paddle.worldVerts:scale(0.75)
			end)
		end

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
	end
end

return Powerup