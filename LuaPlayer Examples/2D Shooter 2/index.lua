local psp = {
	width = 480,
	height = 272
}

-- Player
player = {
	sprite = Image.load("sprite.png"),
	x = psp.width / 2, -- start in center of screen
	y = psp.height - 20,
	width = 14
}

bullets = {}

function createBullet()
  -- Copy the bullet template to create a new bullet
  local newBullet = {}
  
  -- Set the bullet's x and y values to the player's current position
  newBullet.x = player.x + (player.width / 2)
  newBullet.y = player.y

  math.randomseed(os.clock())
  newBullet.color = Color.new(
  		math.random(0, 255), -- r
  		math.random(0, 255), -- g
  		math.random(0, 255) -- b
  	)
  
  -- Append the new bullet to the bullets table
  table.insert(bullets, newBullet)
end


function animateBullets()
	for i, bullet in pairs(bullets) do
		bullet.y = bullet.y - 5

		screen:fillRect(
			bullet.x, bullet.y,  -- x & y
			3,  -- width
			10, -- height (pin to the bottom of the screen)
			bullet.color -- color
		)

		if bullet.y < 0 then -- off screen
			table.remove(bullets, i)
		end
	end
end

--//## MAIN ##\\ --

-- Initialize timer
local lastTime = os.clock()

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

	-- Get current time
	local currentTime = os.clock()
	local deltaTime = currentTime - lastTime

	for _, button in pairs(buttons) do
	    if button.value then
	    	if button.name == "cross" and deltaTime > 0.04 then
	    		-- fire bullet logic
	    		createBullet()
	    		lastTime = currentTime -- reset delay between shots
	    	elseif button.name == "left" then
	    		player.x = player.x - 1.5
	    	elseif button.name == "right" then
	    		player.x = player.x + 1.5
	    	end
	    end
	end

	count = table.getn(bullets)
	if count > 0 then
		animateBullets()
		screen:print(10,10, "Number of bullets:"..count, Color.new(233,23,122))
	end

	screen:blit(player.x, player.y, player.sprite)

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks
