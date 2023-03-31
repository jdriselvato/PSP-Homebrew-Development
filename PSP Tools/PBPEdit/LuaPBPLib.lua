--------------------------
-- Librairie LuaPBPLib --
--  Oslord  25/06/2010  --
--------------------------

local function convertHexaDec(word,mode)
  local offset = ""
  local result = 0
  local number = 0
  local n = 0
  if mode == nil then
    for i = 4 , 1 , -1 do
      offset = offset..string.format("%X",word:byte(i))
    end
  else
    offset = word
  end
  for i = #offset , 1 , -1 do
    if offset:sub(i,i) == "A" then
      number = 10
    elseif offset:sub(i,i) == "B" then
      number = 11
    elseif offset:sub(i,i) == "C" then
      number = 12
    elseif offset:sub(i,i) == "D" then
      number = 13
    elseif offset:sub(i,i) == "E" then
      number = 14
    elseif offset:sub(i,i) == "F" then
      number = 15
    else
      number = offset:sub(i,i)
    end
    result = result + number*16^n
    n = n + 1
  end
  return result
end

local function convertDecHexa(dec)
  local hex = ""
  local result = ""
  while dec > 15 do 
    tmp = dec-(math.floor(dec/16))*16
    hex = string.format("%X",tmp)..hex
    dec = math.floor(dec/16);
  end
  hex = string.format("%X",dec)..hex
  for i = #hex , 7 do
    hex = "0"..hex
  end
  for i = 8 , 1 , -2 do
    result = result..string.char(convertHexaDec(hex:sub(i-1,i),1))
  end
  return result
end

function getEboot(path)
  local path = path or error("La fonction 'getEboot' nessecite le chemin de l'eboot")
  local data = {name = ""}
  local offset = {}
  local eboot = io.open(path,"rb")
  if not eboot then
    return false, "Impossible d'ouvrir l'eboot"
  end

  -- Identification
  local ident = eboot:read(4)
  if ident:byte(1)..ident:byte(2)..ident:byte(3)..ident:byte(4) ~= "0806680"  then
    return nil, "L'eboot est invalide"
  end

  -- Size
  data.size = eboot:seek("end")

  -- Offsets
  eboot:seek("set",8)
  for i = 1, 8 do
    offset[i] = convertHexaDec(eboot:read(4))
  end

  -- Name
  eboot:seek("set",offset[1]+304)
  local name = eboot:read(64)
  for i = 1 , 64 do
    if name:byte(i) ~= 0 then
      data.name = data.name..string.char(name:byte(i))
    else
      break
    end
  end

  -- Icon0
  if offset[2] ~= offset[3] then
    eboot:seek("set",offset[2])
    local image = eboot:read(offset[3]-offset[2])
    data.icon0 = Image.loadFromMemory(image)
  end

  -- Pic1
  if offset[5] ~= offset[6] then
    eboot:seek("set",offset[5])
    local image = eboot:read(offset[6]-offset[5])
    data.pic1 = Image.loadFromMemory(image)
  end

  eboot:close()
  return data
end

function editEboot(path,dest,newName,newIcon0,newPic1)
  local offset = {}
  local data = {offset = {40}}
  local path = path or error("La fonction 'editEboot' nessecite le chemin de l'eboot")
  local eboot = io.open(path,"rb")
  if not eboot then
    return "Impossible d'ouvrir l'eboot"
  end

  -- Identification
  local ident = eboot:read(4)
  if ident:byte(1)..ident:byte(2)..ident:byte(3)..ident:byte(4) ~= "0806680"  then
    return "L'eboot est invalide"
  end

  -- Size
  local size = eboot:seek("end")

  -- Offsets
  eboot:seek("set",8)
  for i = 1, 8 do
    offset[i] = convertHexaDec(eboot:read(4))
  end

  -- Param
  eboot:seek("set",offset[1])
  if newName ~= "" then
    data.param = eboot:read(152)..convertDecHexa(#newName)..convertDecHexa(#newName+4)
    eboot:seek("set",eboot:seek("cur")+8)
    data.param = data.param..eboot:read(144)..newName..string.char(0,0,0,0)
    data.offset[2] = 308 + #newName + data.offset[1]
  else
    data.param = eboot:read(offset[2] - offset[1])
    data.offset[2] = eboot:seek("cur")
  end

  -- Icon0
  eboot:seek("set",offset[2])
  if newIcon0 ~= nil and newIcon0 ~= "" and newIcon0 ~= "Icon0" then
    local image = io.open(newIcon0,"rb")
    if not image then
      return "Impossible d'ouvrir l'icon0"
    end
    data.icon0 = image:read("*a")
    data.offset[3] = data.offset[2] + image:seek("end")
    image:close()
  elseif newIcon0 == "Icon0" then
    data.icon0 = eboot:read(offset[3] - offset[2])
    data.offset[3] = data.offset[2] + offset[3] - offset[2]
  elseif newIcon0 == "" then
    data.icon0 = ""
    data.offset[3] = data.offset[2]
  end

  -- Icon1_Unknow
  eboot:seek("set",offset[3])
  data.icon1_unknown = eboot:read(offset[5] - offset[3])
  data.offset[4] = data.offset[3] + offset[4] - offset[3]
  data.offset[5] = data.offset[4] + offset[5] - offset[4]

  -- Pic1
  eboot:seek("set",offset[5])
  if newPic1 ~= nil and newPic1 ~= "" and newPic1 ~= "Pic1" then
    local image = io.open(newPic1,"rb")
    if not image then
      return "Impossible d'ouvrir le pic1"
    end
    data.pic1 = image:read("*a")
    data.offset[6] = data.offset[5] + image:seek("end")
    image:close()
  elseif newPic1 == "Pic1" then
    data.pic1 = eboot:read(offset[6] - offset[5])
    data.offset[6] = data.offset[5] + offset[6] - offset[5]
  elseif newPic1 == "" then
    data.pic1 = ""
    data.offset[6] = data.offset[5]
  end

  -- Snd0_PSP_Psar
  eboot:seek("set",offset[6])
  data.snd0_psp_psar = eboot:read("*a")
  data.offset[7] = data.offset[6] + offset[7] - offset[6]
  data.offset[8] = data.offset[7] + offset[8] - offset[7]
  eboot:close()

  -- Output
  local output = io.open(dest.."eboot.pbp","wb")
  if not output then
    return "Impossible d'ouvrir le dossier de destination"
  end
  output:write(string.char(0).."PBP"..string.char(0,0,1,0))
  for i = 1 , 8 do
    output:write(convertDecHexa(data.offset[i]))
  end
  output:write(data.param)
  output:write(data.icon0)
  output:write(data.icon1_unknown)
  output:write(data.pic1)
  output:write(data.snd0_psp_psar)
  output:close()
end
