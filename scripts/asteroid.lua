local Asteroid = Class {
	__includes = Transform
}

function Asteroid:init()
	-- TODO generate asteroid
	local x, y = 0, 0

	Transform.init(self, x, y)
end

function Asteroid:update(dt)
	Transform.update(self, dt)
end

function Asteroid:draw()

end

return Asteroid