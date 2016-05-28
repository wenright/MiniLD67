local Game = {}

function Game:enter()
	Game.objects = EntitySystem()

	Game.objects:add(Player())
	Game.objects:add(Ball())

	-- TODO add asteroids
end

function Game:update(dt)
	Game.objects:update(dt)
end

function Game:draw()
	Game.objects:draw(dt)
end

return Game