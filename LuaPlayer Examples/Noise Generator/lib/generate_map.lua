-- generates an with numbers -1 to 0

require("perlin_noise")

map_size = {
	width = 480,
	height = 272
}

-- Block template
block_size = {
	width = 16,
	height = 16
}

-- Define the grid size
local rows = map_size.width / block_size.width
local cols = map_size.height / block_size.height

-- Define the scale of the noise
local scale = 0.5

-- Define the output file name
local filename = "map.csv"

-- Open the output file for writing
local file = assert(io.open(filename, "w"))

-- Generate and write the Perlin noise values for each point in the grid
for i = 1, rows do
  for j = 1, cols do
    local x = i * scale
    local y = j * scale
    local value = perlin_noise_2d(x, y)

    -- write the value to the csv
    file:write(string.format("%f", value))

    -- only add comma between numbers but not the last
    if j < cols then
    	file:write(",")
    end
  end

  -- new line on each i
  file:write("\n")
end

-- Close the output file
file:close()
