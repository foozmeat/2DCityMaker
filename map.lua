Map = {}
Map.__index = Map

function Map:new(x, y, cols, rows)
  local self = MapRegion:new(x, y, cols, rows, {}, 0)

  self.islands = {}
  self.className = "Map"
  self.tiles = globalTerrainData
  self.tileCount = globalMapSize

  function self:initTiles()
    local mapIndex = 1
    for mapY=1,globalRows do
      for mapX=1,globalCols do
        
        -- init with default values then convert to a road
        globalTerrainData[mapIndex] = Terrain(globalTerrainData[mapIndex])
        globalTerrainData[mapIndex] = Road(globalTerrainData[mapIndex])
        globalTerrainData[mapIndex].index = mapIndex
        globalTerrainData[mapIndex].row = mapY
        globalTerrainData[mapIndex].col = mapX
        globalTerrainData[mapIndex].x = (mapX * tileWidth) - 16
        globalTerrainData[mapIndex].y = (mapY * tileHeight) - 16
  
  --         print(tostring(globalTerrainData[mapIndex]))
        -------
        mapIndex = mapIndex + 1
        
      end
    end
  end

  function self:buildBlocks()
    
    BSPNode:reset()
    
    -- Add the root BSP Node inset so there's a band of road around the perimeter
    root = BSPNode:new({x=1, y=1, cols=globalCols-LANE_WIDTH, rows=globalRows-LANE_WIDTH})
  
    root:buildTree()
    root:buildBlocks()
    
    -- fill in the blocks with grass
    for _,node in pairs(BSPNode._allNodes) do
      
      if node.block then
        indexes = node.block:tileIndexes()
        
        for _,index in pairs(indexes) do
          globalTerrainData[index] = Terrain(globalTerrainData[index])
        end
      end
    end
    
  end

  return self
  
end
  