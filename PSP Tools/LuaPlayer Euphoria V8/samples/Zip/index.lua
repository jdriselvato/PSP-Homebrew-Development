--LuaPlayer Euphoria Dialog Sample

white = Color.new(255, 255, 255)
gray = Color.new(128, 128, 128)
black = Color.new(0, 0, 0)
red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
nil_color = Color.new(0, 0, 0, 0)


--Load a Font using IntraFont
font = IntraFont.load("font.pgf", 0)

x = 5
y = 15
zipfilename = "test.zip"

debug_openzipfile = function (zipfilename)
	x = 5
	y = 15

	font:setStyle(1.0, white, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, "Open zip file: ")

	font:setStyle(1.0, red, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, zipfilename)

	font:setStyle(1.0, green, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, " .. done!")

	y = y + 15*2
	x = 5	
end

debug_zipinfo = function (info)

	font:setStyle(1.0, white, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, "Get info ")
	
	font:setStyle(1.0, green, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, " .. done!")

	y = y + 15
	x = 15	
	
	font:setStyle(1.0, white, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, "Number of files: ")
	local nFile = Zip.getNumberEntry()
	font:setStyle(1.0, red, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, tostring(nFile))

	y = y + 15
	x = 15	
	
	for i=1, nFile do
		font:print( x, y, info[i].name)
		y = y + 15
	end
	
	y = y + 15
	x = 5	
end


debug_extract_start = function ()
	font:setStyle(1.0, white, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, "Extract files")
end


debug_extract_end = function ()
	font:setStyle(1.0, green, nil_color, IntraFont.ALIGN_LEFT)
	x = font:print( x, y, " .. done!")

	y = y + 15
	x = 5	
	
	font:setStyle(1.0, white, nil_color, IntraFont.ALIGN_LEFT)
	font:print( x, y, "Close zip file")
end

------------------------------------------------------------------------------------------
-- open the zip file
Zip.open(zipfilename)
------------------------------------------------------------------------------------------

System.draw()
screen:clear(gray)

debug_openzipfile(zipfilename)


font:setStyle(1.0, blue, nil_color, IntraFont.ALIGN_CENTER)
font:print( 240, 262, "Press Cross to continue")

System.endDraw()
screen.flip()


pad = Controls.read()

while not pad:cross() do
	pad = Controls.read()
end

------------------------------------------------------------------------------------------
-- get zip info
info = Zip.getInfo()
------------------------------------------------------------------------------------------

System.draw()
screen:clear(gray)

debug_openzipfile(zipfilename)
debug_zipinfo(info)

font:setStyle(1.0, blue, nil_color, IntraFont.ALIGN_CENTER)
font:print( 240, 262, "Press Circle to continue")

System.endDraw()
screen.flip()

pad = Controls.read()

while not pad:circle() do
	pad = Controls.read()
end

System.draw()
screen:clear(gray)

debug_openzipfile(zipfilename)
debug_zipinfo(info)
debug_extract_start()

System.endDraw()
screen.flip()

System.createDirectory("extracted files")
System.currentDirectory("extracted files")

------------------------------------------------------------------------------------------
-- extract zip
-- 1st  method
Zip.extract()

-- 2nd method
--[[
Zip.goToFirstFile()

continue = true

while (continue) do
	Zip.extractCurrentFile()
	continue = Zip.goToNextFile()
end
]]--
------------------------------------------------------------------------------------------

System.draw()
screen:clear(gray)

debug_openzipfile(zipfilename)
debug_zipinfo(info)
debug_extract_start()
debug_extract_end()

font:setStyle(1.0, blue, nil_color, IntraFont.ALIGN_CENTER)
font:print( 240, 262, "Press Triangle to quit")

System.endDraw()
screen.flip()

------------------------------------------------------------------------------------------
-- close zip file
Zip.close()
------------------------------------------------------------------------------------------

pad = Controls.read()

while not pad:triangle() do
	pad = Controls.read()
end


font:unload() -- Unload font

System.quit() -- Quit the application after the main loop breaks
