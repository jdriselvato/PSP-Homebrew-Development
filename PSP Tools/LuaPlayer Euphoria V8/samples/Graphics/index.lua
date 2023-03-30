--LuaPlayer Euphoria Ogg Sample
--By Zack - www.retroemu.com

--//## Load a Image for the background
bkIMG = Image.load("bk.png")

--//## Set CPU speed
System.setCpuSpeed(222)

--//## MAIN ##\\ --

while not Controls.readPeek():start() do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--//## Blit the background Image
 	screen:blit(0, 0, bkIMG)
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()	
	System.showFPS()
	screen.flip()
end

System.quit() -- Quit the application after the main loop breaks
