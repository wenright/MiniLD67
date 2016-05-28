Gamestate = require 'lib.hump.gamestate'
Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
Camera = require 'lib.hump.camera'
Gamestate = require 'lib.hump.gamestate'

EntitySystem = require 'scripts.entitysystem'
Player = require 'scripts.player'

Game = require 'states.game'

function love.load()

end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end