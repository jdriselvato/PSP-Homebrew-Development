--[[
Dots

   artworks by flattspott
   coding by Shine
]]

-- load images
background = Image.load("background.png")
pieces = { Image.load("red.png"), Image.load("blue.png"), Image.load("white.png") }

-- define globals
topLeft = { x = 19, y = 47 }
fieldSize = { width = 21, height = 10 }
cellSize = { width = 21, height = 21 }

black = Color.new(0, 0, 0)
white = Color.new(255, 255, 255)
red = Color.new(255, 0, 0)
blue = Color.new(0, 0, 255)
emptyColor = black
dotColor = white
lineColor = dotColor

fieldImage = Image.createEmpty(480, 272)

initialBorders = {
	"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+ + + + + + + + + + + + + + + + + + + + + +",
	"|                                         |",
	"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
}

-- 0 = white, 1 = red, 2 = blue, 3 = white
initialPieces = {
	"000000000000000000000",
	"000000000000000000000",
	"000000000000000000000",
	"003330003300333003300",
	"003003030030030030000",
	"003003030030030003000",
	"003003030030030000300",
	"003330003300030033000",
	"000000000000000000000",
	"000000000000000000000",
}

function setPiece(x, y, pieceIndex)
	field[y][x] = pieceIndex
	x0 = (x - 1) * cellSize.width + topLeft.x
	y0 = (y - 1) * cellSize.height + topLeft.y
	if pieceIndex ~= 0 then
		piece = pieces[pieceIndex]
		fieldImage:blit(x0 + 1, y0 + 1, piece, 0, 0, piece:width(), piece:height(), false)
		vBorders[x + 1][y] = white
		vBorders[x][y] = white
		hBorders[y + 1][x] = white
		hBorders[y][x] = white
	end
	fieldImage:pixel(x0, y0, dotColor)
	fieldImage:pixel(x0 + cellSize.width, y0, dotColor)
	fieldImage:pixel(x0 + cellSize.width, y0 + cellSize.height, dotColor)
	fieldImage:pixel(x0, y0 + cellSize.height, dotColor)
end

function drawBorders()
	for y = 1, fieldSize.height do
		for x = 1, fieldSize.width do
			x0 = (x - 1) * cellSize.width + topLeft.x
			y0 = (y - 1) * cellSize.height + topLeft.y
			if x == 1 then
				if vBorders[x][y] then
					fieldImage:drawLine(x0, y0, x0, y0 + cellSize.height, vBorders[x][y])
				end
			end
			if vBorders[x + 1][y] then
				fieldImage:drawLine(x0 + cellSize.width, y0, x0 + cellSize.width, y0 + cellSize.height, vBorders[x + 1][y])
			end
			if y == 1 then
				if hBorders[y][x] then
					fieldImage:drawLine(x0, y0, x0 + cellSize.width, y0, hBorders[y][x])
				end
			end
			if hBorders[y + 1][x] then
				fieldImage:drawLine(x0, y0 + cellSize.height, x0 + cellSize.width, y0 + cellSize.height, hBorders[y + 1][x])
			end
		end
	end
end

function newGame()
	field = {}
	fieldImage:blit(0, 0, background, 0, 0, background:width(), background:height(), false)
	vBorders = {}
	hBorders = {}
	for i = 1, fieldSize.width + 1 do vBorders[i] = {} end
	for i = 1, fieldSize.height do
		if string.sub(initialBorders[2 * i], 1, 1) == "|" then
			vBorders[1][i] = white
		else
			vBorders[1][i] = nil
		end
	end
	for i = 1, fieldSize.height + 1 do hBorders[i] = {} end
	for i = 1, fieldSize.width do
		if string.sub(initialBorders[1], 2 * i, 2 * i) == "-" then
			hBorders[1][i] = white
		else
			hBorders[1][i] = nil
		end
	end
	for y = 1, fieldSize.height do
		for x = 1, fieldSize.width do
			if string.sub(initialBorders[2 * y], 2 * x + 1, 2 * x + 1) == "|" then
				vBorders[x + 1][y] = white
			else
				vBorders[x + 1][y] = nil
			end
			if string.sub(initialBorders[2 * y + 1], 2 * x, 2 * x) == "-" then
				hBorders[y + 1][x] = white
			else
				hBorders[y + 1][x] = nil
			end
		end
	end
	for y = 1, fieldSize.height do
		field[y] = {}
		for x = 1, fieldSize.width do
			pieceIndex = tonumber(string.sub(initialPieces[y], x, x))
			setPiece(x, y, pieceIndex)
		end
	end
	drawBorders()
end

function testCell(x, y)
	if x < 1 or y < 1 or x > fieldSize.width or y > fieldSize.height then return end
	if hBorders[y][x] and hBorders[y + 1][x] and vBorders[x][y] and vBorders[x + 1][y] and field[y][x] == 0 then
		if player == red then
			setPiece(x, y, 1)
			return true
		else
			setPiece(x, y, 2)
			return true
		end
	end
	return false
end

function testAndSet(dx, dy)
	x = cursorX + dx
	y = cursorY + dy
	if dx == 0 then
		if dy == -1 then y = cursorY end
		if hBorders[y][x] then
			return
		else
			hBorders[y][x] = player
		end
	else
		if dx == -1 then x = cursorX end
		if vBorders[x][y] then
			return
		else
			vBorders[x][y] = player
		end
	end

	firstTest = testCell(cursorX, cursorY)
	secondTest = testCell(cursorX + dx, cursorY + dy)
	if not firstTest and not secondTest then
		if player == red then player = blue else player = red end
	end
	drawBorders()
end

-- game loop
blinkIndex = 0
cursorX = 1
cursorY = 1
oldPad = Controls.read()
player = red
newGame()
while not Controls.read():start() do
	-- check controls
	pad = Controls.read()
	if pad ~= oldPad then
		oldPad = pad
		if pad:up() then
			cursorY = cursorY - 1
			if cursorY < 1 then cursorY = fieldSize.height end
		elseif pad:down() then
			cursorY = cursorY + 1
			if cursorY > fieldSize.height then cursorY = 1 end
		elseif pad:left() then
			cursorX = cursorX - 1
			if cursorX < 1 then cursorX = fieldSize.width end
		elseif pad:right() then
			cursorX = cursorX + 1
			if cursorX > fieldSize.width then cursorX = 1 end
		elseif pad:square() then
			testAndSet(-1, 0)
		elseif pad:circle() then
			testAndSet(1, 0)
		elseif pad:triangle() then
			testAndSet(0, -1)
		elseif pad:cross() then
			testAndSet(0, 1)
		elseif pad:select() then
			newGame()
		end
	end
	
	-- draw field
	screen:blit(0, 0, fieldImage, 0, 0, background:width(), background:height(), false)

	-- draw cursor
	c = blinkIndex * 16
	if player == red then c = Color.new(c, 0, 0) else c = Color.new(0, 0, c) end
	x0 = (cursorX - 1) * cellSize.width + topLeft.x + cellSize.width / 3
	y0 = (cursorY - 1) * cellSize.height + topLeft.y + cellSize.width / 3
	screen:fillRect(x0, y0, cellSize.width / 3, cellSize.height / 3, c)
	blinkIndex = blinkIndex + 1
	if blinkIndex > 15 then blinkIndex = 0 end
	
	-- draw score
	redScore = 0
	blueScore = 0
	for y = 1, fieldSize.height do
		for x = 1, fieldSize.width do
			if field[y][x] == 1 then
				redScore = redScore + 1
			end
			if field[y][x] == 2 then
				blueScore = blueScore + 1
			end
		end
	end
	screen:print(150, 20, "red: " .. redScore, white)
	screen:print(250, 20, "blue: " .. blueScore, white)
	
	-- flip screen
	screen.waitVblankStart()
	screen.flip()
end
