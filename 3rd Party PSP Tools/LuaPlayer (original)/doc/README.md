# Lua Player functions

The actual docs have gone offline years ago. Here's a copy from an [archive.org](http://web.archive.org/web/20071001121243/http://wiki.ps2dev.org/psp:lua_player:functions) but converted into markdown - jdriselvato

# Graphics

`Font Font.load(filename)`

Loads a true type font.

`Font Font.createMonoSpaced()`

Creates an instance of the built-in mono-spaced font.

`Font Font.createProportional()`

Creates an instance of the built-in proportional font.

`Font Font:setCharSize(number width, number height, number dpiX, number dpiY)`

Changes the size of the current font to the specified point size height and width (if width is 0, it will be calculated proportional to the height for every character). `dpiX` and `dpiY` is the resolution of the display (see the Freetype documentation for details).

`Font Font:setPixelSizes(number width, number height)`

Changes the size of the current font to the specified pixel size height and width (if width is 0, it will be calculated proportional to the height for every character). (see the Freetype documentation for details).

`width, height Font:getTextSize(string)`

Returns the width and height, which will be used, if the specified text is drawn with this font and the current font size.

`Image Image.createEmpty(width, height)`

Creates an empty image, initially cleared. Max width and height is 512.

`Image Image.load( filename )`

Loads an image. Currently JPEG and PNG files are supported.

`Image Image.loadFromMemory( data )`

Loads an image from memory (data is a Lua string). Currently JPEG and PNG files are supported. Sample:

```
jpegFile = io.open("test.jpg", "rb")
data = jpegFile:read("*a")
jpegFile:close()
image = Image.loadFromMemory(data
```

`nil image:blit(x, y, Image source, [sourcex, sourcey, width, height], [alpha = true])`

Paints the image, which is specified as “source” to the image on which this function is called on (or to the double buffered screen, when using the `screen:blit(...)` variable, which is a special image). `sourcex` and `sourcey` is the position in the source image, from where a rectangle of the size width/height is copied.

`nil image:clear([color = transparent-black])`

Sets all pixels of an image to the specified color.

`nil image:fillRect(x, y, width, height, [color = transparent-black])`

Draws a filled rectangle.

`nil image:drawLine(x0, y0, x1, y1, [color = black])`

Draws a line. TODO: Clipping needs to be enhanced.

`Color image:pixel(x, y) --get `
 
Gets the color of a pixel. See for example this code to get the color of an pixel and assert the value of all color components:

```
image = Image.createEmpty(1, 1)
color = image:pixel(0, 0)
colors = color:colors()
assert(colors.r == 0)
assert(colors.g == 0)
assert(colors.b == 0)
assert(colors.a == 0)
```

`nil image:pixel(x, y, Color) --set` 
 
Sets the color of a pixel.

`nil image:print(x, y, text, [color = black])`

Prints some text with a predefined fixed width font with 8×8 pixels per character.

`nil image:fontPrint(font, x, y, text, [color = black])`

Prints some text with the specified true type font.

`Number image:width()`

Returns the width of an image.

`Number image:height()`

Returns the height of an image.

`nil Image:save( filename )`

Saves an image to memory stick. Currently JPEG and PNG files are supported.

# global Image screen

The special double buffered screen object, which has all methods of an image and some more, see below.

`nil screen.flip() -- note the small s; this is a function of the screen 
 ` 
Flips the offscreen and onscreen screen.

`nil screen.waitVblankStart([count])`

Waits until vertical retrace starts.

`Color Color.new(r, g, b, [a=255])`

Creates a new color object with the specified RGBA values.

`table[r,g,b,a] color:colors()`

Returns the RGBA values of a color object.

`Bool (Color a == Color b)`

Color objects are equal, iff all RGBA components are equal.

# 3D GU mapping

Note: The 3D API might change in future.

`Gu.start3d()` saves the current GE state for the normal 2D operations. Call this function first and then draw your scene. You can use the following functions:

```
Gu.clearColor, Gu.clearDepth, Gu.clear, Gum.matrixMode, Gum.loadIdentity, Gum.perspective, Gum.translate, Gum.rotateXYZ, Gu.texImage, Gu.texFunc, Gu.texEnvColor, Gu.texFilter, Gu.texScale, Gu.texOffset, Gu.ambientColor, Gu.enable, Gu.disable, Gu.blendFunc, Gu.light, Gu.lightAtt, Gu.lightColor, Gu.lightMode, Gu.lightSpot and Gum.drawArray. 
```

See the PSPSDK for documenation about the parameters, for example the pspgu.h. If there is a ScePspFVector3, write 3 numbers instead one parameter (this will be changed in a later version). Whereever a color is expected, use a Color object. For textures use an Image object.

`Gum.drawArray` is something special: It has just 3 parameters: “prim”, “vtype” and a table. With “prim” you specify which primitive should be used, for example Gu.TRIANGLES. “vtype” specifies the vertex format and the transformation operation. For example “Gu.COLOR_8888|Gu.VERTEX_32BITF|Gu.TRANSFORM_3D” means, that your vertices has a color component and a 3 vertex coordinate components and is transformed before passed to the rasterizer. The table is then a list of vertex entries, where each vertex entry has the form (color, x, y, z). If you have specified G`U_TEXTURE_32BITF`, too, then one entry looks like this: (textureU, textureV, color, x, y, z). The order of the entries is defined in pspgu.h: textureU, textureV, color, normalX, normalY, normalZ, vertexX, vertexY, vertexZ. Indices, weights and multiple vertices per entry (which you’ll need for the morphing feature) currently are not supported.

After drawing anything, call `Gu.end3d()`, which flushs the display buffer and draws all pending 3D graphics and restores the 2D GE state. Don’t forget to call a `screen:clear()` before fullscreen 2D operations, because otherwise the z-buffer is not cleared and the blitting functions may not work correctly. If you need to blit 2D images in 3D mode, use textures and triangles.

See the 3D Cube example in the Applications folder of the distribution of Lua Player to see how to use the 3D functions and take a look at the GU example in the PSPSDK how to use all the other functions. Most of the time you can copy and paste the examples and just remove all those C fussinesses like “.0f”, semicolon, malloc etc. :-)

# Controls

```
Controls Controls.read()
Bool controls:select()
Bool controls:start()
Bool controls:up()
Bool controls:right()
Bool controls:down()
Bool controls:left()
Bool controls:l()
Bool controls:r()
Bool controls:triangle()
Bool controls:circle()
Bool controls:cross()
Bool controls:square()
Bool controls:home()
Bool controls:hold()
Bool controls:note()
```

`Number controls:analogX() -- ranges from -127 to 128. `
 
Returns the current analog stick position in x direction.

`Number controls:analogY() -- same `
 
Returns the current analog stick position in y direction.

`Bool (Controls a == Controls b) -- note! The analog stick is NOT considered when comparing because of analog fluctuations.` 
 
Compares two pad states.

`Number controls:buttons() -- returns the bitmask like sceCtrlReadBufferPositive reads it `
 
Constants for binary operations on `buttons()` result (for example “`Controls.read():buttons()` & `Controls.startMask > 0`” is the same as “`Controls.read():start()`”)

```
Number Controls.selectMask
Number Controls.startMask
Number Controls.upMask
Number Controls.rightMask
Number Controls.downMask
Number Controls.leftMask
Number Controls.ltriggerMask
Number Controls.rtriggerMask
Number Controls.triangleMask
Number Controls.circleMask
Number Controls.crossMask
Number Controls.squareMask
Number Controls.homeMask
Number Controls.holdMask
Number Controls.noteMask
```

# Millisecond Timer

`Timer Timer.new([startTime])`

Creates a new Timer object, sets to 0 or startTime in milliseconds, if specified BUT don’t start ticking as yet.

`Number Timer:start()`

Starts to tick the timer (incrementing by one every millisecond), or resumes to tick after being stopped. Returns the current `time() `value. If the timer is running, it is the same as `time()`.

`Number Timer:time()`

Returns in milliseconds since the timer started/resumed.

`Number Timer:stop()`

Stops the timer. Returns the current `time()`. Subsequent `time()` calls returns the value when stopped. If the timer is stopped, this call is the same as `time()`.

`Number Timer:reset([startTime])`

Resets the timer to 0 by default or startTime in milliseconds and holds the timer. Returns the time before resetted to the new value.

# System

`String System.currentDirectory() -- get `
 
Gets the current working directory.

`String System.currentDirectory( path ) -- set, returns old path. `
 
Sets the current working directory.

`table System.listDirectory( [path] )`

Lists the contents of the current working directory or the specified path. The result is a table of tables, where each table-entry has the string entry “name”, the number entry “size” and the boolean entry “directory”, which is set to true, when the current entry is a directory. See for example this code to print all files in the current working directory:

```
files = System.listDirectory()
			
for index, file in files do
	print(file.name)
end
nil System.createDirectory(path)
```

Creates a new directory. The path is relative to the current directory, if not absolute.

`nil System.removeDirectory(path)`

Deletes a directory. The path is relative to the current directory, if not absolute.

`nil System.rename(oldName, newName)`

Renames files and directories. The path is relative to the current directory, if not absolute.

`nil System.removeFile(path)`

Deletes a file. The path is relative to the current directory, if not absolute.

`nil System.usbDiskModeActivate()`

Activates the USB mode. Attention: When writing from USB to the memory stick, you must not write from within your Lua script to the memory stick, until you disable USB, otherwise the filesystem of your memory stick gets corrupted and you have to reformat your memmory stick.

`nil System.usbDiskModeDeactivate()`

Deactivates the USB mode.

# Battery functions:

```
Bool System.powerIsPowerOnline()
Bool System.powerIsBatteryExist()
Bool System.powerIsBatteryCharging()
Number System.powerGetBatteryChargingStatus()
Bool System.powerIsLowBattery()
Number System.powerGetBatteryLifePercent()
Number System.powerGetBatteryLifeTime()
Number System.powerGetBatteryTemp()
Number System.powerGetBatteryVolt()
Number System.powerTick()
```

When called, it resets the internal power off counter, which prevents auto power off.

`String System.md5sum(String)`

Calculates the md5sum of a string. For example print(System.md5sum(io.input(”EBOOT.PBP”):read(”*a”))) prints the same digest as “md5sum EBOOT.PBP” on Unix.

# Serial input/output functions:

`nil System.sioInit(baudrate)`

Opens the SIO device and sets the baud rate. This needs some seconds to power up the UART.

`System.sioWrite(string)`

Writes the string to the SIO

`string System.sioRead()`

Reads all available data from the SIO. Returns an empty string, if no data was received.

`System.sleep(number)`

Pauses program execution for the specified time in milliseconds. It doesn’t affect any timer object.

# IrDA functions:

`nil System.irdaInit()`

Opens the IrDA device. Call this to start the IrDA module.

`System.irdaWrite(string)`

Writes the string to the IrDA port.

`string System.irdaRead()`

Reads all available data from the IrDA port. Returns an empty string, if no data was received.

`number System.getFreeMemory()`

Gets the available free memory. You can use it like this:

`print("about " .. System.getFreeMemory() / 1024 / 1024 .. " megabytes free memory available")`

# Sound and music

`nil Music.playFile( string file, bool loop )`

Plays a music in one of the following formats: UNI, IT, XM, S3M, MOD, MTM, STM, DSM, MED, FAR, ULT or 669.

```
nil Music.pause()
nil Music.resume()
nil Music.stop()
bool Music.playing()
Number Music.volume( [number {0-128}] )
nil SoundSystem.SFXVolume( number {0-128} )
nil SoundSystem.reverb( number {0-15} )
nil SoundSystem.panoramicSeparation( number {0-128} )
Sound Sound.load(filename, [bool loop])
Voice sound:play()
nil voice:stop()
nil voice:resume(Sound) -- DISABLED due to bug. 
 
nil voice:volume( number [0-255] )
nil voice:pan( number [0-255] )
nil voice:frequency( number [1-80000] )
bool voice:playing()
```

# WLAN

`Wlan.init()`

Must be called once at program start to initialize the WLAN module.

`nil Wlan.term()`

Unloads the WLAN module.

`array Wlan.getConnectionConfigs()`

Gets the available WiFi connection configurations.

`Wlan.useConnectionConfig(number)`

Selects the connection configuration. The number is the index in the array that is returned by Wlan.getConnectionConfigs (e.g. use 1 for the first configuration).

`string Wlan.getIPAddress()`

Gets the IP address of the PSP.

`Socket Socket.connect(host, port)`

Creates a new TCP/IP Socket object and starts the connection process to the specified host and port. All sockets are non-blocking.

`bool Socket:isConnected()`

Returns true, when the connection is established. Now recv and send can be called on this socket object.

`Socket Socket:createServerSocket(port)`

Creates a server socket, which listens on the specified port for incoming connections.

`Socket Socket:accept()`

Can be called for server sockets and returns a new incoming connection socket or nil, if no incoming connection is waiting.

`string Socket:recv()`

Reads and returns all available data from the socket or returns an empty string, if no data is available.

`number Socket:send(string)`

Sends a string. The result is the number of bytes which was sent (which can be less than the length of the string) or less than 0, if an error occured.

`nil Socket:close()`

Closes a socket.

# Netlib 2.0

`Socket Socket.udpConnect(host,port)`

Creates a new UDP Socket object and starts the connection process to the specified host and port. All sockets are non-blocking.

`number udpSocket:udpSend(string)`

Sends a string through UDP. The result is the number of bytes which was sent (which can be less than the length of the string) or less than 0, if an error occured.

`nil udpSocket:close()`

Closes an UDP socket

`String udpSocket:recv()`

Reads and returns all available data from the socket or returns an empty string, if no data is available.

`nil netconnect()`

Connects to the standard netlib UDP server for netlib 2.0 unless modified

`nil netclose()`

Closes the connection to any UDP socket

`nil netsend(id, data, attribute)`

Send the specified data to the ID file on the server using the following attribue (w or a for write or append) using UDP.

`nil netget(id)`

Gets the contents of the ID file on the server using UDP.

`nil netreg(id)`

Tells the server to resend the info of the ID whenever changed

`nil netunreg(id)`

Tells the server to stop sending info to the client, even if it is changed.

`nil netrecv()`

Recieves data from the server (normally the netlib one) and sorts the data accordingly.

`nil netvalue(id)`

Returns the value of the given ID

`nil netmail(to,from,subject,message)`

Sends an email to “to” from “from” with the subject of “subject” and the message of “message”

`nil netcall(contact, destination)`

Sets up a call between the contact and destination

`nil netsms(to,message,from)`

Sends a text message to “to” from “from” with the message of “message”. Alternativly, for certain phones, you can send an email to their phone number at a special website. For Verizon, it is @vtext.com

# Notes

It’s possible to tell mikmod to loop only a part of a sample, or loop backwards, or loop back and forth. Tell nevyn if these attributes are needed.
It’s a good idea to ignore low values `(perhaps -5<x, y<+5)` for the analog stick, as its dead zone is larger than a single integer step.
`Socket.connect()` actually returns two values according to the samples, the first is Socket as above, there is also an error number returned (elaborate on this?)
An example of this would be as follows:

```
socket, error = Socket.connect("www.server.com", 80)
```

You could then test the “error” variable to see what the error code is, if any.