local World = Class {}

function World:init()
	self.world = love.physics.newWorld(0, 0, true)
	self.world:setCallbacks(onBeginCollision, onEndCollision, nil, onCollision)
end

function World:update(dt) self.world:update(dt) end
function World:draw() end

function World:addRectangle(x, y, w, h, obj)
	local body = love.physics.newBody(self.world, x, y, 'dynamic')
	local shape = love.physics.newRectangleShape(w/2, h/2, w, h)
	local fixture = love.physics.newFixture(body, shape, 0.01)
	fixture:setUserData(obj)
	return body, shape, fixture
end

function World:addPolygon(verts, obj)
	local body = love.physics.newBody(self.world, x, y, 'dynamic')
	local shape = love.physics.newPolygonShape(verts)
	local fixture = love.physics.newFixture(body, shape, 0.01)
	fixture:setUserData(obj)
	return body, shape, fixture
end

function World:drawBody(body, shape)
	love.graphics.setColor(255, 0, 0)
	love.graphics.polygon('line', body:getWorldPoints(shape:getPoints()))
end

function onBeginCollision(a, b, collision)
	local aud, bud = a:getUserData(), b:getUserData()
	if aud and aud.onBeginCollision then aud:onBeginCollision(bud, collision) end
	if bud and bud.onBeginCollision then bud:onBeginCollision(aud, collision) end
end

function onEndCollision(a, b, collision)
	local aud, bud = a:getUserData(), b:getUserData()
	if aud and aud.onEndCollision then aud:onEndCollision(bud, collision) end
	if bud and bud.onEndCollision then bud:onEndCollision(aud, collision) end
end

-- Called each frame that a collision occurs
function onCollision(a, b, collision)
	local aud, bud = a:getUserData(), b:getUserData()
	if aud and aud.onCollision then aud:onCollision(bud, collision) end
	if bud and bud.onCollision then bud:onCollision(aud, collision) end
end

return World