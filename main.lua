Gamestate = require 'lib.hump.gamestate'
Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
Camera = require 'lib.hump.camera'
Gamestate = require 'lib.hump.gamestate'

EntitySystem = require 'scripts.entitysystem'
Player = require 'scripts.player'
Asteroid = require 'scripts.asteroid'
Ball = require 'scripts.ball'

Game = require 'states.game'

function love.load()
	io.stdout:setvbuf('no')

	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end