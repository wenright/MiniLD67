local Particles = Class {}

function Particles:init(x, y)
	self.system = EntitySystem()
	for i = 1, love.math.random(9, 13) do
		self.system:add(Particle(x, y))
	end

	Timer.after(0.5, function() Game.objects:remove(self) end)
end

function Particles:update(dt)
	self.system:update(dt)
end

function Particles:draw()
	self.system:draw()
end

return Particles