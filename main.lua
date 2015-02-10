--[[

Inspired by http://gamedevelopment.tutsplus.com/tutorials/how-to-use-bsp-trees-to-generate-game-maps--gamedev-12268

--]]

globalCols = 80
globalRows = 50

require "BSPNode"

function love.load()
  rng = love.math.newRandomGenerator()
  rng:setSeed(os.time())
  buildMap()
end

function buildMap()

  tileWidth = 15
  tileHeight = 15

  windowHeight = globalRows * tileHeight
  windowWidth = globalCols * tileWidth
  
  love.window.setMode(windowWidth, windowHeight, {resizable=false, vsync=false})

  tilemap = love.graphics.newImage("tilemap.png")
  road = love.graphics.newQuad(0, 0, tileWidth, tileHeight, tilemap:getWidth(), tilemap:getHeight())
  grass = love.graphics.newQuad(30, 0, tileWidth, tileHeight, tilemap:getWidth(), tilemap:getHeight())

  GlobalMap = {}
  
    -- make a full map of road tiles
  for index=1,globalRows*globalCols do
    table.insert(GlobalMap, road)
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
        GlobalMap[index] = grass
      end
    end
  end

end

function love.draw()

  tileIndex = 1
  for mapY=1,globalRows do
    for mapX=1,globalCols do
      love.graphics.draw(tilemap, GlobalMap[tileIndex], (mapX - 1) * tileWidth, (mapY - 1) * tileHeight)
      tileIndex = tileIndex + 1

--       This will draw a grid over your map      
--       love.graphics.rectangle("line", (mapX - 1) * tileWidth, (mapY - 1) * tileHeight, tileWidth, tileHeight)
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