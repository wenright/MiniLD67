Gamestate = require 'lib.hump.gamestate'
Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
Camera = require 'lib.hump.camera'(0, 0)
Gamestate = require 'lib.hump.gamestate'

EntitySystem = require 'scripts.entitysystem'
Transform = require 'scripts.transform'
Player = require 'scripts.player'
Asteroid = require 'scripts.asteroid'
Ball = require 'scripts.ball'

Game = require 'states.game'

function love.load()
	io.stdout:setvbuf('no')

	Gamestate.registerEvents()
	Gamestate.switch(Game)

	love.graphics.setPointSize(4)
end

function love.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.print(love.timer.getFPS())
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end