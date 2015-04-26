--[[

Inspired by http://gamedevelopment.tutsplus.com/tutorials/how-to-use-bsp-trees-to-generate-game-maps--gamedev-12268

--]]

globalCols = 60
globalRows = 40
globalMapSize = globalCols * globalRows
globalTerrainData = {}
tileWidth = 16
tileHeight = 16

require "BSPNode"
require "TerrainData"
require "Terrain"

function love.load()
  rng = love.math.newRandomGenerator()
  rng:setSeed(os.time())
  
  for i=1, globalMapSize do
    globalTerrainData[i] = terrain_t:new()
  end
  
  buildMap()
end

function buildMap()


  windowHeight = globalRows * tileHeight
  windowWidth = globalCols * tileWidth
  
  love.window.setMode(windowWidth, windowHeight, {resizable=false, vsync=false})
  
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

function love.draw()

  tileIndex = 1
  for mapY=1,globalRows do
    for mapX=1,globalCols do
      local tile = globalTerrainData[tileIndex]
      
      love.graphics.draw(tilemap, globalTerrainData[tileIndex]:image(), tile.x, tile.y)
      tileIndex = tileIndex + 1

--       This will draw a grid over your map      
      love.graphics.rectangle("line", (mapX - 1) * tileWidth, (mapY - 1) * tileHeight, tileWidth, tileHeight)
    end
  end
end

function love.keypressed(key)
   if key == "r" then
      buildMap()
   elseif key == "q" then
      love.event.quit()
   end
end