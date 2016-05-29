local Game = {}

function Game:enter()
	Game.w, Game.h = love.graphics.getDimensions()

	Game.level = 1
	Game.lives = 3

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

	for i = 1, Game.lives do
		love.graphics.push()

		love.graphics.scale(0.5)
		love.graphics.translate(love.graphics.getWidth() * 2 - 50 * i, 50)

		love.graphics.polygon('line', Player.verts)

		love.graphics.pop()
	end

	if Game.over then
		love.graphics.printf('Game over!', 0, love.graphics.getHeight()/2, love.graphics.getWidth(), 'center')
	end
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
		Timer.after(1, function()
			Game.level = Game.level + 1
			Ball.speed = Ball.speed + 50

			Game.spawnPlayer()
		end)
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