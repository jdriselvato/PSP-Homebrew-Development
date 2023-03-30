--LuaPlayer Euphoria Wav Sample
--By Zack - www.retroemu.com

--Assign all available colors to a table (makes life easier)
IntraCol = {black = 0, red = 1, blue = 2, white = 3, lightGrey = 4, grey = 5, darkGrey = 6, purple = 7, yellow  = 8, orange = 9, transparent = 10}

--Load our background Image
backGround = Image.load("bk.png")

--Load a Font using IntraFont
font = IntraFont.load("font.pgf")

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
	IntraFont.print(font, 20, 120, 0.5, IntraCol.white, IntraCol.black, "now playing : sample.wav")
	IntraFont.print(font, 20, 150, 0.5, IntraCol.white, IntraCol.black, "press x to play the wav file")
	IntraFont.print(font, 20, 170, 0.5, IntraCol.white, IntraCol.black, "tap l to decrease the volume")
	IntraFont.print(font, 20, 190, 0.5, IntraCol.white, IntraCol.black, "tap r to increase the volume")
	IntraFont.print(font, 20, 210, 0.5, IntraCol.white, IntraCol.black, "tap square to decrease the playback speed")
	IntraFont.print(font, 20, 230, 0.5, IntraCol.white, IntraCol.black, "tap circle to increase the playback speed")
	IntraFont.print(font, 20, 250, 0.5, IntraCol.white, IntraCol.black, "press start to quit")
	
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
