-- ledtimer.lua by Geo Massar, 2005 (aka KawaGeo)
-- changes for new Timer class by Frank Buss (aka Shine)

dofile "LPut02.lua"

ledfonts = Image.load "LEDfonts.png"

function getFont(x, fontsize)
	fontsize = fontsize or 1
	local font = Image.createEmpty(19,35)
	font:blit(0,0, ledfonts, 19*x, 0, 19,35)
	return font:magnify(fontsize)
end

largeFonts = {}
for i = 0, 9 do
	largeFonts[i] = getFont(i, 2)
end

smallFonts = {}
for i = 0, 9 do
	smallFonts[i] = getFont(i)
end

function getState(state)
	local pad = Controls.read()
	if pad ~= oldpad then
	
		if pad:cross() then
			state = state + 1
		end
		
		if pad:start() then
			state = -1
		end

		oldpad = pad
	end
	return state
end

green = Color.new(0,255,0)
black = Color.new(0,0,0)

panel = Image.createEmpty(480,272)
panel:fillRect(0,0, 480,272, black)   -- solid black
panel:caption(96,26, "LED Timer", green, 4)
panel:print(212,190, "seconds", green)
panel:caption(40,220, "Press X: start|stop|reset", green, 2)
panel:print(2,262, "Created by Geo Massar, 2005", green)

dial = Image.createEmpty(144,80)
dial:fillRect(0,0, 144,80, green)
dial:fillRect(2,2, 140,76, black)

function displayDial(num)
	digits = string.format('%04d', num)
	for i = 1, 4 do
		digit = string.byte(digits, i) - 48
		if i < 4 then
			dial:blit(38*i-36, 4, largeFonts[digit])
		else
			dial:blit(120,36, smallFonts[digit])
		end
	end
	panel:blit(168,100, dial)
	screen:blit(0,0, panel)
	screen.waitVblankStart()
	screen:flip()
end

local timer = Timer.new()
local state = 0
displayDial(0)

repeat
	state = getState(state)
	
	if state == 0 then   -- reset timer
		timer:reset()
	
	elseif state == 1 then   -- start timer
		elapsedTenthSeconds = math.floor(timer:start() / 100 + 0.5)
		displayDial(elapsedTenthSeconds)
		if elapsedTenthSeconds >= 9999 then
			timer:reset(999900)
			state = 2												
		end
	
	elseif state == 2 then   -- stop timer
		timer:stop()
	
	elseif state == 3 then   -- clear timer
		displayDial(0)
		state = 0
	end
	
until state == -1
