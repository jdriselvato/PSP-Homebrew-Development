
local psp = {
	width = 480,
	height = 272
}

-- Algo for the wave
function updateWave(delta, nodeCount)
	local yValues = {}

	local wavelength = 0.5 -- increase or decrease to change frequency
	local amplitude = 20 -- increase or decrease to change wave height

	for i = 1, nodeCount do
		local y = math.sin((i - 1) * wavelength + delta) * amplitude
		table.insert(yValues, y)
	end

	return yValues
end

function start()
	while not Controls.readPeek():start() do
		System.draw()
		screen:clear()

		-- Get current time
		local currentTime = os.clock()

		-- animate "wave"
		local nodeCount = 10
		local nodeWidth = psp.width/nodeCount
		for i, y in ipairs(updateWave(currentTime, nodeCount)) do
			local nodeX = (nodeWidth*i)-nodeWidth -- x
			local nodeY = (psp.height/2) + y -- y (center animation to the middle of PSP screen)
			screen:fillRect(
				nodeX, nodeY,  -- x & y
				nodeWidth,  -- width
				(psp.height/2) - y, -- height (pin to the bottom of the screen)
				Color.new(0, 200, 250) -- color
			)

		end

		System.endDraw();
		screen.waitVblankStart();
		screen.flip();
	end
end

start()

System.quit() -- Quit the application after the main loop breaks