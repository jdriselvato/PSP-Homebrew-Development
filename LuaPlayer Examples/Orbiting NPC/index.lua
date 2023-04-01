--//## Set CPU speed
System.setCpuSpeed(333)


-- Player
player = {
	sprite = Image.load("sprite.png"),
	x = 40,
	y = 200
}

-- NPCs
npc1 = {
	sprite = Image.load("sprite.png"),
	x = 40,
	y = 200,
	angle = 0
}

local lastTime = os.clock()
local currentSpeed = 10

function updateNPC(centerX, centerY, radius)
	npc1.x = centerX + math.cos(npc1.angle) * radius
	npc1.y = centerY + math.sin(npc1.angle) * radius

	-- Get current time
	local currentTime = os.clock()
	
	-- Calculate time delta
	local deltaTime = currentTime - lastTime
	
	-- Update last time
	lastTime = currentTime
	
	-- Increment angle based on elapsed time and speed
	npc1.angle = npc1.angle + deltaTime * 2 * math.pi / (currentSpeed + 0.2) -- Rotate once every `speed`
end

--//## MAIN ##\\ --

local buttonPressed = false

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
	    	-- check if released l or r button
	    	if button.name == "up" then
	    		player.y = player.y - 1.5
	    	elseif button.name == "down" then
	    		player.y = player.y + 1.5
	    	elseif button.name == "left" then
	    		player.x = player.x - 1.5
	    	elseif button.name == "right" then
	    		player.x = player.x + 1.5
	    	elseif button.name == "l" and not buttonPressed then
	    		currentSpeed = math.min(currentSpeed + 1, 10)
	    		buttonPressed = true
	    	elseif button.name == "r" and not buttonPressed then
	    		currentSpeed = math.max(currentSpeed - 1, -10)
	    		buttonPressed = true

	    	end
	    end
	end

	if not pad:l() and not pad:r() then
	    buttonPressed = false -- Button is released
	end

	screen:blit(player.x, player.y, player.sprite)

	updateNPC(player.x, player.y, 50, currentSpeed)
	screen:blit(npc1.x, npc1.y, npc1.sprite)
	screen:print(20, 40, "Press L/R to change speed", Color.new(122,120,22))
	screen:print(20, 10, "Current Speed: "..currentSpeed, Color.new(122,120,22))

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

System.quit() -- Quit the application after the main loop breaks
