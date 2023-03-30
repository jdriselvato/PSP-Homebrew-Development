--LuaPlayer Euphoria Dialog Sample

white = Color.new(255, 255, 255)
black = Color.new(0, 0, 0)

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf", 0)
font:setStyle(1.5, white, black, IntraFont.ALIGN_CENTER)

drawFunc = function()
	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Blit our uber cool background to the screen
	screen:blit(0, 0, backGround)
	
	--Print some text using IntraFont	
	font:print( 240, 136, "Welcome To LuaPlayer Euphoria V7\n\nPress Triangle")
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()
	System.showFPS()
end

while true do

	drawFunc()
	
	--Flip buffers
	screen.flip()
	
	pad = Controls.readPeek()
	
	if pad:triangle() then
		result = System.msgDialog("Thank you for trying the message dialog sample!\n\nDo you want to quit the game?", true, drawFunc)
		if (result==System.MSGDIALOG_RESULT_YES) then
			break;
		end
	end
	
end

font:unload() -- Unload font
backGround:free() -- free the image.

System.quit() -- Quit the application after the main loop breaks
