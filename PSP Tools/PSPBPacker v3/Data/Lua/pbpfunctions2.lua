function addmemsize()
ismem=nil
 if ss(Keyname[1],1,8)=="MEMSIZE"..sch(0)then
 ismem=true
 end
 if not ismem then
 MKeyname={"MEMSIZE"..sch(0)}
  while #Keyname>0 do
  ti(MKeyname,tr(Keyname,1))
  end
  while #MKeyname>0 do
  ti(Keyname,tr(MKeyname,1))
  end
 MKeyname=nil
 Keytable.Amount=Keytable.Amount+1
 Tableend=Tableend+16
 Nameend=Nameend+24
 Keytable[tg(Keytable)+1]={0,"",0,0,0}
 Keyvalue[tg(Keyvalue)+1]=""
  for a=2,#Keyname do
  Higher=tg(Keyname)-(a-2)
  Lower=tg(Keyname)-(a-1)
  Keytable[Higher][1]=Keytable[Lower][1]+8
  Keytable[Higher][2]=Keytable[Lower][2]
  Keytable[Higher][3]=Keytable[Lower][3]
  Keytable[Higher][4]=Keytable[Lower][4]
  Keytable[Higher][5]=Keytable[Lower][5]+4
  Keyvalue[Higher]=Keyvalue[Lower]
  end
 Keyvalue[1]=sch(1)..sch(0)..sch(0)..sch(0)
 Keytable[1][2]=sch(4)..sch(4)
 Keytable[1][3]=4
 Keytable[1][4]=4
 Offset.Icon0=Offset.Icon0+28
 Offset.Icon1=Offset.Icon1+28
 Offset.Pic0=Offset.Pic0+28
 Offset.Pic1=Offset.Pic1+28
 Offset.Snd0=Offset.Snd0+28
 Offset.Datapsp=Offset.Datapsp+28
 Offset.Datapsar=Offset.Datapsar+28
 Offset.Endoffile=Offset.Endoffile+28
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 Eboot.Memsize=true
 Remove.Memsize=nil
 setet()
 end
end

function removememsize()
ismem=nil
 if ss(Keyname[1],1,8)=="MEMSIZE"..sch(0)then
 ismem=true
 end
 if ismem then
  for a=2,#Keytable do
  Keytable[a][1]=Keytable[a][1]-8
  Keytable[a][5]=Keytable[a][5]-4
  end
 tr(Keytable,1)
 tr(Keyname,1)
 tr(Keyvalue,1)
 Keytable.Amount=Keytable.Amount-1
 Tableend=Tableend-16
 Nameend=Nameend-24
 Offset.Icon0=Offset.Icon0-28
 Offset.Icon1=Offset.Icon1-28
 Offset.Pic0=Offset.Pic0-28
 Offset.Pic1=Offset.Pic1-28
 Offset.Snd0=Offset.Snd0-28
 Offset.Datapsp=Offset.Datapsp- 28
 Offset.Datapsar=Offset.Datapsar-28
 Offset.Endoffile=Offset.Endoffile-28
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 Eboot.Memsize=nil
 Remove.Memsize=true
 setet()
 end
end

function changetitle()
 for a=1,Keytable.Amount do
  if ss(Keyname[a],1,6)=="TITLE"..sch(0)then
  tpl=a
  end
 end
tlen=sL(Eboot.Title)
toff=128-Keytable[tpl][4]
 while sL(Eboot.Title)<128 do
 Eboot.Title=Eboot.Title..sch(0)
 end
Keytable[tpl][3]=tlen+1
Keytable[tpl][4]=128
Keyvalue[tpl]=Eboot.Title
 for a=tpl+1,tg(Keytable)do
 Keytable[a][5]=Keytable[a][5]+toff
 end
Offset.Icon0=Offset.Icon0+toff
Offset.Icon1=Offset.Icon1+toff
Offset.Pic0=Offset.Pic0+toff
Offset.Pic1=Offset.Pic1+toff
Offset.Snd0=Offset.Snd0+toff
Offset.Datapsp=Offset.Datapsp+toff
Offset.Datapsar=Offset.Datapsar+toff
Offset.Endoffile=Offset.Endoffile+toff
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changeparental(num)
ispar=nil
 for a=1,tg(Keyname)do
  if ss(Keyname[a],1,15)=="PARENTAL_LEVEL"..sch(0)then
  poff=a
  ispar=true
  end
 end
 if ispar then
 Keyvalue[poff]=sch(num)..sch(0)..sch(0)..sch(0)
 else
 ismem=nil
  if ss(Keyname[1],1,8)=="MEMSIZE"..sch(0)then
  ismem=true
  end
 Keyname[tg(Keyname)+1]="PARENTAL_LEVEL"..sch(0)
  if ismem then
  MKeyname={}
  ti(MKeyname,tr(Keyname,1))
  ts(Keyname)
   while tg(Keyname)>0 do
   ti(MKeyname,tr(Keyname,1))
   end
   while tg(MKeyname)>0 do
   ti(Keyname,tr(MKeyname,1))
   end
  MKeyname=nil
  else
  ts(Keyname)
  end
 Keyname[tg(Keyname)]=Keyname[tg(Keyname)]..sch(0)
 Keytable.Amount=Keytable.Amount+1
 Tableend=Tableend+16
 Nameend=Nameend+32
 Keytable[tg(Keytable)+1]={0,"",0,0,0}
 Keyvalue[tg(Keyvalue)+1]=""
  for a=1,tg(Keyname)do
   if ss(Keyname[a],1,15)=="PARENTAL_LEVEL"..sch(0)then
   poff=a+1
   end
  end
  for a=poff,tg(Keyname)do
  Higher=tg(Keyname)-(a-poff)
  Lower=tg(Keyname)-(a-(poff-1))
  Keytable[Higher][1]=Keytable[Lower][1]+15
  Keytable[Higher][2]=Keytable[Lower][2]
  Keytable[Higher][3]=Keytable[Lower][3]
  Keytable[Higher][4]=Keytable[Lower][4]
  Keytable[Higher][5]=Keytable[Lower][5]+4
  Keyvalue[Higher]=Keyvalue[Lower]
  end
 Keyvalue[poff-1]=sch(num)..sch(0)..sch(0)..sch(0)
 Keytable[poff-1][2]=sch(4)..sch(4)
 Keytable[poff-1][3]=4
 Keytable[poff-1][4]=4
 Offset.Icon0=Offset.Icon0+36
 Offset.Icon1=Offset.Icon1+36
 Offset.Pic0=Offset.Pic0+36
 Offset.Pic1=Offset.Pic1+36
 Offset.Snd0=Offset.Snd0+36
 Offset.Datapsp=Offset.Datapsp+36
 Offset.Datapsar=Offset.Datapsar+36
 Offset.Endoffile=Offset.Endoffile+36
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 end
setet()
end

function removeparental()
 for a=1,tg(Keyname)do
  if ss(Keyname[a],1,15)=="PARENTAL_LEVEL"..sch(0)then
  poff=a
  end
 end
 for a=poff+1,tg(Keytable)do
 Keytable[a][1]=Keytable[a][1]-15
 Keytable[a][5]=Keytable[a][5]-4
 end
tr(Keytable,poff)
tr(Keyname,poff)
tr(Keyvalue,poff)
Keyname[tg(Keyname)]=ss(Keyname[tg(Keyname)],1,-2)
Keytable.Amount=Keytable.Amount-1
Tableend=Tableend-16
Nameend=Nameend-32
Offset.Icon0=Offset.Icon0-36
Offset.Icon1=Offset.Icon1-36
Offset.Pic0=Offset.Pic0-36
Offset.Pic1=Offset.Pic1-36
Offset.Snd0=Offset.Snd0-36
Offset.Datapsp=Offset.Datapsp-36
Offset.Datapsar=Offset.Datapsar-36
Offset.Endoffile=Offset.Endoffile-36
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changeappver(ver)
isapp=nil
 for a=1,tg(Keyname)do
  if ss(Keyname[a],1,8)=="APP_VER"..sch(0)then
  aoff=a
  isapp=true
  end
 end
 if isapp then
 Keyvalue[aoff]=ver
  if sL(ver)<8 then
  Keytable[aoff][3]=sL(ver)+1
  else
  Keytable[aoff][3]=sL(ver)
  end
  while sL(Keyvalue[aoff])<8 do
  Keyvalue[aoff]=Keyvalue[aoff]..sch(0)
  end
 else
 ismem=nil
  if ss(Keyname[1],1,8)=="MEMSIZE"..sch(0)then
  ismem=true
  end
 Keyname[tg(Keyname)+1]="APP_VER"..sch(0)
  if ismem then
  MKeyname={}
  ti(MKeyname,tr(Keyname,1))
  ts(Keyname)
   while tg(Keyname)>0 do
   ti(MKeyname,tr(Keyname,1))
   end
   while tg(MKeyname)>0 do
   ti(Keyname,tr(MKeyname,1))
   end
  MKeyname=nil
  else
  ts(Keyname)
  end
 Keytable.Amount=Keytable.Amount+1
 Tableend=Tableend+16
 Nameend=Nameend+24
 Keytable[tg(Keytable)+1]={0,"",0,0,0}
 Keyvalue[tg(Keyvalue)+1]=""
  for a=1,tg(Keyname)do
   if ss(Keyname[a],1,8)=="APP_VER"..sch(0)then
   aoff=a+1
   end
  end
  for a=aoff,tg(Keyname)do
  Higher=tg(Keyname)-(a-aoff)
  Lower=tg(Keyname)-(a-(aoff-1))
  Keytable[Higher][1]=Keytable[Lower][1]+8
  Keytable[Higher][2]=Keytable[Lower][2]
  Keytable[Higher][3]=Keytable[Lower][3]
  Keytable[Higher][4]=Keytable[Lower][4]
  Keytable[Higher][5]=Keytable[Lower][5]+8
  Keyvalue[Higher]=Keyvalue[Lower]
  end
 Keyvalue[aoff-1]=ver
  if sL(ver)<8 then
  Keytable[aoff-1][3]=sL(ver)+1
  else
  Keytable[aoff-1][3]=sL(ver)
  end
  while sL(Keyvalue[aoff-1])<8 do
  Keyvalue[aoff-1]=Keyvalue[aoff-1]..sch(0)
  end
 Keytable[aoff-1][2]=sch(4)..sch(2)
 Keytable[aoff-1][4]=8
 Offset.Icon0=Offset.Icon0+32
 Offset.Icon1=Offset.Icon1+32
 Offset.Pic0=Offset.Pic0+32
 Offset.Pic1=Offset.Pic1+32
 Offset.Snd0=Offset.Snd0+32
 Offset.Datapsp=Offset.Datapsp+32
 Offset.Datapsar=Offset.Datapsar+32
 Offset.Endoffile=Offset.Endoffile+32
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 end
setet()
end

function removeappver()
 for a=1,tg(Keyname)do
  if ss(Keyname[a],1,8)=="APP_VER"..sch(0)then
  aoff=a
  end
 end
 for a=aoff+1,tg(Keytable)do
 Keytable[a][1]=Keytable[a][1]-8
 Keytable[a][5]=Keytable[a][5]-8
 end
tr(Keytable,aoff)
tr(Keyname,aoff)
tr(Keyvalue,aoff)
Keytable.Amount=Keytable.Amount-1
Tableend=Tableend-16
Nameend=Nameend-24
Offset.Icon0=Offset.Icon0-32
Offset.Icon1=Offset.Icon1-32
Offset.Pic0=Offset.Pic0-32
Offset.Pic1=Offset.Pic1-32
Offset.Snd0=Offset.Snd0-32
Offset.Datapsp=Offset.Datapsp-32
Offset.Datapsar=Offset.Datapsar-32
Offset.Endoffile=Offset.Endoffile-32
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changeicon0(p,mem)
Eboot.Icon0path=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 Eboot.Icon0=pge.texture.load(p)
 Eboot.Icon0w=pngdim(p,"w")
 Eboot.Icon0h=pngdim(p,"h")
 else
 Eboot.Newsize=ext.icon0size
 temp=pge.file.open(p,PGE_FILE_RDONLY)
 temp:seek(ext.icon0offset,PGE_FILE_SET)
 Eboot.Icon0=pge.texture.loadmemory(temp:read(ext.icon0size),PGE_RAM,true)
 temp:seek(ext.icon0offset,PGE_FILE_SET)
 Eboot.pngdata=temp:read(24)
 Eboot.Icon0w=pbppngdim(Eboot.pngdata,"w")
 Eboot.Icon0h=pbppngdim(Eboot.pngdata,"h")
 temp:close()
 temp=nil
 end
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
  message("Error loading PNG data for ICON0.PNG.")
  end
 end
 if Eboot.Icon0 then
 Eboot.Icon0size=bkmg(Eboot.Newsize)
 Offset.Change=(Offset.Icon1-Offset.Icon0)-Eboot.Newsize
 Offset.Icon1=Offset.Icon1-Offset.Change
 Offset.Pic0=Offset.Pic0-Offset.Change
 Offset.Pic1=Offset.Pic1-Offset.Change
 Offset.Snd0=Offset.Snd0-Offset.Change
 Offset.Datapsp=Offset.Datapsp-Offset.Change
 Offset.Datapsar=Offset.Datapsar-Offset.Change
 Offset.Endoffile=Offset.Endoffile-Offset.Change
 Remove.Icon0=nil
 Remove.Icon0w=nil
 Remove.Icon0h=nil
 Remove.Icon0size=nil
 Remove.Icon0path=nil
 Remove.OffsetIcon0=nil
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 setet()
 end
end

function removeicon0()
Remove.Icon0=Eboot.Icon0
Remove.Icon0w=Eboot.Icon0w
Remove.Icon0h=Eboot.Icon0h
Remove.Icon0size=Eboot.Icon0size
Remove.Icon0path=Eboot.Icon0path
Remove.OffsetIcon0=Offset.Icon1-Offset.Icon0
Eboot.Icon0new=nil
Eboot.Icon0path=nil
Eboot.Icon0size=nil
Eboot.Icon0=nil
Eboot.Icon0w=nil
Eboot.Icon0h=nil
Offset.Change=Offset.Icon1-Offset.Icon0
Offset.Icon1=Offset.Icon1-Offset.Change
Offset.Pic0=Offset.Pic0-Offset.Change
Offset.Pic1=Offset.Pic1-Offset.Change
Offset.Snd0=Offset.Snd0-Offset.Change
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restoreicon0()
Eboot.Icon0path=Remove.Icon0path
Eboot.Icon0size=Remove.Icon0size
Eboot.Icon0=Remove.Icon0
Eboot.Icon0w=Remove.Icon0w
Eboot.Icon0h=Remove.Icon0h
Remove.Icon0=nil
Remove.Icon0w=nil
Remove.Icon0h=nil
Remove.Icon0size=nil
Remove.Icon0path=nil
Offset.Icon1=Offset.Icon1+Remove.OffsetIcon0
Offset.Pic0=Offset.Pic0+Remove.OffsetIcon0
Offset.Pic1=Offset.Pic1+Remove.OffsetIcon0
Offset.Snd0=Offset.Snd0+Remove.OffsetIcon0
Offset.Datapsp=Offset.Datapsp+Remove.OffsetIcon0
Offset.Datapsar=Offset.Datapsar+Remove.OffsetIcon0
Offset.Endoffile=Offset.Endoffile+Remove.OffsetIcon0
Remove.OffsetIcon0=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changeicon1(p,mem)
Eboot.Icon1path=p
Eboot.Icon1=true
Eboot.Icon1new=true
 if not mem then
 Eboot.Newsize=sizefile(p)
 Eboot.Icon1w=pmfdim(p,"w")
 Eboot.Icon1h=pmfdim(p,"h")
 else
 Eboot.Newsize=ext.icon1size
 Eboot.Icon1w=pmfdim(p,"w",ext.icon1offset)
 Eboot.Icon1h=pmfdim(p,"h",ext.icon1offset)
 end
Eboot.Icon1size=bkmg(Eboot.Newsize)
Offset.Change=(Offset.Pic0-Offset.Icon1)-Eboot.Newsize
Offset.Pic0=Offset.Pic0-Offset.Change
Offset.Pic1=Offset.Pic1-Offset.Change
Offset.Snd0=Offset.Snd0-Offset.Change
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Remove.Icon1=nil
Remove.Icon1w=nil
Remove.Icon1h=nil
Remove.Icon1size=nil
Remove.Icon1path=nil
Remove.OffsetIcon1=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function removeicon1()
Remove.Icon1=Eboot.Icon1
Remove.Icon1w=Eboot.Icon1w
Remove.Icon1h=Eboot.Icon1h
Remove.Icon1size=Eboot.Icon1size
Remove.Icon1path=Eboot.Icon1path
Remove.OffsetIcon1=Offset.Pic0-Offset.Icon1
Eboot.Icon1new=nil
Eboot.Icon1path=nil
Eboot.Icon1size=nil
Eboot.Icon1=nil
Eboot.Icon1w=nil
Eboot.Icon1h=nil
Offset.Change=Offset.Pic0-Offset.Icon1
Offset.Pic0=Offset.Pic0-Offset.Change
Offset.Pic1=Offset.Pic1-Offset.Change
Offset.Snd0=Offset.Snd0-Offset.Change
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restoreicon1()
Eboot.Icon1path=Remove.Icon1path
Eboot.Icon1size=Remove.Icon1size
Eboot.Icon1=Remove.Icon1
Eboot.Icon1w=Remove.Icon1w
Eboot.Icon1h=Remove.Icon1h
Remove.Icon1=nil
Remove.Icon1w=nil
Remove.Icon1h=nil
Remove.Icon1size=nil
Remove.Icon1path=nil
Offset.Pic0=Offset.Pic0+Remove.OffsetIcon1
Offset.Pic1=Offset.Pic1+Remove.OffsetIcon1
Offset.Snd0=Offset.Snd0+Remove.OffsetIcon1
Offset.Datapsp=Offset.Datapsp+Remove.OffsetIcon1
Offset.Datapsar=Offset.Datapsar+Remove.OffsetIcon1
Offset.Endoffile=Offset.Endoffile+Remove.OffsetIcon1
Remove.OffsetIcon1=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changepic0(p,mem)
Eboot.Pic0path=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 Eboot.Pic0=pge.texture.load(p)
 Eboot.Pic0w=pngdim(p,"w")
 Eboot.Pic0h=pngdim(p,"h")
 else
 Eboot.Newsize=ext.pic0size
 temp=pge.file.open(p,PGE_FILE_RDONLY)
 temp:seek(ext.pic0offset,PGE_FILE_SET)
 Eboot.Pic0=pge.texture.loadmemory(temp:read(ext.pic0size),PGE_RAM,true)
 temp:seek(ext.pic0offset,PGE_FILE_SET)
 Eboot.pngdata=temp:read(24)
 Eboot.Pic0w=pbppngdim(Eboot.pngdata,"w")
 Eboot.Pic0h=pbppngdim(Eboot.pngdata,"h")
 temp:close()
 temp=nil
 end
Eboot.Pic0imgw=Eboot.Pic0w
Eboot.Pic0imgh=Eboot.Pic0h
 if not Eboot.Pic0 then
  if Eboot.Pic0w>512 or Eboot.Pic0>512 then
  Eboot.Pic0=exceedblit
  Eboot.Pic0imgw=195
  Eboot.Pic0imgh=28
  else
  message("Error loading PNG data for PIC0.PNG")
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
 if Eboot.Pic0 then
 Eboot.Pic0size=bkmg(Eboot.Newsize)
 Offset.Change=(Offset.Pic1-Offset.Pic0)-Eboot.Newsize
 Offset.Pic1=Offset.Pic1-Offset.Change
 Offset.Snd0=Offset.Snd0-Offset.Change
 Offset.Datapsp=Offset.Datapsp-Offset.Change
 Offset.Datapsar=Offset.Datapsar-Offset.Change
 Offset.Endoffile=Offset.Endoffile-Offset.Change
 Remove.Pic0=nil
 Remove.Pic0w=nil
 Remove.Pic0h=nil
 Remove.Pic0size=nil
 Remove.Pic0path=nil
 Remove.OffsetPic0=nil
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 setet()
 end
end

function removepic0()
Remove.Pic0=Eboot.Pic0
Remove.Pic0w=Eboot.Pic0w
Remove.Pic0h=Eboot.Pic0h
Remove.Pic0size=Eboot.Pic0size
Remove.Pic0path=Eboot.Pic0path
Remove.OffsetPic0=Offset.Pic1-Offset.Pic0
Eboot.Pic0path=nil
Eboot.Pic0size=nil
Eboot.Pic0=nil
Eboot.Pic0w=nil
Eboot.Pic0h=nil
Offset.Change=Offset.Pic1-Offset.Pic0
Offset.Pic1=Offset.Pic1-Offset.Change
Offset.Snd0=Offset.Snd0-Offset.Change
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restorepic0()
Eboot.Pic0path=Remove.Pic0path
Eboot.Pic0size=Remove.Pic0size
Eboot.Pic0=Remove.Pic0
Eboot.Pic0w=Remove.Pic0w
Eboot.Pic0h=Remove.Pic0h
Remove.Pic0=nil
Remove.Pic0w=nil
Remove.Pic0h=nil
Remove.Pic0size=nil
Remove.Pic0path=nil
Offset.Pic1=Offset.Pic1+Remove.OffsetPic0
Offset.Snd0=Offset.Snd0+Remove.OffsetPic0
Offset.Datapsp=Offset.Datapsp+Remove.OffsetPic0
Offset.Datapsar=Offset.Datapsar+Remove.OffsetPic0
Offset.Endoffile=Offset.Endoffile+Remove.OffsetPic0
Remove.OffsetPic0=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changepic1(p,mem)
Eboot.Pic1path=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 Eboot.Pic1=pge.texture.load(p)
 Eboot.Pic1w=pngdim(p,"w")
 Eboot.Pic1h=pngdim(p,"h")
 else
 Eboot.Newsize=ext.pic1size
 temp=pge.file.open(p,PGE_FILE_RDONLY)
 temp:seek(ext.pic1offset,PGE_FILE_SET)
 Eboot.Pic1=pge.texture.loadmemory(temp:read(ext.pic1size),PGE_RAM,true)
 temp:seek(ext.pic1offset,PGE_FILE_SET)
 Eboot.pngdata=temp:read(24)
 Eboot.Pic1w=pbppngdim(Eboot.pngdata,"w")
 Eboot.Pic1h=pbppngdim(Eboot.pngdata,"h")
 temp:close()
 temp=nil
 end
Eboot.Pic1imgw=Eboot.Pic1w
Eboot.Pic1imgh=Eboot.Pic1h
 if not Eboot.Pic1 then
  if Eboot.Pic1w>512 or Eboot.Pic1h>512 then
  Eboot.Pic1=exceedblit
  Eboot.Pic1imgw=195
  Eboot.Pic1imgh=28
  else
  message("Error loading PNG data for PIC1.PNG")
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
 if Eboot.Pic1 then
 Eboot.Pic1size=bkmg(Eboot.Newsize)
 Offset.Change=(Offset.Snd0-Offset.Pic1)-Eboot.Newsize
 Offset.Snd0=Offset.Snd0-Offset.Change
 Offset.Datapsp=Offset.Datapsp-Offset.Change
 Offset.Datapsar=Offset.Datapsar-Offset.Change
 Offset.Endoffile=Offset.Endoffile-Offset.Change
 Remove.Pic1=nil
 Remove.Pic1w=nil
 Remove.Pic1h=nil
 Remove.Pic1size=nil
 Remove.Pic1path=nil
 Remove.OffsetPic1=nil
 Eboot.PBPsize=bkmg(Offset.Endoffile)
 setet()
 end
end

function removepic1()
Remove.Pic1=Eboot.Pic1
Remove.Pic1w=Eboot.Pic1w
Remove.Pic1h=Eboot.Pic1h
Remove.Pic1size=Eboot.Pic1size
Remove.Pic1path=Eboot.Pic1path
Remove.OffsetPic1=Offset.Snd0-Offset.Pic1
Eboot.Pic1path=nil
Eboot.Pic1size=nil
Eboot.Pic1=nil
Eboot.Pic1w=nil
Eboot.Pic1h=nil
Offset.Change=Offset.Snd0-Offset.Pic1
Offset.Snd0=Offset.Snd0-Offset.Change
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restorepic1()
Eboot.Pic1path=Remove.Pic1path
Eboot.Pic1size=Remove.Pic1size
Eboot.Pic1=Remove.Pic1
Eboot.Pic1w=Remove.Pic1w
Eboot.Pic1h=Remove.Pic1h
Remove.Pic1=nil
Remove.Pic1w=nil
Remove.Pic1h=nil
Remove.Pic1size=nil
Remove.Pic1path=nil
Offset.Snd0=Offset.Snd0+Remove.OffsetPic1
Offset.Datapsp=Offset.Datapsp+Remove.OffsetPic1
Offset.Datapsar=Offset.Datapsar+Remove.OffsetPic1
Offset.Endoffile=Offset.Endoffile+Remove.OffsetPic1
Remove.OffsetPic1=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changesnd0(p,mem)
Eboot.Snd0path=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 else
 Eboot.Newsize=ext.snd0size
 end
Eboot.Snd0=true
Eboot.Snd0size=bkmg(Eboot.Newsize)
Offset.Change=(Offset.Datapsp-Offset.Snd0)-Eboot.Newsize
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Remove.Snd0=nil
Remove.Snd0size=nil
Remove.Snd0path=nil
Remove.OffsetSnd0=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function removesnd0()
Remove.Snd0=Eboot.Snd0
Remove.Snd0size=Eboot.Snd0size
Remove.Snd0path=Eboot.Snd0path
Remove.OffsetSnd0=Offset.Datapsp-Offset.Snd0
Eboot.Snd0path=nil
Eboot.Snd0size=nil
Eboot.Snd0=nil
Offset.Change=Offset.Datapsp-Offset.Snd0
Offset.Datapsp=Offset.Datapsp-Offset.Change
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restoresnd0()
Eboot.Snd0path=Remove.Snd0path
Eboot.Snd0size=Remove.Snd0size
Eboot.Snd0=Remove.Snd0
Remove.Snd0=nil
Remove.Snd0size=nil
Remove.Snd0path=nil
Offset.Datapsp=Offset.Datapsp+Remove.OffsetSnd0
Offset.Datapsar=Offset.Datapsar+Remove.OffsetSnd0
Offset.Endoffile=Offset.Endoffile+Remove.OffsetSnd0
Remove.OffsetSnd0=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changedatapsp(p,mem)
Eboot.Datapsppath=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 Eboot.pbp=io.open(p,"rb")
 Eboot.Datapsptype=Eboot.pbp:read(4)
 Eboot.Modname=""
  if Eboot.Datapsptype~=sch(127).."ELF" and Eboot.Datapsptype~="~PSP" then
  Eboot.Datapsptype="Unknown"
  else
   if Eboot.Datapsptype==sch(127).."ELF" then
   Eboot.Datapsptype="Unsigned/ELF"
   Eboot.pbp:seek("set",16)
   elftype=Eboot.pbp:read(4)
    if elftype==sch(160)..sch(255)..sch(8)..sch(0)then
    Eboot.pbp:seek("set",64)
    mno=getsize(Eboot.pbp,3)
    Eboot.pbp:seek("set",mno+4)
    Eboot.Modname=Eboot.pbp:read(28)
    elseif elftype==sch(2)..sch(0)..sch(8)..sch(0)then
    Eboot.pbp:seek("set",32)
    mno=getsize(Eboot.pbp,3)
    Eboot.pbp:seek("set",mno+(31*16))
    mno=getsize(Eboot.pbp,4)
    Eboot.pbp:seek("set",mno+4)
    Eboot.Modname=Eboot.pbp:read(28)
    end
   elftype=nil
   mno=nil
   elseif Eboot.Datapsptype=="~PSP" then
   Eboot.Datapsptype="Signed/~PSP"
   Eboot.pbp:seek("set",10)
   Eboot.Modname=Eboot.pbp:read(28)
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
 else
 Eboot.Newsize=ext.datapspsize
 end
Eboot.Datapspsize=bkmg(Eboot.Newsize)
Eboot.Datapsp=true
Offset.Change=(Offset.Datapsar-Offset.Datapsp)-Eboot.Newsize
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Remove.Datapsp=nil
Remove.Datapspsize=nil
Remove.Datapsppath=nil
Remove.OffsetDatapsp=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function removedatapsp()
Remove.Datapsp=Eboot.Datapsp
Remove.Datapspsize=Eboot.Datapspsize
Remove.Datapsppath=Eboot.Datapsppath
Remove.OffsetDatapsp=Offset.Datapsar-Offset.Datapsp
Eboot.Datapsppath=nil
Eboot.Datapspsize=nil
Eboot.Datapsp=nil
Offset.Change=Offset.Datapsar-Offset.Datapsp
Offset.Datapsar=Offset.Datapsar-Offset.Change
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restoredatapsp()
Eboot.Datapsppath=Remove.Datapsppath
Eboot.Datapspsize=Remove.Datapspsize
Eboot.Datapsp=Remove.Datapsp
Remove.Datapsp=nil
Remove.Datapspsize=nil
Remove.Datapsppath=nil
Offset.Datapsar=Offset.Datapsar+Remove.OffsetDatapsp
Offset.Endoffile=Offset.Endoffile+Remove.OffsetDatapsp
Remove.OffsetDatapsp=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changedatapsar(p,mem)
Eboot.Datapsarpath=p
 if not mem then
 Eboot.Newsize=sizefile(p)
 else
 Eboot.Newsize=ext.datapsarsize
 end
Eboot.Datapsarsize=bkmg(Eboot.Newsize)
Eboot.Datapsar=true
Offset.Change=(Offset.Endoffile-Offset.Datapsar)-Eboot.Newsize
Offset.Endoffile=Offset.Endoffile-Offset.Change
Remove.Datapsar=nil
Remove.Datapsarsize=nil
Remove.Datapsarpath=nil
Remove.OffsetDatapsar=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function removedatapsar()
Remove.Datapsar=Eboot.Datapsar
Remove.Datapsarsize=Eboot.Datapsarsize
Remove.Datapsarpath=Eboot.Datapsarpath
Remove.OffsetDatapsar=Offset.Endoffile-Offset.Datapsar
Eboot.Datapsarpath=nil
Eboot.Datapsarsize=nil
Eboot.Datapsar=nil
Offset.Change=Offset.Endoffile-Offset.Datapsar
Offset.Endoffile=Offset.Endoffile-Offset.Change
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function restoredatapsar()
Eboot.Datapsarpath=Remove.Datapsarpath
Eboot.Datapsarsize=Remove.Datapsarsize
Eboot.Datapsar=Remove.Datapsar
Remove.Datapsar=nil
Remove.Datapsarsize=nil
Remove.Datapsarpath=nil
Offset.Endoffile=Offset.Endoffile+Remove.OffsetDatapsar
Remove.OffsetDatapsar=nil
Eboot.PBPsize=bkmg(Offset.Endoffile)
setet()
end

function changeeboot()
newf=pge.file.openasync(ebootpath.."_n",PGE_FILE_CREATE+PGE_FILE_WRONLY)
newf:write(pbpheader)
newf:write(convertsize(Offset.Param))
newf:write(convertsize(Offset.Icon0))
newf:write(convertsize(Offset.Icon1))
newf:write(convertsize(Offset.Pic0))
newf:write(convertsize(Offset.Pic1))
newf:write(convertsize(Offset.Snd0))
newf:write(convertsize(Offset.Datapsp))
newf:write(convertsize(Offset.Datapsar))
newf:write(paramheader)
newf:write(convertsize(Tableend))
newf:write(convertsize(Nameend))
newf:write(convertsize(Keytable.Amount))
 for a=1,Keytable.Amount do
 newf:write(convertsize(Keytable[a][1],2))
 newf:write(Keytable[a][2])
 newf:write(convertsize(Keytable[a][3]))
 newf:write(convertsize(Keytable[a][4]))
 newf:write(convertsize(Keytable[a][5]))
 end
 for a=1,Keytable.Amount do
 newf:write(Keyname[a])
 end
 for a=1,Keytable.Amount do
 newf:write(Keyvalue[a])
 end
 if Offset.Icon1-Offset.Icon0>0 then
  if Eboot.Icon0path then
   if ext.icon0path then
   srcf=pge.file.open(ext.icon0path,PGE_FILE_RDONLY)
   srcf:seek(ext.icon0offset,PGE_FILE_SET)
   srcfs=ext.icon0size
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Icon0path)
   srcf=pge.file.open(Eboot.Icon0path,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.OIcon0,PGE_FILE_SET)
  srcfs=Offset.OIcon1-Offset.OIcon0
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    elseif srcfs>0 and srcfs<1024*256 then
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Pic0-Offset.Icon1>0 then
  if Eboot.Icon1path then
   if ext.icon1path then
   srcf=pge.file.open(ext.icon1path,PGE_FILE_RDONLY)
   srcf:seek(ext.icon1offset,PGE_FILE_SET)
   srcfs=ext.icon1size
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Icon1path)
   srcf=pge.file.open(Eboot.Icon1path,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.OIcon1,PGE_FILE_SET)
  srcfs=Offset.OPic0-Offset.OIcon1
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Pic1-Offset.Pic0>0 then
  if Eboot.Pic0path then
   if ext.pic0path then
   srcf=pge.file.open(ext.pic0path,PGE_FILE_RDONLY)
   srcf:seek(ext.pic0offset,PGE_FILE_SET)
   srcfs=ext.pic0size
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Pic0path)
   srcf=pge.file.open(Eboot.Pic0path,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.OPic0,PGE_FILE_SET)
  srcfs=Offset.OPic1-Offset.OPic0
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Snd0-Offset.Pic1>0 then
  if Eboot.Pic1path then
   if ext.pic1path then
   srcf=pge.file.open(ext.pic1path,PGE_FILE_RDONLY)
   srcf:seek(ext.pic1offset,PGE_FILE_SET)
   srcfs=ext.pic1size
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Pic1path)
   srcf=pge.file.open(Eboot.Pic1path,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.OPic1,PGE_FILE_SET)
  srcfs=Offset.OSnd0-Offset.OPic1
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Datapsp-Offset.Snd0>0 then
  if Eboot.Snd0path then
   if ext.snd0path then
   srcf=pge.file.open(ext.snd0path,PGE_FILE_RDONLY)
   srcf:seek(ext.snd0offset,PGE_FILE_SET)
   srcfs=ext.snd0size
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Snd0path)
   srcf=pge.file.open(Eboot.Snd0path,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.OSnd0,PGE_FILE_SET)
  srcfs=Offset.ODatapsp-Offset.OSnd0
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Datapsar-Offset.Datapsp>0 then
  if Eboot.Datapsppath then
   if ext.datapsppath then
   srcf=pge.file.open(ext.datapsppath,PGE_FILE_RDONLY)
   srcf:seek(ext.datapspoffset,PGE_FILE_SET)
   srcfs=ext.datapspsize
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Datapsppath)
   srcf=pge.file.open(Eboot.Datapsppath,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.ODatapsp,PGE_FILE_SET)
  srcfs=Offset.ODatapsar-Offset.ODatapsp
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end

 if Offset.Endoffile-Offset.Datapsar>0 then
  if Eboot.Datapsarpath then
   if ext.datapsarpath then
   srcf=pge.file.open(ext.datapsarpath,PGE_FILE_RDONLY)
   srcf:seek(ext.datapsaroffset,PGE_FILE_SET)
   srcfs=ext.datapsarsize
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   else
   srcfs=sizefile(Eboot.Datapsarpath)
   srcf=pge.file.open(Eboot.Datapsarpath,PGE_FILE_RDONLY)
    while srcfs>0 do
     if srcfs>=1024*256 then
     newf:write(srcf:read(1024*256))
     srcfs=srcfs-1024*256
     else
     newf:write(srcf:read(srcfs))
     srcfs=0
     end
    end
   srcf:close()
   end
  else
  srcf=pge.file.open(ebootpath,PGE_FILE_RDONLY)
  srcf:seek(Offset.ODatapsar,PGE_FILE_SET)
  srcfs=Offset.OEndoffile-Offset.ODatapsar
   while srcfs>0 do
    if srcfs>=1024*256 then
    newf:write(srcf:read(1024*256))
    srcfs=srcfs-1024*256
    else
    newf:write(srcf:read(srcfs))
    srcfs=0
    end
   end
  srcf:close()
  end
 end
newf:close()
newf=nil
srcf=nil
srcfs=nil
pge.file.remove(ebootpath)
pge.file.rename(ebootpath.."_n",ebootpath)
end
