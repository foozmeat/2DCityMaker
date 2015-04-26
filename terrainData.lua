tilemap = love.graphics.newImage("tilemap.png")
road = love.graphics.newQuad(0, 0, tileWidth, tileHeight, tilemap:getWidth(), tilemap:getHeight())
grass = love.graphics.newQuad(16, 0, tileWidth, tileHeight, tilemap:getWidth(), tilemap:getHeight())

meshWidth = 10
meshHeight = 11

--! COLISSION MASKS
COLLISION_MASK_GROUND = 1
COLLISION_MASK_ABOVE_GROUND = 2

--! DIRECTIONS
DIRECTION_C = 0
DIRECTION_N = 1
DIRECTION_S = 2
DIRECTION_E = 4
DIRECTION_W = 8
DIRECTION_NW = 9
DIRECTION_SW = 10
DIRECTION_SE = 6
DIRECTION_NE = 5

DIRECTION_NSW = 11
DIRECTION_NEW = 13
DIRECTION_NES = 7
DIRECTION_EWS = 14

DIRECTION_INW = 12
DIRECTION_ISW = 14
DIRECTION_ISE = 16
DIRECTION_INE = 18

OPPOSITE_DIRECTIONS = {
    [DIRECTION_NW] = DIRECTION_SE,
    [DIRECTION_N] = DIRECTION_S,
    [DIRECTION_NE] = DIRECTION_SW,
    [DIRECTION_W] = DIRECTION_E,
    [DIRECTION_C] = DIRECTION_C,
    [DIRECTION_E] = DIRECTION_W,
    [DIRECTION_SW] = DIRECTION_NE,
    [DIRECTION_S] = DIRECTION_N,
    [DIRECTION_SE] = DIRECTION_NW
}

INNER_CORNERS = {
    [DIRECTION_NW] = DIRECTION_INW,
    [DIRECTION_NE] = DIRECTION_INE,
    [DIRECTION_SW] = DIRECTION_ISW,
    [DIRECTION_SE] = DIRECTION_ISE
}

ROAD_DIRECTIONS = {
    [DIRECTION_NW] = DIRECTION_NE,
    [DIRECTION_N] = DIRECTION_E,
    [DIRECTION_NE] = DIRECTION_SE,
    [DIRECTION_W] = DIRECTION_N,
    [DIRECTION_C] = DIRECTION_C,
    [DIRECTION_E] = DIRECTION_S,
    [DIRECTION_SW] = DIRECTION_NW,
    [DIRECTION_S] = DIRECTION_W,
    [DIRECTION_SE] = DIRECTION_SW,
    [DIRECTION_INW] = DIRECTION_S,
    [DIRECTION_ISW] = DIRECTION_E,
    [DIRECTION_ISE] = DIRECTION_N,
    [DIRECTION_INE] = DIRECTION_W
}

ROAD_DIRECTION_ANGLES = {
    [DIRECTION_NW] = 135,
    [DIRECTION_N] = 90,
    [DIRECTION_NE] = 45,
    [DIRECTION_W] = 180,
    [DIRECTION_E] = 0,
    [DIRECTION_SW] = 225,
    [DIRECTION_S] = 270,
    [DIRECTION_SE] = 315
}


--! Orientations
ORIENTATION_NONE = 0
ORIENTATION_H = 1
ORIENTATION_V = 2

--! HIGH-LEVEL TYPES
BLANK = 0
ROAD = 1
CROSSWALK = 2
BUSH = 3
SIDEWALK = 4
BUILDING = 5
PARKTHING = 6
WINDOW = 7
DOOR = 8
ARROW = 9

STREET = 10
AVENUE = 11

BUILDING1 = 50
BUILDING1_ROOF = 51

BUILDING2 = 60
BUILDING2_ROOF = 61

BUILDING_ROOF_DECORATION = 70

--! Map Codes
TYPES = {
  [BLANK] = { [DIRECTION_C] = { image = grass, code = "."} },
  
  [ROAD] = {
    [DIRECTION_NW] = { image = road, code = " "},
    [DIRECTION_N] = { image = road, code = " "},
    [DIRECTION_NE] = { image = road, code = " "},
    [DIRECTION_W] = { image = road, code = " "},
    [DIRECTION_C] = { image = road, code = " "},
    [DIRECTION_E] = { image = road, code = " "},
    [DIRECTION_SW] = { image = road, code = " "},
    [DIRECTION_S] = { image = road, code = " "},
    [DIRECTION_SE] = { image = road, code = " "},
    [DIRECTION_NSW] = { image = road, code = " "},
    [DIRECTION_NEW] = { image = road, code = " "},
    [DIRECTION_NES] = { image = road, code = " "},
    [DIRECTION_EWS] = { image = road, code = " "}
  },
  
  [CROSSWALK] = {
    [ORIENTATION_H] = { image = 8, code = " "},
    [ORIENTATION_V] = { image = 18, code = " "}
  },
  
  [SIDEWALK] = {
    [DIRECTION_NW] = { image = 1, code = "/"},
    [DIRECTION_N] = { image = 2, code = "-"},
    [DIRECTION_NE] = { image = 3, code = "\\"},
    [DIRECTION_W] = { image = 11, code = "|"},
    [DIRECTION_C] = { image = 12, code = "."},
    [DIRECTION_E] = { image = 13, code = "|"},
    [DIRECTION_SW] = { image = 21, code = "\\"},
    [DIRECTION_S] = { image = 22, code = "-"},
    [DIRECTION_SE] = { image = 23, code = "/"},
    [DIRECTION_INW] = { image = 4, code = "/"},
    [DIRECTION_ISW] = { image = 14, code = "\\"},
    [DIRECTION_ISE] = { image = 15, code = "/"},
    [DIRECTION_INE] = { image = 5, code = "\\"}
  }
  
}