BSPNode = {}
BSPNode.__index = BSPNode 
BSPNode._allNodes = {}

-- Tune these values to suit your needs. They give fairly proportional blocks
LANE_WIDTH = 2
MIN_LEAF_SIZE = 3 * LANE_WIDTH
MAX_LEAF_SIZE = math.floor(math.min(globalCols,globalRows) / MIN_LEAF_SIZE)

function BSPNode:new(o)
  o = o or {}
  setmetatable(o, self)
  o.leftChild = nil
  o.rightChild = nil
  
  table.insert(BSPNode._allNodes, o)
  return o
end

function BSPNode:reset()
  BSPNode._allNodes = {}
end

function BSPNode:buildTree()
  didSplit = true

  -- Build the tree of BSPNodes
  while didSplit do
    didSplit = false
    for _,node in pairs(BSPNode._allNodes) do
      if not node.leftChild and not node.rightChild then
--       print(l)
        if node.cols > MAX_LEAF_SIZE or node.rows > MAX_LEAF_SIZE then
          if node:split() then
            table.insert(BSPNode._allNodes, node.leftChild)
            table.insert(BSPNode._allNodes, node.rightChild)
            didSplit = true
          end
        end
      end
    end
  end
  
end

function BSPNode:split()
  -- return if this room has already ben split
  if self.leftChild ~= nil or self.rightChild ~= nil then
    return false
  end
  
  splitH = rng:random() > 0.5
  
  if self.cols > self.rows and self.rows / self.cols >= 0.05 then
    splitH = false
    
  elseif self.rows > self.cols and self.cols / self.rows >= 0.05 then
    splitH = true
  end
  
  if splitH then splitDir = "H" else splitDir = "V" end
  
  maxSize = 0
  
  if splitH then maxSize = self.rows else maxSize = self.cols end
  maxSize = maxSize - MIN_LEAF_SIZE

  -- if the max is smaller than the min then this room can't be split
  if maxSize <= MIN_LEAF_SIZE then return false end
    
  split = rng:random(MIN_LEAF_SIZE, maxSize)
  
--   print("Split: " .. split)
  
  if splitH then
    self.leftChild = BSPNode:new({x=self.x, y=self.y, cols=self.cols, rows=split})
    self.rightChild = BSPNode:new({x=self.x, y=self.y + split, cols=self.cols, rows=self.rows - split})
  else
    self.leftChild = BSPNode:new({x=self.x, y=self.y, cols=split, rows=self.rows})
    self.rightChild = BSPNode:new({x=self.x + split, y=self.y, cols=self.cols - split, rows=self.rows})
  end
  
--   print("Left: " .. tostring(self.leftChild))
--   print("Right: " .. tostring(self.rightChild))

  return true

end

function BSPNode:buildBlocks()
  
  if self.leftChild ~= nil or self.rightChild ~= nil then

    if self.leftChild ~= nil then
      self.leftChild:buildBlocks()
    end

    if self.rightChild ~= nil then
      self.rightChild:buildBlocks()
    end
    
  else
    
    -- We've reached a leaf so create a block with this region
  self.block = BSPNode:new({x=self.x + LANE_WIDTH, y=self.y + LANE_WIDTH, cols=self.cols - LANE_WIDTH, rows=self.rows - LANE_WIDTH})
  end

end

function BSPNode:tileIndexes()

  indexes = {}

  for row=self.y, self.y + self.rows - 1 do
    for col=self.x, self.x + self.cols - 1 do
      --print("looking at " .. row .. "/" .. col)
      table.insert(indexes, (globalCols * (row - 1)) + col)
    end
  end
  
  return indexes

end
