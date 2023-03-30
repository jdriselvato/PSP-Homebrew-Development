--//## Set CPU speed
System.setCpuSpeed(333)

--Font setup
font = IntraFont.load("font.pgf")
IntraCol = {black = 0, red = 1, blue = 2, white = 3, lightGrey = 4, grey = 5, darkGrey = 6, purple = 7, yellow  = 8, orange = 9, transparent = 10}

-- create a table to hold the button state
local buttons = {
  up = false,
  down = false,
  left = false,
  right = false,
  triangle = false,
  circle = false,
  cross = false,
  square = false,
  l = false,
  r = false,
  select = false,
  start = false
}

--//## MAIN ##\\ --

while true do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--Read Controls
	pad = Controls.readPeek()

	buttons = {
	    {name = "up", value = pad:up()},
	    {name = "down", value = pad:down()},
	    {name = "left", value = pad:left()},
	    {name = "right", value = pad:right()},
	    {name = "cross", value = pad:cross()},
	    {name = "circle", value = pad:circle()},
	    {name = "triangle", value = pad:triangle()},
	    {name = "square", value = pad:square()},
	    {name = "select", value = pad:select()},
	    {name = "start", value = pad:start()},
	    {name = "l", value = pad:l()},
	    {name = "r", value = pad:r()},
	}

	IntraFont.print(font, 20, 12, 0.4, IntraCol.white, IntraCol.black, "Press a button:")

	local buttonsPress = ""

	for _, button in pairs(buttons) do
	    if button.value then
	    	buttonsPress = button.name .. " " .. buttonsPress
	    end
	end

	IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, buttonsPress)
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()	
	System.showFPS()
	screen.flip()
end

IntraFont.unLoad() -- deinit the font
System.quit() -- Quit the application after the main loop breaks
