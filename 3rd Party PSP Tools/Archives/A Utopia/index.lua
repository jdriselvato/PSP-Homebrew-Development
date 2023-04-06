function debugval(theval)
   screen:clear()
               screen:print(250,20,theval,white)
   screen:flip()
   while (true) do
      pad = Controls.read()
      if pad:start() then
         time=os.clock()
         while (os.clock()-time<1.5) do
         end
         break
      end
   end
end

--#################################
--BITMAP FONT OBJECT
--#################################
bitmapfont = {
               image = {},
               charmap  = " ",
               width = 0,
               height = 0
}

function bitmapfont:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function bitmapfont:load(filename,charw,charh,tcharmap)
            self.image=Image.load(filename)
            self.height=charh
            self.width=charw
            self.charmap=tcharmap
end

function bitmapfont:findletter(letterl)
   pos=0
   for i=1,string.len(self.charmap) do
      if (string.sub(self.charmap,i,i)==letterl) then
         pos=i
         break
      end
   end
   return pos
end

function bitmapfont:print(x,y,text)
      text=string.upper(text)
      for i=1,string.len(text) do
      letter=string.sub(text,i,i)
         if (letter~=" ") then
            loc=self:findletter(letter)
            if (loc>0) then
               screen:blit(x+((i-1)*self.width),y,self.image,(loc-1)*self.width,0,self.width,self.height,true)
            end
         end
      end
end

function bitmapfont:printimage(text)
      returnimg=Image.createEmpty(string.len(text)*self.width,self.height)
      text=string.upper(text)
      for i=1,string.len(text) do
      letter=string.sub(text,i,i)
         if (letter~=" ") then
            loc=self:findletter(letter)
            if (loc>0) then
               returnimg:blit((i-1)*self.width,0,self.image,(loc-1)*self.width,0,self.width,self.height,true)
            end
         end
      end
   return returnimg
end

function bitmapfont:printverticalimage(text)
      returnimg=Image.createEmpty(self.width,self.height*string.len(text))
      text=string.upper(text)
      for i=1,string.len(text) do
      letter=string.sub(text,i,i)
         if (letter~=" ") then
            loc=self:findletter(letter)
            if (loc>0) then
               returnimg:blit(0,(i-1)*self.height,self.image,(loc-1)*self.width,0,self.width,self.height,true)
            end
         end
      end
   return returnimg
end

--#################################
--MARQUEE OBJECT
--#################################

marqueemessage = {
	img = {},
	x = 0,
	message = ""
}

function marqueemessage:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

marquee = {
	messages = {},
	x = 0,
	empty = true,
	marqueetime=0
}

function marquee:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function marquee:addtext(texti)
	n=marqueemessage:new()
	n.img=font:printimage(texti)
	n.caption=texti
	n.x=fullscreenw
	high=table.getn(self.messages)
	if (high>0)
	and(self.messages[high].x+self.messages[high].img:width()+25>=fullscreenw) then
	    n.x=self.messages[high].x+self.messages[high].img:width()+25
	end
	table.insert(self.messages,n)
end

function marquee:draw()

	--check if there is anything to draw
	if (table.getn(self.messages)==0) then return end

	move=false
	if (os.clock()-self.marqueetime>0.05) then
	    self.marqueetime=os.clock()
     move=true
	end

	n=0
	for i=1,table.getn(self.messages) do
	    if (i-n>table.getn(self.messages)) then break end
		
		if (self.messages[i-n].x+self.messages[i-n].img:width()<=0) then
			table.remove(self.messages,i-n)
			n=n+1
		else
			if (move==true) then
				self.messages[i-n].x=self.messages[i-n].x-3
			end

			xadd=0
			if (xadd<0) then
				xadd=math.abs(self.messages[i-n].x)
			end
			
			screen:blit(self.messages[i-n].x+xadd,fullscreenh-1-self.messages[i-n].img:height(),self.messages[i-n].img,xadd,0,self.messages[i-n].img:width()-xadd,self.messages[i-n].img:height(),true)
		end
	end
	
end


--#################################
--BUILDING OBJECT
--#################################
buildingarray = { }

building = {
   x = 0,
   y = 0,
   life = 0,
   constructing = 0,
   type = "",
   destroyed = 0,
   created = 0
}

buildingtypes = {
   ["smallhouse"]
         = {
            tileid=0,
            price=750,
            occupancy = 5,
            job=0,
            constructiontime = 30,
            life = 180,
            waterreq=4,
            electricityreq=4,
            water=0,
            electricity=0,
            cat="house"
         },
   ["mediumhouse"]
         = {
            tileid=1,
            price=1550,
            occupancy = 10,
            constructiontime = 40,
            job=0,
            life = 180,
            waterreq=5,
            electricityreq=5,
            water=0,
            electricity=0,
            cat="house"
         },
   ["largehouse"]
         = {
            tileid=2,
            price=3200,
            occupancy = 20,
            constructiontime = 45,
            job=0,
            life = 180,
            waterreq=6,
            electricityreq=6,
            water=0,
            electricity=0,
            cat="house"
         },
   ["mediumcommerce"]
         = {
            tileid=4,
            price=3000,
            occupancy = 0,
            constructiontime = 45,
            job=13,
            life = 180,
            waterreq=6,
            electricityreq=6,
            water=0,
            electricity=0,
            cat="commerce"
         },
   ["largecommerce"]
         = {
            tileid=5,
            price=6000,
            occupancy = 0,
            constructiontime = 65,
            job =25,
            life = 180,
            waterreq=8,
            electricityreq=8,
            water=0,
            electricity=0,
            cat="commerce"
         },
   ["smallwater"]
         = {
            tileid=8,
            price=1000,
            occupancy = 0,
            constructiontime = 65,
            job = 2,
            life = 180,
            waterreq=0,
            electricityreq=2,
            water=14,
            electricity=0,
            cat="water"
         },
   ["mediumwater"]
         = {
            tileid=9,
            price=3000,
            occupancy = 0,
            constructiontime = 65,
            job = 4,
            life = 180,
            waterreq=0,
            electricityreq=5,
            water=30,
            electricity=0,
            cat="water"
         },
   ["largewater"]
         = {
            tileid=10,
            price=8000,
            occupancy = 0,
            constructiontime = 65,
            job = 7,
            life = 180,
            waterreq=0,
            electricityreq=10,
            water=55,
            electricity=0,
            cat="water"
         },
   ["superwater"]
         = {
            tileid=11,
            price=15000,
            occupancy = 0,
            constructiontime = 65,
            job = 10,
            life = 180,
            waterreq=0,
            electricityreq=15,
            water=95,
            electricity=0,
            cat="water"
         },
   ["smallelectricity"]
         = {
            tileid=12,
            price=1000,
            occupancy = 0,
            constructiontime = 65,
            job = 2,
            life = 180,
            waterreq=2,
            electricityreq=0,
            water=0,
            electricity=14,
            cat="electricity"
         },
   ["mediumelectricity"]
         = {
            tileid=13,
            price=3000,
            occupancy = 0,
            constructiontime = 65,
            job = 4,
            life = 180,
            waterreq=5,
            electricityreq=0,
            water=0,
            electricity=30,
            cat="electricity"
         },
   ["largeelectricity"]
         = {
            tileid=14,
            price=8000,
            occupancy = 0,
            constructiontime = 65,
            job = 7,
            life = 180,
            waterreq=10,
            electricityreq=0,
            water=0,
            electricity=55,
            cat="electricity"
         },
   ["superelectricity"]
         = {
            tileid=15,
            price=15000,
            occupancy = 0,
            constructiontime = 65,
            job = 10,
            life = 180,
            waterreq=15,
            electricityreq=0,
            water=0,
            electricity=95,
            cat="electricity"
         }

}

function building:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function building:load(xi,yi,wi,lifei,constructingi,typei)
  self.x=xi
  self.y=yi
  self.life=lifei
  self.constructing=constructingi
  self.type=typei
  self.created=globaltime
end

function newbuilding(xi,xy,typei)
   newindex=0
   for i=1,table.getn(buildingarray) do
      if (buildingarray[i].destroyed==1) then
         newindex=i
         break
      end
   end

   if (newindex==0) then
      table.setn(buildingarray,table.getn(buildingarray)+1)
      newindex=table.getn(buildingarray)
   end

   buildingarray[newindex]=building:new()
   buildingarray[newindex].x=xi
   buildingarray[newindex].y=yi
   buildingarray[newindex].life=buildingtypes[typei].life
   buildingarray[newindex].constructing=buildingtypes[typei].constructiontime
   buildingarray[newindex].created=globaltime
   buildingarray[newindex].type=typei
   map.map[xi][xy]["buildingid"]=newindex
end



--#################################
--ICON OBJECT
--#################################
gameicon = {
      w = 0,
      h = 0,
      x = 0,
      y = 0,
      caption = ""
}

function gameicon:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function gameicon:load(xi,yi,wi,hi,captioni,typei)
  self.w=wi
  self.h=hi
  self.x=xi
  self.y=yi
  self.caption=captioni
end

function gameicon:hit(drawtext)
   if (cursorx+cursor:width()/2>=self.x) and (cursorx+cursor:width()/2<=self.x+self.w) and (cursory+cursor:height()/2>=self.y) and (cursory+cursor:height()/2<=self.y+self.h) then
      if drawtext then
         screen:print(cursorx+1+cursor:width()/2,cursory+1+cursor:height()/2,self.caption,white)
         screen:print(cursorx+cursor:width()/2,cursory+cursor:height()/2,self.caption,black)
      end
      return true
   else
      return false
   end
end

--#################################
--GAME MAP OBJECT
--#################################
gamemap = {
              map = {},
              offscreen = {}
}

function gamemap:generatesingleoffscreen(x,y)
   returnimg=Image.createEmpty(offscreenmaxw,offscreenmaxh)
   for b=1,((offscreenmaxh/tileh)*2)+1+math.ceil(buildingtileh/(tileh/2)) do
      for a=1,offscreenmaxw/tilew+1 do
         if (a+x>maptilew) or (b+y>maptileh) then break end

         if (self.map[a+x][b+y]["buildingid"]==0) then --draw a tile
            tileid=self.map[a+x][b+y]["tileid"]
            if (tileid==nil) then tileid=2 end
            tilesetsrcX = math.mod(tileid,tilesetrow)  * tilew
            tilesetsrcY = math.floor(tileid/tilesetrow) * tileh
            xadd=0
            yadd=0
            if (math.mod(b,2)==1) then --odd
               xadd=-(tilew/2)
            end
            xcoord=math.floor((a-1)*tilew+xadd)
            ycoord=math.floor((b-2)*(tileh/2))
            srcxadd=0
            srcyadd=0
            if (xcoord<0) then
               srcxadd=math.abs(xcoord)
            end
            if (ycoord<0) then
               srcyadd=math.abs(ycoord)
            end
            if (xcoord<=offscreenmaxw) or (ycoord<=offscreenmaxh) then
               returnimg:blit(xcoord+srcxadd,ycoord+srcyadd,tileset,tilesetsrcX+srcxadd,tilesetsrcY+srcyadd,tilew-srcxadd,tileh-srcyadd,true)
            end

         else--draw a building
            buildingtype=buildingarray[self.map[a+x][b+y]["buildingid"]].type

            --building stats
            gameresidents=buildingtypes[buildingtype].occupancy+gameresidents
            gamejobsreq=buildingtypes[buildingtype].occupancy+gamejobsreq
            gamejobs=buildingtypes[buildingtype].job+gamejobs
            gamewater=buildingtypes[buildingtype].water+gamewater
            gamewaterreq=buildingtypes[buildingtype].waterreq+gamewaterreq
            gameelectricity=buildingtypes[buildingtype].electricity+gameelectricity
            gameelectricityreq=buildingtypes[buildingtype].electricityreq+gameelectricityreq

            tileid=buildingtypes[buildingtype].tileid
            tilesetsrcX = math.mod(tileid,buildingtilesetrow)  * buildingtilew
            tilesetsrcY = math.floor(tileid/buildingtilesetrow) * buildingtileh
            xadd=0
            yadd=0
            if (math.mod(b,2)==1) then --odd
               xadd=-(tilew/2)
            end
            xcoord=math.floor((a-1)*tilew+xadd)
            ycoord=math.floor((b-2)*(tileh/2)-(buildingtileh-tileh))
            srcxadd=0
            srcyadd=0
            if (xcoord<0) then
               srcxadd=math.abs(xcoord)
            end
            if (ycoord<0) then
               srcyadd=math.abs(ycoord)
            end
            if (xcoord<=offscreenmaxw) or (ycoord<=offscreenmaxh) then
               returnimg:blit(xcoord+srcxadd,ycoord+srcyadd,buildingimg,tilesetsrcX+srcxadd,tilesetsrcY+srcyadd,buildingtilew-srcxadd,buildingtileh-srcyadd,true)
            end
         end
      end
   end
   return returnimg
end

function gamemap:generateoffscreens()
   gamewaterreq=0
   gamewater=0
   gameelectricityreq=0
   gameelectricity=0
   gamehouse     =0
   gamehousereq=0
   gamejobs        =0
   gamejobsreq   =0
   gameresidents =0

   for a=1,math.ceil(mapw/offscreenmaxw) do
      self.offscreen[a]={}
      for b=1,math.ceil(maph/offscreenmaxh) do
         self.offscreen[a][b]=self:generatesingleoffscreen((a-1)*offscreenmaxw/tilew, (b-1)*((offscreenmaxh/tileh)*2) )
      end
   end

   blitstats()
end      

function gamemap:generatetile(xi,yi)
	x=math.floor(xi/(offscreenw/tilew))
	y=math.floor(yi/(offscreenh/tileh))  
	tilex=xi-x*offscreenw
	tiley=yi-y*offscreenh
	self.offscreen[x][y]=self:generatesingleoffscreen((x-1)*offscreenmaxw/tilew, (y-1)*((offscreenmaxh/tileh)*2) )
	
	if (tilex>=offscreenw/tilew) and (x+1<=math.ceil(mapw/offscreenmaxw)) then
		self.offscreen[x+1][y]=self:generatesingleoffscreen((x)*offscreenmaxw/tilew, (y-1)*((offscreenmaxh/tileh)*2) )				
	end
	if (tiley>=offscreenh/tileh) and (y+1<=math.ceil(maph/offscreenmaxh)) then
		self.offscreen[x][y+1]=self:generatesingleoffscreen((x-1)*offscreenmaxw/tilew, (y)*((offscreenmaxh/tileh)*2) )				
	end
	if (tilex>=offscreenw/tilew) and (x+1<=math.ceil(mapw/offscreenmaxw))
	and(tiley>=offscreenh/tileh) and (y+1<=math.ceil(maph/offscreenmaxh)) then
		self.offscreen[x+1][y+1]=self:generatesingleoffscreen((x)*offscreenmaxw/tilew, (y)*((offscreenmaxh/tileh)*2) )				
	end
	
end

function gamemap:drawoffscreens()
   for a=1,math.ceil(screenw/offscreenmaxw)+1 do
      for b=1,math.ceil(screenh/offscreenmaxh)+1 do
         XID=a+math.floor(scrollx/offscreenmaxw)
         YID=b+math.floor(scrolly/offscreenmaxh)
         if (XID>math.ceil(mapw/offscreenmaxw)) or (YID>math.ceil(maph/offscreenmaxh)) then break end
         runX=((XID-1)*offscreenmaxw)-scrollx
         runY=((YID-1)*offscreenmaxh)-scrolly
         screen:blit(runX+panel:width(),runY,self.offscreen[XID][YID],true)
      end
   end
end

function gamemap:makestructure(xi,yi,newtile)
	self.map[xi][yi]["tileid"]=newtile

	for y=yi-1,yi+1 do
	    for x=xi-1,xi+1 do
	    	gamemap:setroad(x,y)
	    end
	end

	self:generateoffscreens()
end

function gamemap:setroad(x,y)
	 --got the idea for this function from nebula on blitzcoder. ported it to isometric engine

     if (x<1) or (y<1) or (x>maptilew) or (y>maptileh) then return end
     if self.map[x][y]["tileid"] == 0 then return end

	 r=""
	 if (math.mod(y,2)==0) then--evens and odds
     	if (y-1>0) and
		 (self.map[x][y-1]["tileid"] > 1) then r = r.."1" else r = r.."0" end

	    if (y+1<maptileh) and
		 (self.map[x][y+1]["tileid"] > 1) then r = r.."1" else r = r.."0" end

	    if (x+1<maptilew) and (y-1>0) and
		 (self.map[x+1][y-1]["tileid"] > 1) then r = r.."1" else r = r.."0" end

	    if (y+1<maptileh) and (x+1<maptilew) and
		 (self.map[x+1][y+1]["tileid"] > 1) then r = r.."1" else r = r.."0" end
	 else
     	if (y-1>0) and (x-1>0) and
		 (self.map[x-1][y-1]["tileid"] > 1) then r = r.."1" else r = r.."0" end
	    if (x-1>0) and (y+1<maptileh) and
		 (self.map[x-1][y+1]["tileid"] > 1) then r = r.."1" else r = r.."0" end
	    if (y-1>0) and
		 (self.map[x][y-1]["tileid"] > 1) then r = r.."1" else r = r.."0" end
	    if (y+1<maptileh) and
		 (self.map[x][y+1]["tileid"] > 1) then r = r.."1" else r = r.."0" end
	 end

     	 if (r=="0000") then t = 12 --1
     elseif (r=="1000") then t = 12 --3
     elseif (r=="0100") then t = 11 --3
     elseif (r=="0010") then t = 11 --2
     elseif (r=="0001") then t = 12 --2
     elseif (r=="1100") then t = 10 --3
     elseif (r=="0011") then t = 2 --2
     elseif (r=="1010") then t = 8 --8
     elseif (r=="1001") then t = 12 --10
     elseif (r=="0110") then t = 11 --9
     elseif (r=="0101") then t = 4 --11
     elseif (r=="1110") then t = 9 --6
     elseif (r=="1101") then t = 7 --7
     elseif (r=="1011") then t = 5 --4
     elseif (r=="0111") then t = 3 --5
     elseif (r=="1111") then t = 6 --1
     end
     self.map[x][y]["tileid"] = t
end

function gamemap:new()
	for a=1,maptilew do
		self.map[a]={}
		for b=1,maptileh do
			self.map[a][b]={ ["tileid"]=0,["buildingid"]=0 }
		end
	end

   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

--#################################
--KEY MOVEMENTS
--#################################
function getKeys()
   nomovement=nomovement+1
   --screenie
   if pad:l() then screen:save("utopia-ss.png") end
   dx=pad:analogX()
   --cursor movement
	if (math.abs(dx) > 32) and (math.abs(dx) <110) then
      nomovement=0
		cursorx = cursorx+math.floor(dx/70)
   elseif math.abs(dx)>32 then
      nomovement=0
      cursorx = cursorx+math.floor(dx/40)
	end

	dy=pad:analogY()
	if (math.abs(dy) > 32) and (math.abs(dy) <110) then
      nomovement=0
		cursory = cursory+math.floor(dy/70)
   elseif math.abs(dy)>32 then
      nomovement=0
      cursory = cursory+math.floor(dy/40)
	end

   --cursor clip
   if cursorx+cursor:width()/2<0 then cursorx=0-cursor:width()/2 end
   if cursory+cursor:height()/2<0 then cursory=0-cursor:height()/2 end
   if cursorx+cursor:width()/2>fullscreenw then cursorx=fullscreenw-cursor:width()/2 end
   if cursory+cursor:height()/2>fullscreenh then cursory=fullscreenh-cursor:height()/2 end
   --camera movement
   if (cursorx+cursor:width()/2==0) and (scrollx>0) and (dx<-32) then scrollx=scrollx-4 end
   if (cursory+cursor:height()/2==0) and (scrolly>0) and (dy<-32) then scrolly=scrolly-4 end
   if (cursorx-cursor:width()/2>=fullscreenw-cursor:width()) and (dx>32) then scrollx=scrollx+4 end
   if (cursory-cursor:height()/2>=fullscreenh-cursor:height()) and (dy>32) then scrolly=scrolly+4 end

   if (pad:left()) then scrollx=scrollx-5 end
   if (pad:right()) then scrollx=scrollx+5 end
   if (pad:up()) then scrolly=scrolly-5 end
   if (pad:down()) then scrolly=scrolly+5 end
   --cam clip
   if (scrollx<0) then scrollx=0 end
   if (scrolly<0) then scrolly=0 end
   if (scrollx>mapw+tilew-screenw) then scrollx=mapw+tilew-screenw end
   if (scrolly>maph+tileh-screenh) then scrolly=maph+tileh-screenh end
   --construction
   if (pad:cross()) then
      if (houseicon:hit(false)) then constructmenu("smallhouse mediumhouse largehouse") return end
      if (commerceicon:hit(false)) then constructmenu("mediumcommerce largecommerce") return end
      if (electricityicon:hit(false)) then constructmenu("smallelectricity mediumelectricity largeelectricity superelectricity") return end
      if (watericon:hit(false)) then constructmenu("smallwater mediumwater largewater superwater") return end
      if (roadicon:hit(false)) then constructingroad=true constructingid="" return end
   end

end

--#################################
--DATE FUNCTIONS
--#################################
function blitDate()
   dateimg=font:printimage( string.format("%02d-%02d-%02d",datemonth,dateday,dateyear) )
end

function addDay()

   if (os.clock()-lastaddday<2) then return end

   dateday=dateday+1

   if (math.mod(datemonth,2)==1) and (dateday==31) then
      datemonth=datemonth+1
      dateday=1
      endofthemonth()
   elseif (math.mod(datemonth,2)==0) and (dateday==30) then
      datemonth=datemonth+1
      dateday=1
      endofthemonth()
   end

   if (datemonth==12) then
      dateyear=dateyear+1
      datemonth=1
   end

   blitDate()

   lastaddday=os.clock()

end

function endofthemonth()

   beginval=gamemoney

   --residents give money
   gamemoney=gamemoney+gameresidents*3

   if (gamejobs-gamejobsreq<0) then
      --pay for unemployment
      gamemoney=gamemoney-math.abs(gamejobs-gamejobsreq)*10
   else
      --get money from jobs
      if (gamejobs-gamejobsreq>gameresidents) then val=gameresidents
      else val=gamejobs-gamejobsreq end
      gamemoney=gamemoney+val*8
   end

   gamemoney=gamemoney-gamewaterreq*5 --pay for water
   gamemoney=gamemoney-gameelectricityreq*5  --pay for electricity

   gamemoney=gamemoney+gamewater*3 --get money from water
   gamemoney=gamemoney+gameelectricity*3 --get money from electricity

   val=gamemoney-beginval
   if (val>=0) then val="+"..string.format("%d",math.abs(val))
   else val="-"..string.format("%d",math.abs(val)) end
   newflyingtext(fullscreenw-50,fullscreenh-15,val,90,false)
end

--#################################
--FLYING TEXT FUNCTIONS
--#################################

aflyingtext = {
              x = 0,
              y = 0,
              text = "",
              life = 50,
              lived = 0,
              inmap = false
}

function aflyingtext:new()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function newflyingtext(xi,yi,texti,lifei,inmapi)
   newval=aflyingtext:new()
   newval.x=xi
   newval.y=yi
   newval.text=texti
   newval.life=lifei
   newval.inmap=inmapi
   table.insert(flyingtext,newval)
end

function processflyingtext()
   if (os.clock()-lastflyingtext<0.3) then return end
   n=0
   for i=1,table.getn(flyingtext) do
      if (i-n>table.getn(flyingtext)) then break end

      if (flyingtext[i-n].lived>flyingtext[i-n].life) then
         table.remove(flyingtext,i-n)
         n=n+1
      else
         flyingtext[i-n].lived=flyingtext[i-n].lived+1
         color=250-( (250/flyingtext[i-n].life) * flyingtext[i-n].lived)
         newcol=Color.new(color,color,color)
         if (flyingtext[i-n].inmap==true) then
            screen:print(flyingtext[i-n].x-scrollx+panel:width(),flyingtext[i-n].y-scrolly-flyingtext[i-n].lived,flyingtext[i-n].text,newcol)
         else
            screen:print(flyingtext[i-n].x,flyingtext[i-n].y-flyingtext[i-n].lived,flyingtext[i-n].text,newcol)
         end
      end
   end
end

--#################################
--EXTRA FUNCTIONS
--#################################         

function dialogmsg(title,text)

	title=font:printimage(title)
	msg=font:printimage(text)
	w=msg:width()+20
	screen:clear()
	screen:fillRect( (fullscreenw-w)/2 ,100,w,10,Color.new(51,99,253) )
	screen:blit((fullscreenw-w)/2+(w-msg:width())/2,100,title,true)
	screen:fillRect( (fullscreenw-w)/2 ,110,w,25,Color.new(237,224,115) )
	screen:blit((fullscreenw-w)/2+(w-msg:width())/2,115,msg,true)
	screen.waitVblankStart()
	screen.flip()
	System.sleep(300)
	while true do
		pad=Controls.read()
		if pad:cross() then
			System.sleep(300)
			break
		end
	end
end

function pausegame()
   screen:blit(fullscreenw/2-(pauseimg:width()/2),fullscreenh/2-(pauseimg:height()/2),pauseimg,true)
   screen.waitVblankStart()
   screen:flip()
   System.sleep(300)--sleep to wait for key unpush
   while true do
      pad = Controls.read()
      if pad:start() then
         System.sleep(300)
         break
      end
   end
end

function blitGUI()
   GUI:blit(0,0,panel,false)   --panel
   GUI:blit(fullscreenw-bottompanel:width(),fullscreenh-bottompanel:height(),bottompanel,false) --bottom panel
   GUI:blit((panel:width()-logo:width())/2,fullscreenh-logo:height()-20,logo,true) --logo text
   GUI:blit(9,4,constructionicons,true) --construction icons

--   GUI:blit(stathouseicon.x,stathouseicon.y,statsicons,0,0,stathouseicon.w,stathouseicon.h,true)--stat icons
   GUI:blit(statcommerceicon.x,statcommerceicon.y,statsicons,16,0,statcommerceicon.w,statcommerceicon.h,true)--stat icons
   GUI:blit(statelectricityicon.x,statelectricityicon.y,statsicons,32,0,statelectricityicon.w,statelectricityicon.h,true)--stat icons
   GUI:blit(statwatericon.x,statwatericon.y,statsicons,48,0,statwatericon.w,statwatericon.h,true)--stat icons
   GUI:blit(statresidentsicon.x,statresidentsicon.y,statsicons,64,0,statelectricityicon.w,statelectricityicon.h,true)--stat icons

   GUI:fillRect(panel:width(),0,fullscreenw-panel:width(),fullscreenh-bottompanel:height())--make the screen area visible
end

function blitstats()
   blitGUI()

--   val=(gamehouse-gamehousereq)
--   if (val>=0) then val="+"..string.format("%d",math.abs(val))
--   else val="-"..string.format("%d",math.abs(val)) end
--   stattxt=font:printimage(val)
--   GUI:blit(stathouseicon.x+18,stathouseicon.y+4,stattxt,true)

   val=(gamejobs-gamejobsreq)
   if (val>=0) then val="+"..string.format("%d",math.abs(val))
   else val="-"..string.format("%d",math.abs(val)) end
   stattxt=font:printimage(val)
   GUI:blit(statcommerceicon.x+18,statcommerceicon.y+4,stattxt,true)

   val=(gameelectricity-gameelectricityreq)
   if (val>=0) then val="+"..string.format("%d",math.abs(val))
   else val="-"..string.format("%d",math.abs(val)) end
   stattxt=font:printimage(val)
   GUI:blit(statelectricityicon.x+18,statelectricityicon.y+4,stattxt,true)

   val=(gamewater-gamewaterreq)
   if (val>=0) then val="+"..string.format("%d",math.abs(val))
   else val="-"..string.format("%d",math.abs(val)) end
   stattxt=font:printimage(val)
   GUI:blit(statwatericon.x+18,statwatericon.y+4,stattxt,true)

   stattxt=font:printimage(string.format("%d",gameresidents))
   GUI:blit(statresidentsicon.x+18,statresidentsicon.y+4,stattxt,true)

   stattxt=font:printimage("$"..string.format("%d",gamemoney))
   GUI:blit(fullscreenw-stattxt:width()-20,statresidentsicon.y+4,stattxt,true)
end

function constructmenu(tbuildingtype)
   constructingroad=false
   if (tbuildingtype=="") or (tbuildingtype==nil) then return end
   --get all the buildings under that cat
   thebuildings={}
   while true do
      ind=string.find(tbuildingtype," ")
      if (ind~=nil) then
         cur=string.sub(tbuildingtype,1,ind-1)
      else
         cur=string.sub(tbuildingtype,1)
      end

      if (cur~=nil) then
         table.insert(thebuildings,cur)
      end

      if (string.find(tbuildingtype," ")~=nil)  then
         tbuildingtype=string.sub(tbuildingtype,string.find(tbuildingtype," ")+1)
      else
         break
      end

   end

   if (table.getn(thebuildings)==0) then
      return
   end

   itemw=80
   itemindex=1
   bg=Color.new(207,158,111)
   selectioncolor=Color.new(221,191,158)
   selectionmenu=Image.createEmpty(table.getn(thebuildings)*itemw,200)
   selectionmenu:fillRect(0,0,selectionmenu:width(),selectionmenu:height(),bg)
   selectionx=(fullscreenw-selectionmenu:width())/2
   selectiony=(fullscreenh-selectionmenu:height())/2
   lastmove=0
   while (true) do
   	apad = Controls.read()
      if apad:triangle() then
         break
      end

      if apad:square() then
         constructingid=thebuildings[itemindex]
         break
      end

      if (os.clock()-lastmove>0.3) then
         if (apad:analogX()<-32) or (apad:left()) then
            if (itemindex>1) then
               lastmove=os.clock()
               itemindex=itemindex-1
            end
         end
         if (apad:analogX()>32) or (apad:right()) then
            if (itemindex<table.getn(thebuildings)) then
               lastmove=os.clock()
               itemindex=itemindex+1
            end
         end
      end

      screen:blit(selectionx,selectiony,selectionmenu,false)
      --draw pics
      for i=1,table.getn(thebuildings) do
         tileid=buildingtypes[thebuildings[i]].tileid
         tilesetsrcX = math.mod(tileid,buildingtilesetrow)  * buildingtilew
         tilesetsrcY = math.floor(tileid/buildingtilesetrow) * buildingtileh
         if itemindex==i then
            printy=selectiony+buildingtileh+25
            --print building stat
            screen:print(selectionx+2,printy,"Price:$"..buildingtypes[thebuildings[i]].price,black) printy=printy+10
            screen:print(selectionx+2,printy,"Life Expc.:"..buildingtypes[thebuildings[i]].life.." years",black) printy=printy+10
           if buildingtypes[thebuildings[i]].occupancy>0 then
            screen:print(selectionx+2,printy,"Residents:"..buildingtypes[thebuildings[i]].occupancy,black) printy=printy+10 end
           if buildingtypes[thebuildings[i]].job>0 then
            screen:print(selectionx+2,printy,"Jobs:"..buildingtypes[thebuildings[i]].job,black) printy=printy+10 end
           if buildingtypes[thebuildings[i]].waterreq>0 then
            screen:print(selectionx+2,printy,"Water Req.:"..buildingtypes[thebuildings[i]].waterreq,black) printy=printy+10 end
           if buildingtypes[thebuildings[i]].electricityreq>0 then
            screen:print(selectionx+2,printy,"Electricity Req.:"..buildingtypes[thebuildings[i]].electricityreq,black) printy=printy+10 end
           if buildingtypes[thebuildings[i]].water>0 then
            screen:print(selectionx+2,printy,"Water Provided:"..buildingtypes[thebuildings[i]].water,black) printy=printy+10 end
           if buildingtypes[thebuildings[i]].electricity>0 then
            screen:print(selectionx+2,printy,"Electricity Provided:"..buildingtypes[thebuildings[i]].electricity,black) printy=printy+10 end

            screen:fillRect(selectionx+(itemw-buildingtilew)/2+itemw*(i-1),selectiony+10,buildingtilew,buildingtileh,selectioncolor)
         end
         screen:blit(selectionx+(itemw-buildingtilew)/2+itemw*(i-1) ,selectiony+10,buildingimg,tilesetsrcX,tilesetsrcY,buildingtilew,buildingtileh)
      end

      screen:print(selectionx+1,selectiony+1,"Pick a building...",black)

      screen.waitVblankStart()
      screen.flip()

   end
end

function pixeltotile(xi,yi) --returns in format ={x,y}
   --get which rect we're on
   px=math.floor(xi/tilew)
   py=math.floor(yi/tileh)
   --get the pixel in the rect
   rx=xi-(px*tilew)
   ry=yi-(py*tileh)
   --get the actual x,y
   realx=px
   realy=1+(py*2)
   --see if we have to move
   pcolor=tilemask:pixel(rx,ry)
   if (pcolor==white) then--we need to move it to the right place
      if (rx<tilew/2) and (ry<tileh/2) then --top left
         realy=realy-1
      elseif (rx<tilew/2) and (ry>tileh/2) then --bottom left
         realy=realy+1
      elseif (rx>tilew/2) and (ry<tileh/2) then --top right
         realx=realx+1
         realy=realy-1
      elseif (rx>tilew/2) and (ry>tileh/2) then --bottom right
         realx=realx+1
         realy=realy+1
      end
   end

   result={realx+1,realy+1}--offset for lua table start
   return result
end

function tiletopixel(xi,yi)
   xadd=0
   if (math.mod(yi,2)==1) then --odd
      xadd=-(tilew/2)
   end
   result={math.floor((xi-1)*tilew+xadd),math.floor((yi-2)*(tileh/2))}
   return result
end

function constructroad()
   if cursorx+cursor:width()/2<panel:width() then return end
   if cursory+cursor:height()/2>fullscreenh-bottompanel:height() then return end

   rx=cursorx+cursor:width()/2-panel:width()+scrollx
   ry=cursory+scrolly+cursor:height()/2
   tilecoord=pixeltotile(rx,ry)
   pixelcoord=tiletopixel(tilecoord[1],tilecoord[2])
   if (map.map[tilecoord[1]][tilecoord[2]]["buildingid"]~=0)
    or(map.map[tilecoord[1]][tilecoord[2]]["tileid"]~=0) then return end--already something here
   tileid=12
   tilesetsrcX = math.mod(tileid,tilesetrow)  * tilew
   tilesetsrcY = math.floor(tileid/tilesetrow) * tileh
   screen:blit(pixelcoord[1]-scrollx+panel:width(),pixelcoord[2]-scrolly,tileset,tilesetsrcX,tilesetsrcY,tilew,tileh,true)

   if pad:cross() then
      if (gamemoney<3) then
         dialogmsg("Error","not enough money")
         return
      end
      --build it
      gamemoney=gamemoney-3
      newflyingtext(pixelcoord[1],pixelcoord[2],"-$3",70,true)
      map:makestructure(tilecoord[1],tilecoord[2],11)      
   end
end

function constructing()
   if cursorx+cursor:width()/2<panel:width() then return end
   if cursory+cursor:height()/2>fullscreenh-bottompanel:height() then return end

   rx=cursorx+cursor:width()/2-panel:width()+scrollx
   ry=cursory+scrolly+cursor:height()/2
   tilecoord=pixeltotile(rx,ry)
   pixelcoord=tiletopixel(tilecoord[1],tilecoord[2])
   --screen:print(100,25,tilecoord[1]..","..tilecoord[2],white)
   if (map.map[tilecoord[1]][tilecoord[2]]["buildingid"]~=0) then return end--already something here
   tileid=buildingtypes[constructingid].tileid
   tilesetsrcX = math.mod(tileid,buildingtilesetrow)  * buildingtilew
   tilesetsrcY = math.floor(tileid/buildingtilesetrow) * buildingtileh
   screen:blit(pixelcoord[1]-scrollx+panel:width(),pixelcoord[2]-(buildingtileh-tileh)-scrolly,buildingimg,tilesetsrcX,tilesetsrcY,buildingtilew,buildingtileh,true)

	if pad:cross() then
      if (gamemoney<buildingtypes[constructingid].price) then
         dialogmsg("error","not enough money")
         return
      end
      --build it
      gamemoney=gamemoney-buildingtypes[constructingid].price
--      blitstats()
      newflyingtext(pixelcoord[1],pixelcoord[2],"-$"..buildingtypes[constructingid].price,70,true)
      newbuilding(tilecoord[1],tilecoord[2],constructingid)
      if (map.map[tilecoord[1]][tilecoord[2]]["tileid"]~=0) then 
        map:makestructure(tilecoord[1],tilecoord[2],0)
      else
      	map:generateoffscreens()
      end
   end
end


--#################################
-- initiate colors
black=Color.new(0,0,0)
white=Color.new(255,255,255)
gray=Color.new(125,125,125)
red=Color.new(225,0,0)
yellow=Color.new(250,250,0)

--#################################
-- initiate objects
font=bitmapfont:new()
font:load("font.png",9,9,"!$_,-./0123456789:;+?ABCDEFGHIJKLMNOPQRSTUVWXYZ")

--#################################
-- initiate images
tileset = Image.load("tiles.png")
cursor = Image.load("cursor.png")
panel  = Image.load("panel.png")
constructionicons = Image.load("icons.png")
bottompanel = Image.load("bottompanel.png")
buildingimg = Image.load("buildingtiles.png")
statsicons = Image.load("staticons.png")
tilemask = Image.load("tilemask.png")

logo = font:printverticalimage("Utopia v1.0")
pauseimg = font:printimage("paused")

--#################################
-- initiate constants/vars
buildingtilesetw = buildingimg:width()
buildingtileseth = buildingimg:height()
buildingtilew  = 64
buildingtileh  = 113
buildingtilesetrow      = buildingtilesetw/buildingtilew
buildingtilesetcolumn = buildingtileseth/buildingtileh

tilew              = 64
tileh               = 31
tilesetw         = tileset:width()
tileseth          = tileset:height()
tilesetrow      = tilesetw/tilew
tilesetcolumn = tileseth/tileh

fullscreenw    = 480
fullscreenh    = 272
screenw        = fullscreenw-panel:width()
screenh         = 248
screentilew   = screenw/tilew+tilew
screentileh    = screenh/tileh+tileh

bottompanelx = panel:width()
bottompanely = fullscreenh-bottompanel:height()

mapw      = 896
maph       = 434
maptilew = mapw/tilew+tilew
maptileh  = maph/tileh+tileh

offscreenmaxw = 256
offscreenmaxh  = 248

cursorx=screenw/2-cursor:width()/2
cursory=screenh/2-cursor:height()/2

scrollx = 0
scrolly = 0

globaltime=0

datemonth =  1
dateday      = 1
dateyear     = 05
dateimg = Image.createEmpty(1,1)
lastaddday = 0

constructingid = ""
constructingroad = false

nomovement=0

flyingtext={}
lastflyingtext=os.clock()

pad={}

--#################################
-- game stat vars
gamehouse     =0
gamehousereq=0
gamejobs        =0
gamejobsreq   =0
gameresidents =0
gameelectricity=0
gameelectricityreq=0
gamewater      =0
gamewaterreq=0
gamemoney     =2000000


--#################################
-- initiate icons
houseicon = gameicon:new()
houseicon:load(9,4,24,24,"Build House")
commerceicon = gameicon:new()
commerceicon:load(9,4+24,24,24,"Build Commerce")
electricityicon = gameicon:new()
electricityicon:load(9,4+24*2,24,24,"Build Electricity Plant")
watericon = gameicon:new()
watericon:load(9,4+24*3,24,24,"Build Water Plant")
roadicon = gameicon:new()
roadicon:load(9,4+24*4,24,24,"Build Roads")
destroyicon = gameicon:new()
destroyicon:load(9,4+24*5,24,24,"Bulldozer")



--#################################
--GAME SEQUENCE
--#################################
--create our GUI and fill it w/ pretty icons :)
GUI = Image.createEmpty(fullscreenw,fullscreenh)
stathouseicon = gameicon:new()
stathouseicon:load(panel:width(),fullscreenh-bottompanel:height()+2,16,18,"Housing Status")
statcommerceicon = gameicon:new()
statcommerceicon:load(panel:width(),fullscreenh-bottompanel:height()+2,16,18,"Commerce Status")
statelectricityicon = gameicon:new()
statelectricityicon:load(panel:width()+70,fullscreenh-bottompanel:height()+2,16,18,"Electricity Status")
statwatericon = gameicon:new()
statwatericon:load(panel:width()+140,fullscreenh-bottompanel:height()+2,16,18,"Water Status")
statresidentsicon = gameicon:new()
statresidentsicon:load(panel:width()+210,fullscreenh-bottompanel:height()+2,16,18,"Residents")

--start up the map and generate the primary screens
map=gamemap:new()
map:generateoffscreens()

amarquee=marquee:new()

dialogmsg("Welcome to Utopia","Press X To Begin Playing!")

while true do
   pad = Controls.read()
   --process keys
   getKeys()
   if (nomovement>7500) then pausegame() end

   --draw map
	map:drawoffscreens()

   --see if we are building something
   if (constructingid~="") then
      constructing()
      if pad:triangle() then constructingid="" end
   elseif (constructingroad==true) then
   	  constructroad()
   	  if pad:triangle() then constructingroad=false end
   end

   --draw GUI
   screen:blit(0,0,GUI,true)

   --draw flying text
   processflyingtext()

   --add day and blit date
   addDay()
   screen:blit(fullscreenw-dateimg:width(),0,dateimg,true)

   --process construction icons (could put this in a table but, eh, no biggie)
   commerceicon:hit(true)
   houseicon:hit(true)
   electricityicon:hit(true)
   watericon:hit(true)
   destroyicon:hit(true)
   roadicon:hit(true)
   stathouseicon:hit(true)
   statcommerceicon:hit(true)
   statwatericon:hit(true)
   statelectricityicon:hit(true)
   statresidentsicon:hit(true)
   --draw/process marquee
   amarquee:draw()

   --draw cursor
   screen:blit(cursorx,cursory,cursor,true)

   --vblank and flip
	screen.waitVblankStart()
	screen.flip()

   --loop kill	
   if pad:start() then
      pausegame()
   end

	if pad:select() then
		break
   end
end