--//## Set CPU speed
System.setCpuSpeed(333)

-- Player
playerSprite = Image.load("sprite.png")
player = {}
player.x = 40
player.y = 200


--//## MAIN ##\\ --

while not Controls.readPeek():start() do

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

	for _, button in pairs(buttons) do
	    if button.value then
	    	if button.name == "up" then
	    		player.y = player.y - 1.5
	    	elseif button.name == "down" then
	    		player.y = player.y + 1.5
	    	elseif button.name == "left" then
	    		player.x = player.x - 1.5
	    	elseif button.name == "right" then
	    		player.x = player.x + 1.5
	    	end
	    end
	end

	screen:blit(player.x, player.y, playerSprite)

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks
