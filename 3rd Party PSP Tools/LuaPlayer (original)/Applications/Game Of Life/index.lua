--[[
Game Of Life, Copyright (c) 2006 Frank Buss <fb@frank-buss.de> (aka Shine)

   demonstration for loading and using a Lua Player library
]]

-- load effect library with the lifeStep function for Game Of Life
effect = loadlib( "effect", "init" )

-- init library (function pointer is nil, if already initialized)
if effect then effect() end

-- cellular automaton dimension
width = 480
height = 272

function reset()
	-- create images
	current = Image.createEmpty(width, height)
	next = Image.createEmpty(width, height)
	
	-- init rabbits pattern
	green = Color.new(0, 255, 0)
	black = Color.new(0, 0, 0)
	centerX = math.floor(width / 2)
	centerY = math.floor(height / 2)
	current:pixel(centerX - 3, centerY, green)
	current:pixel(centerX + 1, centerY, green)
	current:pixel(centerX + 2, centerY, green)
	current:pixel(centerX + 3, centerY, green)
	current:pixel(centerX - 3, centerY + 1, green)
	current:pixel(centerX - 2, centerY + 1, green)
	current:pixel(centerX - 1, centerY + 1, green)
	current:pixel(centerX + 2, centerY + 1, green)
	current:pixel(centerX - 2, centerY + 2, green)
end

reset()

-- main loop
generation = 0
while not Controls.read():start() do
	-- calculate next generation
	Effect.lifeStep(current, next)

	-- swap buffers
	tmp = next
	next = current
	current = tmp

	-- update screen
	screen:blit(0, 0, next, 0, 0, width, height, false)
	generation = generation + 1
	screen:print(0, 0, "generation: " .. generation, green)
	screen:print(0, 10, "press start for exit and x for reset", green)
	screen.waitVblankStart()
	screen.flip()
	
	-- check for reset
	if Controls.read():cross() then reset() end
end
