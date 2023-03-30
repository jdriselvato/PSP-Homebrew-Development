--LuaPlayer Euphoria IntraFont Sample
--By Walar

red = 			Color.new(255,   0,   0);
green =			Color.new(  0, 255,   0);
blue =			Color.new(  0,   0, 255);
white = 		Color.new(255, 255, 255);
litegray = 		Color.new(200, 200, 200);
gray = 			Color.new(150, 150, 150);
darkgray = 		Color.new(100, 100, 100);
black = 		Color.new(  0,   0,   0);
transparent = 	Color.new(255, 255, 255, 128);
nil_color = 	Color.new(  0,   0,   0,   0);

screen:print(0, 262, "loading ...", white)
screen.flip();


-- latin fonts (large/small, with/without serif, regular/italic/bold/italic&bold)
ltn = {};
for i=1, 16 do
	-- this is where the actual loading happens 
	ltn[i] = IntraFont.load("flash0:/font/ltn"..(i-1)..".pgf", 0); 
	ltn[i]:setStyle(1.0, white, darkgray, 0);
end


x_scroll1 = 80; x_scroll2 = 225; x_scroll3 = 370;  x_scroll4 = 385;

while true do
	--Initialize the GU
	System.draw();
	screen:clear(gray);

	
	x = 0;
	y = 20;
	ltn[ 5]:setStyle(1.0, black, white, IntraFont.ALIGN_CENTER);
	ltn[ 5]:print(240, y, "IntraFont");
	ltn[ 5]:setStyle(1.0, white, darkgray, 0);


	y = y + 21;
	ltn[ 9]:print( 10, y, "Latin Sans-Serif:");
	ltn[ 1]:print(180, y, "regular,");
	ltn[ 3]:print(270, y, "italic,");
	ltn[ 5]:print(330, y, "bold,");
	ltn[ 7]:print(390, y, "both");


	y = y + 17;
	ltn[ 9]:print( 10, y, "Latin Sans-Serif small:");
	ltn[ 9]:print(180, y, "regular,");
	ltn[11]:print(270, y, "italic,");
	ltn[13]:print(330, y, "bold,");
	ltn[15]:print(390, y, "both");


	y = y + 17;
	ltn[ 9]:print( 10, y, "Latin with Serif:");
	ltn[ 2]:print(180, y, "regular,");
	ltn[ 4]:print(270, y, "italic,");
	ltn[ 6]:print(330, y, "bold,");
	ltn[ 8]:print(390, y, "both");


	y = y + 17;
	ltn[ 9]:print( 10, y, "Latin with Serif small:");
	ltn[10]:print(180, y, "regular,");
	ltn[12]:print(270, y, "italic,");
	ltn[14]:print(330, y, "bold,");
	ltn[16]:print(390, y, "both");
	
	
	y = y + 17 + 15;
	ltn[ 9]:print( 10, y, "Colors: ");
	ltn[ 9]:setStyle(1.0, red, blue, 0);
x = ltn[ 9]:print(80, y, "colorful, ");	
	ltn[ 9]:setStyle(1.0, white, nil_color, 0);
x = ltn[ 9]:print(x, y, "no shadow, ");
	ltn[ 9]:setStyle(1.0, nil_color, darkgray, 0);
x = ltn[ 9]:print(x, y, "no text, ");
	ltn[ 9]:setStyle(1.0, transparent, darkgray, 0);
x = ltn[ 9]:print(x, y, "transparent, ");		
	ltn[ 9]:setStyle(1.0, gray, white, 0);
x = ltn[ 9]:print(x, y, "glowing, ");
	ltn[ 9]:setStyle(1.0, white, darkgray, 0);
	
	
	y = y + 17 + 15;
	ltn[ 9]:print(10, y, "Spacing: ");
	ltn[ 9]:setStyle(1.0, white, darkgray, IntraFont.WIDTH_FIX);
x = ltn[ 9]:print(80, y, "fixed (default), ");
	ltn[ 9]:setStyle(1.0, white, darkgray, IntraFont.WIDTH_FIX+12);
x = ltn[ 9]:print(x, y, "fixed (12), ");		
	ltn[ 9]:setStyle(1.0, white, darkgray, 0);
x = ltn[ 9]:print(x, y, "variable width");


	y = y + 22 + 15;
	ltn[ 9]:print(10, y, "Scaling: ");
	ltn[ 1]:setStyle(0.5, white, darkgray, 0);
x = ltn[ 1]:print(80, y, "tiny, ");
	ltn[ 1]:setStyle(0.75, white, darkgray, 0);
x = ltn[ 1]:print(x, y, "small, ");
	ltn[ 1]:setStyle(1.0, white, darkgray, 0);
x = ltn[ 1]:print(x, y, "regular, ");
	ltn[ 1]:setStyle(1.25, white, darkgray, 0);
x = ltn[ 1]:print(x, y, "large, ");
	ltn[ 1]:setStyle(1.5, white, darkgray, 0);
x = ltn[ 1]:print(x, y, "huge"); 
	ltn[ 1]:setStyle(1.0, white, darkgray, 0);
	
	
	y = y + 17 + 15;
	ltn[ 9]:print(10, y, "Align: ");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.ALIGN_LEFT);
	ltn[ 9]:printColumn(80, y,  90, "left aligned w. linebreaks  ");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.ALIGN_CENTER);
	ltn[ 9]:printColumn(225, y, 110, "center aligned w. linebreaks");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.ALIGN_RIGHT);
	ltn[ 9]:printColumn(370, y,  90, "right aligned w. linebreaks ");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.ALIGN_FULL);
	ltn[ 9]:printColumn(380, y,  90, "full justified w. linebreaks");
	ltn[ 9]:setStyle(1.0,white,darkgray,0);
	

	y = y + 28 + 15;
	ltn[ 9]:print(10, y, "Scrolling: ");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.SCROLL_LEFT);
x_scroll1 = ltn[ 9]:printColumn(x_scroll1, y, 80, "This text is scrolled to the left.");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.SCROLL_SEESAW);
x_scroll2 = ltn[ 9]:printColumn(x_scroll2, y, 90, "Back & forth like a seesaw.");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.SCROLL_RIGHT);
x_scroll3 = ltn[ 9]:printColumn(x_scroll3, y, 80, "Scrolling to the right...");
	ltn[ 9]:setStyle(1.0,white,darkgray,IntraFont.SCROLL_THROUGH);
x_scroll4 = ltn[ 9]:printColumn(x_scroll4, y, 80, "This text is scrolled through.");
	ltn[ 9]:setStyle(1.0,white,darkgray,0);

	

	--Finish the GU and Sync
	System.endDraw();
	screen.waitVblankStart();
	screen.flip();
	
	local pad = Controls.readPeek()
	
	if pad:select() then
		screen:save("screenshot.png");
	elseif pad:start() then
		break;
	end
		
end

System.quit(); -- Quit the application after the main loop breaks

