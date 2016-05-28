local EntitySystem = Class {
	init = function(self) end,
	pool = {}
}

function EntitySystem:add(e)
	table.insert(self.pool, e)
	return e
end

function EntitySystem:remove(e)
	if e.body and not e.body:isDestroyed() then
		e.body:destroy()
	end

	for key, entity in pairs(self.pool) do
		if entity == e then
			self.pool[key] = nil
			return true
		end
	end
	return false
end

function EntitySystem:loop(func, ...)
	for key, entity in pairs(self.pool) do entity[func](entity, ...) end
end

function EntitySystem:update(dt)
	self:loop('update', dt)
end

function EntitySystem:draw()
	self:loop('draw')
end

return EntitySystem
