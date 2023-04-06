function emenu()
 if not MAINDIR then
 MAINsn=sn
 MAINbtm=btm
 MAINpxs=pxs
 MAINDIR=Dir
  if updateerror then
  updateerror=nil
  message("Warning!","An edited system software update eboot will not run.")
  end
  if Dir[sn].path~="ms0:/" then
   for a=1,sL(Dir[sn].path)-1 do
    if ss(Dir[sn].path,a,a)=="/" then
    backupfolder=ss(Dir[sn].path,a+1,-2)
    end
   end
  else
  backupfolder=ss(Dir[sn].path,1,3)
  end
 ebootname=Dir[sn].name
 ebootpath=Dir[sn].path..Dir[sn].name
 ey=1
 en=10
 em=0
 setet()
  if Eboot.Datapsp then
   if Eboot.Datapsptype~="Unknown" then
   ebootstart=true
   else
   ebootstart=true
   ebootstarterror=true
   end
  else
  ebootstarterror=nil
  ebootstart=nil
  end
 end
 while pge.running()do
 pge.controls.update()
 sD()
 blitbg()
 pge.gfx.drawrect(0,14,6,140,gray)
 pge.gfx.drawrect(0,((em/14)*140/(tg(et)-9))+14,6,mc(140/(tg(et)-9)),red)
 pge.gfx.drawrect(1,15,478,138,cn(255,255,255,40))
 pge.gfx.drawrectoutline(0,14,479,139,black)
 Printcenter(0,"Eboot Menu",yellow,tblack)
 Print(0,258,"Eboot size: "..Eboot.PBPsize,Color.info,tblack)
  if pad:U()and ey==1 then
  ey=tg(et)+1
  en=tg(et)
  em=(en-10)*14
  end
  if pad:D()and ey==tg(et)then
  ey=0
  en=10
  em=0
  end
  if pad:U(2)and ey>1 then
  ey=ey-1
   if ey<en-9 then
   en=ey+9
   em=(en-10)*14
   end
  end
  if pad:D(2)and ey<tg(et)then
  ey=ey+1
   if ey>en then
   en=ey
   em=(en-10)*14
   end
  end
  for a=en-9,en do
   if ey==a then
   Print(17,a*14-em,et[a],Color.optionselect,tblack)
   else
   Print(17,a*14-em,et[a],Color.option,tblack)
   end
   if a<12 then
   Print(8,(a*14-em)+2,iseb[a],isebc[a],tblack)
   end
  end
  if ss(et[ey],1,6)=="Title:" then
  Print(0,168,"X - change title",Color.info,tblack)
   if pad:X()then
   eboottitle=osk("Title",Eboot.Title)
    if sL(eboottitle)>0 then
    Eboot.Title=eboottitle
    changetitle()
    end
   end
  end
  if ss(et[ey],1,15)=="Parental level:" then
  Print(0,168,"Left/Right - change parental level",Color.info,tblack)
   if Eboot.Parental~="" then
   Print(14,182,"Triangle - remove parental level",Color.info,tblack)
   elseif Remove.Parental then
   Print(14,182,"Triangle - restore parental level",Color.info,tblack)
   end
   if pad:L()then
    if Eboot.Parental~="" then
    Eboot.Parental=Eboot.Parental-1
     if Eboot.Parental<0 then
     Eboot.Parental=11
     end
    else
    Eboot.Parental=0
    end
   changeparental(Eboot.Parental)
   end
   if pad:R()then
    if Eboot.Parental~="" then
    Eboot.Parental=Eboot.Parental+1
     if Eboot.Parental>11 then
     Eboot.Parental=0
     end
    else
    Eboot.Parental=0
    end
   changeparental(Eboot.Parental)
   end
   if pad:T()then
    if Eboot.Parental~="" then
    Remove.Parental=Eboot.Parental
    Eboot.Parental=""
    removeparental()
    elseif Remove.Parental then
    Eboot.Parental=Remove.Parental
    Remove.Parental=nil
    changeparental(Eboot.Parental)
    end
   end
  end
  if ss(et[ey],1,12)=="App version:" then
  Print(49,168,"X - change app version",Color.info,tblack)
   if Eboot.Appversion~="" then
   Print(0,182,"Triangle - remove app version",Color.info,tblack)
   elseif Remove.Appversion then
   Print(0,182,"Triangle - restore app version",Color.info,tblack)
   end
   if pad:X("r")then
   appmenu()
   end
   if pad:T()then
    if Eboot.Appversion~="" then
    Remove.Appversion=Eboot.Appversion
    Eboot.Appversion=""
    removeappver()
    elseif Remove.Appversion then
    Eboot.Appversion=Remove.Appversion
    Remove.Appversion=nil
    changeappver(Eboot.Appversion)
    end
   end
  end
  if et[ey]=="ICON0.PNG" then
  Print(49,168,"X - change ICON0.PNG",Color.info,tblack)
   if Eboot.Icon0 then
   Print(0,182,"Triangle - remove ICON0.PNG",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Icon0size,Color.info,tblack)
   Print(21,210,"Width: "..Eboot.Icon0w,Color.info,tblack)
   Print(14,224,"Height: "..Eboot.Icon0h,Color.info,tblack)
   epx=358-(Eboot.Icon0imgw/2)
   pge.gfx.drawline(epx-1,134-(Eboot.Icon0imgh/2),epx-1,138+(Eboot.Icon0imgh/2),red)
   pge.gfx.drawline(epx+Eboot.Icon0imgw,134-(Eboot.Icon0imgh/2),epx+Eboot.Icon0imgw,138+(Eboot.Icon0imgh/2),red)
   pge.gfx.drawline(epx-2,135-(Eboot.Icon0imgh/2),epx+2+Eboot.Icon0imgw,135-(Eboot.Icon0imgh/2),red)
   pge.gfx.drawline(epx-2,136+(Eboot.Icon0imgh/2),epx+2+Eboot.Icon0imgw,136+(Eboot.Icon0imgh/2),red)
   Eboot.Icon0:activate()
   Eboot.Icon0:draw(epx,136-(Eboot.Icon0imgh/2),Eboot.Icon0imgw,Eboot.Icon0imgh)
   elseif Remove.Icon0 then
   Print(0,182,"Triangle - restore ICON0.PNG",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="ICON0.PNG"
   end
   if pad:T()then
    if Eboot.Icon0 then
    removeicon0()
    elseif Remove.Icon0 then
    restoreicon0()
    end
   end
  end
  if et[ey]=="ICON1.PMF" then
  Print(49,168,"X - change ICON1.PMF",Color.info,tblack)
   if Eboot.Icon1 then
   Print(0,182,"Triangle - remove ICON1.PMF",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Icon1size,Color.info,tblack)
   Print(21,210,"Width: "..Eboot.Icon1w,Color.info,tblack)
   Print(14,224,"Height: "..Eboot.Icon1h,Color.info,tblack)
   elseif Remove.Icon1 then
   Print(0,182,"Triangle - restore ICON1.PMF",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="ICON1.PMF"
   end
   if pad:T()then
    if Eboot.Icon1 then
    removeicon1()
    elseif Remove.Icon1 then
    restoreicon1()
    end
   end
  end
  if et[ey]=="PIC0.PNG" then
  Print(49,168,"X - change PIC0.PNG",Color.info,tblack)
   if Eboot.Pic0 then
   Print(0,182,"Triangle - remove PIC0.PNG",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Pic0size,Color.info,tblack)
   Print(21,210,"Width: "..Eboot.Pic0w,Color.info,tblack)
   Print(14,224,"Height: "..Eboot.Pic0h,Color.info,tblack)
   epx=358-(Eboot.Pic0imgw/2)
   pge.gfx.drawline(epx-1,134-(Eboot.Pic0imgh/2),epx-1,138+(Eboot.Pic0imgh/2),red)
   pge.gfx.drawline(epx+Eboot.Pic0imgw,134-(Eboot.Pic0imgh/2),epx+Eboot.Pic0imgw,138+(Eboot.Pic0imgh/2),red)
   pge.gfx.drawline(epx-2,135-(Eboot.Pic0imgh/2),epx+2+Eboot.Pic0imgw,135-(Eboot.Pic0imgh/2),red)
   pge.gfx.drawline(epx-2,136+(Eboot.Pic0imgh/2),epx+2+Eboot.Pic0imgw,136+(Eboot.Pic0imgh/2),red)
   Eboot.Pic0:activate()
   Eboot.Pic0:draw(epx,136-(Eboot.Pic0imgh/2),Eboot.Pic0imgw,Eboot.Pic0imgh)
   elseif Remove.Pic0 then
   Print(0,182,"Triangle - restore PIC0.PNG",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="PIC0.PNG"
   end
   if pad:T()then
    if Eboot.Pic0 then
    removepic0()
    elseif Remove.Pic0 then
    restorepic0()
    end
   end
  end
  if et[ey]=="PIC1.PNG" then
  Print(49,168,"X - change PIC1.PNG",Color.info,tblack)
   if Eboot.Pic1 then
   Print(0,182,"Triangle - remove PIC1.PNG",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Pic1size,Color.info,tblack)
   Print(21,210,"Width: "..Eboot.Pic1w,Color.info,tblack)
   Print(14,224,"Height: "..Eboot.Pic1h,Color.info,tblack)
   epx=358-(Eboot.Pic1imgw/2)
   pge.gfx.drawline(epx-1,134-(Eboot.Pic1imgh/2),epx-1,138+(Eboot.Pic1imgh/2),red)
   pge.gfx.drawline(epx+Eboot.Pic1imgw,134-(Eboot.Pic1imgh/2),epx+Eboot.Pic1imgw,138+(Eboot.Pic1imgh/2),red)
   pge.gfx.drawline(epx-2,135-(Eboot.Pic1imgh/2),epx+2+Eboot.Pic1imgw,135-(Eboot.Pic1imgh/2),red)
   pge.gfx.drawline(epx-2,136+(Eboot.Pic1imgh/2),epx+2+Eboot.Pic1imgw,136+(Eboot.Pic1imgh/2),red)
   Eboot.Pic1:activate()
   Eboot.Pic1:draw(epx,136-(Eboot.Pic1imgh/2),Eboot.Pic1imgw,Eboot.Pic1imgh)
   elseif Remove.Pic1 then
   Print(0,182,"Triangle - restore PIC1.PNG",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="PIC1.PNG"
   end
   if pad:T()then
    if Eboot.Pic1 then
    removepic1()
    elseif Remove.Pic1 then
    restorepic1()
    end
   end
  end
  if et[ey]=="SND0.AT3" then
  Print(49,168,"X - change SND0.AT3",Color.info,tblack)
   if Eboot.Snd0 then
   Print(0,182,"Triangle - remove SND0.AT3",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Snd0size,Color.info,tblack)
   elseif Remove.Snd0 then
   Print(0,182,"Triangle - restore SND0.AT3",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="SND0.AT3"
   end
   if pad:T()then
    if Eboot.Snd0 then
    removesnd0()
    elseif Remove.Snd0 then
    restoresnd0()
    end
   end
  end
  if et[ey]=="DATA.PSP" then
  Print(49,168,"X - change DATA.PSP",Color.info,tblack)
   if Eboot.Datapsp then
   Print(0,182,"Triangle - remove DATA.PSP",Color.info,tblack)
   Print(28,196,"Size: "..Eboot.Datapspsize,Color.info,tblack)
   Print(28,210,"Type: "..Eboot.Datapsptype,Color.info,tblack)
   Print(0,224,"Module name: "..Eboot.Modname,Color.info,tblack)
   elseif Remove.Datapsp then
   Print(0,182,"Triangle - restore DATA.PSP",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="DATA.PSP"
   end
   if pad:T()then
    if Eboot.Datapsp then
    removedatapsp()
    elseif Remove.Datapsp then
    restoredatapsp()
    end
   end
  end
  if et[ey]=="DATA.PSAR" then
  Print(49,168,"X - change DATA.PSAR",Color.info,tblack)
   if Eboot.Datapsar then
   Print(0,182,"Triangle - remove DATA.PSAR",Color.info,tblack)
   Print(49,196,"Size: "..Eboot.Datapsarsize,Color.info,tblack)
   elseif Remove.Datapsar then
   Print(0,182,"Triangle - restore DATA.PSAR",Color.info,tblack)
   end
   if pad:X("r")then
   dosearch=true
   searchoption="DATA.PSAR"
   end
   if pad:T()then
    if Eboot.Datapsar then
    removedatapsar()
    elseif Remove.Datapsar then
    restoredatapsar()
    end
   end
  end
  if et[ey]=="MEMSIZE" then
  Print(49,168,"X - Add MEMSIZE",Color.info,tblack)
  Print(0,196,"Unlock extra RAM for eboot (slim PSP only).",Color.info,tblack)
   if pad:X("r")then
   addmemsize()
   end
   if Eboot.Memsize then
   Print(0,182,"Triangle - remove MEMSIZE",Color.info,tblack)
    if pad:T()then
    removememsize()
    end
   elseif Remove.Memsize then
   Print(0,182,"Triangle - restore MEMSIZE",Color.info,tblack)
    if pad:T()then
    addmemsize()
    end
   end
  end
  if pge.utils.msfreesize()~=0 then
   if et[ey]=="Backup eboot" then
   Print(0,168,"All eboots will be backed up into",Color.info,tblack)
   Print(0,182,defdir.."Eboot/Backup",Color.info,tblack)
    if pad:X("r")then
     if pge.file.exists(defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname)then
     ebootmessage="backedupalready"
     else
     ebootmessage="isbackedup"
     end
    end
   end
   if et[ey]=="Restore eboot" then
    if pad:X("r")then
     if pge.file.exists(defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname)then
     ebootmessage="dorestore"
     else
     ebootmessage="notbackedup"
     end
    end
   end
   if et[ey]=="Unpack eboot" then
   Print(0,168,"All eboots will be unpacked into",Color.info,tblack)
   Print(0,182,defdir.."Eboot/Unpack",Color.info,tblack)
    if pad:X("r")then
     if pge.dir.exists(defdir.."Eboot/Unpack/"..backupfolder.."/"..ss(ebootname,1,-5))then
     ebootmessage="unpackedalready"
     else
     ebootmessage="isunpacked"
     end
    end
   end
   if et[ey]=="Reload eboot" then
    if pad:X("r")then
    getpbp(ebootpath)
    setet()
    ey=1
    en=10
    em=0
    end
   end
   if et[ey]=="Remove all backed up eboots" then
    if pad:X("r")then
    bud=sld(defdir.."Eboot/Backup")
    if tg(bud)==0 then
     ebootmessage="backupempty"
     elseif tg(bud)>0 then
     ebootmessage="removebackup"
     end
    bud=nil
    end
   end
   if et[ey]=="Remove all unpacked eboots" then
    if pad:X("r")then
    upd=sld(defdir.."Eboot/Unpack")
     if #upd==0 then
     ebootmessage="unpackempty"
     elseif #upd>0 then
     ebootmessage="removeunpack"
     end
    upd=nil
    end
   end
   if et[ey]=="View PARAM.SFO info" then
    if pad:X("r")then
    viewparam=true
    end
   end
   if et[ey]=="Save changes" and pad:X("r")then
    if enoughspace(ebootpath)then
     if pge.file.exists(defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname)then
      if yesno("Are you sure you want to proceed?")then
      saveeboot=true
      end
     else
      if yesno("This eboot has not been backed up.","Do you want to proceed?")then
      saveeboot=true
      end
     end
    end
    if saveeboot then
    saveeboot=nil
    sc(black)
    blitbg()
    Printcenter(216,"Saving changes to eboot.",yellow,tblack)
    Printcenter(230,"Please wait.",yellow,tblack)
    fs()
    changeeboot()
    exitapp=true
    end
   end
  else
   if pad:X("r")then
   message("The MS has not been detected.")
   end
  end
  if et[ey]=="Cancel" or resetapp or exitapp then
   if pad:X("r")or resetapp or exitapp then
   Eboot=nil
   Remove=nil
   Offset=nil
   Keyname=nil
   Keytable=nil
   Keyvalue=nil
   ext=nil
   Tableend=nil
   Nameend=nil
   pbpheader=nil
   paramheader=nil
   exitapp=nil
   resetapp=nil
   Dir=MAINDIR
   sn=MAINsn
   btm=MAINbtm
   pxs=MAINpxs
   MAINDIR=nil
   MAINsn=nil
   MAINbtm=nil
   MAINpxs=nil
   SEARCHDIR=nil
   SEARCHsn=nil
   SEARCHbtm=nil
   SEARCHpxs=nil
   searchoption=""
   collectgarbage("collect")
    break
   end
  end
  if ebootmessage=="unpackempty" then
   ebootmessage=""
   message("The unpack directory is already empty.")
  elseif ebootmessage=="backupempty" then
   ebootmessage=""
   message("The backup directory is already empty.")
  elseif ebootmessage=="removeunpack" then
   if yesno("Are you sure you want to remove all unpacked eboots?")then
   sc(black)
   blitbg()
   Printcenter(216,"Removing all unpacked eboots.",yellow,black)
   Printcenter(230,"Please wait.",yellow,black)
   fs()
   removeunpack()
   ebootmessage="unpackemptied"
   else
   ebootmessage=""
   end
  elseif ebootmessage=="removebackup" then
   if yesno("Are you sure you want to remove all backed up eboots?")then
   sc(black)
   blitbg()
   Printcenter(216,"Removing all backed up eboots.",yellow,black)
   Printcenter(230,"Please wait.",yellow,black)
   fs()
   removebackup()
   ebootmessage="backupemptied"
   else
   ebootmessage=""
   end
  elseif ebootmessage=="unpackemptied" then
   ebootmessage=""
   message("The unpack directory is now empty.")
  elseif ebootmessage=="isunpacked" then
   if enoughspace(ebootpath)then
   Printcenter(216,"Unpacking eboot.",yellow,black)
   Printcenter(230,"Please wait.",yellow,black)
   fs()
   collectgarbage("collect")
   unpack()
   ebootmessage="nowunpacked"
   else
   ebootmessage=""
   end
  elseif ebootmessage=="nowunpacked" then
   ebootmessage=""
   message("Unpack successful.")
  elseif ebootmessage=="unpackedalready" then
   if enoughspace(ebootpath)then
    if yesno("A directory for this eboot has been detected. Do you want to proceed?")then
    sc(black)
    blitbg()
    Printcenter(216,"Unpacking eboot.",yellow,black)
    Printcenter(230,"Please wait.",yellow,black)
    fs()
    unpack()
    ebootmessage="nowunpacked"
    else
    ebootmessage=""
    end
   else
   ebootmessage=""
   end
  elseif ebootmessage=="backupemptied" then
   ebootmessage=""
   message("The backup directory is now empty.")
  elseif ebootmessage=="isbackedup" then
   if enoughspace(ebootpath)then
   Printcenter(216,"Backing up eboot.",yellow,black)
   Printcenter(230,"Please wait.",yellow,black)
   fs()
    if not pge.dir.exists(defdir.."Eboot/Backup/"..backupfolder)then
    pge.dir.mkdir(defdir.."Eboot/Backup/"..backupfolder)
    end
   copyfile(ebootpath,defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname)
   ebootmessage="nowbackedup"
   else
   ebootmessage=""
   end
  elseif ebootmessage=="nowbackedup" then
   ebootmessage=""
   message("Back up successful.")
  elseif ebootmessage=="backedupalready" then
   if enoughspace(ebootpath)then
    if yesno("This eboot has been backed up already.","Do you want to proceed?")then
    sc(black)
    blitbg()
    Printcenter(216,"Backing up eboot.",yellow,black)
    Printcenter(230,"Please wait.",yellow,black)
    fs()
    copyfile(ebootpath,defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname,nil,true)
    ebootmessage="nowbackedup"
    else
    ebootmessage=""
    end
   else
   ebootmessage=""
   end
  elseif ebootmessage=="notbackedup" then
   ebootmessage=""
   message("This eboot has not been backed up.")
  elseif ebootmessage=="isrestored" then
   ebootmessage=""
   message("Restore successful.")
  elseif ebootmessage=="dorestore" then
   if enoughspace(ebootpath)then
    if yesno("Are you sure you want to restore the eboot?")then
    sc(black)
    blitbg()
    Printcenter(216,"Restoring eboot.",yellow,black)
    Printcenter(230,"Please wait.",yellow,black)
    fs()
    copyfile(defdir.."Eboot/Backup/"..backupfolder.."/"..ebootname,ebootpath)
    getpbp(ebootpath)
    setet()
    ey=1
    en=10
    em=0
    ebootmessage="isrestored"
    else
    ebootmessage=""
    end
   else
   ebootmessage=""
   end
  end
  if dosearch and pge.utils.msfreesize()~=0 then
  dosearch=nil
  collectgarbage("collect")
   if not SEARCHDIR then
   Dir=sort("ms0:/")
   SEARCHDIR=Dir
   sn=1
   btm=13
   pxs=10
   else
   Dir=SEARCHDIR
   sn=SEARCHsn
   btm=SEARCHbtm
   pxs=SEARCHpxs
   end
   break
  elseif dosearch and pge.utils.msfreesize()==0 then
  dosearch=nil
  message("The MS has not been detected.")
  end
  if viewparam then
  viewparam=nil
   while pge.running()do
   pge.controls.update()
   sD()
   blitbg()
   Printcenter(0,"PARAM.SFO",yellow,tblack)
   pge.gfx.drawrect(1,14,478,#Keyname*13-2,tblack)
   pge.gfx.drawrectoutline(0,13,479,#Keyname*13-1,cn(255,255,255,40))
    for a=1,#Keyname do
    Print(0,a*13,Keyname[a],Color.info)
     if Keytable[a][2]==sch(4)..sch(4)then
     Print(110,a*13,datasize(Keyvalue[a]),Color.info)
     else
     Print(110,a*13,Keyvalue[a],Color.info)
     end
    end
    if pressedany("r")then
     break
    end
   eD()
   fs()
   updatepress()
   end
  end
 eD()
 fs()
 updatepress()
 end
end
