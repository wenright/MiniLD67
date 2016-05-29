local Transform = Class {}

function Transform:init(x, y, w, h)
	self.x = x or 0
	self.y = y or 0

	self.w = w or 1
	self.h = h or 1

	self.vx, self.vy = 0, 0

	if self.verts then
		self.worldVerts = Polygon(unpack(self.verts))
	end
end

function Transform:applyForce(dx, dy)
	self.vx = self.vx + dx or 0
	self.vy = self.vy + dy or 0
end

function Transform:update(dt)
	if self.worldVerts then
		self.worldVerts:move(self.vx * dt, self.vy * dt)

		local x1, y1, x2, y2 = self.worldVerts:bbox()

		-- TODO move accross a little less so less teleporting
		if x2 < -Game.w / 2 then
			self.worldVerts:move(Game.w, 0)
		elseif x1 > Game.w / 2 then
			self.worldVerts:move(-Game.w, 0)
		end

		if y2 < -Game.h / 2 then
			self.worldVerts:move(0, Game.h)
		elseif y1 > Game.h / 2 then
			self.worldVerts:move(0, -Game.h)
		end

		self.x, self.y = self.worldVerts.centroid.x, self.worldVerts.centroid.y
	else
		self.x = self.x + self.vx * dt
		self.y = self.y + self.vy * dt

		if self.x + self.w < -Game.w / 2 then
			self.x = Game.w / 2
		elseif self.x > Game.w / 2 then
			self.x = -Game.w / 2
		end

		if self.y + self.h < -Game.h / 2 then
			self.y = Game.h / 2
		elseif self.y > Game.h / 2 then
			self.y = -Game.h / 2
		end
	end
end

function Transform:reflect(r)
	local v = Vector.new(self.vx, self.vy)
	local n = Vector.new(math.cos(r), math.sin(r))
	local u = ((v * n) / (n * n)) * n
	local w = v - u
	self.vx, self.vy = (w - u):unpack()

	if self.type == 'Ball' then
		self.size = 10
		Timer.tween(1, self, {size = 4}, 'in-bounce', function() self.size = 4 end)
	end
end

return Transform