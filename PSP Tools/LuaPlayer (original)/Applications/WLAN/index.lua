-- WLAN example: reads a test file from www.luaplayer.org
-- and provides a very simple webserver on the PSP

white = Color.new(255, 255, 255)
offscreen = Image.createEmpty(480, 272)
offscreen:clear(Color.new(0, 0, 0))
y = 0
x = 0

function graphicsPrint(text)
	for i = 1, string.len(text) do
		char = string.sub(text, i, i)
		if char == "\n" then
			y = y + 8
			x = 0
		elseif char ~= "\r" then
			offscreen:print(x, y, char, white)
			x = x + 8
		end
	end
	screen:blit(0, 0, offscreen)
	screen.waitVblankStart()
	screen.flip()
end

function graphicsPrintln(text)
	graphicsPrint(text .. "\n")
end

-- init WLAN and choose connection config
Wlan.init()
configs = Wlan.getConnectionConfigs()
graphicsPrintln("available connections:")
graphicsPrintln("")
for key, value in ipairs(configs) do
	graphicsPrintln(key .. ": " .. value)
end
graphicsPrintln("")
graphicsPrintln("using first connection...")
Wlan.useConnectionConfig(1)

-- start server socket
graphicsPrintln("open server socket...")
serverSocket = Socket.createServerSocket(80)

-- start connection and wait until it is connected
graphicsPrintln("waiting for WLAN init and determining IP address...")
while true do
	ipAddress = Wlan.getIPAddress()
	if ipAddress then break end
	System.sleep(100)
end
graphicsPrintln("the PSP IP address is: " .. ipAddress)
graphicsPrintln("try http:// " .. ipAddress .. " on your computer")
graphicsPrintln("")

graphicsPrintln("connecting to www.luaplayer.org...")
socket, error = Socket.connect("www.luaplayer.org", 80)
while not socket:isConnected() do System.sleep(100) end
graphicsPrintln("connected to " .. tostring(socket))

-- send request
graphicsPrintln("loading test page...")
bytesSent = socket:send("GET /wlan-test.txt HTTP/1.0\r\n")
bytesSent = socket:send("host: www.luaplayer.org\r\n\r\n")

-- read and display result
requestCount = 0
header = ""
headerFinished = false
while true do
	-- read from test page
	buffer = socket:recv()
	if string.len(buffer) > 0 then 
		if headerFinished then
			graphicsPrint(buffer)
		else
			header = header .. buffer
			startIndex, endIndex = string.find(header, "\r\n\r\n")
			if endIndex then
				graphicsPrint(string.sub(header, endIndex))
			end
		end
	end
	
	-- check for incoming requests
	incomingSocket = serverSocket:accept()
	if incomingSocket then
		-- send test page back and close socket
		requestCount = requestCount + 1
		incomingSocket:send("HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n")
		incomingSocket:send("Testpage from your PSP.\r\n")
		incomingSocket:send("This was request number " .. requestCount .. ". Reload to increment it.")
		incomingSocket:close()
	end
	if Controls.read():start() then break end
	screen.waitVblankStart()
end
Wlan.term()
