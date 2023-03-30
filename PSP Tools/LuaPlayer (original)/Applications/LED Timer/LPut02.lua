-- LPut.lua editted by Geo Massar, 2005 (aka KawaGeo)
-- Ver. 0.1 - first release

function math.round(num, dp)
  local mult = 10^(dp or 0)
  return math.floor(num  * mult + 0.5) / mult
end

function Image:drawEllipse(x1,y1, x2,y2, segments, color)
  local a = (x2-x1) / 2; local x0 = (x2+x1) / 2
  local b = (y2-y1) / 2; local y0 = (y2+y1) / 2
  local PI2 = math.pi * 2
  x1, y1 = x0, y0 + b
  for i = 1, segments do
    x2 = math.round(x0 + a * math.sin(PI2*i/segments))
    y2 = math.round(y0 + b * math.cos(PI2*i/segments))
    self:drawLine(x1,y1, x2,y2, color)
    x1,y1 = x2,y2
  end
end

function Image:magnify(mag)
  mag = mag or 2           -- 2 times in size by default
  local w = self:width()  
  local h = self:height()
  local result = Image.createEmpty(mag*w, mag*h)
  for x = 0, w-1 do
    for y = 0, h-1 do
      result:fillRect(mag*x, mag*y, mag,mag, self:pixel(x,y))
    end
  end
  return result
end

function Image:caption(x,y, text, color, fontsize)
  fontsize = fontsize or 1
  local w = string.len(text)
  local temp = Image.createEmpty(8 * w, 8)
  temp:print(0,0, text, color)
  if fontsize > 1 then 
    temp = temp:magnify(fontsize)
  end
  self:blit(x,y, temp)
end

function Image:rotate(cw)
  cw = cw or 1             -- clockwise by default
                           -- cw ~= 1 -> counter-clockwise
  local w = self:width()
  local h = self:height()
  local result = Image.createEmpty(h, w)
  for x = 0, w-1 do
    for y = 0, h-1 do
      if cw == 1 then
        result:pixel(h-y-1, x, self:pixel(x,y))
      else
        result:pixel(y, w-x-1, self:pixel(x,y))
      end
    end
  end
  return result
end


--------------------  Credits ---------------------

-- Nils       for math.round()
-- KawaGeo    for Image:drawEllipse()
-- MikeHaggar for Image:magnify() (formerly, resize)
-- KawaGeo    for Image:caption()
-- Shine      for Image:rotate()
