local Game = {}

function Game:enter()
	Game.w, Game.h = love.graphics.getDimensions()

	Game.objects = EntitySystem()
	Game.balls = EntitySystem()

	Game.player = Instantiate(Player())
	
	Instantiate(Ball(Game.player.x, Game.player.y - 100, Game.player.r))

	-- Spawn some asteroids
	for i = 1, 5 do
		Instantiate(Asteroid())
	end
end

function Game:update(dt)
	Game.objects:update(dt)
	Game.balls:update(dt)
end

function Game:draw()
	Camera:attach()

	Game.objects:draw(dt)
	Game.balls:draw(dt)

	Camera:detach()
end

-- Wrapper for adding objects to entity system
function Instantiate(obj)
	if obj.type == 'Ball' then
		return Game.balls:add(obj)
	else
		return Game.objects:add(obj)
	end
end

return Game