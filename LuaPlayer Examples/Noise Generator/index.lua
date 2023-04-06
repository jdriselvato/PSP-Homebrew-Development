require("lib/load_map")

--//## Set CPU speed
System.setCpuSpeed(333)

--// Helpers

local numberColor = {
  [1] = Color.new(10,203,20),
  [2] = Color.new(50,23,20),
  [3] = Color.new(20,43,20),
  [4] = Color.new(25,43,20),
  [5] = Color.new(50,3,20),
  [6] = Color.new(94,100,20),
  [7] = Color.new(49,130,20),
  [8] = Color.new(43,1,20),
  [9] = Color.new(88,2,50),
  [10] = Color.new(40,40,20),
}

local block_size = {
	width = 4,
	height = 4
}

-- Function to load the map from a CSV file
local map = loadMap("./maps/map.csv")

function displayMap()
	local numRows = #map
	local numCols = #map[1]

	-- Iterate over each row and column
	for j = 1, numRows do
		for i = 1, numCols do
			local tileValue = map[j][i]
			screen:fillRect(
				block_size.width * (j-1), block_size.height * (i-1),  -- x & y
				block_size.width,  -- width
				block_size.height, -- height
				Color.new(
					tileValue * (255/10),
					tileValue * (255/10),
					tileValue * (255/10)
				)
			)
		end
	end
end

--//## MAIN ##\\ --

while not Controls.readPeek():start() do
	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	displayMap()

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks