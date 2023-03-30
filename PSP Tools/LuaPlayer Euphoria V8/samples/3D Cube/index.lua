red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
black = Color.new(0, 0, 0)
white = Color.new(255, 255, 255)
gray = Color.new(128, 128, 128)
cyan = Color.new(100, 255, 255)

val = 0

logo = Image.createEmpty(64, 64)
logo:clear(gray)
logo:print(20, 20, "Lua Player", black)
logo:print(10, 40, "Euphoria", black)

cube = {
	{0, 0, red, -1, -1,  1},  -- 0
	{2, 0, red, -1,  1,  1},  -- 4
	{2, 2, red,  1,  1,  1},  -- 5

	{0, 0, red, -1, -1,  1},  -- 0
	{2, 2, red,  1,  1,  1},  -- 5
	{0, 2, red,  1, -1,  1},  -- 1

	{0, 0, red, -1, -1, -1},  -- 3
	{2, 0, red,  1, -1, -1},  -- 2
	{2, 2, red,  1,  1, -1},  -- 6

	{0, 0, red, -1, -1, -1},  -- 3
	{2, 2, red,  1,  1, -1},  -- 6
	{0, 2, red, -1,  1, -1},  -- 7

	{0, 0, green,  1, -1, -1},  -- 0
	{2, 0, green,  1, -1,  1},  -- 3
	{2, 2, green,  1,  1,  1},  -- 7

	{0, 0, green,  1, -1, -1},  -- 0
	{2, 2, green,  1,  1,  1},  -- 7
	{0, 2, green,  1,  1, -1},  -- 4

	{0, 0, green, -1, -1, -1},  -- 0
	{2, 0, green, -1,  1, -1},  -- 3
	{2, 2, green, -1,  1,  1},  -- 7

	{0, 0, green, -1, -1, -1},  -- 0
	{2, 2, green, -1,  1,  1},  -- 7
	{0, 2, green, -1, -1,  1},  -- 4

	{0, 0, blue, -1,  1, -1},  -- 0
	{2, 0, blue,  1,  1, -1},  -- 1
	{2, 2, blue,  1,  1,  1},  -- 2

	{0, 0, blue, -1,  1, -1},  -- 0
	{2, 2, blue,  1,  1,  1},  -- 2
	{0, 2, blue, -1,  1,  1},  -- 3

	{0, 0, blue, -1, -1, -1},  -- 4
	{2, 0, blue, -1, -1,  1},  -- 7
	{2, 2, blue,  1, -1,  1},  -- 6

	{0, 0, blue, -1, -1, -1},  -- 4
	{2, 2, blue,  1, -1,  1},  -- 6
	{0, 2, blue,  1, -1, -1},  -- 5
}

plane = {
	{blue, -8, -3,  0},
	{cyan, 8,  3,  0},
	{blue,  8,  -3,  0},
	{cyan, 8, 3,  0},
	{blue, -8,  -3,  0},
	{cyan,  -8,  3,  0},
}

while true do
	Gu.start3d()

	-- clear screen
	Gu.clearDepth(0);
	Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT)

	-- setup projection and view matrices

	Gum.matrixMode(Gu.PROJECTION)
	Gum.loadIdentity()
	Gum.perspective(75, 16/9, 0.5, 1000)

	Gum.matrixMode(Gu.VIEW)
	Gum.loadIdentity()

	-- setup matrix for triangle
	Gum.matrixMode(Gu.MODEL)
	Gum.loadIdentity()
	Gum.translate(0, 0, -3);

	-- draw triangle without texture

	Gu.disable(Gu.TEXTURE_2D)
	Gum.drawArray(Gu.TRIANGLES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, plane)

	-- setup texture

	Gu.enable(Gu.BLEND)
	Gu.blendFunc(Gu.ADD, Gu.SRC_ALPHA, Gu.ONE_MINUS_SRC_ALPHA, 0, 0)
	Gu.enable(Gu.TEXTURE_2D);
	Gu.texImage(logo)
	Gu.texFunc(Gu.TFX_MODULATE, Gu.TCC_RGBA)
	Gu.texEnvColor(white)
	Gu.texFilter(Gu.LINEAR, Gu.LINEAR)
	Gu.texScale(1, 1)
	Gu.texOffset(0, 0)
	Gu.ambientColor(white)

	-- setup matrix for cube

	Gum.matrixMode(Gu.MODEL)
	Gum.loadIdentity()
	Gum.translate(0, 0, -3.5);
	Gum.rotateXYZ(val * 0.79 * (Gu.PI/180), val * 0.98 * (Gu.PI/180.0), val * 1.32 * (Gu.PI/180.0))

	-- draw cube

	Gum.drawArray(Gu.TRIANGLES, Gu.TEXTURE_32BITF+Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, cube)

	Gu.end3d()

	val = val + 1

	if Controls.read():start() then
		screen:clear()
		break
	end

	screen.waitVblankStart()
	screen.flip()
end
