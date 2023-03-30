Lua Player
http://www.luaplayer.org/

Writing Lua software for PSP
============================
Lua is an interpreted language. This means that all applications are distributed in source form, which in turn means that you can look at other people's code. Just go to the Applications folder, and then look at the index.lua inside the applications. There's also documentation inside the Documentation folder, and a 'Samples' folder.

To learn the Lua language, read the Lua book over at
http://www.lua.org/pil/
and use the resources at the Lua Wiki:
http://lua-users.org/wiki/

Feel free to drop by at the LuaPlayer forums at
http://forums.ps2dev.org/viewforum.php?f=21
This forum is for LuaPlayer- and Lua on PSP-specific questions and discussions,  /not/ general Lua questions.

Function reference
============================
See doc/ for all functions and libraries that are specific to LuaPlayer.

Making a Lowser-compatible application
============================
Making your app play nicely with Lowser is very simple.
1. The main script file should be called "index.lua". Place it, with all its resources in a folder with the application's name (spaces and everything is allowed; make the name nice: "Foobar's Magical Quest", not "foobar_game")
2. Instruct your downloaders to install your game in memorystick:/PSP/GAME/luaplayer/Applications/ . 
3. Make your game *exitable*, please. Just make sure that the end of the file is reachable. (Your main loop could look something like this:
	while not Controls.read():start() do
		[ your app's code ]
	end
)

Making your Lua application stand-alone
============================
If you don't want your application to rely on an already-installed LuaPlayer on your end user's PSP, you might want to create a stand-alone version of LuaPlayer bundling only your LuaPlayer application. This standalone version will not include the file browser/application launcher `Lowser`. It does, however, require that you are familiar with the unix build system, have the latest PSP toolchain installed, and the dependencies listed in "Readme (LuaPlayer Core developers).txt". Put your lua app files (either a Lowser-compatible folder or package, or just loose files with a main script.lua) in standalone/app folder. Modify the Makefile.psp-standalone makefile to match your app name, change title-icon.png, and run
	$ make -f Makefile.psp-standalone release10 -- for firmware 1.0
or
	$ make -f Makefile.psp-standalone release15 -- for firmware 1.5
from the luaplayer directory.


The LuaPlayer startup sequence
============================
When LuaPlayer starts up, it will look for a script to load in the following locations, and in the following order:
./luaplayer/script.lua
./luaplayer/[Application bundle or package]/index.lua
./luaplayer/[Application bundle or package]/script.lua
./luaplayer/System/system.lua


