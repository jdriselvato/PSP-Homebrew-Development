-- Librairie
dofile("LuaPBPLib.lua")

-- Couleur
local noir = Color.new(0,0,0)
local blanc = Color.new(255,255,255)

-- Image
local interface = Image.load("interface.png")

-- Police
font = Font.createProportional()
font:setPixelSizes(18,18)

-- Variable
local fichier = System.listDirectory()
table.remove(fichier,1)
table.remove(fichier,1)
local selecteur = 1
local debut = 1
local fin = 1
local extension = ""
local curseur = 1
local parcourir = false
local data =  {"","","",""}
local eboot = nil
local icon0 = nil
local pic1 = nil

local function ouvrir()
  System.currentDirectory(System.currentDirectory() .. "/" .. fichier[selecteur + debut - 1].name)
  fichier = System.listDirectory()
  table.remove(fichier,1)
  table.remove(fichier,1)
  selecteur = 1
  debut = 1
end

local function precedent()
  if System.currentDirectory() ~= "ms0:" then
    System.currentDirectory(System.currentDirectory() .. "/..")
    fichier = System.listDirectory()
    table.remove(fichier,1)
    table.remove(fichier,1)
    selecteur = 1
    debut = 1
  end
end

function explorer()
  screen:print(7,10,string.sub(System.currentDirectory().."/",-23),noir)

  local y = 40
  if debut + 15 < #fichier then
    fin = debut + 15
  else
    fin = #fichier
  end
  for i = debut, fin do
    local ext = string.lower(fichier[i].name:sub(#fichier[i].name-3))
    if fichier[i].directory then
      screen:print(20,y,string.sub(fichier[i].name,1,21),Color.new(255,100,0))
    elseif ext == extension then
      screen:print(20,y,string.sub(fichier[i].name,1,21),noir)
    else
      screen:print(20,y,string.sub(fichier[i].name,1,21),Color.new(100,100,150))
    end
    y = y + 15
  end

  if parcourir then
    screen:fillRect(17,23 + (selecteur * 15),#string.sub(fichier[selecteur+debut-1].name,1,21)*8+3,10,Color.new(0,0,255))
    screen:print(20,25 + (selecteur * 15),string.sub(fichier[selecteur+debut-1].name,1,21),blanc)

    if pad:up() and oldpad:up() ~= pad:up() or pad:analogY()<-60 then
      if selecteur + debut - 1 > 1 then
        if selecteur > 1 then
          selecteur = selecteur - 1
        else
          debut = debut - 1
        end
      end
    elseif pad:down() and oldpad:down() ~= pad:down() or pad:analogY()>60 then
      if selecteur + debut - 1 < #fichier then
        if selecteur < 15 then
          selecteur = selecteur + 1
        else
          debut = debut + 1
        end
      end
    end
    if pad:triangle() and oldpad:triangle() ~= pad:triangle() then
      precedent()
    elseif pad:cross() and oldpad:cross() ~= pad:cross() then
      local ext = string.lower(fichier[selecteur+debut-1].name:sub(#fichier[selecteur+debut-1].name-3))
      if fichier[selecteur+debut-1].directory then
        ouvrir()
      elseif ext == extension then
        data[curseur] = System.currentDirectory().."/"..fichier[selecteur+debut-1].name
        if extension == ".pbp" then
          eboot,erreur = getEboot(fichier[selecteur+debut-1].name)
          if eboot ~= nil then
            data[2] = eboot.name
            data[3] = eboot.icon0 == nil and "" or "Icon0"
            data[4] = eboot.pic1 == nil and "" or "Pic1"
            icon0 = nil
            pic1 = nil
          else
            System.message(erreur,0)
            data[1] = ""
          end
        end
        if curseur == 3 then
          icon0 = Image.load(data[curseur])
          if icon0:width() > 200 or icon0:height() > 200 then
            System.message("Cette image est trop grande. Taille maximale : 200*200 px",0)
            data[3] = ""
          end
        elseif curseur == 4 then
          pic1 = Image.load(data[curseur])
          if pic1:width() > 480 or pic1:height() > 272 then
            System.message("Cette image est trop grande. Taille maximale : 480*272 px",0)
            data[4] = ""
          end
        end
        parcourir = false
        oldpad = pad
      end
    elseif pad:circle() and oldpad:circle() ~= pad:circle() then
      parcourir = false
    end
  end
end

while true do
  pad = Controls.read()
  screen:clear()
  screen:blit(0,0,interface)

  for i = 1 , 4 do
    screen:print(274,i*40+30,string.sub(data[i],-22),noir)
  end
  screen:drawLine(274,curseur*40+40,446,curseur*40+40,Color.new(255,0,0))
  screen:print(274,curseur*40+30,string.sub(data[curseur],-22),Color.new(250,0,0))

  explorer()

  if not parcourir then
    if pad:cross() and oldpad:cross() ~= pad:cross() then
      if curseur == 1 then
        parcourir = true
        extension = ".pbp"
      elseif curseur == 2 then
        data[2] = System.startOSK(data[2],"Nom")
      else
        parcourir = true
        extension = ".png"
      end
    end
    if pad:up() and oldpad:up() ~= pad:up() and curseur > 1 then
      curseur = curseur - 1
    elseif pad:down() and oldpad:down() ~= pad:down() and curseur < 4 then
      curseur = curseur + 1
    end
    if pad:start() and oldpad:start() ~= pad:start() and data[1] ~= "" then
      System.message("Voulez vous generer l'eboot ?", 1)
      if System.buttonPressed(0) == 1 then
        screen:fontPrint(font,210,230,"Creation en cours...",Color.new(255,0,0))
        screen.flip()
        editEboot(data[1],"ms0:/psp/game/PBPEdit/eboot/",data[2],data[3],data[4])
      end
      System.message("L'eboot a ete genere avec succes. Il se trouve a l'adresse : ms0:/psp/game/PBPEdit/Eboot/", 0)
    end
    if pad:square() then
      if eboot ~= nil then
        screen:clear(blanc)
        screen:fontPrint(font,220,140,data[2],noir)
        if eboot.pic1 ~= nil and data[4] == "Pic1" then
          screen:blit(0,0,eboot.pic1)
        elseif data[4] ~= "Pic1" and data[4] ~= "" then
          screen:blit(0,0,pic1)
        end
        if eboot.icon0 ~= nil and data[3] == "Icon0" then
          screen:blit(20,136-eboot.icon0:height()/2,eboot.icon0)
        elseif data[3] ~= "Icon0" and data[3] ~= "" then
          screen:blit(20,136-icon0:height()/2,icon0)
        end
      end
    end
    if pad:l() then
      if curseur > 1 then
        data[curseur] = ""
      end
    end
  end

  screen.flip()
  oldpad = pad
end
