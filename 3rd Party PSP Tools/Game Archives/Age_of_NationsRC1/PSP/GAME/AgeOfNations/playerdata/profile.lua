--[[	AoN
		Custom Player Ressources Definition File
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 17/08/2010
	]]

playerRes = {Food = 0, Wood = 0, Stone = 0, Gold = 0, age = Age:new()}
playerRes.TopBoard = Image.load("Images/icons/board1.jpg")

playerRes.drawTopBoard = function()
screen:blit(0,0,playerRes.TopBoard)
print(41,6,playerRes.Wood)
print(102,6,playerRes.Food)
print(170,6,playerRes.Gold)
print(236,6,playerRes.Stone)
playerRes.age:drawProgress()
end

