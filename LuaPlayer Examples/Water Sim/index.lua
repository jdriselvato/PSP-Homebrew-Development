
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
		local nodeCount = 15
		local nodeWidth = 480/nodeCount
		local nodeHeight = 272
		for i, y in ipairs(updateWave(currentTime, nodeCount)) do
			screen:fillRect(
				(nodeWidth*i)-nodeWidth, -- x
				(nodeHeight/2) + y, -- y
				nodeWidth,  -- width
				nodeHeight, -- height
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