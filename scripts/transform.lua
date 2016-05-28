local Transform = Class {}

function Transform:init(x, y, w, h)
	self.x = x or 0
	self.y = y or 0

	self.w = w or 1
	self.h = h or 1

	self.vx, self.vy = 0, 0

	if self.verts then
		self.worldVerts = Class.clone(self.verts)
	end
end

function Transform:applyForce(dx, dy)
	self.vx = self.vx + dx or 0
	self.vy = self.vy + dy or 0
end

function Transform:update(dt)
	self.x = self.x + self.vx
	self.y = self.y + self.vy

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

function Transform:translateVertices()
	------------------------------------------------------------
	-- Update vertices from template into real world coordinates

	-- Just some helpers for trig functions
	local cos, sin = math.cos(self.r), math.sin(self.r)

	-- Rotate vertices
	for i=1, #self.worldVerts, 2 do
		self.worldVerts[i] = self.verts[i] * cos - self.verts[i + 1] * sin
		self.worldVerts[i + 1] = self.verts[i] * sin + self.verts[i + 1] * cos
	end

	-- Translate vertices
	for i=1, #self.worldVerts, 2 do
		self.worldVerts[i] = self.worldVerts[i] + self.x
		self.worldVerts[i + 1] = self.worldVerts[i + 1] + self.y
	end
end

function Transform:reflect(r)
	local v = Vector.new(self.vx, self.vy)
	local n = Vector.new(math.cos(r), math.sin(r))
	local u = ((v * n) / (n * n)) * n
	local w = v - u
	self.vx, self.vy = (w - u):unpack()
end

return Transform