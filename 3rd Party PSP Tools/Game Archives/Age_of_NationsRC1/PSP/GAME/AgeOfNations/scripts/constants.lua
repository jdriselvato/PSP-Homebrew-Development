--[[	AoN Game Engine 
		Game Engine Constants Definition File
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 25/07/2010
	]]
 

--Basic Colors
WHITE=Color.new(255,255,255)
RED=Color.new(255,0,0)
GREEN=Color.new(0,255,0)
BLUE=Color.new(0,0,255)
YELLOW=Color.new(255,255,0)
BLACK=Color.new(0,0,0)
GRAY=Color.new(192,192,192)
BROWN =Color.new(111,54,24)

--Screen Dimensions (for Sony's PSP Screen)
SCREEN_WIDTH = 480
SCREEN_HEIGHT = 272

--WORLD SIZE (defines Game map Size)
WORLD_SIZE_X = SCREEN_WIDTH*3
WORLD_SIZE_Y = SCREEN_HEIGHT*4

--Minimap Size
MINIMAP_WIDTH = 100
MINIMAP_HEIGHT = 100

--Map Cells Size (squares for Pathfinding A*)
GRID_WIDTH = 30
GRID_HEIGHT = 30

--Resources Default stock
DEF_STOCK = {}
	DEF_STOCK['Food']=100
	DEF_STOCK['Wood']=200
	DEF_STOCK['Stone']=150
	DEF_STOCK['Gold']=75

--Resources Health bar dimensions
MAX_HEALTH_BAR_LENGTH = 30
MAX_HEALTH_BAR_HEIGHT = 1
	
--Map scrolling speed
SCROLL = 5

--Units Constants
UNIT_MAX_HEALTH = {}
	UNIT_MAX_HEALTH["Peasant"] = 50
	UNIT_MAX_HEALTH["Soldier"] = 80
	UNIT_MAX_HEALTH["Bowman"] = 75
	UNIT_MAX_HEALTH["Horseman"] = 100
	UNIT_MAX_HEALTH["Priest"] = 75

UNIT_DEFAULT_SPEED = {}
	UNIT_DEFAULT_SPEED["Peasant"] = 5/2
	UNIT_DEFAULT_SPEED["Soldier"] = 5/2
	UNIT_DEFAULT_SPEED["Bowman"] = 5/2
	UNIT_DEFAULT_SPEED["Horseman"] = 5/2
	UNIT_DEFAULT_SPEED["Priest"] = 5/2
	
DEFAULT_ATK = 5
	
PEASANT_GATHER_RESOURCE_DEFAULT = 5/2 
PEASANT_REPAIR_UPVALUE = 10
PEASANT_REPAIR_COST = 1	

MAX_UNIT_HEALTH_BAR_LENGTH = 20
MAX_UNIT_HEALTH_BAR_HEIGHT = 1


--Builds Constants
BUILD_DEFAULT_HEALTH = {}
	BUILD_DEFAULT_HEALTH["House"] = 100
	BUILD_DEFAULT_HEALTH["Barrack"] = 200
	BUILD_DEFAULT_HEALTH["TownCenter"] = 175
	BUILD_DEFAULT_HEALTH["Stable"] = 175
	--BUILD_DEFAULT_HEALTH["Market"] = 150
	BUILD_DEFAULT_HEALTH["Temple"] = 250
	BUILD_DEFAULT_HEALTH["Tower"] = 75

BUILD_BOUNDARIES={}
	BUILD_BOUNDARIES["House"]={w = 1,h = 1}
	BUILD_BOUNDARIES["Barrack"]={w = 3,h = 2}
	--BUILD_BOUNDARIES["Market"]={w = 3,h = 2}
	BUILD_BOUNDARIES["Stable"]={w = 3,h = 2}
	BUILD_BOUNDARIES["TownCenter"]={w = 2,h = 2}
	BUILD_BOUNDARIES["Temple"]={w = 3,h = 3}
	BUILD_BOUNDARIES["Tower"]={w = 1,h = 2}
	
BUILD_MAX_HEALTH_BAR_LENGTH = 30
BUILD_MAX_HEALTH_BAR_HEIGHT = 1

---Costs in Terms of Resources
COST = {}
COST["House"] = {Wood = 50}
COST["Barrack"] = {Wood = 150}
COST["TownCenter"] = {Wood = 400}
COST["Stable"] = {Wood = 200, Stone = 75}
--COST["Market"] = {Wood = 175}
COST["Temple"] = {Wood = 250, Stone = 100, Gold = 100}
COST["Tower"] = {Wood = 100, Stone = 100}
COST["Peasant"] = {Food = 75}
COST["Soldier"] = {Food = 75, Wood = 50}
COST["Bowman"] = {Food = 75, Wood = 75}
COST["Horseman"] = {Food = 125, Wood = 50, Stone = 50}
COST["Priest"] = {Food = 50, Gold = 100}
COST["Update Soldier"] = {Food = 50, Wood = 100}
COST["Update Bowman"] = {Food = 75, Wood = 100, Stone = 25}
COST["Update Horseman"] = {Food = 100, Wood = 100, Stone = 100}

--Timers for Units Creation
MAX_CREATION_BAR_LENGTH = 100
MAX_CREATION_BAR_HEIGHT= 2

CREATE_TIMER_SPEED = 0.5
CREATE_TIMER_MAX = {}
	CREATE_TIMER_MAX["TownCenter"]=100
	CREATE_TIMER_MAX["Barrack"]=150
	CREATE_TIMER_MAX["Stable"]=150
	CREATE_TIMER_MAX["Temple"]=200
	--CREATE_TIMER_MAX["Market"]=500
	
	
--Ages Update Constants
AGE_UPDATE_PROGRESS = 0.1
AGES_COST = {}
	--AGES_COST[1] = {Food = 200, Wood = 200, Stone = 0, Gold = 0,timer = 500}
	AGES_COST[2] = {Food = 200, Wood = 150 , Stone = 0 , Gold = 0}
	AGES_COST[3] = {Food = 300, Wood = 200 , Stone = 100, Gold = 100}

COST["Age2"] = AGES_COST[2]
COST["Age3"] = AGES_COST[3]