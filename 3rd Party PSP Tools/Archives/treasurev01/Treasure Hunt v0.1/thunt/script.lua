-- Treasure Hunt v0.1
-- Based on the Atari 2600 game Flag Capture by Jim Huether
-- Graphics, sounds, and music snatched from all over the Web
-- Painfully sloppy Lua script by Zach Meston
-- Suggestions, improvements, complaints? zachmeston@yahoo.com
-- To do: script optimization, gameplay variations, 1-player mode


-- System.usbDiskModeActivate()

-- initialize variables

flagx = 0
flagy = 0
bombx = 0
bomby = 0
bombs = 0
numberx = 0
numbery = 0
numbers = 0
arrowx = 0
arrowy = 0
arrows = 0
p1x = 1
p1y = 1
p2x = 8
p2y = 8
nut = 0
art = 0
wingame = 0
scorep1 = 0
scorep2 = 0
stepx = 0
stepy = 0
m1 = 1
m2 = 2
m3 = 3
m4 = 4
m5 = 5
m6 = 6
n = {}
a = {}
lua = {}
scorefx = {}
colorcycle = {}
instr = {}
loloanim = {}
lalaanim = {}
win = {}


-- initialize graphics

for x=0,255 do
	colorcycle[x]=Color.new(x, x, x)
end

red = Color.new(255, 0, 0)

green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
yellow = Color.new(255, 255, 0)
purple = Color.new(255, 0, 255)
bg = Image.load("grid.png")
title = Image.load("title.png")
pause = Image.load("pause.png")
p1win = Image.load("p1win.png")
p2win = Image.load("p2win.png")
instr[1] = Image.load("instr1.png")
instr[2] = Image.load("instr2.png")
instr[3] = Image.load("instr3.png")
instr[4] = Image.load("instr4.png")
instr[5] = Image.load("instr5.png")
instr[6] = Image.load("instr6.png")
instr[7] = Image.load("instr7.png")
lua[1] = Image.load("lua01.png")
lua[2] = Image.load("lua02.png")
lua[3] = Image.load("lua03.png")
lua[4] = Image.load("lua04.png")
lua[5] = Image.load("lua05.png")
lua[6] = Image.load("lua06.png")
lua[7] = Image.load("lua07.png")
lua[8] = Image.load("lua08.png")
lua[9] = Image.load("lua09.png")
lua[10] = Image.load("lua10.png")
loloanim[1] = Image.load("loloanim1.png")
loloanim[2] = Image.load("loloanim2.png")
loloanim[3] = Image.load("loloanim3.png")
loloanim[4] = Image.load("loloanim4.png")
loloanim[5] = Image.load("loloanim5.png")
loloanim[6] = Image.load("loloanim6.png")
lalaanim[1] = Image.load("lalaanim1.png")
lalaanim[2] = Image.load("lalaanim2.png")
lalaanim[3] = Image.load("lalaanim3.png")
lalaanim[4] = Image.load("lalaanim4.png")
lalaanim[5] = Image.load("lalaanim5.png")
lalaanim[6] = Image.load("lalaanim6.png")
p1 = Image.load("lolo.png")
p2 = Image.load("lolo2.png")
n[1] = Image.load("1.png")
n[2] = Image.load("2.png")
n[3] = Image.load("3.png")
n[4] = Image.load("4.png")
n[5] = Image.load("5.png")
n[6] = Image.load("6.png")
n[7] = Image.load("7.png")
a[1] = Image.load("ul.png")
a[2] = Image.load("u.png")
a[3] = Image.load("ur.png")
a[4] = Image.load("l.png")
a[5] = Image.load("r.png")
a[6] = Image.load("dl.png")
a[7] = Image.load("d.png")
a[8] = Image.load("dr.png")
scorefx[0] = Image.load("score00.png")
scorefx[1] = Image.load("score01.png")
scorefx[2] = Image.load("score02.png")
scorefx[3] = Image.load("score03.png")
scorefx[4] = Image.load("score04.png")
scorefx[5] = Image.load("score05.png")
scorefx[6] = Image.load("score06.png")
scorefx[7] = Image.load("score07.png")
scorefx[8] = Image.load("score08.png")
scorefx[9] = Image.load("score09.png")
scorefx[10] = Image.load("score10.png")
scorefx[11] = Image.load("score11.png")
scorefx[12] = Image.load("score12.png")
scorefx[13] = Image.load("score13.png")
scorefx[14] = Image.load("score14.png")
bo = Image.load("bomb.png")
fl = Image.load("flag.png")



-- initialize sounds

boom = Sound.load("explosion.wav")
win[1] = Sound.load("behave.wav")
win[2] = Sound.load("burns.wav")
win[3] = Sound.load("check.wav")
win[4] = Sound.load("excellent.wav")
win[5] = Sound.load("factjack.wav")
win[6] = Sound.load("fanfare.wav")
win[7] = Sound.load("groovy.wav")
win[8] = Sound.load("kickass.wav")
win[9] = Sound.load("kombat.wav")
win[10] = Sound.load("shnikes.wav")

-- initialize grid matrix

grid = {}

for x=1,8 do
	grid[x] = {}
	for y=1,8 do
		grid[x][y] = 0
	end
end



-- initialize flag matrix

flag = {}

for x=1,8 do
	flag[x] = {}
	for y=1,8 do
		flag[x][y] = 0
	end
end



function plantflag()

-- pick X/Y coordinates for the flag

flagx = math.random(8)
flagy = math.random(8)


-- place the flag into the matrix

flag[flagx][flagy] = 1

end



function plantbomb()

-- pick X/Y coordinates for the bomb

bombx = math.random(8)
bomby = math.random(8)


-- verify the square doesn't have a bomb, and plant the bomb

if grid[bombx][bomby]<3 then
	grid[bombx][bomby]=3
	bombs = bombs+1
end

end



function plantnumber()

-- pick X/y coordinates for the number

numberx = math.random(8)
numbery = math.random(8)

-- verify the square doesn't have a bomb or number, and plant the number

if grid[numberx][numbery]<2 then
	grid[numberx][numbery]=2
	numbers = numbers+1
end

end



function plantarrow()

arrowx = math.random(8)
arrowy = math.random(8)

if grid[arrowx][arrowy]<1 then
	grid[arrowx][arrowy]=1
	arrows = arrows+1
end

end



function readpad()

pad = Controls.read()

end




function checkgridp1()

if flag[p1x][p1y] == 1 then
	screen:blit(80+(32*p1x), -24+(32*p1y), fl)
	wingame=1
	scorep1 = scorep1+1
elseif grid[p1x][p1y] == 1 then
	displayarrp1()
elseif grid[p1x][p1y] == 2 then
	displaynump1()
elseif grid[p1x][p1y] == 3 then
	bombp1()
	p1x=1
	p1y=1
end

end


function checkgridp2()

if flag[p2x][p2y] == 1 then
	screen:blit(80+(32*p2x), -24+(32*p2y), fl)
	wingame=1
	scorep2= scorep2+1
elseif grid[p2x][p2y] == 1 then
	displayarrp2()
elseif grid[p2x][p2y] == 2 then
	displaynump2()
elseif grid[p2x][p2y] == 3 then
	bombp2()
end

end



function displaynump1()

-- measure left/right distance as stepx

if p1x>flagx then stepx=p1x-flagx
elseif p1x<flagx then stepx=flagx-p1x
else stepx=0
end

-- measure up/down distance as stepy
if p1y>flagy then stepy=p1y-flagy
elseif p1y<flagy then stepy=flagy-p1y
else stepy=0
end

-- whichever is bigger becomes our number

if stepx>=stepy then nut=stepx else nut=stepy
end

screen:blit(80+(32*p1x), -24+(32*p1y), n[nut])
stepx=0
stepy=0
nut=0

end



function displaynump2()

-- measure left/right distance as stepx

if p2x>flagx then stepx=p2x-flagx
elseif p2x<flagx then stepx=flagx-p2x
else stepx=0
end

-- measure up/down distance as stepy
if p2y>flagy then stepy=p2y-flagy
elseif p2y<flagy then stepy=flagy-p2y
else stepy=0
end

-- whichever is bigger becomes our number

if stepx>=stepy then nut=stepx else nut=stepy
end

screen:blit(80+(32*p2x), -24+(32*p2y), n[nut])
stepx=0
stepy=0
nut=0

end



function displayarrp1()

-- is player above and left of flag?
if p1x<flagx and p1y<flagy then art=8

-- is player above flag?
elseif p1x == flagx and p1y<flagy then art=7

-- is player above and right of flag?
elseif p1x>flagx and p1y<flagy then art=6

-- is player left of flag?
elseif p1x<flagx and p1y == flagy then art=5

-- is player right of flag?
elseif p1x>flagx and p1y == flagy then art=4

-- is player below and left?
elseif p1x<flagx and p1y>flagy then art=3

-- is player below?
elseif p1x == flagx and p1y>flagy then art=2

-- player must be below and right
else art=1

end

screen:blit(80+(32*p1x), -24+(32*p1y), a[art])

end




function displayarrp2()

-- is player above and left of flag?
if p2x<flagx and p2y<flagy then art=8

-- is player above flag?
elseif p2x == flagx and p2y<flagy then art=7

-- is player above and right of flag?
elseif p2x>flagx and p2y<flagy then art=6

-- is player left of flag?
elseif p2x<flagx and p2y == flagy then art=5

-- is player right of flag?
elseif p2x>flagx and p2y == flagy then art=4

-- is player below and left?
elseif p2x<flagx and p2y>flagy then art=3

-- is player below?
elseif p2x == flagx and p2y>flagy then art=2

-- player must be below and right
else art=1

end

screen:blit(80+(32*p2x), -24+(32*p2y), a[art])

end


function bombp1()

screen:blit(80+(32*p1x), -24+(32*p1y), bo)
boom:play()

if not p2x == 8 and not p2y == 8 then
	p1x=8
	p1y=8
end

end



function bombp2()

screen:blit(80+(32*p2x), -24+(32*p2y), bo)
boom:play()

if not p1x == 8 and not p1y == 8 then
	p2x=8
	p2y=8
end

end



function pausegame()

screen:blit(0, 0, pause)
screen:blit(20, 150, scorefx[scorep1])
screen:blit(391, 150, scorefx[scorep2])
screen:flip()
screen.waitVblankStart(60)

while true do

readpad()

if pad:start() then break
end

end

end



function p1wins()

y=-36

while true do

screen:blit(0, 0, p1win)
screen:blit(13, y+1, loloanim[m1])
screen:blit(51, y-2, loloanim[m2])
screen:blit(89, y+2, loloanim[m3])
screen:blit(127, y-1, loloanim[m4])
screen:blit(165, y, loloanim[m5])
screen:blit(203, y-3, loloanim[m6])
screen:blit(241, y+2, loloanim[m1])
screen:blit(279, y+3, loloanim[m2])
screen:blit(317, y, loloanim[m3])
screen:blit(355, y-1, loloanim[m4])
screen:blit(393, y+1, loloanim[m5])
screen:blit(431, y-2, loloanim[m6])
screen:flip()
screen.waitVblankStart(10)

if m1<6 then m1 = m1+1 else m1=1
end

if m2<6 then m2 = m2+1 else m2=1
end

if m3<6 then m3 = m3+1 else m3=1
end

if m4<6 then m4 = m4+1 else m4=1
end

if m5<6 then m5 = m5+1 else m5=1
end

if m6<6 then m6 = m6+1 else m6=1
end

if y<274 then y = y+2 else y=-34
end

readpad()

if pad:start() then break
end

end

screen:flip()
screen.waitVblankStart(60)
scorep1=0
scorep2=0

end




function p2wins()

y=-36

while true do

screen:blit(0, 0, p2win)
screen:blit(13, y+1, lalaanim[m1])
screen:blit(51, y-2, lalaanim[m2])
screen:blit(89, y+2, lalaanim[m3])
screen:blit(127, y-1, lalaanim[m4])
screen:blit(165, y, lalaanim[m5])
screen:blit(203, y-3, lalaanim[m6])
screen:blit(241, y+2, lalaanim[m1])
screen:blit(279, y+3, lalaanim[m2])
screen:blit(317, y, lalaanim[m3])
screen:blit(355, y-1, lalaanim[m4])
screen:blit(393, y+1, lalaanim[m5])
screen:blit(431, y-2, lalaanim[m6])
screen:flip()
screen.waitVblankStart(10)

if m1<6 then m1 = m1+1 else m1=1
end

if m2<6 then m2 = m2+1 else m2=1
end

if m3<6 then m3 = m3+1 else m3=1
end

if m4<6 then m4 = m4+1 else m4=1
end

if m5<6 then m5 = m5+1 else m5=1
end

if m6<6 then m6 = m6+1 else m6=1
end

if y<274 then y = y+2 else y=-34
end

readpad()

if pad:start() then break
end

end

screen:flip()
screen.waitVblankStart(60)
scorep1=0
scorep2=0

end





function instructions()


-- Call up the first page

-- X is current screen
-- y and z are for animation

x=1
y=1
z=3


while true do

readpad()

if pad:triangle() then break
end

if pad:l() and x>1 then x=x-1
end

if pad:r() and x<7 then x=x+1
end

screen:blit(0, 0, instr[x])

if x == 1 then
screen:blit(101, 120, loloanim[y])
screen:blit(343, 120, lalaanim[z])
y=y+1
z=z+1
end

if y == 7 then y=1
end

if z == 7 then z=1
end





screen:flip()
screen.waitVblankStart(10)

end

-- End of routine

screen:blit(0, 0, title)
screen:flip()

end






function newgame()

for x=1,8 do
	grid[x] = {}
	for y=1,8 do
		grid[x][y] = 0
	end
end


for x=1,8 do
	flag[x] = {}
	for y=1,8 do
		flag[x][y] = 0
	end
end

flagx = 0
flagy = 0
bombx = 0
bomby = 0
bombs = 0
numberx = 0
numbery = 0
numbers = 0
arrowx = 0
arrowy = 0
arrows = 0
p1x = 1
p1y = 1
p2x = 8
p2y = 8
nut = 0
art = 0
wingame = 0
stepx = 0
stepy = 0
m1 = 1
m2 = 2
m3 = 3
m4 = 4
m5 = 5
m6 = 6



plantflag()

repeat
	plantbomb()
until bombs == 8

repeat
	plantnumber()
until numbers == 28

repeat
	plantarrow()
until arrows == 28

end



-- main game loop


-- Opening sequence

-- Black screen to white screen

-- Has to be a way to use the built-in commands

for x=0,255 do
	screen:fillRect(0, 0, 480, 272, colorcycle[x])
	screen:flip()
end

screen:flip()
screen.waitVblankStart(60)

for x=1,10 do
	screen:blit(182, 61, lua[x])
	screen:flip()
	screen.waitVblankStart(3)
end

win[7]:play()
screen.waitVblankStart(120)

for x=9,1,-1 do
	screen:blit(182, 61, lua[x])
	screen:flip()
	screen.waitVblankStart(3)
end

screen:fillRect(0, 0, 480, 272, colorcycle[255])
screen:flip()
screen.waitVblankStart(60)

for x=255,0,-1 do
	screen:fillRect(0, 0, 480, 272, colorcycle[x])
	screen:flip()
end

screen:flip()
screen.waitVblankStart(30)

screen:blit(0, 0, title)
screen:flip()

Music.volume(128)
Music.playFile("mule.s3m", true)

while true do
readpad()
if pad:select() then instructions()
elseif pad:start() then break
end

end







-- stock the grid

plantflag()

repeat
	plantbomb()
until bombs == 8

repeat
	plantnumber()
until numbers == 28

repeat
	plantarrow()
until arrows == 28


Music.volume(90)
Music.playFile("war14.mod", true)


-- Start of the main game loop
while true do



-- Place the background

screen:blit(0, 0, bg)


-- Place the scores

screen:blit(20, 150, scorefx[scorep1])
screen:blit(391, 150, scorefx[scorep2])



-- Read the controls

readpad()


-- Pause the game?

if pad:start() then pausegame()
end


-- Player 1's move



-- Adjust Player 1's coordinates

if pad:up() and not pad:l() then p1y = p1y-1
end

if pad:down() and not pad:l() then p1y = p1y+1
end

if pad:left() and not pad:l() then p1x = p1x-1
end

if pad:right() and not pad:l() then p1x = p1x+1
end



-- Make sure Player 1 isn't moving onto Player 2

if pad:up() and p1x == p2x and p1y == p2y then p1y = p1y+1
elseif pad:up() and p1x == p2x and p1y == 0 and p2y == 8 then p1y = p1y+1

elseif pad:down() and p1x == p2x and p1y == p2y then p1y = p1y-1
elseif pad:down() and p1x == p2x and p1y == 9 and p2y == 1 then p1y = p1y-1

elseif pad:left() and p1x == p2x and p1y == p2y then p1x = p1x+1
elseif pad:left() and p1y == p2y and p1x == 0 and p2x == 8 then p1x = p1x+1

elseif pad:right() and p1x == p2x and p1y == p2y then p1x = p1x-1
elseif pad:right() and p1y == p2y and p1x == 9 and p2x == 1 then p1x = p1x-1

end



-- Wraparound adjustments

if p1y == 0 then p1y=8
end

if p1y == 9 then p1y=1
end

if p1x == 0 then p1x=8
end

if p1x == 9 then p1x=1
end



-- Check for L trigger and display symbol or player

if pad:l() then
	checkgridp1()
else
	screen:blit(80+(32*p1x), -24+(32*p1y), p1)
end






-- player 2's move


if pad:triangle() and not pad:r() then p2y = p2y-1
end

if pad:cross() and not pad:r() then p2y = p2y+1
end

if pad:square() and not pad:r() then p2x = p2x-1
end

if pad:circle() and not pad:r() then p2x = p2x+1
end


-- Make sure Player 2 isn't moving into Player 1

if pad:triangle() and p1x == p2x and p1y == p2y then p2y = p2y+1
elseif pad:triangle() and p1x == p2x and p2y == 0 and p1y == 8 then p2y = p2y+1

elseif pad:cross() and p1x == p2x and p1y == p2y then p2y = p2y-1
elseif pad:cross() and p1x == p2x and p2y == 9 and p1y == 1 then p2y = p2y-1

elseif pad:square() and p1x == p2x and p1y == p2y then p2x = p2x+1
elseif pad:square() and p1y == p2y and p2x == 0 and p1x == 8 then p2x = p2x+1

elseif pad:circle() and p1x == p2x and p1y == p2y then p2x = p2x-1
elseif pad:circle() and p1y == p2y and p2x == 9 and p1x == 1 then p2x = p2x-1

end


-- Wraparound adjustments

if p2y == 0 then p2y=8
end

if p2y == 9 then p2y=1
end

if p2x == 0 then p2x=8
end

if p2x == 9 then p2x=1
end



-- Check for R trigger and display symbol or player

if pad:r() then
	checkgridp2()
else
	screen:blit(80+(32*p2x), -24+(32*p2y), p2)
end	



-- Screen flip

screen.flip()
screen.waitVblankStart(10)

if pad:select() then
screen:save("screenshot.tga")
end



-- Found the flag?

if wingame == 1 then
x = math.random(10)
	win[x]:play()
	screen.waitVblankStart(110)
	newgame()
end

-- Player 1 wins?

if scorep1 == 15 then
	p1wins()
	newgame()
end


if scorep2 == 15 then
	p2wins()
	newgame()
end


end

