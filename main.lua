--[[

Inspired by http://gamedevelopment.tutsplus.com/tutorials/how-to-use-bsp-trees-to-generate-game-maps--gamedev-12268

--]]

globalCols = 60
globalRows = 40
globalMapSize = globalCols * globalRows
globalTerrainData = {}
tileWidth = 16
tileHeight = 16
globalMap = {}

require "BSPNode"
require "TerrainData"
require "Terrain"
require "mapRegion"
require "map"

function love.load()
  rng = love.math.newRandomGenerator()
  rng:setSeed(os.time())
  
  windowHeight = globalRows * tileHeight
  windowWidth = globalCols * tileWidth
  
  love.window.setMode(windowWidth, windowHeight, {resizable=false, vsync=false})
  
  for i=1, globalMapSize do
    globalTerrainData[i] = terrain_t:new()
  end

  globalMap = Map:new(0, 0, globalCols, globalRows)
  
  globalMap:initTiles()
  globalMap:buildBlocks()
  
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