require("lib/load_map")

--//## Set CPU speed
System.setCpuSpeed(333)

--// Helpers

local psp = {
	width = 480,
	height = 272
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

local needsMapUpdate = false
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