--[[	AoN Game Engine 
		Game Engine Custom Functions File
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 18/08/2010
	]]


--Modified screen:print()
function print(x,y,str,COLOR)
screen:print(x,y,str,COLOR or WHITE)
end

--Modified screen:fontPrint()
function printf(font,x,y,str,COLOR)
screen:fontPrint(font,x,y,str,COLOR or WHITE)
end

--Print centered text with no font 
function printCenter(y,text,color)
local s = text:len()*8
screen:print(240-s/2,y,text,color)
end

--Custom end-of-drawing function for while..do loops
function swapBuffers()
screen.waitVblankStart()
screen.flip()
end

--Draws a rectangle outline
function drawrect(x1,x2,y1,y2,COLOR)
screen:drawLine(x1,y1,x2,y1,COLOR or WHITE)
screen:drawLine(x1,y1,x1,y2,COLOR or WHITE)
screen:drawLine(x1,y2,x2,y2,COLOR or WHITE)
screen:drawLine(x2,y1,x2,y2,COLOR or WHITE)
end

--Modified screen:fillRect()
function drawfilledRect(sx,sy,w,h,COLOR)
screen:fillRect(sx,sy,w,h,COLOR or WHITE)
end

--Modified output:fillRect() : Not used at last
function drawOutputfilledRect(output,sx,sy,w,h,COLOR)
output:fillRect(sx,sy,w,h,COLOR or WHITE)
end

--Tests if a moving object is on an entity
function isOn(cur,o,mapX,mapY)
	if (cur.x > o.x-mapX) and (cur.x < o.x+o.w-mapX) and (cur.y > o.y-mapY) and (cur.y < o.y+o.h-mapY) then
	return true
	else return false
	end
end

--Tests if an entity is in dragging box
function isDragged(x0,y0,w,h,o,mapX,mapY)
	if (o.x - mapX > x0) and (o.x - mapX + o.img:width() < x0+w) and (o.y - mapY > y0) and (o.y - mapY + o.img:height() < y0+h) then
	return true
	else return false
	end
end

--Tests if a moving object is within a rectangle bounds
function onScreen(cur,boundX,boundY)
	if cur.x > 0 and cur.x < boundX and cur.y > 0 and cur.y < boundY then return true end
	return false
end

--Returns a raw copy of a table : Not used
function table_raw_copy(t)
	local _t = {}
	for k in pairs(t) do _t[k] = t[k] end
end

--Finds pattern %s%u%a in a string
function string.get2ndWord(str)
local s,e = string.find(str,'%s%u%a*')
	if s and e then return string.sub(str,s+1,e) end
return nil
end

--Alphablit Anim
--Blits a custom image with alphavalue animation.(Should be called out of a loop)
function AlphaBlit(img)
local image = img
local fader = Image.createEmpty(480,272)
local alphaValue = 255
local faderColor = Color.new(0,0,0,alphaValue)
fader:clear(faderColor)
	while true do
		screen:clear()
		screen:blit(0,0,image)
		screen:blit(0,0,fader)
			if alphaValue > 0 then
			alphaValue = alphaValue - 5
			else
			break
			end
		faderColor = Color.new(0,0,0,alphaValue)
		fader:clear(faderColor)
		swapBuffers()
	end
screen.waitVblankStart(200)
collectgarbage()
	while true do
		--screen:clear()
		screen:blit(0,0,image)
		screen:blit(0,0,fader)
		   if alphaValue < 255 then
		   alphaValue = alphaValue + 5
		   else
		   break
		   end
		faderColor = Color.new(0,0,0,alphaValue)
		fader:clear(faderColor)
		swapBuffers()
	end
alphaValue,fader,faderColor = nil,nil,nil
collectgarbage()
end


function MainMenu()
	local state = 'Menu'
	local background = Image.load('./Images/splash/AON.png')
	local font = Font.load("./Font/harrington.ttf")
		  font:setPixelSizes(15,15)
	local _text = dialog.mainmenu
	local _options = dialog.lang
	local append = (Engine.locale=='FR') and 'Francais..>' or '<..English'
	local cur = 1	
	
	dofile './scripts/credits.lua'
	local function navigate(pad,oldpad)
		if pad and oldpad then
			if pad:up() and not oldpad:up() then 
				if _text[cur-1] then cur = cur-1 end
			elseif pad:down() and not oldpad:down() then 
				if _text[cur+1] then cur = cur+1 end
			end
		end		
	end	
		
	Mp3me.load('./SFX/BubbleChum.mp3')
	Mp3me.play()
	local oldpad = Controls.read()
	repeat
		while state=='Menu' do
	local pad = Controls.read()
	navigate(pad,oldpad)
	screen:clear()	
	screen:blit(0,0,background)
		for k,v in pairs(_text) do
		local length = (Font.getTextSize(font,v).width)
		local color = (k~=cur) and Color.new(255,255,255) or Color.new(255,255,0)
		printf(font,240-(length/2),200+15*k,v,color)
		end		
		if pad:cross() and not oldpad:cross() then
			if cur == 1 then 
			state = nil 
			
			dofile './scripts/Anim3DLib.lua'
			local spr = Image.load './Images/misc/leaf.png'
			Anim3D.createModel(spr)
			
			Engine.loadCampaign('./campaign/tutorial.cpn') 
			elseif cur==2 then state='Options'
			elseif cur==3 then state='Credits'
			else 
				System.message(dialog.exit,1)
				if System.buttonPressed(1)=='yes' then System.Quit() end
			end		
		end
		
	swapBuffers()
	oldpad = pad
	end
	
		while state=='Options' do
	local pad = Controls.read()
	navigate(pad,oldpad)
	screen:clear()
	screen:blit(0,0,background)
		if pad:left() and not oldpad:left() then append = 'Francais..>'
		elseif pad:right() and not oldpad:right() then append = '<..English'
		end	
		for k,v in pairs(_options) do
		local length = ((v:len())*15)
		printf(font,250-length/2,200+15*k,v..append)
		end
		if pad:circle() and not oldpad:circle() then
		local sav = (append=='Francais..>') and 'FR' or 'EN'
		local f = assert(io.open('./playerdata/locale.lua','w'))
		f:write('Engine.locale='..string.format('%q',sav))		
		f:close()		
		Engine.setLocale()
		_text = dialog.mainmenu
		_options = dialog.lang
		append = (Engine.locale=='FR') and 'Francais..>' or '<..English'
		state = 'Menu'
		end
	swapBuffers()
	oldpad = pad
	end
		
	
	while state=='Credits' do
		if not cur_cre  then cur_cre = 0 end
	cur_cre = cur_cre+0.02
	screen:clear()
	screen:blit(0,0,background)
	local l1 = credits[math.ceil(cur_cre)]
	local l2 = credits_name[math.ceil(cur_cre)]
		if l1 and l2 then
		printf(font,240-(Font.getTextSize(font,l1).width/2),200+20,l1,Color.new(255,255,255))
		printf(font,240-(Font.getTextSize(font,l2).width/2),200+35,l2,Color.new(255,255,0))	
		else	
		cur_cre = nil		
		state = 'Menu'		
		end	
	swapBuffers()
	end
	
	until (not state)
	state,background,font,_text,_options,append,cur= nil,nil,nil,nil,nil,nil,nil
	Mp3me.stop()
end
