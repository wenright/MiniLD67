local Game = {}

function Game:enter()
	Game.w, Game.h = love.graphics.getDimensions()

	Game.objects = EntitySystem()

	Game.player = Game.objects:add(Player())
	Game.ball = Game.objects:add(Ball(Game.player.x, Game.player.y, Game.player.r))

	-- TODO add asteroids
end

function Game:update(dt)
	Game.objects:update(dt)
end

function Game:draw()
	Camera:attach()
	Game.objects:draw(dt)
	Camera:detach()
end

return Game