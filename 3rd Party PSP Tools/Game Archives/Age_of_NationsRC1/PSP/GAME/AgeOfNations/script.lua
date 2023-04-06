--[[	AoN
		Main Pilot File
		Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Latest Update: 18/08/2010
	]]

--Loads and runs Game Engine	
require './scripts/Engine'

Engine.setLocale() -- Sets Language
Engine.init() --Inits engine
Engine.setGlobalData() --set global Data

--Runs Introduction (Menu, Options, Credits and all the stuff)
Engine.runIntro() 

--Loads and start a campain
local oldkey = Controls.read()

--Main Loop
while true do
	MainMenu()
	while Engine.run(GameState) do
	local key = Controls.read()
	Mainboard.defineScreen(Mainboard)                         
	screen:clear()
	Engine.runCampaign(key,oldkey,cursor)
	swapBuffers()
	oldkey = key
	end	
end
