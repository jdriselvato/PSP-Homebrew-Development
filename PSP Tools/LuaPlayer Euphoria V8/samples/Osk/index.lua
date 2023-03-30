--LuaPlayer Euphoria Dialog Sample

white = Color.new(255, 255, 255)
black = Color.new(0, 0, 0)

username = ""

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf", 0)
font:setStyle(1.5, white, black, IntraFont.ALIGN_CENTER)

drawFunc = function()
	if Controls.readPeek():select() then
		screen:save("screenshot.png")
	end

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Blit our uber cool background to the screen
	screen:blit(0, 0, backGround)
	
	--Print some text using IntraFont	
	font:print( 240, 136, "Hi "..username.."\nWelcome To LuaPlayer Euphoria V7\n\nPress Triangle")
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endDraw()
	System.showFPS()
end


while not Controls.readPeek():start() do

	drawFunc()
	
	--Flip buffers
	screen.flip()
	
	pad = Controls.readPeek()
	
	if pad:start() then
		break
	elseif pad:triangle() then
		new_username, result = System.osk("LuaPlayer Euphoria V7\nType your name", "my name",
									System.OSK_INPUTTYPE_ALL, drawFunc)
		local text = ""
		if (result==System.OSK_RESULT_UNCHANGED) then
			text = "result unchanged!"
		elseif (result==System.OSK_RESULT_CANCELLED) then
			text = "osk cancelled!"
		elseif (result==System.OSK_RESULT_CHANGED) then
			username = new_username;
			text = "result changed\nname: "..username
		end
		
		System.msgDialog(text)		
	end
	
end

font:unload() -- Unload font
backGround:free() -- free the image.

System.quit() -- Quit the application after the main loop breaks

