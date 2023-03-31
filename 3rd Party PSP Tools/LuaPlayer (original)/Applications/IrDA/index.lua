-- IrDA sample
System.irdaInit()
ownCrossPressed = false
otherCrossPressed = false
gray = Color.new(64, 64, 64)
white = Color.new(255, 255, 255)
timeout = 10
while true do
	screen:clear()
	screen:print(0, 0, "IrDA sample", white)
	screen:print(0, 10, "start on 2 PSPs and press x", white)

	if ownCrossPressed then
		color = white
	else
		color = gray
	end
	screen:print(0, 30, "own cross", color)

	if otherCrossPressed then
		color = white
	else
		color = gray
	end
	screen:print(0, 40, "other cross", color)
	
	if timeout > 10 then
		color = gray
	else
		color = white
	end
	screen:print(0, 50, "irda connected", color)

	pad = Controls.read()
	if pad:cross() then
		ownCrossPressed = true
		System.irdaWrite("X")
	else
		ownCrossPressed = false
		System.irdaWrite("x")
	end
	if pad:start() then break end

	command = System.irdaRead()
	if string.len(command) >= 1 then
		for i = 1, string.len(command) do
			char = string.sub(command, i, i)
			if char == "X" then
				otherCrossPressed = true
			elseif char == "x" then
				otherCrossPressed = false
			end
		end
		timeout = 0
	else
		timeout = timeout + 1
	end

	screen.waitVblankStart()
	screen:flip()
end
