Lua Player
http://www.luaplayer.org/


Contributing code to the LuaPlayer project
============================
If you want to help out with writing code for the LuaPlayer project,
you're reading the right file. Lots of work needs to be done before
LP can be considered stable. There's a bunch of undocumented bugs
all over the place, for example.

Current maintainers are Frank 'Shine' Buﬂ (fb@frank-buss.de)
and Joachim 'Nevyn' Bengtsson (joachimb@gmail.com).

You're welcome to submit code patches, ideas and bug reports to
http://forums.ps2dev.org/viewforum.php?f=21


Dependencies
============================
All the dependencies are available at svn://svn.ps2dev.org/
Required to build LuaPlayer:
- A recent version of opoo's PSP toolchain
- zlib, libpng, libjpeg, freetype, liblua, liblualib, mikmodlib


Acquisition and build
============================
 % svn checkout svn://svn.ps2dev.org/pspware/LuaPlayer/

Either of:
 % make 		-- Creates the eboot
 % make kxploit 	-- Creates luaplayer and luaplayer% folders
 % make release10	-- Entire distribution folder with 1.0 binaries
 % make release15	-- ditto for 1.5

