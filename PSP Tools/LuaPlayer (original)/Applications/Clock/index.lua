background = Image.createEmpty(480, 272)
clockOfs = 150
clockWidth = 100
clockTextPosition = 85
clockBigMarkWidth = 7
clockSmallMarkWidth = 3
x0 = clockOfs
y0 = clockOfs - clockWidth
pi = 4*math.atan(1)
color = Color.new(0, 255, 0)
for i=0,60 do
	x1 = math.sin(pi-i/60*2*pi) * clockWidth + clockOfs
	y1 = math.cos(pi-i/60*2*pi) * clockWidth + clockOfs
	background:drawLine(x0, y0, x1, y1, color)
	xv = (x1 - clockOfs) / clockWidth
	yv = (y1 - clockOfs) / clockWidth
	if math.mod(i, 5) == 0 then
		xt = xv * clockTextPosition + clockOfs
		yt = yv * clockTextPosition + clockOfs
		value = math.ceil(i / 5)
		if value == 0 then
			value = 12
		end
		background:print(xt, yt, value, color)
		xv = xv * (clockWidth - clockBigMarkWidth) + clockOfs
		yv = yv * (clockWidth - clockBigMarkWidth) + clockOfs
		background:drawLine(x1, y1, xv, yv, color)
	else
		xv = xv * (clockWidth - clockSmallMarkWidth) + clockOfs
		yv = yv * (clockWidth - clockSmallMarkWidth) + clockOfs
		background:drawLine(x1, y1, xv, yv, color)
	end
	x0 = x1
	y0 = y1
end
background:print(4, 4, "os.date: ", color)
background:print(4, 14, "digital: ", color)

while not Controls.read():start() do
	screen:blit(0, 0, background, 0, 0, background:width(), background:height(), false)
	time = os.time()
	dateString = os.date("%c", time)
	screen:print(84, 4, dateString, color)
	dateFields = os.date("*t", time)
	hour = dateFields.hour
	if hour < 10 then
		hour = "0" .. hour
	end
	min = dateFields.min
	if min < 10 then
		min = "0" .. min
	end
	sec = dateFields.sec
	if sec < 10 then
		sec = "0" .. sec
	end
	screen:print(84, 14, hour .. ":" .. min .. ":" .. sec, color)

	hour = dateFields.hour
	if hour > 12 then
		hour = hour - 12
	end
	hour = hour + dateFields.min / 60 + dateFields.sec / 3600
	x = math.sin(pi-hour/12*2*pi) * clockWidth / 3 * 2 + clockOfs
	y = math.cos(pi-hour/12*2*pi) * clockWidth / 3 * 2 + clockOfs
	screen:drawLine(clockOfs, clockOfs, x, y, color)

	min = dateFields.min + dateFields.sec / 60
	x = math.sin(pi-min/60*2*pi) * clockWidth + clockOfs
	y = math.cos(pi-min/60*2*pi) * clockWidth + clockOfs
	screen:drawLine(clockOfs, clockOfs, x, y, color)

	x = math.sin(pi-dateFields.sec/60*2*pi) * clockWidth + clockOfs
	y = math.cos(pi-dateFields.sec/60*2*pi) * clockWidth + clockOfs
	screen:drawLine(clockOfs, clockOfs, x, y, color)

	screen.waitVblankStart()
	screen.flip()
end
