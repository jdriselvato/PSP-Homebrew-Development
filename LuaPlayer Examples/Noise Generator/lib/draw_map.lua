-- for debugging map to terminal

local colors = require 'ansicolors'
require("load_map")

local numberColor = {
  [1] = "%{greenbg}",
  [2] = "%{green}",
  [3] = "%{blackbg}",
  [4] = "%{redbg}",
  [5] = "%{bluebg}",
  [6] = "%{magentabg}",
  [7] = "%{cyanbg}",
  [8] = "%{magenta}",
  [9] = "%{yellowbg}",
  [10] = "%{white}",
}

-- Print the map
local map = loadMap("map.csv")

local numRows = #map
local numCols = #map[1]

-- Iterate over each row and column
for i = 1, numCols do
	local line = ""
	for j = 1, numRows do
		local tileValue = map[j][i]
		local color = numberColor[tileValue]
		line = line..colors(color..tileValue..'%{reset}')
	end
	print(line)
end

