--LuaPlayer Euphoria IntraFont Sample
--By Walar

gray = Color.new(180, 180, 180);
white = Color.new(255, 255, 255);
darkgray = Color.new(100, 100, 100, 128);

ifont = IntraFont.load("font.pgf", 0);
ifont:setStyle(1.0, white, darkgray, IntraFont.ALIGN_CENTER);


while true do
	--Initialize the GU
	System.draw();
	screen:clear(gray);
	
	ifont:print(240, 136, "Hello World !");
	
	--Finish the GU and Sync
	System.endDraw();
	screen.flip();
	
	local pad = Controls.readPeek()
	
	if pad:select() then
		screen:save("screenshot.png");
	elseif pad:start() then
		break;
	end
		
end

ifont:unload();

System.quit(); -- Quit the application after the main loop breaks

