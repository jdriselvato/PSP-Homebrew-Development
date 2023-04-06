--[[	AoN Game Engine 
		Game Engine Core Definition
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 18/08/2010
	]]

--Engine Set	
Engine = {}

--Sets the game language
Engine.setLocale = function()
	pcall(dofile,'./playerdata/locale.lua')
	pcall(dofile,'./playerdata/locale/'..Engine.locale..'.LOCALE')
end

--Runs Intro Animation
Engine.runIntro = function()
	local image = Image.load('./Images/splash/neocomp2010.png')
	AlphaBlit(image)	
end

--Inits Engine
Engine.init = function()
dofile 'scripts/constants.Lua'
dofile 'scripts/functions.lua'
dofile 'scripts/loader.lua'
dofile 'scripts/pathfinding.lua'

dofile 'scripts/classes/AgeClass.class'
dofile 'playerdata/profile.lua'

dofile 'scripts/classes/IconClass.class'
dofile 'scripts/classes/CursorClass.class'
dofile 'scripts/classes/MapClass.class'
dofile 'scripts/classes/ResourceClass.class'
dofile 'scripts/classes/BuildClass.class'
dofile 'scripts/classes/UnitClass.class'
end

--Sets global vars
Engine.setGlobalData = function()
	map = Map:new(WORLD_SIZE_X,WORLD_SIZE_Y)
	mmap = Minimap:new()
	grid = Collide:new(WORLD_SIZE_X,WORLD_SIZE_Y)
	cursor = Mouse:init{}
	Resource.init{food = 10, gold = 2,stone = 4,wood = 10}
end

--Loads a campain file
Engine.loadCampaign = function(CpnPath)
	pcall(dofile,CpnPath)
end

--Returns the current gamestate
Engine.run = function(GameState)
	return GameState[current_game_state]
end

--Run previously loaded campaign
Engine.runCampaign = function(key,oldkey,cursor)
	map:draw(key)
	drawResources(key,oldkey)
	drawBuilds(key,oldkey)
	drawUnits(key,oldkey)
	playerRes.drawTopBoard()
	mmap:draw(key,oldkey,cursor)
	cursor:draw(key,oldkey)
	runDemo(key, oldkey)
	--print(10,30,tostring(os.getenv('os')))
end

--Some stuff to override LuaForWindows exceptions on System funcs and Mp3me funcs
--[[
System = {}
function System.buttonPressed(val)
	if val == 1 then return 'yes'
	else return 'no'
	end
end

function System.message(text)
	while not Controls.read():start() do
	screen:clear()
	print(10,0,text)
	swapBuffers()
	end
end

Mp3me = {}
function Mp3me.load(media)
	Mp3.load(media)
end

function Mp3me.play()
	Mp3.play()
end

function Mp3me.stop()
	Mp3.stop()
end

--]]
