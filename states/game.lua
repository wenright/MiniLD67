local Game = {}

function Game:enter()
	Game.w, Game.h = love.graphics.getDimensions()

	Game.level = 1

	Game.world = Physics.new(250)

	Game.spawnPlayer()
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

	love.graphics.print('Level ' .. Game.level)
end

-- Wrapper for adding objects to entity system
function Instantiate(obj)
	if obj.type == 'Ball' then
		return Game.balls:add(obj)
	else
		return Game.objects:add(obj)
	end
end

function Game.checkForWin()
	local count = 0
	for k, obj in pairs(Game.objects.pool) do
		if obj.type == 'Asteroid' then
			count = count + 1
		end
	end

	if count == 1 then
		Game.level = Game.level + 1
		Ball.speed = Ball.speed + 50

		Game.spawnPlayer()
	end
end

function Game.spawnPlayer()
	Game.objects = EntitySystem()
	Game.balls = EntitySystem()
	
	Game.player = Instantiate(Player())
	
	Instantiate(Ball(Game.player.x, Game.player.y - 100, Game.player.r))

	-- Spawn some asteroids
	for i = 1, 4 + Game.level do
		Instantiate(Asteroid())
	end
end

return Game