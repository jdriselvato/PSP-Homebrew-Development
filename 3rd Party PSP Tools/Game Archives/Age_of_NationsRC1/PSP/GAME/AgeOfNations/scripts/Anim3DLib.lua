--[[	AoN
		3D Rendering Animation Library
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 18/08/2010
	]]
	
Anim3D = {}

function Anim3D.initGU()
	Gu.start3d()
	Gu.clearDepth(0);
	Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT)
	Gum.matrixMode(Gu.PROJECTION)
	Gum.loadIdentity()
	Gum.perspective(75, 480/272, 0.5, 1000)
	Gum.matrixMode(Gu.VIEW)
	Gum.loadIdentity()
end

function Anim3D.endGU()
	Gu.end3d()
end


function Anim3D.createModel(img,num)
	if img then
	local w = img:width()
	local h = img:height()
	local vertices = {
			{0, 1, WHITE, -w, -h,  0},
			{0, 0, WHITE, -w,  h,  0},
			{1, 0, WHITE,  w,  h,  0},
		
			{0, 1, WHITE, -w, -h,  0},
			{1, 0, WHITE,  w,  h,  0},
			{1, 1, WHITE,  w, -h,  0}
		}
	local num = (not num) and 10 or num
	Anim3D.models = {}
	for k=1,num do
		Anim3D.models[k] = {x = math.random(400)-200, y = math.random(200)-100, gravity = math.random(2), angularMotion = 0.02,angle = math.random()*math.pi*2}
	end
	Anim3D.mesh = {img = img,vertices = vertices}
	end
end

function Anim3D.drawModel(mesh,x,y,angle)	
	local x = (not x) and 0 or x
	local y = (not y) and 0 or y
	local angle = (not angle) and 0 or angle

	Gu.enable(Gu.BLEND)
	Gu.blendFunc(Gu.ADD, Gu.SRC_ALPHA, Gu.ONE_MINUS_SRC_ALPHA, 0, 0)
	Gu.enable(Gu.TEXTURE_2D);
	Gu.texImage(mesh.img)
	Gu.texFunc(Gu.TFX_MODULATE, Gu.TCC_RGBA)
	Gu.texEnvColor(WHITE)
	Gu.texFilter(Gu.LINEAR, Gu.LINEAR)
	Gu.texScale(1, 1)

	Gum.matrixMode(Gu.MODEL)
	Gum.loadIdentity()
	Gum.translate(x, y, -176);
	

	Gum.rotateXYZ(0, 0, -angle)

	Gum.drawArray(Gu.TRIANGLES, Gu.TEXTURE_32BITF+Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, mesh.vertices)	

end

	
function Anim3D.drawAnimation()
	Anim3D.initGU()	
		for _,model in ipairs(Anim3D.models) do
		Anim3D.drawModel(Anim3D.mesh,model.x,model.y,model.angle)
		model.angle = model.angle+model.angularMotion
		model.y = model.y - model.gravity
			if model.y < -168 then
			model.y = 168+math.random(40)
			model.x = math.random(400)-200
			model.gravity = math.random(2)
			end
		end		
	Anim3D.endGU()
end