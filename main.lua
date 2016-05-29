Gamestate = require 'lib.hump.gamestate'
Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
Camera = require 'lib.hump.camera'(0, 0)
Gamestate = require 'lib.hump.gamestate'
Vector = require 'lib.hump.vector'

EntitySystem = require 'scripts.entitysystem'
Transform = require 'scripts.transform'
Player = require 'scripts.player'
Paddle = require 'scripts.paddle'
Asteroid = require 'scripts.asteroid'
Ball = require 'scripts.ball'
Powerup = require 'scripts.powerup'

Particles = require 'scripts.particles'
Particle = require 'scripts.particle'

Game = require 'states.game'

require 'scripts.collisions'

function love.load()
	io.stdout:setvbuf('no')

	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

function love.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.print(love.timer.getFPS())
end

function love.update(dt)
	Timer.update(dt)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end