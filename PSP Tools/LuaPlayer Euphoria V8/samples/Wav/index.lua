--LuaPlayer Euphoria Wav Sample
--By Zack - www.retroemu.com

white = Color.new(255, 255, 255);
darkgray = Color.new(100, 100, 100, 128);

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf", 0) 
font:setStyle(0.5, white, darkgray, IntraFont.CACHE_ALL);

--Load a Wav into channel 0
Wav.load("sample.wav", 0)

local volume = 1.0
local speed = 1.0

--Get last pad state
oldpad = Controls.readPeek()

while not Controls.readPeek():start() do

	pad = Controls.readPeek()

	--Initialize the GU (Note : Any graphical functions MUST be placed AFTER this)
	System.draw()
	
	--Clear the screen
	screen:clear()
	
	--Set Wav Volume (on channel 0)
	Wav.volume(volume, 0) --Must be called inside a loop if you wish to change its value
	--Set Wav Playback Speed (on channel 0)
	Wav.speed(speed, 0) --Must be called inside a loop if you wish to change its value
		
	--Blit our uber cool background to the screen
	screen:blit(0, 0, backGround)
		
	--Print some controls using IntraFont	
	font:print(20, 120, "now playing : sample.wav\n\npress x to pause/unpause\n\ntap l to decrease the volume\n\ntap r to increase the volume\n\ntap square to decrease the playback speed\n\ntap circle to increase the playback speed\n\npress start to quit")
		
	--Pause/Unpause the Wav
	if pad:cross() and pad:cross() ~= oldpad:cross() then
		--Play Wav (on channel 0) true = loop, false = play once then stop
		Wav.play(false, 0) --Can be called inside or outside a loop
	end

	--Lower the Wav volume
	if pad:l() and pad:l() ~= oldpad:l() then
		volume = volume - 0.1
		if volume <= 0.0 then
			volume = 0.0
		end
	end
	
	--Raise the Wav volume
	if pad:r() and pad:r() ~= oldpad:r() then
		volume = volume + 0.1
		if volume >= 1.0 then
			volume = 1.0
		end
	end
	
	--Lower the Wav Playback Speed
	if pad:square() and pad:square() ~= oldpad:square() then
		speed = speed - 0.1
		if speed <= 0.0 then
			speed = 0.0
		end
	end
	
	--Raise the Wav Playback Speed
	if pad:circle() and pad:circle() ~= oldpad:circle() then
		speed = speed + 0.1
		if speed >= 1.0 then
			speed = 1.0
		end
	end
	
	--Finish the GU and Sync
	System.endDraw()
	
	--Show the FPS (Note : MUST be called after System.endGU()
	System.showFPS()
	--Flip buffers
	screen.flip()
	--Assign oldpad to pad
	oldpad = pad
end

IntraFont.unLoad() -- Unload any fonts used by IntraFont
System.quit() -- Quit the application after the main loop breaks
