MapRegion = {}
MapRegion.__index = MapRegion

function MapRegion:new(x, y, cols, rows, incomingTiles, tileCount)
  local self = setmetatable({}, MapRegion)
  
  incomingTiles = incomingTiles or {}
  tileCount = tileCount or 0
  
  self.x = x
  self.y = y
  self.rows = rows
  self.cols = cols
  self.className = "MapRegion"
  self.tileIndexes = {}

  if self.rows <= 0 then self.rows = 1 end
  if self.cols <= 0 then self.cols = 1 end

  local newTiles = {}
  
  -- reduce the included tileset to only those that fit within our rect
  local rowMin = self.y
  local rowMax = self.y + self.rows - 1
  local colMin = self.x
  local colMax = self.x + self.cols - 1
  
  if tileCount > 0 then
    for i=1,tileCount do

      local t = incomingTiles[i]
      
--       if not t then
--         tprint(self.tiles)
--       end
      
      if t.row >= rowMin and 
      t.row <= rowMax and 
      t.col >= colMin and 
      t.col <= colMax then
        newTiles[#newTiles+1] = t
        self.tileIndexes[#self.tileIndexes+1] = t.index
      end
      
    end
  end
  
  self.tiles = newTiles
  self.tileCount = #newTiles

  function self:rect()
    return {x=(self.x - 1) * tileWidth, y=(self.y - 1) * tileHeight, width=self.cols * tileWidth, height=self.rows * tileHeight}
  end
  
  function self:indexForCoordinates(row, col)
    return (self.cols * (row - 1)) + col
  end
  
  function self:intersectsRegion(region)
  
    local intersects = false
    
    if self.x + self.cols - 1 >= region.x or
       region.x + region.cols - 1 <= self.x or
       self.y + self.rows - 1 >= region.y or
       region.y + region.rows - 1 <= self.y then
         
       intersects = true  
    end
  
    return intersects
  end
  
  function self:directionForCoordinates(x, y)
  
    if y == 1 then
      if x == 1 then
        return DIRECTION_NW
      elseif x == self.cols then
        return DIRECTION_NE
      else
        return DIRECTION_N
      end
    
    elseif y < self.rows then
      if x == 1 then
        return DIRECTION_W
      elseif x == self.cols then
        return DIRECTION_E
      else
        return DIRECTION_C
      end
  
    elseif y == self.rows then
      if x == 1 then
        return DIRECTION_SW
      elseif x == self.cols then
        return DIRECTION_SE
      else
        return DIRECTION_S
      end
    end
  
  end
  
  function self:edgeTilesWithDirections()
    local edges = {}
    local directions = {}
    
    local row = 1
    local col = 1
  
    for i=1, self.tileCount do
      
      local isEdge = false
      local t = self.tiles[i]
  
      -- top/bottom
      if row == 1 or row == self.rows or col == 1 or col == self.cols then
        isEdge = true
      end
      
      if isEdge then
  --       print("T: " .. t .. " Col: " .. col .. " Row: " .. row)
        directions[#directions + 1] = self:directionForCoordinates(col, row)
        edges[#edges+1] = t
      end
            
      col = col + 1
      if col > self.cols then
        col = 1
        row = row + 1
      end
      
    end
    
    return edges,directions
  
  end
  
  return self
end


function MapRegion:__tostring()
  return self.className .. ": X: "..self.x.." Y: "..self.y.." Cols: "..self.cols.." Rows: "..self.rows .. " Tile Count: " .. #self.tiles
end
