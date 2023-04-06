Version="PSPBPacker v3"
defdir=pge.dir.getcwd().."/"
curdir=string.sub(defdir,1,2).."0:/"
dofile(defdir.."Data/Lua/values.lua")
dofile(defdir.."Data/Lua/pad.lua")
dofile(defdir.."Data/Lua/functions.lua")
dofile(defdir.."Data/Lua/pbpfunctions.lua")
dofile(defdir.."Data/Lua/pbpfunctions2.lua")
dofile(defdir.."Data/Lua/ebootmenu.lua")
dofile(defdir.."Data/Lua/config.lua")

Dir=sort(curdir)

p={h=14,l=13}
sn=1
btm=p.l
scrollht=math.ceil((p.h*p.l)/(#Dir-(p.l-1)))
if scrollht<1 then
scrollht=1
end

while pge.running()do
pge.controls.update()
sD()
blitbg()
pge.gfx.drawrect(1,15,478,180,cn(255,255,255,40))
pge.gfx.drawrectoutline(0,14,479,181,black)
 if pad:L("h")or pad:R("h")then
  if not UD then
  LR=true
  end
 else
 LR=nil
 end
 if pad:U("h")or pad:D("h")then
  if not LR then
  UD=true
  end
 else
 UD=nil
 end
 if not pad:LS("h")then
  if UD then
   if pad:U()and sn==1 then
   sn=#Dir+1
   end
   if pad:U(1)and sn>1 then
   sn=sn-1
   end
   if pad:D()and sn==#Dir then
   sn=0
   end
   if pad:D(1)and sn<#Dir then
   sn=sn+1
   end
  end
  if LR then
   if pad:L(1)and sn>1 then
   sn=sn-4
    if sn<1 then
    sn=1
    end
   end
   if pad:R(1)and sn<#Dir then
   sn=sn+4
    if sn>#Dir then
    sn=#Dir
    end
   end
  end
 else
  if pad:LS()then
  lastsn=sn
  holdw=Dir[sn].w
  end
  if pad:T()then
   if Dir[sn].w==1 then
   sn=1
   else
   parent=true
   lastsn=sn
   lastw=Dir[sn].w
   end
  end
  if pad:U(1)and sn>1 and UD then
   if Dir[sn-1].w>holdw then
    while Dir[sn-1].w~=holdw do
     if Dir[sn-1].w<holdw then
     sn=lastsn
      break
     end
    sn=sn-1
    end
   end
   if Dir[sn-1].w==holdw then
   sn=sn-1
   lastsn=sn
   end
  elseif pad:U()and sn==1 and UD then
   if Dir[#Dir].w==holdw then
   sn=#Dir
   end
  end
  if pad:D(1)and sn<#Dir and UD then
   if Dir[sn+1].w>holdw then
    while Dir[sn+1].w~=holdw do
    sn=sn+1
     if Dir[sn].w<holdw or sn==#Dir then
     sn=lastsn
      break
     end
    end
   end
   if Dir[sn+1].w==holdw then
   sn=sn+1
   lastsn=sn
   end
  elseif pad:D()and sn==#Dir and UD then
   if Dir[1].w==holdw then
   sn=1
   end
  end
  if pad:L(1)and sn>1 and LR then
   if Dir[sn-1].w>holdw then
    while Dir[sn-1].w~=holdw do
     if Dir[sn-1].w<holdw then
     sn=lastsn
      break
     end
    sn=sn-1
    end
   end
   if Dir[sn-1].w==holdw then
   sn=sn-1
   lastsn=sn
   end
   if sn>1 then
    if Dir[sn-1].w>holdw then
     while Dir[sn-1].w~=holdw do
      if Dir[sn-1].w<holdw then
      sn=lastsn
       break
      end
     sn=sn-1
     end
    end
    if Dir[sn-1].w==holdw then
    sn=sn-1
    lastsn=sn
    end
   end
   if sn>1 then
    if Dir[sn-1].w>holdw then
     while Dir[sn-1].w~=holdw do
      if Dir[sn-1].w<holdw then
      sn=lastsn
       break
      end
     sn=sn-1
     end
    end
    if Dir[sn-1].w==holdw then
    sn=sn-1
    lastsn=sn
    end
   end
   if sn>1 then
    if Dir[sn-1].w>holdw then
     while Dir[sn-1].w~=holdw do
      if Dir[sn-1].w<holdw then
      sn=lastsn
       break
      end
     sn=sn-1
     end
    end
    if Dir[sn-1].w==holdw then
    sn=sn-1
    lastsn=sn
    end
   end
  end
  if pad:R(1)and sn<#Dir and LR then
   if Dir[sn+1].w>holdw then
    while Dir[sn+1].w~=holdw do
    sn=sn+1
     if Dir[sn].w<holdw or sn==#Dir then
     sn=lastsn
      break
     end
    end
   end
   if Dir[sn+1].w==holdw then
   sn=sn+1
   lastsn=sn
   end
   if sn<#Dir then
    if Dir[sn+1].w>holdw then
     while Dir[sn+1].w~=holdw do
     sn=sn+1
      if Dir[sn].w<holdw or sn==#Dir then
      sn=lastsn
       break
      end
     end
    end
    if Dir[sn+1].w==holdw then
    sn=sn+1
    lastsn=sn
    end
   end
   if sn<#Dir then
    if Dir[sn+1].w>holdw then
     while Dir[sn+1].w~=holdw do
     sn=sn+1
      if Dir[sn].w<holdw or sn==#Dir then
      sn=lastsn
       break
      end
     end
    end
    if Dir[sn+1].w==holdw then
    sn=sn+1
    lastsn=sn
    end
   end
   if sn<#Dir then
    if Dir[sn+1].w>holdw then
     while Dir[sn+1].w~=holdw do
     sn=sn+1
      if Dir[sn].w<holdw or sn==#Dir then
      sn=lastsn
       break
      end
     end
    end
    if Dir[sn+1].w==holdw then
    sn=sn+1
    lastsn=sn
    end
   end
  end
 end
 if parent then
  repeat
  sn=sn-1
   if sn<btm-12 then
   btm=sn+12
   end
  until Dir[sn].w==lastw-1
 holdw=Dir[sn].w
 lastsn=sn
 parent=nil
 end
 if sn>btm then
 btm=sn
 end
 if sn<btm-(p.l-1)then
 btm=sn+(p.l-1)
 end
 if pad:O()then
  if Dir[sn].dir and pge.dir.exists(Dir[sn].path..Dir[sn].name)then
   if Dir[sn].f==1 or pad:RS("h")and Dir[sn].f==2 then
   curdir=Dir[sn].path..Dir[sn].name.."/"
   nDir=sort(curdir)
   tDir={}
   Dir[sn].a=#nDir
   Dir[sn].f=0
    if #nDir>0 then
    update(sn,#nDir)
     for a=1,sn do
     ti(tDir,Dir[a])
     end
     for a=1,#nDir do
     ti(tDir,nDir[a])
     end
     for a=sn+1,#Dir do
     ti(tDir,Dir[a])
     end
    Dir=tDir
    end
   nDir=nil
   tDir=nil
   elseif Dir[sn].f==0 then
    if Dir[sn].a>0 then
    Dir[sn].f=2
    Dir[sn].sd={}
    num=Dir[sn].a
    updateminus(sn,num)
    Dir[sn].a=0
    tDir={}
     for a=1,num do
     ti(Dir[sn].sd,Dir[sn+a])
     end
     for a=1,sn do
     ti(tDir,Dir[a])
     end
     for a=sn+num+1,#Dir do
     ti(tDir,Dir[a])
     end
    Dir=tDir
    tDir=nil
    num=nil
    else
    Dir[sn].f=1
    end
   elseif Dir[sn].f==2 and not pad:RS("h") then
   Dir[sn].f=0
   Dir[sn].a=#Dir[sn].sd
   update(sn,Dir[sn].a)
   tDir={}
    for a=1,sn do
    ti(tDir,Dir[a])
    end
    for a=1,#Dir[sn].sd do
    ti(tDir,Dir[sn].sd[a])
    end
    for a=sn+1,#Dir do
    ti(tDir,Dir[a])
    end
   Dir[sn].sd=nil
   Dir=tDir
   tDir=nil
   end
  elseif not Dir[sn].dir and pge.file.exists(Dir[sn].path..Dir[sn].name)then
   if sl(ss(Dir[sn].name,-4))==".pbp" then
    if Dir[sn].f==3 or pad:RS("h")and Dir[sn].f==5 then
    openpbp(Dir[sn].path..Dir[sn].name)
    elseif Dir[sn].f==4 then
     if Dir[sn].a>0 then
     Dir[sn].f=5
     Dir[sn].sd={}
     num=Dir[sn].a
     updateminus(sn,num)
     Dir[sn].a=0
     tDir={}
      for a=1,num do
      ti(Dir[sn].sd,Dir[sn+a])
      end
      for a=1,sn do
      ti(tDir,Dir[a])
      end
      for a=sn+num+1,#Dir do
      ti(tDir,Dir[a])
      end
     Dir=tDir
     tDir=nil
     num=nil
     else
     Dir[sn].f=3
     end
    elseif Dir[sn].f==5 then
    Dir[sn].f=4
    Dir[sn].a=#Dir[sn].sd
    update(sn,Dir[sn].a)
    tDir={}
     for a=1,sn do
     ti(tDir,Dir[a])
     end
     for a=1,#Dir[sn].sd do
     ti(tDir,Dir[sn].sd[a])
     end
     for a=sn+1,#Dir do
     ti(tDir,Dir[a])
     end
    Dir[sn].sd=nil
    Dir=tDir
    tDir=nil
    end
   end
  end
 collectgarbage("collect")
 end
 if pad:X("r")then
  if searchoption=="" then
   if pge.file.exists(Dir[sn].path..Dir[sn].name)then
    if sl(ss(Dir[sn].name,-4))==".pbp" then
    initeboot=true
    end
   end
  else
   if searchoption=="ICON0.PNG" then
    if sl(ss(Dir[sn].name,-4))==".png" and Dir[sn].e then
     if extracteboot(Dir[sn].name)then
     changeicon0(ext.icon0path,true)
     searchdone=true
     else
     message("Error reading PNG data.")
     end
    elseif sl(ss(Dir[sn].name,-4))==".png" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if ispng(Dir[sn].path..Dir[sn].name)then
     changeicon0(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
     message("Error reading PNG file.")
     end
    end
   elseif searchoption=="PIC0.PNG" then
    if sl(ss(Dir[sn].name,-4))==".png" and Dir[sn].e then
     if extracteboot(Dir[sn].name)then
     changepic0(ext.pic0path,true)
     searchdone=true
     else
     message("Error reading PNG data.")
     end
    elseif sl(ss(Dir[sn].name,-4))==".png" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if ispng(Dir[sn].path..Dir[sn].name)then
     changepic0(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
     message("Error reading PNG file.")
     end
    end
   elseif searchoption=="PIC1.PNG" then
    if sl(ss(Dir[sn].name,-4))==".png" and Dir[sn].e then
     if extracteboot(Dir[sn].name)then
     changepic1(ext.pic1path,true)
     searchdone=true
     else
     message("Error reading PNG data.")
     end
    elseif sl(ss(Dir[sn].name,-4))==".png" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if ispng(Dir[sn].path..Dir[sn].name)then
     changepic1(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
     message("Error reading PNG file.")
     end
    end
   elseif searchoption=="ICON1.PMF" then
    if ss(Dir[sn].name,-10)=="_ICON1.PMF" and Dir[sn].e then
     if extracteboot(Dir[sn].name)then
     changeicon1(ext.icon1path,true)
     searchdone=true
     else
     message("Error reading PMF data.")
     end
    elseif sl(ss(Dir[sn].name,-4))==".pmf" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if ispmf(Dir[sn].path..Dir[sn].name)then
     changeicon1(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
     message("Error reading PMF file.")
     end
    end
   elseif searchoption=="SND0.AT3" then
    if sl(ss(Dir[sn].name,-4))==".at3" and Dir[sn].e then
     if extracteboot(Dir[sn].name)then
     changesnd0(ext.snd0path,true)
     searchdone=true
     else
     message("Error reading AT3 data.")
     end
    elseif sl(ss(Dir[sn].name,-4))==".at3" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if isat3(Dir[sn].path..Dir[sn].name)then
     changesnd0(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
     message("Error reading AT3 file.")
     end
    end
   elseif searchoption=="DATA.PSP" then
    if ss(Dir[sn].name,1,9)=="_DATA.PSP" and Dir[sn].e then
    extracteboot(Dir[sn].name)
    changedatapsp(ext.datapsppath,true)
    searchdone=true
    elseif sl(ss(Dir[sn].name,-4))==".psp" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
     if isdatapsp(Dir[sn].path..Dir[sn].name)then
     changedatapsp(Dir[sn].path..Dir[sn].name)
     searchdone=true
     else
      if yesno("The DATA.PSP type is unknown.","Do you want to proceed?")then
      changedatapsp(Dir[sn].path..Dir[sn].name)
      searchdone=true
      end
     end
    end
   elseif searchoption=="DATA.PSAR" then
    if sl(ss(Dir[sn].name,-5))==".psar" and Dir[sn].e then
    extracteboot(Dir[sn].name)
    changedatapsar(ext.datapsarpath,true)
    searchdone=true
    elseif sl(ss(Dir[sn].name,-5))==".psar" and pge.file.exists(Dir[sn].path..Dir[sn].name)then
    changedatapsar(Dir[sn].path..Dir[sn].name)
    searchdone=true
    end
   end
  end
 end
L=99
 if #Dir>p.l then
  if btm>#Dir then
  btm=#Dir
  end
  for a=btm-(p.l-1),btm do
   if Dir[a].w<L then
   L=Dir[a].w
   end
  end
  for a=btm-(p.l-1),btm do
  xo=7+((Dir[a].w-1)*14)-((L-1)*12)
  yo=a*p.h-((btm-p.l)*p.h)
  hw=mf((476-(42+xo))/14)
  fL[Dir[a].w]=xo-6
   for b=2,L do
   fL[b]=fL[b-1]+2
   end
   for b=L+1,tg(fL)do
   fL[b]=fL[b-1]+14
   end
   if a~=sn then
    if Dir[a].dir then
    ltw=fL[Dir[a].w]+(sL(Dir[a].name)*7)+14
     if ltw<476 then
     Print(xo,yo,pom[Dir[a].f]..Dir[a].name.."/",Color.folder)
     else
     Print(xo,yo,pom[Dir[a].f]..ss(Dir[a].name,1,hw).." .... "..ss(Dir[a].name,-(hw-1)).."/",Color.folder)
     end
     for b=1,Dir[a].w do
     Font.load[3]:activate()
     Font.load[3]:print(fL[b],yo,Color.folder,"|")
     end
    else
    ltw=xo+(sL(Dir[a].name)*7)+7
     if ltw<476 then
     Print(xo,yo,pom[Dir[a].f]..Dir[a].name,Color.file)
     else
     Print(xo,yo,pom[Dir[a].f]..ss(Dir[a].name,1,hw).." .... "..ss(Dir[a].name,-hw),Color.file)
     end
     for b=1,Dir[a].w do
     Font.load[3]:activate()
     Font.load[3]:print(fL[b],yo,Color.file,"|")
     end
    end
   end
  end
 pge.gfx.drawrect(0, p.h, 4,p.h*p.l, gray)
 scrollht=math.ceil((p.h*p.l)/(#Dir-(p.l-1)))
  if scrollht<1 then
  scrollht=1
  end
 pge.gfx.drawrect(0,((btm-p.l)*((p.h*p.l)/(#Dir-(p.l-1)))+p.h),4,scrollht, red)
 else
  for a=1,#Dir do
   if Dir[a].w<L then
   L=Dir[a].w
   end
  end
  for a=1,#Dir do
  xo=7+((Dir[a].w-1)*14)-((L-1)*12)
  yo=a*p.h
  hw=mf((476-(42+xo))/14)
  fL[Dir[a].w]=xo-6
   for b=2,L do
   fL[b]=fL[b-1]+2
   end
   for b=L+1,tg(fL)do
   fL[b]=fL[b-1]+14
   end
   if a~=sn then
    if Dir[a].dir then
    ltw=xo+(sL(Dir[a].name)*7)+14
     if ltw<476 then
     Print(xo,a*p.h,pom[Dir[a].f]..Dir[a].name.."/",Color.folder)
     else
     Print(xo,a*p.h,pom[Dir[a].f]..ss(Dir[a].name,1,hw).." .... "..ss(Dir[a].name,-(hw-1)).."/",Color.folder)
     end
     for b=1,Dir[a].w do
     Font.load[3]:activate()
     Font.load[3]:print(fL[b],yo,Color.folder,"|")
     end
    else
    ltw=xo+(sL(Dir[a].name)*7)+7
     if ltw<476 then
     Print(xo,a*p.h,pom[Dir[a].f]..Dir[a].name,Color.file)
     else
     Print(xo,a*p.h,pom[Dir[a].f]..ss(Dir[a].name,1,hw).." .... "..ss(Dir[a].name,-hw),Color.file)
     end
     for b=1,Dir[a].w do
     Font.load[3]:activate()
     Font.load[3]:print(fL[b],yo,Color.file,"|")
     end
    end
   end
  end
 end
 if #Dir>0 then
 xo=7+((Dir[sn].w-1)*14)-((L-1)*12)
  if #Dir>13 then
  yo=sn*p.h-((btm-p.l)*p.h)
  else
  yo=sn*p.h
  end
 hw=mf((476-(42+xo))/14)
  if pressedany("h")then
  pxs=xo
  end
  for a=1,Dir[sn].w do
  Font.load[3]:activate()
  Font.load[3]:print(fL[a],yo,Color.fileselect,"|")
  end
  if Dir[sn].dir then
  ltw=xo+(sL(Dir[sn].name)*7)+14
   if ltw<476 then
   Print(xo,yo,pom[Dir[sn].f]..Dir[sn].name.."/",Color.fileselect)
   else
   Print(xo,yo,pom[Dir[sn].f]..ss(Dir[sn].name,1,hw).." .... "..ss(Dir[sn].name,-(hw-1)).."/",Color.fileselect)
   end
  else
  ltw=xo+(sL(Dir[sn].name)*7)+7
   if ltw<476 then
   Print(xo,yo,pom[Dir[sn].f]..Dir[sn].name,Color.fileselect)
   else
   Print(xo,yo,pom[Dir[sn].f]..ss(Dir[sn].name,1,hw).." .... "..ss(Dir[sn].name,-hw),Color.fileselect)
   end
  end
 end
Print(0,0,Version,yellow,tblack)
Print(0,196,Dir[sn].path,cyan,tblack)
Print(0,210,"MS space: "..trunc(pge.utils.msfreesize()).." MB",cyan,tblack)
 if not MAINDIR then
 Printcenter(258,"Select - Option Menu",yellow,tblack)
 else
  if not av then
  av=0
  ad=0
  end
  if ad==0 then
   if av<255 then
   av=av+4
   else
   av=255
   ad=1
   end
  else
   if av>0 then
   av=av-4
   else
   av=0
   ad=0
   end
  end
 Printcenter(244,searchoption,cn(255,av,av),tblack)
 Printcenter(258,"Select - Cancel",yellow,tblack)
 end
 if initeboot then
 initeboot=nil
 Printcenter(130,"Reading eboot",yellow,tblack)
 fs()
 loadeboot=getpbp(Dir[sn].path..Dir[sn].name)
 collectgarbage("collect")
  if ss(loadeboot,1,3)=="PBP" then
   if loadeboot=="PBPUPD" then
   updateerror=true
   end
  emenu()
  elseif loadeboot=="ELF" then
  message("Unable to edit standalone ELF eboot.")
  else
  message("Error reading eboot.")
  end
 end
 if pad:SL("r")or searchdone then
 collectgarbage("collect")
  if not MAINDIR then
  opmenu()
  else
  searchdone=nil
  SEARCHDIR=Dir
  SEARCHsn=sn
  SEARCHbtm=btm
  SEARCHpxs=pxs
  emenu()
  end
 end
 if pad:RS("h")and pad:ST("h")then
  if pge.utils.msfreesize()~=0 then
  Dir=sort(ss(defdir,1,2).."0:/")
  sn=1
  btm=13
  end
 end
eD()
fs()
updatepress()
end
