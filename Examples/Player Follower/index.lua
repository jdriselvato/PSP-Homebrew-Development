--//## Set CPU speed
System.setCpuSpeed(333)

--Font setup
font = IntraFont.load("font.pgf")
IntraCol = {black = 0, red = 1, blue = 2, white = 3, lightGrey = 4, grey = 5, darkGrey = 6, purple = 7, yellow  = 8, orange = 9, transparent = 10}


-- Player
playerSprite = Image.load("sprite.png")
player = {}
player.x = 40
player.y = 200
player.lastPosition = "up"

-- Follower
followerSprite = Image.load("sprite.png")
follower = {}
follower.x = 40
follower.y = 200

--//## MAIN ##\\ --

function movePlayer()
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
			player.lastPosition = button.name
		end
	end
end

-- move the follower according to the players location
function moveFollower()
	local positionX, positionY = easeInOutFollow(follower.x, follower.y, player.x, player.y, 2, 6)

	follower.x = positionX
	follower.y = positionY
end

function easeInOutFollow(currentX, currentY, targetX, targetY, time, duration)
	-- Spacing between player and follower
	local spacing = 10

    -- Calculate the time ratio
    local tRatio = time / duration

    -- Adjust the target coordinates to add spacing

    -- if the last press button was up or down, move the follower on y properly
    if player.lastPosition == "up" or player.lastPosition == "down" then
    	if currentY < targetY then
    		if player.lastPosition == "up" then -- fixes pushing bug
    			targetY = targetY + spacing
    		else
    			targetY = targetY - spacing
    		end
    	elseif currentY > targetY then
    		if player.lastPosition == "down" then -- fixes pushing bug
    			targetY = targetY - spacing
    		else
    			targetY = targetY + spacing
    		end
       	end
    end

    -- if the last press button was left or right, move the follower on x properly
    if player.lastPosition == "left" or player.lastPosition == "right" then
    	if currentX < targetX then
    		if player.lastPosition == "left" then -- fixes pushing bug
    			argetX = targetX + spacing
    		else
    			targetX = targetX - spacing
    		end 
    	elseif currentX > targetX then
    		if player.lastPosition == "right" then -- fixes pushing bug
	    		targetX = targetX - spacing
	    	else
	    		targetX = targetX + spacing
	    	end
    	end
    end

    -- Calculate the easing factor
    local easingFactor = 0
    if tRatio < 0.5 then
    	easingFactor = 2 * tRatio * tRatio
    else
    	easingFactor = -2 * tRatio * tRatio + 4 * tRatio - 1
    end

    -- Calculate the new x and y coordinates based on the easing factor
    local newX = currentX + (targetX - currentX) * easingFactor
    local newY = currentY + (targetY - currentY) * easingFactor

    -- Return the updated x and y coordinates
    return truncate(newX, 4), truncate(newY, 4)
end

-- Rounding function
function truncate(num, precision)
    local mult = 10^(precision or 0)
    return math.floor(num * mult) / mult
end

while not Controls.readPeek():start() do

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()

	--Clear the screen
	screen:clear()

	movePlayer()
	moveFollower()

	screen:blit(follower.x, follower.y, followerSprite)
	screen:blit(player.x, player.y, playerSprite) -- player on top

	local playerOutput = "player: x" .. player.x .. " y" .. player.y
	IntraFont.print(font, 20, 30, 0.3, IntraCol.white, IntraCol.black, playerOutput)
	local followerOutput = "follower: x" .. follower.x .. " y" .. follower.y 
	IntraFont.print(font, 20, 40, 0.3, IntraCol.white, IntraCol.black, followerOutput)

	--Finish the GU and Sync	
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();

end

IntraFont.unLoad() -- deinit the font
System.quit() -- Quit the application after the main loop breaks
