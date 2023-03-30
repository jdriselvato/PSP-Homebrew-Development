--LuaPlayer Euphoria Dialog Sample
--By Zack - www.retroemu.com

white = Color.new(255, 255, 255);
darkgray = Color.new(100, 100, 100, 128);

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf", 0) 
font:setStyle(0.5, white, darkgray, IntraFont.CACHE_ALL);

local alpha = 255

--Get last pad state
oldpad = Controls.readPeek()

while not Controls.readPeek():start() do

	pad = Controls.readPeek()

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--Blit our uber cool background to the screen (with variable alpha)
	screen:blit(0, 0, backGround, alpha)
		
	--Print some controls using IntraFont	
	font:print(20, 150, "press l to decrease the alpha level")
	font:print(20, 170, "press r to increase the alpha level ")
	
	--Lower the alpha value
	if pad:l() and pad:l() ~= oldpad:l() then
		alpha = alpha - 1
		if alpha <= 0 then
			alpha = 0
		end
	end
	
	--Raise the alpha value
	if pad:r() and pad:r() ~= oldpad:r() then
		alpha = alpha + 1
		if alpha >= 255 then
			alpha = 255
		end
	end
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endGU()
	System.showFPS()
	--Flip buffers
	screen.flip()
end

IntraFont.unLoad() -- Unload any fonts used by IntraFont
System.quit() -- Quit the application after the main loop breaks
