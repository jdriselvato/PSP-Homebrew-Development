--//## Set CPU speed
System.setCpuSpeed(333)

-- Player
playerSprite = Image.load("gfx/sprite.png")
player = {}
player.x = 16
player.y = 110

-- 0 = walkable tile
walkableTile = {
	sprite = Image.load("gfx/walkable.png"),
	width = 16,
	height = 16
}

-- 1 = wall
wallTile = {
	sprite = Image.load("gfx/wall.png"),
	width = 16,
	height = 16
}

-- 2 = water
waterTile = {
	sprite = Image.load("gfx/water.png"),
	width = 16,
	height = 16
}

-- 3 = tree
treeTile = {
	sprite = Image.load("gfx/tree.png"),
	width = 16,
	height = 16
}

-- Helpers

-- Define the size of your map in tiles
local mapWidth = 480
local mapHeight = 272

-- Function to load the map from a CSV file
map = {}
function loadMap(filename)
	-- Open the file
	local file = io.open(filename, "rb")
	
	-- Read in the data
	for line in file:lines() do
	    local row = {}
	    for i in string.gmatch(line, "%d+") do
	        table.insert(row, tonumber(i))
	    end
	    table.insert(map, row)
	end

	file:close()
end

function displayMap()

	local numRows = #map
	local numCols = #map[1]

	-- Iterate over each row and column
	for j = 1, numRows do
		for i = 1, numCols do
			local tileValue = map[j][i]
			local x = i - 1 -- arrays start at 1 in lua
			local y = j - 1 -- arrays start at 1 in lua

			if tileValue == 0 then
				screen:blit(x * walkableTile.width, y * walkableTile.height, walkableTile.sprite)

			elseif tileValue == 1 then
				screen:blit(x * wallTile.width, y * wallTile.height, wallTile.sprite)

			elseif tileValue == 2 then
				screen:blit(x * waterTile.width, y * waterTile.height, waterTile.sprite)

			elseif tileValue == 3 then
				screen:blit(x * treeTile.width, y * treeTile.height, treeTile.sprite)

			else
				screen:blit(player.x, player.y, playerSprite)
			end
		end
	end
end


--//## MAIN ##\\ --

-- Create a 2D array to represent your tile map
loadMap("map1.csv")

while not Controls.readPeek():start() do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	displayMap()

	screen:blit(player.x, player.y, playerSprite)

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks