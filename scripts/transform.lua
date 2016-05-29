local Transform = Class {}

function Transform:init(x, y, w, h)
	self.x = x or 0
	self.y = y or 0

	self.w = w or 1
	self.h = h or 1

	self.vx, self.vy = 0, 0

	if self.verts then
		self.worldVerts = Game.world:polygon(unpack(self.verts))
		self.worldVerts.parent = self
	end
end

function Transform:applyForce(dx, dy)
	self.vx = self.vx + dx or 0
	self.vy = self.vy + dy or 0
end

function Transform:update(dt)
	self.worldVerts:move(self.vx * dt, self.vy * dt)
	self.x, self.y = self.worldVerts:center()

	local x1, y1, x2, y2 = self.worldVerts:bbox()

	-- TODO move accross a little less so less teleporting
	if not self.stuck then
		if x2 < -Game.w / 2 then
			self.worldVerts:move(Game.w + self.w, 0)
		elseif x1 > Game.w / 2 then
			self.worldVerts:move(-Game.w - self.w, 0)
		end

		if y2 < -Game.h / 2 then
			self.worldVerts:move(0, Game.h + self.h or self.w)
		elseif y1 > Game.h / 2 then
			self.worldVerts:move(0, -Game.h - self.h or self.w)
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
		if self.timer then
			Timer.cancel(self.timer)
		end

		self.size = 10
		self.timer = Timer.tween(1, self, {size = 4}, 'in-bounce')
	end
end

return Transform