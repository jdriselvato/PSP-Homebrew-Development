function sort(path)
lr=0
 for a=1,sL(path)do
  if ss(path,a,a)=="/" then
  lr=lr+1
  end
 end
pge.dir.chdir(path)
dir=pge.dir.open(path)
list=dir:read()
dir:close()
 if not list then
  return {}
 end
ts(list,function(a,b)return sl(a.name)<sl(b.name)end)
top={}
bot={}
 for a=1,#list do
 list[a].w=lr
 list[a].path=path
  if list[a].dir then
  list[a].f=1
  ti(top,list[a])
  else
   if sl(ss(list[a].name,-4))==".pbp" then
   list[a].f=3
   else
   list[a].f=0
   end
  ti(bot,list[a])
  end
 end
 for a=1,#bot do
 ti(top,bot[a])
 end
  return top
end

function sld(path)
pge.dir.chdir(path)
dir=pge.dir.open(path)
list=dir:read()
dir:close()
 if not list then
  return {}
 end
ts(list,function(a,b)return sl(a.name)<sl(b.name)end)
top={}
bot={}
 for a=1,#list do
 list[a].path=pge.dir.getcwd().."/"
  if list[a].dir then
  ti(top,list[a])
  else
  ti(bot,list[a])
  end
 end
 for a=1,#bot do
 ti(top,bot[a])
 end
  return top
end

function Print(x,y,t,c,b)
 if b and sL(t)>0 and Textbackgroundbox then
 pge.gfx.drawrect(x,y,(sL(t)*7)+2,14,b)
 end
font:activate()
font:print(x,y,c,t)
end

function Printcenter(y,t,c,b)
 if b and sL(t)>0 and Textbackgroundbox then
 pge.gfx.drawrect(240-((sL(t)/2)*7),y,(sL(t)*7)+2,14,b)
 end
font:activate()
font:print(240-((sL(t)/2)*7),y,c,t)
end

function update(num,amount)
curw=Dir[num].w
 if num>1 and curw>1 then
  repeat
   repeat
   num=num-1
   until Dir[num].w==curw-1
  Dir[num].a=Dir[num].a+amount
  curw=curw-1
  until curw==1
 end
end

function updateminus(num,amount)
curw=Dir[num].w
 if num>1 and curw>1 then
  repeat
   repeat
   num=num-1
   until Dir[num].w==curw-1
  Dir[num].a=Dir[num].a-amount
  curw=curw-1
  until curw==1
 end
end

function blitbg()
 if Color.backgroundvalue==0 then
  if dv==0 then
   if fv<285 then
   fv=fv+.25
   else
   fv=285
   dv=1
   end
  else
   if fv>-30 then
   fv=fv-.25
   else
   fv=-30
   dv=0
   end
  end
 rfv=fv
  if rfv>255 then
  rfv=255
  end
  if rfv<0 then
  rfv=0
  end
 bg1:activate()
 bg1:draweasy(0,0,0,rfv)
 bg2:activate()
 bg2:draweasy(0,0,0,255-rfv)
 else
 sc(Color.background)
 end
end

function getsize(file,num)
size={1,256,256*256,256*256*256}
readsize={0,0,0,0}
 if not num then
 num=4
 end
 for a=1,num do
 readsize[a]=sb(file:read(1))*size[a]
 end
 if num==2 then
  return readsize[1]+readsize[2]
 else
  return readsize[1]+readsize[2]+readsize[3]+readsize[4]
 end
end

function datasize(data,num)
size={1,256,256*256,256*256*256}
readsize={0,0,0,0}
 if not num then
 num=4
 end
 for a=1,num do
 readsize[a]=sb(ss(data,a,a))*size[a]
 end
 if num==2 then
  return readsize[1]+readsize[2]
 else
  return readsize[1]+readsize[2]+readsize[3]+readsize[4]
 end
end

function convertsize(size,num)
N={}
N[1]=0
N[2]=0
N[3]=0
N[4]=0
 while size>0 do
  if size>=256*256*256 then
  N[4]=N[4]+1
  size=size-256*256*256
  end
  if size>=256*256 and size<256*256*256 then
  N[3]=N[3]+1
  size=size-256*256
  end
  if size>=256 and size<256*256 then
  N[2]=N[2]+1
  size=size-256
  end
  if size<256 then
  N[1]=size
  size=0
  end
 end
 if num==2 then
  return sch(N[1])..sch(N[2])
 else
  return sch(N[1])..sch(N[2])..sch(N[3])..sch(N[4])
 end
end

function bkmg(size)
 if size<1024 then
  return size.." Bytes"
 elseif size>=1024 and size<1024*1024 then
 size=size/1024
  for a=1,sL(size)do
   if ss(size,a,a)=="." then
   size=ss(size,1,a+2)
   end
  end
  return size.." KB"
 elseif size>=1024*1024 and size<1024*1024*1024 then
 size=size/1024/1024
  for a=1,sL(size)do
   if ss(size,a,a)=="." then
   size=ss(size,1,a+2)
   end
  end
  return size.." MB"
 elseif size>=1024*1024*1024 then
 size=size/1024/1024/1024
  for a=1,sL(size)do
   if ss(size,a,a)=="." then
   size=ss(size,1,a+2)
   end
  end
  return size.." GB"
 end
end

function sizefile(p)
local f=io.open(p,"rb")
local fsize=f:seek("end")
f:close()
f=nil
 return fsize
end

function opmenu()
 if not oy then
 oy=1
 end
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
 pge.gfx.drawrect(1,15,478,152,cn(255,255,255,40))
 pge.gfx.drawrectoutline(0,14,479,152,black)
 Printcenter(0,"Option Menu",yellow,tblack)
  if pad:U()and oy==1 then
  oy=12
  end
  if pad:D()and oy==11 then
  oy=0
  end
  if pad:U(4)and oy>1 then
  oy=oy-1
  end
  if pad:D(4)and oy<11 then
  oy=oy+1
  end
 Print(260,14,"Folder",Color.folder,tblack)
 Print(260,28,"File",Color.file,tblack)
 Print(260,42,"File select",Color.fileselect,tblack)
 Print(260,56,"Option",Color.option,tblack)
 Print(260,70,"Option select",Color.optionselect,tblack)
 Print(260,84,"Info",Color.info,tblack)
 Print(260,112,Font.name[fontvalue],Color.option,tblack)
  if Textbackgroundbox then
  Print(260,126,"Enabled",Color.option,tblack)
  else
  Print(260,126,"Disabled",Color.option,tblack)
  end
  if oy==1 then
  Print(59,14,"Folder: "..Color.name[Color.foldervalue],Color.optionselect,tblack)
   if pad:L(6)and Color.foldervalue>1 then
   Color.foldervalue=Color.foldervalue-1
   Color.folder=Color.table[Color.foldervalue]
   end
   if pad:R(6)and Color.foldervalue<20 then
   Color.foldervalue=Color.foldervalue+1
   Color.folder=Color.table[Color.foldervalue]
   end
  else
  Print(59,14,"Folder: "..Color.name[Color.foldervalue],Color.option,tblack)
  end
  if oy==2 then
  Print(73,28,"File: "..Color.name[Color.filevalue],Color.optionselect,tblack)
   if pad:L(6)and Color.filevalue>1 then
   Color.filevalue=Color.filevalue-1
   Color.file=Color.table[Color.filevalue]
   end
   if pad:R(6)and Color.filevalue<20 then
   Color.filevalue=Color.filevalue+1
   Color.file=Color.table[Color.filevalue]
   end
  else
  Print(73,28,"File: "..Color.name[Color.filevalue],Color.option,tblack)
  end
  if oy==3 then
  Print(24,42,"File select: "..Color.name[Color.fileselectvalue],Color.optionselect,tblack)
   if pad:L(6)and Color.fileselectvalue>1 then
   Color.fileselectvalue=Color.fileselectvalue-1
   Color.fileselect=Color.table[Color.fileselectvalue]
   end
   if pad:R(6)and Color.fileselectvalue<20 then
   Color.fileselectvalue=Color.fileselectvalue+1
   Color.fileselect=Color.table[Color.fileselectvalue]
   end
  else
  Print(24,42,"File select: "..Color.name[Color.fileselectvalue],Color.option,tblack)
  end
  if oy==4 then
  Print(59,56,"Option: "..Color.name[Color.optionvalue],Color.optionselect,tblack)
   if pad:L(6)and Color.optionvalue>1 then
   Color.optionvalue=Color.optionvalue-1
   Color.option=Color.table[Color.optionvalue]
   end
   if pad:R(6)and Color.optionvalue<20 then
   Color.optionvalue=Color.optionvalue+1
   Color.option=Color.table[Color.optionvalue]
   end
  else
  Print(59,56,"Option: "..Color.name[Color.optionvalue],Color.option,tblack)
  end
  if oy==5 then
  Print(10,70,"Option select: "..Color.name[Color.optionselectvalue],Color.optionselect,tblack)
   if pad:L(6)and Color.optionselectvalue>1 then
   Color.optionselectvalue=Color.optionselectvalue-1
   Color.optionselect=Color.table[Color.optionselectvalue]
   end
   if pad:R(6)and Color.optionselectvalue<20 then
   Color.optionselectvalue=Color.optionselectvalue+1
   Color.optionselect=Color.table[Color.optionselectvalue]
   end
  else
  Print(10,70,"Option select: "..Color.name[Color.optionselectvalue],Color.option,tblack)
  end
  if oy==6 then
  Print(73,84,"Info: "..Color.name[Color.infovalue],Color.optionselect,tblack)
   if pad:L(6)and Color.infovalue>1 then
   Color.infovalue=Color.infovalue-1
   Color.info=Color.table[Color.infovalue]
   end
   if pad:R(6)and Color.infovalue<20 then
   Color.infovalue=Color.infovalue+1
   Color.info=Color.table[Color.infovalue]
   end
  else
  Print(73,84,"Info: "..Color.name[Color.infovalue],Color.option,tblack)
  end
  if oy==7 then
  Print(31,98,"Background: "..Color.name[Color.backgroundvalue],Color.optionselect,tblack)
   if pad:L(6)and Color.backgroundvalue>0 then
   Color.backgroundvalue=Color.backgroundvalue-1
    if Color.backgroundvalue>0 then
    Color.background=Color.table[Color.backgroundvalue]
    end
   end
   if pad:R(6)and Color.backgroundvalue<20 then
   Color.backgroundvalue=Color.backgroundvalue+1
   Color.background=Color.table[Color.backgroundvalue]
   end
  else
  Print(31,98,"Background: "..Color.name[Color.backgroundvalue],Color.option,tblack)
  end
  if oy==8 then
  Print(73,112,"Font:",Color.optionselect,tblack)
   if pad:L(6)and fontvalue>1 then
   fontvalue=fontvalue-1
   font=Font.load[fontvalue]
   end
   if pad:R(6)and fontvalue<8 then
   fontvalue=fontvalue+1
   font=Font.load[fontvalue]
   end
  else
  Print(73,112,"Font:",Color.option,tblack)
  end
  if oy==9 then
  Print(10,126,"Text background box",Color.optionselect,tblack)
   if pad:X()then
    if Textbackgroundbox then
    Textbackgroundbox=nil
    else
    Textbackgroundbox=true
    end
   end
  else
  Print(10,126,"Text background box",Color.option,tblack)
  end
  if oy==10 then
  Print(10,140,"Save changes",Color.optionselect,tblack)
   if pad:X("r")then
   pge.file.remove(defdir.."Data/Lua/config.lua")
   config=pge.file.open(defdir.."Data/Lua/config.lua",PGE_FILE_CREATE+PGE_FILE_WRONLY)
   config:write("Color.foldervalue="..Color.foldervalue.."\n")
   config:write("Color.filevalue="..Color.filevalue.."\n")
   config:write("Color.fileselectvalue="..Color.fileselectvalue.."\n")
   config:write("Color.optionvalue="..Color.optionvalue.."\n")
   config:write("Color.optionselectvalue="..Color.optionselectvalue.."\n")
   config:write("Color.infovalue="..Color.infovalue.."\n")
   config:write("Color.backgroundvalue="..Color.backgroundvalue.."\n")
   config:write("Color.folder=Color.table[Color.foldervalue]\n")
   config:write("Color.file=Color.table[Color.filevalue]\n")
   config:write("Color.fileselect=Color.table[Color.fileselectvalue]\n")
   config:write("Color.option=Color.table[Color.optionvalue]\n")
   config:write("Color.optionselect=Color.table[Color.optionselectvalue]\n")
   config:write("Color.info=Color.table[Color.infovalue]\n")
   config:write("if Color.backgroundvalue>0 then\n")
   config:write("Color.background=Color.table[Color.backgroundvalue]\n")
   config:write("end\n")
   config:write("Textbackgroundbox="..tostring(Textbackgroundbox).."\n")
   config:write("fontvalue="..fontvalue.."\n")
   config:write("font=Font.load[fontvalue]")
   config:close()
   config=nil
   message("Changes have been saved.")
    break
   end
  else
  Print(10,140,"Save changes",Color.option,tblack)
  end
  if oy==11 then
  Print(10,154,"View browsing controls",Color.optionselect,tblack)
   if pad:X()then
   ctrlmenu()
   end
  else
  Print(10,154,"View browsing controls",Color.option,tblack)
  end
  if pad:SL("r")then
   break
  end
 Printcenter(258,"Select - Exit",yellow,tblack)
 eD()
 fs()
 updatepress()
 end
end

function ctrlmenu()
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
 pge.gfx.drawrect(1,15,478,110,cn(255,255,255,40))
 Printcenter(0,"Browsing Controls",yellow,tblack)
 Print(10,14,"Up/Down      - scroll by one",Color.info,tblack)
 Print(10,28,"Left/Right   - scroll by four",Color.info,tblack)
 Print(10,42,"L + D pad    - stay locked in a directory while scrolling",Color.info,tblack)
 Print(10,56,"L + Triangle - move to parent directory",Color.info,tblack)
 Print(10,70,"O            - open/close a directory or eboot",Color.info,tblack)
 Print(10,84,"R + O        - reset a directory",Color.info,tblack)
 Print(10,98,"R + Start    - reset to root directory",Color.info,tblack)
 Print(10,112,"X            - edit eboot/select eboot file",Color.info,tblack)
 pge.gfx.drawrectoutline(0,14,479,111,black)
 Printcenter(258,"Select - Exit",yellow,tblack)
  if pad:SL("r")then
   break
  end
 eD()
 fs()
 updatepress()
 end
end

function appmenu()
ay=1
major="00"
minor="00"
 if Eboot.Appversion~="" then
  for a=1,sL(Eboot.Appversion)do
   if ss(Eboot.Appversion,a,a)=="." then
   major=ss(Eboot.Appversion,1,a-1)
   minor=ss(Eboot.Appversion,a+1)
    break
   end
  end
 end
 while sL(major)<2 do
 major="0"..major
 end
 while sL(minor)<2 do
 minor=minor.."0"
 end
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
 pge.gfx.drawrect(0,14,480,56,cn(255,255,255,40))
 Printcenter(0,"App version",yellow,tblack)
  if pad:U()then
  ay=ay-1
   if ay<1 then
   ay=4
   end
  end
  if pad:D()then
  ay=ay+1
   if ay>4 then
   ay=1
   end
  end
  if ay==1 then
  Print(17,14,"Version: "..major,Color.optionselect,tblack)
   if pad:X("r")then
   newmajor=osk("Version",major)
    if sL(newmajor)>0 then
    major=newmajor
     while sL(major)<2 do
     major="0"..major
     end
    newmajor=nil
    end
   end
  else
  Print(17,14,"Version: "..major,Color.option,tblack)
  end
  if ay==2 then
  Print(10,28,"Revision: "..minor,Color.optionselect,tblack)
   if pad:X("r")then
   newminor=osk("Revision",minor)
    if sL(newminor)>0 then
    minor=newminor
     while sL(minor)<2 do
     minor=minor.."0"
     end
    newminor=nil
    end
   end
  else
  Print(10,28,"Revision: "..minor,Color.option,tblack)
  end
  if ay==3 then
  Print(10,42,"Save changes",Color.optionselect,tblack)
   if pad:X("r")then
   Eboot.Appversion=major.."."..minor
   changeappver(Eboot.Appversion)
    break
   end
  else
  Print(10,42,"Save changes",Color.option,tblack)
  end
  if ay==4 then
  Print(10,56,"Cancel",Color.optionselect,tblack)
   if pad:X("r")then
    break
   end
  else
  Print(10,56,"Cancel",Color.option,tblack)
  end
 eD()
 fs()
 updatepress()
 end
end

function message(t,t2)
wc=0
wd=0
 if t2 then
 Mm=7
 else
 Mm=0
 end
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
  if wd==0 then
   if wc<255 then
   wc=wc+8
   else
   wc=255
   wd=1
   end
  else
   if wc>0 then
   wc=wc-8
   else
   wc=0
   wd=0
   end
  end
 Printcenter(129-Mm,t,cn(255,wc,wc),tblack)
  if t2 then
  Printcenter(136,t2,cn(255,wc,wc),tblack)
  end
  if pressedany("r")then
   break
  end
 eD()
 fs()
 updatepress()
 end
end

function yesno(t,t2)
wc=0
wd=0
answer=nil
yn=1
 if t2 then
 ynm=7
 else
 ynm=0
 end
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
  if wd==0 then
   if wc<255 then
   wc=wc+8
   else
   wc=255
   wd=1
   end
  else
   if wc>0 then
   wc=wc-8
   else
   wc=0
   wd=0
   end
  end
 Printcenter(129-ynm,t,Color.option,tblack)
  if t2 then
  Printcenter(136,t2,Color.option,tblack)
  end
  if yn==1 then
  Print(212,185,"Yes",cn(255,wc,wc),tblack)
  Print(247,185,"No",Color.option,tblack)
   if pad:R()then
   yn=2
   end
   if pad:X("r")then
   answer=true
    break
   end
  else
  Print(212,185,"Yes",Color.option,tblack)
  Print(247,185,"No",cn(255,wc,wc),tblack)
   if pad:L()then
   yn=1
   end
   if pad:X("r")then
    break
   end
  end
 eD()
 fs()
 updatepress()
 end
 return answer
end

function copyfile(source,destination)
 if pge.file.exists(destination)then
 pge.file.remove(destination)
 end
sfile=pge.file.open(source,PGE_FILE_RDONLY)
dfile=pge.file.openasync(destination,PGE_FILE_CREATE+PGE_FILE_WRONLY)
ssize=sfile:size()
 while ssize>0 do
  if ssize>=1024*256 then
  dfile:write(sfile:read(1024*256))
  ssize=ssize-1024*256
  else
  dfile:write(sfile:read(ssize))
  ssize=0
  end
 end
dfile:close()
sfile:close()
dfile=nil
sfile=nil
ssize=nil
collectgarbage("collect")
end

function osk(desc,title)
done=false
text=""
 if not desc then
 desc=""
 end
pge.utils.oskinit(desc,title)
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
 eD()
 done,text=pge.utils.oskupdate()
  if done then
   if text~="" then
    if desc~="Title" then
     if tonumber(text)then
      for a=1,sL(text)do
       if not tonumber(ss(text,a,a))then
       text=ss(text,1,a-1)..ss(text,a+1)
       end
      end
      if desc=="Version" then
      text=ss(text,1,2)
      elseif desc=="Revision" then
      text=ss(text,1,5)
      end
     else
      if desc=="Version" then
      text=major
      elseif desc=="Revision" then
      text=minor
      end
     end
    end
   end
   break
  end
 fs()
 end
 return text
end

function scan(path)
List=sld(path)
 if not dirt then
 dirt={}
 rtab={}
 end
 if #List>0 then
  for a=1,#List do
   if List[a].dir then
   ti(dirt,List[a])
   end
  ti(rtab,List[a])
  end
 end
 if #dirt>0 then
 nd=dirt[1].path..dirt[1].name
 tr(dirt,1)
 scan(nd)
 end
List=nil
dirt=nil
 return rtab
end

function trunc(num)
 for a=1,sL(num)do
  if ss(num,a,a)=="." then
  num=ss(num,1,a+2)
   break
  end
 end
 return num
end

function enoughspace(src)
 if sizefile(src)/1024/1024<pge.utils.msfreesize()then
  return true
 else
 message("Insufficient MS space.")
 end
end
