terrain_t = {
  type = BLANK,
  walkable = false,
  drivable = false,
  direction = DIRECTION_C,
  roadDirection = DIRECTION_C,
  floor = 1,
  index = 0,
  name = "Terrain",
  row = 0,
  col = 0,
  x = 0,
  y = 0,
  street = "",
  avenue = 0,
  address = 0,
  highlight = false
}

terrain_t.__index = terrain_t

function terrain_t:new()
  local self = setmetatable({}, terrain_t)

  function self:image()
    return TYPES[self.type][self.direction].image
  end

  function self:mapCode()
--     if isRoad(self) and self.avenue ~= 0 then
--       return self.avenue % 10
--     else
      return TYPES[self.type][self.direction].code
--     end
  end
  
  return self
end

-- setmetatable(terrain_t, mt)

function Terrain(t, direction)
  t.walkable = true
  t.drivable = false
  t.type = BLANK
  t.direction = direction or DIRECTION_C
  t.floor = 1
  t.name = "Terrain"
  return t
end

function Building(t, type)
  t.type = type or BUILDING1
  t.walkable = false
  t.drivable = false
  t.name = "Building"
  return t
end

function Sidewalk(t, direction)
  t.type = SIDEWALK
  t.walkable = true
  t.drivable = false
  t.name = "Sidewalk"
  t.direction = direction or DIRECTION_C
  return t
end

function Bush(t, direction)
  t.type = BUSH
  t.walkable = false
  t.drivable = false
  t.name = "Bush"
  t.direction = direction or DIRECTION_C
  return t
end

function Road(t, direction)
  t.type = ROAD
  t.drivable = true
  t.walkable = false
  t.direction = direction or DIRECTION_C
  t.name = "Road"
  return t
end

function Crosswalk(t, direction)
  t.type = CROSSWALK
  t.drivable = true
  t.walkable = true
  t.direction = direction or DIRECTION_C
  t.name = "Crosswalk"
  return t
end

function isRoad(t)
  return t.type == ROAD or t.type == CROSSWALK
end

function TerrainReverseDirection(t)
  if t.direction > 10 then return end
  t.direction = OPPOSITE_DIRECTIONS[t.direction]
end

function TerrainReverseRoadDirection(t)
  if t.roadDirection > 10 then return end
  t.roadDirection = OPPOSITE_DIRECTIONS[t.roadDirection]
end

function TerrainToString(self)
  local output = self.name .. " " .. self.index .. ": X: "..self.x.." Y: "..self.y.." Col: "..self.col.." Row: "..self.row
      
  if self:fullAddress() ~= "" then output = output .. " - " .. self:fullAddress() end
  if self.walkable then output = output .. " Walkable," end
  if self.drivable then 
    output = output .. " drivable,"
    output = output .. " Direction: " .. self.roadDirection
else
    output = output .. " Direction: " .. self.direction
  end
  return output
end

