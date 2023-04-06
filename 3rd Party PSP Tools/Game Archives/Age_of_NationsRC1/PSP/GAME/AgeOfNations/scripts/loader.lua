--[[	AoN Game Engine 
		Game Engine Userdata Loader File
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 25/07/2010
	]]


grass=Image.load("images/resources/map.jpg") --map background picture
mainboard_img = Image.load("Images/icons/board2.jpg") -- Info board picture 
selector={}  --Cursors pics
	selector["Default"]=Image.load("Images/icons/selector.png")
	selector["Attack"]=Image.load("Images/icons/atkimg.png")
	--selector["Food"]=Image.load("Images/icons/fruitsimg.png")
	--selector["Gold"]=Image.load("Images/icons/goldimg.png")
	--selector["Stone"]=Image.load("Images/icons/stoneimg.png")
	--selector["Wood"]=Image.load("Images/icons/woodimg.png")
	selector["Repair"]=Image.load("Images/icons/repairimg.png")
	
res = {}  --resources pics
	res["Food"] = Image.load("Images/resources/fruits.png")
	res["Gold"] = Image.load("Images/resources/gold.png")
	res["Stone"] = Image.load("Images/resources/stone.png")
	res["Wood"] = {}
		for i=1,4 do res["Wood"][i]=Image.load("Images/resources/tree"..i..".png") end
		
unit_img={}  --units pics
	unit_img["Bowman"]={}
		for i=1,12 do unit_img["Bowman"][i] = Image.load("Images/units/bowman/"..i..".png")	end
	unit_img["Horseman"]={}
		for i=1,12 do unit_img["Horseman"][i] = Image.load("Images/units/horseman/"..i..".png") end
	unit_img["Peasant"]={}
		for i=1,16 do unit_img["Peasant"][i] = Image.load("Images/units/peasant/"..i..".png") end	
	unit_img["Priest"]={}
		for i=1,12 do unit_img["Priest"][i] = Image.load("Images/units/priest/"..i..".png") end
	unit_img["Soldier"]={}
		for i=1,12 do unit_img["Soldier"][i] = Image.load("Images/units/soldier/"..i..".png") end
		
build_img = {}  --builds pics
	build_img["Default"] = Image.load("Images/builds/playerbuilds/constructionyard.png")
	build_img["House"] = Image.load("Images/builds/playerbuilds/house.png")
	build_img["Barrack"] = Image.load("Images/builds/playerbuilds/barrack.png")
	build_img["TownCenter"] = Image.load("Images/builds/playerbuilds/tcenter.png")
	build_img["Stable"] = Image.load("Images/builds/playerbuilds/stable.png")
	--build_img["Market"] = Image.load("Images/builds/playerbuilds/Market.png")
	build_img["Temple"] = Image.load("Images/builds/playerbuilds/temple.png")
	build_img["Tower"] = Image.load("Images/builds/playerbuilds/tower.png")
	
icon_img = {} --icons pics
	local str = {"house","tcenter","barrack","stable","tower","temple"}
	for k in ipairs(str) do icon_img[k] = Image.load("Images/builds/icon/"..str[k].."icon.png") end
	icon_img[8] = Image.load("Images/units/icon/peasanticon.png")
	icon_img[9] = Image.load("Images/units/icon/horsemanicon.png")
	icon_img[10] = Image.load("Images/Updates/updatehorsemanicon.png")
	icon_img[11] = Image.load("Images/units/icon/soldiericon.png")
	icon_img[12] = Image.load("Images/units/icon/bowmanicon.png")
	icon_img[13] = Image.load("Images/Updates/updatesoldiericon.png")
	icon_img[14] = Image.load("Images/Updates/updatebowmanicon.png")
	icon_img[15] = Image.load("Images/units/icon/priesticon.png")
	icon_img[16] = Image.load("Images/builds/icon/age2.png")
	icon_img[17] = Image.load("Images/builds/icon/age3.png")

icon_desc = {}  --icons descriptions 
	icon_desc[1] = "Build House"
	icon_desc[2] = "Build TownCenter"
	icon_desc[3] = "Build Barrack"
	icon_desc[4] = "Build Stable"
	--icon_desc[5] = "Build Market"
	icon_desc[5] = "Build Tower"
	icon_desc[6] = "Build Temple"
	icon_desc[8] = "Create Peasant"
	icon_desc[9] = "Create Horseman"
	icon_desc[10] = "Update Horsemen"
	icon_desc[11] = "Create Soldier"
	icon_desc[12] = "Create Bowman"
	icon_desc[13] = "Update Soldiers"
	icon_desc[14] = "Update Bowmen"
	icon_desc[15] = "Create Priest"
	icon_desc[16] = "Update to Age II"
	icon_desc[17] = "Update to Age III"
	
	
