-- echo the SIO input and send every second a dot

terminalX = 0
terminalY = 0
green = Color.new(0, 255, 0)
terminal = Image.createEmpty(480, 272)

function scroll(image, dx, dy)
	new = Image.createEmpty(image:width(), image:height())
	new:blit(dx, dy, image)
	return new
end

function printTerminal(text)
	for i = 1, string.len(text) do
		char = string.sub(text, i, i)
		if char == "\n" then
			terminalY = terminalY + 1
			terminalX = 0
		else
			terminal:print(terminalX * 8, terminalY * 8, char, green)
			terminalX = terminalX + 1
			if terminalX >= 60 then
				terminalX = 0
				terminalY = terminalY + 1
			end
		end
		if terminalY >= 34 then
			terminalY = 33
			terminal = scroll(terminal, 0, -8)
		end
	end
end

function normalizeLinefeed(text)
	-- terminal programs like Hyperterminal sends just a \r for return key, convert it
	result = ""
	for i = 1, string.len(text) do
		char = string.sub(text, i, i)
		if char == "\r" then char = "\n" end
		result = result .. char
	end
	return result
end

printTerminal("initializing SIO...\n");
System.sioInit(2400)
infoString = "starting echo...\n"
printTerminal(infoString);
System.sioWrite(infoString)
ping = 0
while true do
	text = normalizeLinefeed(System.sioRead())
	ping = ping + 1
	if ping == 60 then
		ping = 0
		text = text .. "."
	end
	printTerminal(text)
	System.sioWrite(text)
	screen:blit(0, 0, terminal, 0, 0, terminal:width(), terminal:height(), false)
	screen.waitVblankStart()
	screen:flip()
	if Controls.read():start() then break end
end
