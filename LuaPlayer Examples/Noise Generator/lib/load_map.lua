
-- Function to convert values to positive numbers between 1 and 10 
local function convertValue(value)
  local positive = math.abs(value)
  local scaled = (positive * 9) + 1
  return math.ceil(scaled)
end

function loadMap(filename)
  local map = {}

  -- Open the file
  local file = io.open(filename, "rb")
  
  -- Read in the map
  for line in file:lines() do
      local row = {}
      for i in string.gmatch(line, "%d+%.?%d*") do
          table.insert(row, convertValue(i))
      end
      table.insert(map, row)
  end

  file:close()

  -- return map table: {x, y, value}
  return map
end

loadMap("map.csv")