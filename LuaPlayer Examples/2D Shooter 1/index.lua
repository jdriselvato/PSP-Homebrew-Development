local psp = {
	width = 480,
	height = 272
}

--//## Set CPU speed
System.setCpuSpeed(333)

-- Player
player = {
	sprite = Image.load("sprite.png"),
	x = psp.width / 2, -- start in center of screen
	y = 200,
	width = 14
}

-- Bullet
bullet = {
	sprite = Image.load("sprite.png"),
	x = player.x,
	y = player.y
}

local shooting = false
function shoot()
	bullet.y = bullet.y - 5

	if bullet.y < 0 then -- off screen 
		shooting = false
	end
end


--//## MAIN ##\\ --

while not Controls.readPeek():start() do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()

	--Read Controls
	pad = Controls.readPeek()

	buttons = {
	    {name = "left", value = pad:left()},
	    {name = "right", value = pad:right()},
	    {name = "cross", value = pad:cross()},
	}

	for _, button in pairs(buttons) do
	    if button.value then
	    	if button.name == "cross" and shooting == false then
	    		-- fire bullet logic
	    		shooting = true
	    		bullet.x = player.x + (player.width / 2) -- shoot from center to player sprite
	    		bullet.y = player.y
	    		screen:print(10,10, "Fire!", Color.new(233,23,122))
	    	elseif button.name == "left" then
	    		player.x = player.x - 1.5
	    	elseif button.name == "right" then
	    		player.x = player.x + 1.5
	    	end
	    end
	end

	if shooting == true then
		shoot()
		screen:fillRect(
			bullet.x, bullet.y,  -- x & y
			3,  -- width
			10, -- height (pin to the bottom of the screen)
			Color.new(20, 200, 250) -- color
		)
	end

	screen:blit(player.x, player.y, player.sprite)


	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks
