--//## Set CPU speed
System.setCpuSpeed(333)

--Font setup
font = IntraFont.load("font.pgf")
IntraCol = {black = 0, red = 1, blue = 2, white = 3, lightGrey = 4, grey = 5, darkGrey = 6, purple = 7, yellow  = 8, orange = 9, transparent = 10}

--//## MAIN ##\\ --

while true do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--Read Controls
	pad = Controls.readPeek()

	IntraFont.print(font, 20, 12, 0.4, IntraCol.white, IntraCol.black, "Press a button:")

	if pad:cross() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "X button")
	elseif pad:square() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Square button")
	elseif pad:triangle() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Triangle button")
	elseif pad:circle() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Circle button")
	elseif pad:start() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Start button")
	elseif pad:select() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Select button")
	elseif pad:l() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "L button")
	elseif pad:r() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "R button")
	elseif pad:up() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Up button")
	elseif pad:down() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Down button")
	elseif pad:left() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Left button")
	elseif pad:right() then
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, "Right button")
	elseif pad:analogX() or pad:analogY() then -- Always prints because it returns values 0,0 when not in use
		local x = pad:analogX()
		local y = pad:analogY()
		output = "Analog stick X: " .. x .. ", Y: " .. y
		IntraFont.print(font, 20, 30, 0.4, IntraCol.white, IntraCol.black, output)
	end
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()	
	System.showFPS()
	screen.flip()
end

IntraFont.unLoad() -- deinit the font
System.quit() -- Quit the application after the main loop breaks
