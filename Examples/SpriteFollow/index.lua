--//## Set CPU speed
System.setCpuSpeed(333)

--//## MAIN ##\\ --

while not Controls.readPeek():start() do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	-- set the drawing color to red
	draw.setColor(255, 0, 0)

	-- draw a filled circle at coordinates (100, 100) with a radius of 50 pixels
	draw.circle(100, 100, 50)
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()	
	System.showFPS()
	screen.flip()
end

System.quit() -- Quit the application after the main loop breaks
