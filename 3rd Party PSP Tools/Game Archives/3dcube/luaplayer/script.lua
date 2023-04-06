-- Classic 3d wireframe cube demo in LUA  for PSP by Nils - ventoline.com
-- v 1.0 __ 13/08/2005
-- Many thanks to Shine for LuaPlayer, this wonderful toy ! See luaplayer.org for more :)
-- This code needs Lua 0.7 to run
-- Use pad or analog pad to move the cube ...


-- create a scene
theScene = Image.createEmpty(480, 272)

--focal length to determine perspective scaling
focalLength = 300

-- here we set up a function to make an object with 
-- x, y and z properties to represent a 3D point.  
make3DPoint = function(x,y,z)
	local point = {}
	point.x = x
	point.y = y
	point.z = z
	return point
	end

-- similarly set up a function to make an object with 
-- x and y properties to represent a 2D point.
make2DPoint = function(x, y)
	local point = {}
	point.x = x+240
	point.y = y+131
	return point
	end

-- conversion function for changing an array of 3D points to an
-- array of 2D points which is to be returned.
Transform3DPointsTo2DPoints = function(points, axisRotations)
	-- the array to hold transformed 2D points - the 3D points
	-- from the point array which are here rotated and scaled
	--to generate a point as it would appear on the screen
	local TransformedPointsArray = {}
	-- Math calcs for angles - sin and cos for each (trig)
	-- this will be the only time sin or cos is used for the
	-- entire portion of calculating all rotations
	local sx = math.sin(axisRotations.x)
	local cx = math.cos(axisRotations.x)
	local sy = math.sin(axisRotations.y)
	local cy = math.cos(axisRotations.y)
	local sz = math.sin(axisRotations.z)
	local cz = math.cos(axisRotations.z)
	
	-- a couple of variables to be used in the looping
	-- of all the points in the transform process
	local x,y,z, xy,xz, yx,yz, zx,zy, scaleRatio

	-- loop through all the points in your object/scene/space
	-- whatever - those points passed - so each is transformed
	local i = table.getn(points)
	while (i >0) do
		--apply Math to making transformations
		-- based on rotations
		-- assign variables for the current x, y and z
		x = points[i].x
		y = points[i].y
		z = points[i].z

		-- perform the rotations around each axis
		-- rotation around x
		xy = cx*y - sx*z
		xz = sx*y + cx*z
		-- rotation around y
		yz = cy*xz - sy*x
		yx = sy*xz + cy*x
		-- rotation around z
		zx = cz*yx - sz*xy
		zy = sz*yx + cz*xy

		-- now determine perspective scaling factor
		-- yz was the last calculated z value so its the
		-- final value for z depth
		scaleRatio = focalLength/(focalLength + yz)
		-- assign the new x and y
		x = zx*scaleRatio
		y = zy*scaleRatio
		-- create transformed 2D point with the calculated values
		-- adding it to the array holding all 2D points
		TransformedPointsArray[i] = make2DPoint(x, y)
	i = i -1
	end
	-- after looping return the array of points as they
	-- exist after the rotation and scaling
	return TransformedPointsArray
end

-- the points array contains all the points in the 3D
-- scene.  These 8 make a square on the screen.
pointsArray = {
make3DPoint(-50,-50,-50),
make3DPoint(50,-50,-50),
make3DPoint(50,-50,50),
make3DPoint(-50,-50,50),
make3DPoint(-50,50,-50),
make3DPoint(50,50,-50),
make3DPoint(50,50,50),
make3DPoint(-50,50,50),
}

-- an object to represent the 3 angles of rotation
cubeAxisRotations = make3DPoint(0,0,0)

rotateCube = function()
	cubeAxisRotations.y = cubeAxisRotations.y + userY
	cubeAxisRotations.x = cubeAxisRotations.x + userX
	-- create a new array to contain the 2D x and y positions of the
	-- points in the pointsArray as they would exist on the screen
	local screenPoints = Transform3DPointsTo2DPoints(pointsArray, cubeAxisRotations)
	-- clear the scene
	theScene:fillRect(0, 0 , 480, 272, color.black)
	-- draw the lines needed to make the square
	-- top
	theScene:drawLine(screenPoints[1].x, screenPoints[1].y, screenPoints[2].x, screenPoints[2].y, color.green)
	theScene:drawLine(screenPoints[2].x, screenPoints[2].y, screenPoints[3].x, screenPoints[3].y, color.green)
	theScene:drawLine(screenPoints[3].x, screenPoints[3].y, screenPoints[4].x, screenPoints[4].y, color.green)
	theScene:drawLine(screenPoints[4].x, screenPoints[4].y, screenPoints[1].x, screenPoints[1].y, color.green)
	-- bottom
	theScene:drawLine(screenPoints[5].x, screenPoints[5].y, screenPoints[6].x, screenPoints[6].y, color.red)
	theScene:drawLine(screenPoints[6].x, screenPoints[6].y, screenPoints[7].x, screenPoints[7].y, color.red)
	theScene:drawLine(screenPoints[7].x, screenPoints[7].y, screenPoints[8].x, screenPoints[8].y, color.red)
	theScene:drawLine(screenPoints[8].x, screenPoints[8].y, screenPoints[5].x, screenPoints[5].y, color.red)
	-- connecting bottom and top
	theScene:drawLine(screenPoints[1].x, screenPoints[1].y, screenPoints[5].x, screenPoints[5].y, color.white)
	theScene:drawLine(screenPoints[2].x, screenPoints[2].y, screenPoints[6].x, screenPoints[6].y, color.white)
	theScene:drawLine(screenPoints[3].x, screenPoints[3].y, screenPoints[7].x, screenPoints[7].y, color.blue)
	theScene:drawLine(screenPoints[4].x, screenPoints[4].y, screenPoints[8].x, screenPoints[8].y, color.blue)
end

-- some colors to play with
color = { 
	red = Color.new(255,0,0);
	green = Color.new(0, 255, 0);
	blue = Color.new(0,0,255);
	white = Color.new(255,255,255);
	black = Color.new(0,0,0);
	white = Color.new(255,255,255);
}

-- keyboard control
function keyboardControl()
	local pad = Controls.read()
	if pad:select() then
	screen:save("screenshot.tga")
	end
	-- going left
	if pad:analogX() < -30 or pad:left() then
		if  userY > -0.2 then 
			userY = userY  -.01
		end
	-- going right
        elseif pad:analogX() > 30 or pad:right() then
		if userY < 0.2 then
		        userY = userY  + .01	
                end
	end 
	-- going down
	if pad:analogY() < -30 or pad:down() then
		if  userX > -0.2 then 
			userX = userX  -.01
		end
	-- going up
        elseif pad:analogY() > 30 or pad:up() then
		if userX < 0.2 then
		        userX = userX  + .01	
                end
	end
	
end


-- initial decays of 3D cube
userX = - 0.01
userY =  0.01


-- main loop
while not Controls.read():start() do
-- look for input
keyboardControl()
-- rotate cube accordingly
rotateCube()
-- display
theScene:print(90, 262,"Classic 3d wireframe cube demo by Nils", color.white)
screen:blit(0, 0, theScene)
screen.waitVblankStart()
screen.flip()
end