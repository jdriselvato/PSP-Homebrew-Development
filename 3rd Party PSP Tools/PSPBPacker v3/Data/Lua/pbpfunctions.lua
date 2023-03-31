function openpbp(path)
pbplist={}
readpbp={}
readpbp.data=io.open(path,"rb")
readpbp.header=readpbp.data:read(4)
 if readpbp.header==sch(0).."PBP" then
 readpbp.data:seek("set",12)
 readpbp.icon0=getsize(readpbp.data)
 readpbp.icon1=getsize(readpbp.data)
 readpbp.pic0=getsize(readpbp.data)
 readpbp.pic1=getsize(readpbp.data)
 readpbp.snd0=getsize(readpbp.data)
 readpbp.datapsp=getsize(readpbp.data)
 readpbp.datapsar=getsize(readpbp.data)
 readpbp.endoffile=readpbp.data:seek("end")
 readpbp.data:seek("set",readpbp.datapsp)
 readpbp.datapspheader=readpbp.data:read(4)
  if readpbp.datapspheader==sch(0x7f).."ELF" then
  etype=" (ELF)"
  elseif readpbp.datapspheader=="~PSP" then
  etype=" (~PSP)"
  else
  etype=" (?)"
  end
 elseif readpbp.header==sch(0x7f).."ELF" then
 etype=" (ELF)"
 end
readpbp.data:close()
 if readpbp.header==sch(0).."PBP" then
  if readpbp.endoffile-readpbp.datapsar>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_DATA.PSAR"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
  if readpbp.datapsar-readpbp.datapsp>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_DATA.PSP"..etype
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
  if readpbp.icon1-readpbp.icon0>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_ICON0.PNG"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
  if readpbp.pic0-readpbp.icon1>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_ICON1.PMF"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
 pbpn=#pbplist+1
 pbplist[pbpn]={}
 pbplist[pbpn].a=#pbplist
 pbplist[pbpn].name="_PARAM.SF0"
 pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
 pbplist[pbpn].w=Dir[sn].w+1
 pbplist[pbpn].f=0
  if readpbp.pic1-readpbp.pic0>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_PIC0.PNG"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
  if readpbp.snd0-readpbp.pic1>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_PIC1.PNG"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
  if readpbp.datapsp-readpbp.snd0>0 then
  pbpn=#pbplist+1
  pbplist[pbpn]={}
  pbplist[pbpn].a=#pbplist
  pbplist[pbpn].name="_SND0.AT3"
  pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
  pbplist[pbpn].w=Dir[sn].w+1
  pbplist[pbpn].f=0
  pbplist[pbpn].e=true
  end
 Dir[sn].a=pbpn
 elseif readpbp.header==sch(127).."ELF" then
 pbpn=#pbplist+1
 pbplist[pbpn]={}
 pbplist[pbpn].a=#pbplist
 pbplist[pbpn].name="_DATA.PSP (ELF)"
 pbplist[pbpn].path=Dir[sn].path..Dir[sn].name
 pbplist[pbpn].w=Dir[sn].w+1
 pbplist[pbpn].f=0
 pbplist[pbpn].e=true
 Dir[sn].a=1
 else
 Dir[sn].a=0
 end
Dir[sn].f=4
 if #pbplist>0 then
 update(sn,pbpn)
 tDir={}
  for a=1,sn do
  ti(tDir,Dir[a])
  end
  for a=1,pbpn do
  ti(tDir,pbplist[a])
  end
  for a=sn+1,#Dir do
  ti(tDir,Dir[a])
  end
 Dir=tDir
 tDir=nil
 end
pbpn=nil
readpbp=nil
pbplist=nil
etype=nil
pbpn=nil
collectgarbage("collect")
end

function ispbp(p)
pbp=io.open(p,"rb")
header=pbp:read(4)
pbp:close()
pbp=nil
 if header==sch(0).."PBP" then
  return true
 end
end

function ispng(p)
png=io.open(p,"rb")
header=png:read(4)
png:close()
png=nil
 if header==sch(0x89).."PNG" then
  return true
 end
end

function ispmf(p)
pmf=io.open(p,"rb")
header=pmf:read(4)
pmf:close()
pmf=nil
 if header=="PSMF" then
  return true
 end
end

function isat3(p)
at3=io.open(p,"rb")
header=at3:read(4)
at3:close()
at3=nil
 if header=="RIFF" then
  return true
 end
end

function isdatapsp(p)
dpsp=io.open(p,"rb")
header=dpsp:read(4)
dpsp:close()
dpsp=nil
 if header==sch(127).."ELF" or header=="~PSP" then
  return true
 end
end

function isupdate(p)
 for a=1,tg(Keyname)do
  if ss(Keyname[a],1,12)=="UPDATER_VER"..sch(0)then
   return true
  end
 end
end

function pbppngdim(data,dim)
 if dim=="w" then
 w={}
 w[1]=sb(ss(data,17,17))*256*256*256
 w[2]=sb(ss(data,18,18))*256*256
 w[3]=sb(ss(data,19,19))*256
 w[4]=sb(ss(data,20,20))
  return w[1]+w[2]+w[3]+w[4]
 elseif dim=="h" then
 h={}
 h[1]=sb(ss(data,21,21))*256*256*256
 h[2]=sb(ss(data,22,22))*256*256
 h[3]=sb(ss(data,23,23))*256
 h[4]=sb(ss(data,24,24))
  return h[1]+h[2]+h[3]+h[4]
 end
end

function pngdim(p,dim)
local f=io.open(p,"rb")
 if dim=="w" then
 f:seek("set",16)
 w={}
 w[1]=sb(f:read(1))*256*256*256
 w[2]=sb(f:read(1))*256*256
 w[3]=sb(f:read(1))*256
 w[4]=sb(f:read(1))
 f:close()
 f=nil
  return w[1]+w[2]+w[3]+w[4]
 elseif dim=="h" then
 f:seek("set",20)
 h={}
 h[1]=sb(f:read(1))*256*256*256
 h[2]=sb(f:read(1))*256*256
 h[3]=sb(f:read(1))*256
 h[4]=sb(f:read(1))
 f:close()
 f=nil
  return h[1]+h[2]+h[3]+h[4]
 end
end

function pmfdim(p,w,o)
local f=io.open(p,"rb")
 if not o then
 o=0
 end
 if w=="w" then
 f:seek("set",142+o)
  return sb(f:read(1))*16
 elseif w=="h" then
 f:seek("set",143+o)
  return sb(f:read(1))*16
 end
f:close()
f=nil
end

function getheader(p)
epbp=io.open(p,"rb")
epbpheader=epbp:read(4)
epbp:close()
epbp=nil
 return epbpheader
end

function getpbp(p)
 if ispbp(p)then
 pbp=io.open(p,"rb")
 pbpheader=pbp:read(8)
 Offset={}
 Offset.Param=getsize(pbp)
 Offset.Icon0=getsize(pbp)
 Offset.Icon1=getsize(pbp)
 Offset.Pic0=getsize(pbp)
 Offset.Pic1=getsize(pbp)
 Offset.Snd0=getsize(pbp)
 Offset.Datapsp=getsize(pbp)
 Offset.Datapsar=getsize(pbp)
 Offset.Endoffile=pbp:seek("end")
 Offset.OParam=Offset.Param
 Offset.OIcon0=Offset.Icon0
 Offset.OIcon1=Offset.Icon1
 Offset.OPic0=Offset.Pic0
 Offset.OPic1=Offset.Pic1
 Offset.OSnd0=Offset.Snd0
 Offset.ODatapsp=Offset.Datapsp
 Offset.ODatapsar=Offset.Datapsar
 Offset.OEndoffile=Offset.Endoffile
  if Offset.Icon1<Offset.Icon0 or Offset.Pic0<Offset.Icon1 or Offset.Pic1<Offset.Pic0 or Offset.Snd0<Offset.Pic1 or Offset.Datapsp<Offset.Snd0 or Offset.Datapsar<Offset.Datapsp or Offset.Endoffile<Offset.Datapsar then
  message("The offsets in this eboot are corrupted.")
  end
 pbp:seek("set",40)
 paramheader=pbp:read(8)
 Tableend=getsize(pbp)
 Nameend=getsize(pbp)
 Keytable={}
 Keytable.Amount=getsize(pbp)
  for a=1,Keytable.Amount do
  Keytable[a]={0,"",0,0,0}
  Keytable[a][1]=getsize(pbp,2)
  Keytable[a][2]=pbp:read(2)
  Keytable[a][3]=getsize(pbp)
  Keytable[a][4]=getsize(pbp)
  Keytable[a][5]=getsize(pbp)
  end
 Keyname={}
  for a=1,Keytable.Amount-1 do
  Keyname[a]=pbp:read(Keytable[a+1][1]-Keytable[a][1])
  end
 Keyname[Keytable.Amount]=pbp:read(Nameend-(Tableend+Keytable[Keytable.Amount][1]))
 Keyvalue={}
 Remove={}
 ext={}
 Eboot={}
 Eboot.Title=""
 Eboot.Parental=""
 Eboot.Appversion=""
 Eboot.Datapsptype=""
 Eboot.Modname=""
 Newtitle=""
  for a=1,Keytable.Amount do
  Keyvalue[a]=pbp:read(Keytable[a][4])
   if ss(Keyname[a],1,6)=="TITLE"..sch(0)then
   Eboot.Title=ss(Keyvalue[a],1,Keytable[a][3])
    while ss(Eboot.Title,-1)==sch(0)do
    Eboot.Title=ss(Eboot.Title,1,-2)
    end
   end
   if ss(Keyname[a],1,15)=="PARENTAL_LEVEL"..sch(0)then
   Eboot.Parental=sb(ss(Keyvalue[a],1,1))
   end
   if ss(Keyname[a],1,8)=="APP_VER"..sch(0)then
   Eboot.Appversion=Keyvalue[a]
    while ss(Eboot.Appversion,-1)==sch(0)do
    Eboot.Appversion=ss(Eboot.Appversion,1,-2)
    end
   end
  end
  if ss(Keyname[1],1,8)=="MEMSIZE"..sch(0)then
  Eboot.Memsize=true
  end
  if Offset.Icon1-Offset.Icon0>0 then
  pbp:seek("set",Offset.Icon0)
   if pbp:read(4)==sch(0x89).."PNG" then
   pbp:seek("set",Offset.Icon0)
   Eboot.Icon0=pge.texture.loadmemory(pbp:read(Offset.Icon1-Offset.Icon0),PGE_RAM,true)
   pbp:seek("set",Offset.Icon0)
   Eboot.pngdata=pbp:read(24)
   Eboot.Icon0w=pbppngdim(Eboot.pngdata,"w")
   Eboot.Icon0h=pbppngdim(Eboot.pngdata,"h")
   Eboot.Icon0size=bkmg(Offset.Icon1-Offset.Icon0)
   Eboot.Icon0imgw=Eboot.Icon0w
   Eboot.Icon0imgh=Eboot.Icon0h
    if Eboot.Icon0imgw>144 then
    Eboot.Icon0imgh=mc((144/Eboot.Icon0imgw)*Eboot.Icon0imgh)
    Eboot.Icon0imgw=144
    end
    if Eboot.Icon0imgh>80 then
    Eboot.Icon0imgw=mc((80/Eboot.Icon0imgh)*Eboot.Icon0imgw)
    Eboot.Icon0imgh=80
    end
    if not Eboot.Icon0 then
     if Eboot.Icon0w>512 or Eboot.Icon0h>512 then
     Eboot.Icon0=exceedblit
     Eboot.Icon0imgw=195
     Eboot.Icon0imgh=28
     else
     message("Error loading ICON0.PNG.")
     end
    end
   else
   message("Error reading ICON0.PNG")
   end
  end
  if Offset.Pic0-Offset.Icon1>0 then
  pbp:seek("set",Offset.Icon1)
   if pbp:read(4)=="PSMF" then
   pbp:seek("set",Offset.Icon1+tonumber(0x8e))
   Eboot.Icon1=true
   Eboot.Icon1w=sb(pbp:read(1))*16
   Eboot.Icon1h=sb(pbp:read(1))*16
   Eboot.Icon1size=bkmg(Offset.Pic0-Offset.Icon1)
   else
   message("Error reading ICON1.PMF")
   end
  end
  if Offset.Pic1-Offset.Pic0>0 then
  pbp:seek("set",Offset.Pic0)
   if pbp:read(4)==sch(0x89).."PNG" then
   pbp:seek("set",Offset.Pic0)
   Eboot.Pic0=pge.texture.loadmemory(pbp:read(Offset.Pic1-Offset.Pic0))
   pbp:seek("set",Offset.Pic0)
   Eboot.pngdata=pbp:read(24)
   Eboot.Pic0w=pbppngdim(Eboot.pngdata,"w")
   Eboot.Pic0h=pbppngdim(Eboot.pngdata,"h")
   Eboot.Pic0size=bkmg(Offset.Pic1-Offset.Pic0)
   Eboot.Pic0imgw=Eboot.Pic0w
   Eboot.Pic0imgh=Eboot.Pic0h
    if not Eboot.Pic0 then
     if Eboot.Pic0w>512 or Eboot.Pic0h>512 then
     Eboot.Pic0=exceedblit
     Eboot.Pic0imgw=195
     Eboot.Pic0imgh=28
     else
     message("Error loading PIC0.PNG.")
     end
    end
    if Eboot.Pic0imgw>240 then
    Eboot.Pic0imgh=mc((240/Eboot.Pic0imgw)*Eboot.Pic0imgh)
    Eboot.Pic0imgw=240
    end
    if Eboot.Pic0imgh>136 then
    Eboot.Pic0imgw=mc((136/Eboot.Pic0imgh)*Eboot.Pic0imgw)
    Eboot.Pic0imgh=136
    end
   else
   message("Error reading PIC0.PNG")
   end
  end
  if Offset.Snd0-Offset.Pic1>0 then
  pbp:seek("set",Offset.Pic1)
   if pbp:read(4)==sch(0x89).."PNG" then
   pbp:seek("set",Offset.Pic1)
   Eboot.Pic1=pge.texture.loadmemory(pbp:read(Offset.Snd0-Offset.Pic1),PGE_RAM,true)
   pbp:seek("set",Offset.Pic1)
   Eboot.pngdata=pbp:read(24)
   Eboot.Pic1w=pbppngdim(Eboot.pngdata,"w")
   Eboot.Pic1h=pbppngdim(Eboot.pngdata,"h")
   Eboot.Pic1size=bkmg(Offset.Snd0-Offset.Pic1)
   Eboot.Pic1imgw=Eboot.Pic1w
   Eboot.Pic1imgh=Eboot.Pic1h
    if not Eboot.Pic1 then
     if Eboot.Pic1w>512 or Eboot.Pic1h>512 then
     Eboot.Pic1=exceedblit
     Eboot.Pic1imgw=195
     Eboot.Pic1imgh=28
     else
     message("Error loading PIC1.PNG.")
     end
    end
    if Eboot.Pic1imgw>240 then
    Eboot.Pic1imgh=mc((240/Eboot.Pic1imgw)*Eboot.Pic1imgh)
    Eboot.Pic1imgw=240
    end
    if Eboot.Pic1imgh>136 then
    Eboot.Pic1imgw=mc((136/Eboot.Pic1imgh)*Eboot.Pic1imgw)
    Eboot.Pic1imgh=136
    end
   else
   message("Error reading PIC1.PNG")
   end
  end
  if Offset.Datapsp-Offset.Snd0>0 then
  pbp:seek("set",Offset.Snd0)
   if pbp:read(4)=="RIFF" then
   Eboot.Snd0=true
   Eboot.Snd0size=bkmg(Offset.Datapsp-Offset.Snd0)
   else
   message("Error reading SND0.AT3")
   end
  end
  if Offset.Datapsar-Offset.Datapsp>0 then
  Eboot.Datapsp=true
  pbp:seek("set",Offset.Datapsp)
  Eboot.Datapsptype=pbp:read(4)
  Eboot.Datapspsize=bkmg(Offset.Datapsar-Offset.Datapsp)
   if Eboot.Datapsptype~=sch(127).."ELF" and Eboot.Datapsptype~="~PSP" then
   Eboot.Datapsptype="Unknown"
   else
    if Eboot.Datapsptype==sch(127).."ELF" then
    Eboot.Datapsptype="Unsigned/ELF"
    pbp:seek("set",Offset.Datapsp+16)
    elftype=pbp:read(4)
     if elftype==sch(160)..sch(255)..sch(8)..sch(0)then
     pbp:seek("set",Offset.Datapsp+64)
     mno=getsize(pbp,3)
     pbp:seek("set",Offset.Datapsp+mno+4)
     Eboot.Modname=pbp:read(28)
     elseif elftype==sch(2)..sch(0)..sch(8)..sch(0)then
     pbp:seek("set",Offset.Datapsp+32)
     mno=getsize(pbp,3)
     pbp:seek("set",Offset.Datapsp+mno+(31*16))
     mno=getsize(pbp,4)
     pbp:seek("set",Offset.Datapsp+mno+4)
     Eboot.Modname=pbp:read(28)
     end
    elftype=nil
    mno=nil
    elseif Eboot.Datapsptype=="~PSP" then
    Eboot.Datapsptype="Signed/~PSP"
    pbp:seek("set",Offset.Datapsp+10)
    Eboot.Modname=pbp:read(28)
    end
    while ss(Eboot.Modname,-1)==sch(0)do
    Eboot.Modname=ss(Eboot.Modname,1,-2)
    end
    for a=1,sL(Eboot.Modname)do
     if sb(ss(Eboot.Modname,a,a))>127 or sb(ss(Eboot.Modname,a,a))<10 then
     Eboot.Modname=""
      break
     end
    end
   end
  end
  if Offset.Endoffile-Offset.Datapsar>0 then
  Eboot.Datapsar=true
  Eboot.Datapsarsize=bkmg(Offset.Endoffile-Offset.Datapsar)
  end
 Eboot.PBPsize=bkmg(pbp:seek("end"))
 pbp:close()
 pbp=nil
 Update=""
  if isupdate(p)then
  Update="UPD"
  end
  return "PBP"..Update
 else
 readheader=getheader(p)
  if readheader==sch("0x7f").."ELF" then
  Eboot={}
  Eboot.Datapsptype="Unsigned/ELF"
   return "ELF"
  else
  Eboot={}
  Eboot.Datapsptype="Unknown"
   return "UNK"
  end
 end
end

function setet()
et={
"Title: "..Eboot.Title,
"Parental level: "..Eboot.Parental,
"App version: "..Eboot.Appversion,
"ICON0.PNG",
"ICON1.PMF",
"PIC0.PNG",
"PIC1.PNG",
"SND0.AT3",
"DATA.PSP",
"DATA.PSAR",
"MEMSIZE",
"Backup eboot",
"Restore eboot",
"Unpack eboot",
"Reload eboot",
"Remove all backed up eboots",
"Remove all unpacked eboots",
"View PARAM.SFO info",
"Save changes",
"Cancel"}
 while ss(et[1],-1)==sch(0)do
 et[1]=ss(et[1],1,-2)
 end
iseb={"*","","","","","","","","","",""}
isebc={Color.option,clear,clear,clear,clear,clear,clear,clear,clear,clear,clear}
 if Eboot.Parental~="" then
 iseb[2]="*"
 isebc[2]=Color.option
 end
 if Remove.Parental then
 iseb[2]="*"
 isebc[2]=Color.optionselect
 end
 if Eboot.Appversion~="" then
 iseb[3]="*"
 isebc[3]=Color.option
 end
 if Remove.Appversion then
 iseb[3]="*"
 isebc[3]=Color.optionselect
 end
 if Eboot.Icon0 then
 iseb[4]="*"
 isebc[4]=Color.option
 end
 if Remove.Icon0 then
 iseb[4]="*"
 isebc[4]=Color.optionselect
 end
 if Eboot.Icon1 then
 iseb[5]="*"
 isebc[5]=Color.option
 end
 if Remove.Icon1 then
 iseb[5]="*"
 isebc[5]=Color.optionselect
 end
 if Eboot.Pic0 then
 iseb[6]="*"
 isebc[6]=Color.option
 end
 if Remove.Pic0 then
 iseb[6]="*"
 isebc[6]=Color.optionselect
 end
 if Eboot.Pic1 then
 iseb[7]="*"
 isebc[7]=Color.option
 end
 if Remove.Pic1 then
 iseb[7]="*"
 isebc[7]=Color.optionselect
 end
 if Eboot.Snd0 then
 iseb[8]="*"
 isebc[8]=Color.option
 end
 if Remove.Snd0 then
 iseb[8]="*"
 isebc[8]=Color.optionselect
 end
 if Eboot.Datapsp then
 iseb[9]="*"
 isebc[9]=Color.option
 end
 if Remove.Datapsp then
 iseb[9]="*"
 isebc[9]=Color.optionselect
 end
 if Eboot.Datapsar then
 iseb[10]="*"
 isebc[10]=Color.option
 end
 if Remove.Datapsar then
 iseb[10]="*"
 isebc[10]=Color.optionselect
 end
 if Eboot.Memsize then
 iseb[11]="*"
 isebc[11]=Color.option
 end
 if Remove.Memsize then
 iseb[11]="*"
 isebc[11]=Color.optionselect
 end
end

function extracteboot(ebp)
extp=Dir[sn].path
extpbp=pge.file.open(extp,PGE_FILE_RDONLY)
extread=nil
temp={}
 if ebp=="_DATA.PSAR" then
 extpbp:seek(36,PGE_FILE_SET)
 ext.datapsaroffset=getsize(extpbp)
 ext.datapsarsize=extpbp:size()-ext.datapsaroffset
 ext.datapsarpath=extp
 elseif ss(ebp,1,9)=="_DATA.PSP" then
  if extpbp:read(4)==sch(127).."ELF" then
  ext.datapspoffset=0
  ext.datapspsize=extpbp:size()
  Eboot.Datapsptype="Unsigned/ELF"
  extpbp:seek(16,PGE_FILE_SET)
  elftype=extpbp:read(4)
   if elftype==sch(160)..sch(255)..sch(8)..sch(0)then
   extpbp:seek(64,PGE_FILE_SET)
   mno=getsize(extpbp,3)
   extpbp:seek(mno+4,PGE_FILE_SET)
   Eboot.Modname=extpbp:read(28)
   elseif elftype==sch(2)..sch(0)..sch(8)..sch(0)then
   extpbp:seek(32,PGE_FILE_SET)
   mno=getsize(extpbp,3)
   extpbp:seek(mno+(31*16),PGE_FILE_SET)
   mno=getsize(extpbp,4)
   extpbp:seek(mno+4,PGE_FILE_SET)
   Eboot.Modname=extpbp:read(28)
   end
  elftype=nil
  mno=nil
  else
  extpbp:seek(32,PGE_FILE_SET)
  ext.datapspoffset=getsize(extpbp)
  ext.datapspsize=getsize(extpbp)-ext.datapspoffset
  extpbp:seek(ext.datapspoffset,PGE_FILE_SET)
  Eboot.Datapsptype=extpbp:read(4)
  Eboot.Modname=""
   if Eboot.Datapsptype~=sch(127).."ELF" and Eboot.Datapsptype~="~PSP" then
   Eboot.Datapsptype="Unknown"
   else
    if Eboot.Datapsptype==sch(127).."ELF" then
    Eboot.Datapsptype="Unsigned/ELF"
    extpbp:seek(ext.datapspoffset+16,PGE_FILE_SET)
    elftype=extpbp:read(4)
     if elftype==sch(160)..sch(255)..sch(8)..sch(0)then
     extpbp:seek(ext.datapspoffset+64,PGE_FILE_SET)
     mno=getsize(extpbp,3)
     extpbp:seek(ext.datapspoffset+mno+4,PGE_FILE_SET)
     Eboot.Modname=extpbp:read(28)
     elseif elftype==sch(2)..sch(0)..sch(8)..sch(0)then
     extpbp:seek(ext.datapspoffset+32,PGE_FILE_SET)
     mno=getsize(extpbp,3)
     extpbp:seek(ext.datapspoffset+mno+(31*16),PGE_FILE_SET)
     mno=getsize(extpbp,4)
     extpbp:seek(ext.datapspoffset+mno+4,PGE_FILE_SET)
     Eboot.Modname=extpbp:read(28)
     end
    elftype=nil
    mno=nil
    elseif Eboot.Datapsptype=="~PSP" then
    Eboot.Datapsptype="Signed/~PSP"
    extpbp:seek(ext.datapspoffset+10,PGE_FILE_SET)
    Eboot.Modname=extpbp:read(28)
    end
   end
  end
  while ss(Eboot.Modname,-1)==sch(0)do
  Eboot.Modname=ss(Eboot.Modname,1,-2)
  end
  for a=1,sL(Eboot.Modname)do
   if sb(ss(Eboot.Modname,a,a))>127 or sb(ss(Eboot.Modname,a,a))<10 then
   Eboot.Modname=""
    break
   end
  end
 ext.datapsppath=extp
 elseif ebp=="_ICON1.PMF" then
 extpbp:seek(16,PGE_FILE_SET)
 ext.icon1offset=getsize(extpbp)
 ext.icon1size=getsize(extpbp)-ext.icon1offset
 extpbp:seek(ext.icon1offset,PGE_FILE_SET)
 extread=extpbp:read(4)
  if extread~="PSMF" then
  extpbp:close()
  extpbp=nil
   return nil
  end
 ext.icon1path=extp
 elseif ebp=="_ICON0.PNG" then
 extpbp:seek(12,PGE_FILE_SET)
 temp.offset=getsize(extpbp)
 temp.size=getsize(extpbp)-temp.offset
 extpbp:seek(temp.offset,PGE_FILE_SET)
 extread=extpbp:read(4)
  if extread~=sch(0x89).."PNG" then
  extpbp:close()
  extpbp=nil
  temp=nil
   return nil
  end
  if searchoption=="ICON0.PNG" then
  ext.icon0offset=temp.offset
  ext.icon0size=temp.size
  ext.icon0path=extp
  elseif searchoption=="PIC0.PNG" then
  ext.pic0offset=temp.offset
  ext.pic0size=temp.size
  ext.pic0path=extp
  elseif searchoption=="PIC1.PNG" then
  ext.pic1offset=temp.offset
  ext.pic1size=temp.size
  ext.pic1path=extp
  end
 elseif ebp=="_PIC0.PNG" then
 extpbp:seek(20,PGE_FILE_SET)
 temp.offset=getsize(extpbp)
 temp.size=getsize(extpbp)-temp.offset
 extpbp:seek(temp.offset,PGE_FILE_SET)
 extread=extpbp:read(4)
  if extread~=sch(0x89).."PNG" then
  extpbp:close()
  extpbp=nil
   return nil
  end
  if searchoption=="ICON0.PNG" then
  ext.icon0offset=temp.offset
  ext.icon0size=temp.size
  ext.icon0path=extp
  elseif searchoption=="PIC0.PNG" then
  ext.pic0offset=temp.offset
  ext.pic0size=temp.size
  ext.pic0path=extp
  elseif searchoption=="PIC1.PNG" then
  ext.pic1offset=temp.offset
  ext.pic1size=temp.size
  ext.pic1path=extp
  end
 elseif ebp=="_PIC1.PNG" then
 extpbp:seek(24,PGE_FILE_SET)
 temp.offset=getsize(extpbp)
 temp.size=getsize(extpbp)-temp.offset
 extpbp:seek(temp.offset,PGE_FILE_SET)
 extread=extpbp:read(4)
  if extread~=sch(0x89).."PNG" then
  extpbp:close()
  extpbp=nil
  temp=nil
   return nil
  end
  if searchoption=="ICON0.PNG" then
  ext.icon0offset=temp.offset
  ext.icon0size=temp.size
  ext.icon0path=extp
  elseif searchoption=="PIC0.PNG" then
  ext.pic0offset=temp.offset
  ext.pic0size=temp.size
  ext.pic0path=extp
  elseif searchoption=="PIC1.PNG" then
  ext.pic1offset=temp.offset
  ext.pic1size=temp.size
  ext.pic1path=extp
  end
 elseif ebp=="_SND0.AT3" then
 extpbp:seek(28,PGE_FILE_SET)
 ext.snd0offset=getsize(extpbp)
 ext.snd0size=getsize(extpbp)-ext.snd0offset
 extpbp:seek(ext.snd0offset,PGE_FILE_SET)
 extread=extpbp:read(4)
  if extread~="RIFF" then
  extpbp:close()
  extpbp=nil
   return nil
  end
 ext.snd0path=extp
 end
extpbp:close()
extpbp=nil
temp=nil
 return true
end

function unpack()
unpath=defdir.."Eboot/Unpack/"..backupfolder.."/"..ss(ebootname,1,-5)
unread=pge.file.open(ebootpath,PGE_FILE_RDONLY)
 if not pge.dir.exists(defdir.."Eboot/Unpack/"..backupfolder)then
 pge.dir.mkdir(defdir.."Eboot/Unpack/"..backupfolder)
 end
 if not pge.dir.exists(unpath)then
 pge.dir.mkdir(unpath)
 end
 if Offset.OEndoffile-Offset.ODatapsar>0 then
 ufile=pge.file.openasync(unpath.."/DATA.PSAR",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.ODatapsar,PGE_FILE_SET)
 usize=Offset.OEndoffile-Offset.ODatapsar
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
 if Offset.ODatapsar-Offset.ODatapsp>0 then
 ufile=pge.file.openasync(unpath.."/DATA.PSP",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.ODatapsp,PGE_FILE_SET)
 usize=Offset.ODatapsar-Offset.ODatapsp
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
 if Offset.OIcon1-Offset.OIcon0>0 then
 ufile=pge.file.openasync(unpath.."/ICON0.PNG",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.OIcon0,PGE_FILE_SET)
 usize=Offset.OIcon1-Offset.OIcon0
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
 if Offset.OPic0-Offset.OIcon1>0 then
 ufile=pge.file.openasync(unpath.."/ICON1.PMF",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.OIcon1,PGE_FILE_SET)
 usize=Offset.OPic0-Offset.OIcon1
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
ufile=pge.file.openasync(unpath.."/".."PARAM.SFO",PGE_FILE_CREATE+PGE_FILE_WRONLY)
unread:seek(40,PGE_FILE_SET)
ufile:write(unread:read(Offset.OIcon0-40))
ufile:close()
 if Offset.OPic1-Offset.OPic0>0 then
 ufile=pge.file.openasync(unpath.."/PIC0.PNG",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.OPic0,PGE_FILE_SET)
 usize=Offset.OPic1-Offset.OPic0
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
 if Offset.OSnd0-Offset.OPic1>0 then
 ufile=pge.file.openasync(unpath.."/PIC1.PNG",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.OPic1,PGE_FILE_SET)
 usize=Offset.OSnd0-Offset.OPic1
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
 if Offset.ODatapsp-Offset.OSnd0>0 then
 ufile=pge.file.openasync(unpath.."/SND0.AT3",PGE_FILE_CREATE+PGE_FILE_WRONLY)
 unread:seek(Offset.OSnd0,PGE_FILE_SET)
 usize=Offset.ODatapsp-Offset.OSnd0
  while usize>0 do
   if usize>=1024*256 then
   ufile:write(unread:read(1024*256))
   usize=usize-1024*256
   elseif usize<1024*256 then
   ufile:write(unread:read(usize))
   usize=0
   end
  end
 ufile:close()
 end
ufile=nil
usize=nil
unread:close()
unread=nil
end

function removebackup()
dirbackup=scan(defdir.."Eboot/Backup")
 for a=1,#dirbackup do
  if dirbackup[#dirbackup].dir then
  pge.dir.rmdir(dirbackup[#dirbackup].path..dirbackup[#dirbackup].name)
  else
  pge.file.remove(dirbackup[#dirbackup].path..dirbackup[#dirbackup].name)
  end
 tr(dirbackup,#dirbackup)
 end
dirbackup=nil
end

function removeunpack()
dirunpack=scan(defdir.."Eboot/Unpack")
 for a=1,#dirunpack do
  if dirunpack[#dirunpack].dir then
  pge.dir.rmdir(dirunpack[#dirunpack].path..dirunpack[#dirunpack].name)
  else
  pge.file.remove(dirunpack[#dirunpack].path..dirunpack[#dirunpack].name)
  end
 tr(dirunpack,#dirunpack)
 end
dirunpack=nil
end
