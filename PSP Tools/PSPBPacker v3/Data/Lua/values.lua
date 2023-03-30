cn=pge.gfx.createcolor
babyblue=cn(128,192,255)
black=cn(0,0,0)
blue=cn(0,0,255)
brown=cn(80,0,0)
cyan=cn(0,255,255)
darkgray=cn(64,64,64)
forestgreen=cn(0,128,64)
gray=cn(128,128,128)
green=cn(0,255,0)
greenapple=cn(128,255,64)
magenta=cn(255,0,255)
maroon=cn(128,0,0)
orange=cn(255,128,0)
pink=cn(255,128,192)
purple=cn(128,0,255)
red=cn(255,0,0)
royalpurple=cn(128,64,128)
skyblue=cn(128,128,255)
tblack=cn(0,0,0,80)
yellow=cn(255,255,0)
white=cn(255,255,255)
clear=cn(0,0,0,0)

function mm(n,b)return n-(mf(n/b)*b)end
ma=math.abs
mc=math.ceil
mf=math.floor
mr=math.random
msq=math.sqrt

sb=string.byte
sch=string.char
sf=string.format
sL=string.len
sl=string.lower
srv=string.reverse
ss=string.sub
su=string.upper

tg=table.getn
ti=table.insert
tr=table.remove
ts=table.sort

sD=pge.gfx.startdrawing
eD=pge.gfx.enddrawing
sc=pge.gfx.clearscreen
fs=pge.gfx.swapbuffers

if not pge.dir.exists(defdir.."Eboot")then
pge.dir.mkdir(defdir.."Eboot")
end
if not pge.dir.exists(defdir.."Eboot/Backup")then
pge.dir.mkdir(defdir.."Eboot/Backup")
end
if not pge.dir.exists(defdir.."Eboot/Unpack")then
pge.dir.mkdir(defdir.."Eboot/Unpack")
end
bg1=pge.texture.load(defdir.."Data/Graphics/bg1.png")
bg2=pge.texture.load(defdir.."Data/Graphics/bg2.png")
exceedblit=pge.texture.load(defdir.."Data/Graphics/blit.png")

Font={
load={
pge.font.load(defdir.."Data/Font/UMB.ttf",14,PGE_RAM),
pge.font.load(defdir.."Data/Font/UMBI.ttf",14,PGE_RAM),
pge.font.load(defdir.."Data/Font/UMR.ttf",14,PGE_RAM),
pge.font.load(defdir.."Data/Font/UMRI.ttf",14,PGE_RAM),
pge.font.load(defdir.."Data/Font/VSMB.ttf",12,PGE_RAM),
pge.font.load(defdir.."Data/Font/VSMBI.ttf",12,PGE_RAM),
pge.font.load(defdir.."Data/Font/VSMR.ttf",12,PGE_RAM),
pge.font.load(defdir.."Data/Font/VSMRI.ttf",12,PGE_RAM)},
name={
"Ubuntu Mono Bold",
"Ubuntu Mono Bold Italic",
"Ubuntu Mono Regular",
"Ubuntu Mono Regular Italic",
"Vera Sans Mono Bold",
"Vera Sans Mono Bold Italic",
"Vera Sans Mono Regular",
"Vera Sans Mono Regular Italic"}
}

Color={}
Color.table={
babyblue,
black,
blue,
brown,
cyan,
darkgray,
forestgreen,
gray,
green,
greenapple,
magenta,
maroon,
orange,
pink,
purple,
red,
royalpurple,
skyblue,
yellow,
white}

Color.name={
"baby blue",
"black",
"blue",
"brown",
"cyan",
"dark gray",
"forest green",
"gray",
"green",
"green apple",
"magenta",
"maroon",
"orange",
"pink",
"purple",
"red",
"royal purple",
"skyblue",
"yellow",
"white"}
Color.name[0]="image"

fL={}
pom={}
pom[0]="-"
pom[1]="+"
pom[2]="+"
pom[3]="+"
pom[4]="-"
pom[5]="+"
pxs=10
fv=0
dv=0
searchoption=""
