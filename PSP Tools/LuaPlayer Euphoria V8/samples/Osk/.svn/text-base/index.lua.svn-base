--LuaPlayer Euphoria OSK Sample
--By Zack - www.retroemu.com

--Assign all available colors to a table (makes life easier)
IntraCol = {black = 0, red = 1, blue = 2, white = 3, lightGrey = 4, grey = 5, darkGrey = 6, purple = 7, yellow  = 8, orange = 9, transparent = 10}

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf")

text = System.osk("LuaPlayer Euphoria V7", "Type Here!")

while not Controls.readPeek():start() do

	pad = Controls.readPeek()

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--Blit our uber cool background to the screen
	screen:blit(0, 0, backGround)
		
	--Print some controls using IntraFont	
	IntraFont.print(font, 20, 120, 0.5, IntraCol.white, IntraCol.black, "thank you for trying")
	IntraFont.print(font, 20, 150, 0.5, IntraCol.white, IntraCol.black, "the osk sample!")
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endGU()
	System.showFPS()
	--Flip buffers
	screen.flip()
end

IntraFont.unLoad() -- Unload any fonts used by IntraFont
System.quit() -- Quit the application after the main loop breaks
