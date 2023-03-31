dofile("LuaPBPLib.lua")


-- index.lua
local filepath = arg[1] -- Get the file path from the command line argument
local icon0Filepath = arg[2] -- Get the icon0 that'll be be use to patch on the EBOOT

-- Get the directory path and the file name from the file path
local dirpath = string.match(filepath, "(.-)[\\/][^\\/]-$")
local filename = string.match(filepath, "[\\/]?([^\\/]-)$")
local icon0Filename = string.match(icon0Filepath, "[\\/]?([^\\/]-)$")


-- EBOOT helpers

local data = {"","","",""}

function loadEboot(filename)
	eboot, error = getEboot(filename)
	if eboot ~= nil then
	  data[1] = filename
	  data[2] = eboot.name
	  data[3] = eboot.icon0 == nil and "" or "Icon0"
	  data[4] = eboot.pic1 == nil and "" or "Pic1"
	  icon0 = nil
	  pic1 = nil
	else
	  print(error)
	  data[1] = ""
	end
end

-- Define the main function
function main()
	-- Print the directory path and the file name
	print("Directory path:", dirpath)
	print("File name:", filename)
	print("icon0:", icon0Filename)

	loadEboot(filename)
	print("Current EBOOT name:", data[2])

	io.write("Enter a new EBOOT name: ")
	local newName = io.read()

	print("Changing Eboot name to: " .. newName)
	editEboot(data[1],"./output/",newName,icon0Filename,icon0Filename)
end

main()