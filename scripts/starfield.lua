local Starfield = Class {
	numStars = 50,
	maxSize = 3
}

function Starfield:init()
	self.canvas = love.graphics.newCanvas()

	love.graphics.setCanvas(self.canvas)

	for i=1, self.numStars do
		love.graphics.setPointSize(love.math.random(1, self.maxSize))
		love.graphics.points(love.math.random(0, Game.w), love.math.random(0, Game.h))
	end

	love.graphics.setCanvas()
end

function Starfield:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.canvas, -Game.w/2, -Game.h/2)
end

return Starfield