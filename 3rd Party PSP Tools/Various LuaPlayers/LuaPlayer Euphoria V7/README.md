# LuaPlayer Euphoria V7 By Zack

If you find a bug with LuaPlayer Euphoria, Please submit to the [official forums](http://www.retroemu.com/forum/forumdisplay.php?f=148) or on the [google code page](http://code.google.com/p/luaplayereuphoria/)

Based on LuaPlayer v0.20 by Shine | [Official forums](http://www.retroemu.com/forum/forumdisplay.php?f=148)

# Documentation

### SCREEN

#### Initialize screen:

```
screen:blit(x, y, image, [alpha], [source x], [source y], [width], [height]) 
```

- Added optional alpha level variable.
- usage is optional when just using `(screen:blit(x, y, image)`, but when using sourcex/y you must set the alpha value.
- The reason it's there is so you can easilly fade images in/out.


#### Clear screne:

```
screen:clear() - clear screen
screen:slowClear() - clear screen slow
```

NOTE: If your having problems with the screen not clearing correctly and cannot fix it, use `screen:slowClear()`. It is slower than using the standard screen:clear() so only use if there is no alternative)

### IMAGE

```
Image.free(Image) - free an image.
Image.swizzle(Image) - Swizzle an Image (only after unswizzling! as images are auto swizzled by default).
Image.unSwizzle(Image) - UnSwizzle an Image.
Image.toVram(Image) - Move an image to Vram (only moves it to vram if there is enough space available).
```

### SYSTEM

#### Drawing: 

```
System.draw() -- Start the GU (MUST BE CALLED BEFORE ANY GRAPHICS BLITTING)
System.endDraw() -- End the GU (MUST BE CALLED AT THE END OF ANY GRAPHICS BLITTING)
```


#### Helpers:

```
System.setCpuSpeed(number) -- Set the Cpu speed. Options : 100, 222, 266, 333.
System.showFPS() -- Show the current FPS.
System.quit() -- Exit back to the XMB.
System.dialog(message, yes/no) - Shows the Sony message dialog. yes/no = options
System.osk(description, initalText) - Shows the Sony OSK.
```

### Controls

```
Controls.ReadPeek() -- Same as Controls.Read() except it doesn't cap the Framerate to 60FPS
```

#### Buttons:

Using `local controls = Controls.ReadPeek()`:

```
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

#### Analog stick:

```
Number controls:analogX() -- ranges from -127 to 128. 
Number controls:analogY() -- ranges from -127 to 128.  
```

#### Mutliple buttons

```
Number controls:buttons() -- returns the bitmask like sceCtrlReadBufferPositive reads it 
```



### IntraFont

```
IntraFont.load(font) -- Loads a Pgf font from a file.
IntraFont.print(font, x, y, textSize, foreGround color, backGround color, text) -- Print text to the screen using IntraFont
```

### VFPU MATH

Now linked to default lua math functions.

For a list of these see: [Math Library Tutorial](http://lua-users.org/wiki/MathLibraryTutorial)

### AUDIO

Supported formats : `MP3`, `At3`, `Ogg` & `WAV`. All formats (except `WAV`) playback using the PSP Media Engine.

#### Channels: 

`MP3`, `At3` & `Ogg` files have a maxiumum of 2 channels each (per format) to use. 

- The channels you may use range from 0 > 1 (2 channels). If you try to load or play a `MP3` in a channel over the maximum value, lua will return an error.

`WAV` files have a maxiumum of 30 channels to use. 

- The channels you may use range from 0 > 30. 
- If you try to load or play a `WAV` in a channel over the maximum value, lua will return an error.

#### MP3 Functions:

```
Mp3.load(fileName, channel) --Loads an Mp3 file.
Mp3.play(loop, channel) -- Plays an Mp3 file, loop : true/false.
Mp3.stop(channel) -- Stops a currently playing Mp3 file.
Mp3.pause(channel) -- Pauses a currently playing Mp3 file.
Mp3.unload(channel) -- Unloads/deletes a currently playing Mp3 file.
Mp3.volume(volume, channel) -- Set the volume of the currently playing Mp3 file (float) - 1.0 = max volume | 0.0 = mute.
Mp3.speed(speed, channel) - Set the playback speed of the currently playing Mp3 file. - Speed : 1.0 = normal speed | 0.0 slowest speed.
Mp3.endOfStream(speed, channel) - Returns true upon the Mp3 file reaching the end of its stream (Mp3 finishing).
```

#### At3 Functions -

```
At3.load(fileName, channel) --Loads an At3 file.
At3.play(loop, channel) -- Plays an At3 file, loop : true/false.
At3.stop(channel) -- Stops a currently playing At3 file.
At3.pause(channel) -- Pauses a currently playing At3 file.
At3.unload(channel) -- Unloads/deletes a currently playing At3 file.
At3.volume(volume, channel) -- Set the volume of the currently playing At3 file (float) - 1.0 = max volume | 0.0 = mute.
At3.speed(speed, channel) - Set the playback speed of the currently playing At3 file. - Speed : 1.0 = normal speed | 0.0 slowest speed.
At3.endOfStream(speed, channel) - Returns true upon the At3 file reaching the end of its stream (At3 finishing).
```

#### Ogg Functions -

```
Ogg.load(fileName, channel) --Loads an Ogg file.
Ogg.play(loop, channel) -- Plays an Ogg file, loop : true/false.
Ogg.stop(channel) -- Stops a currently playing Ogg file.
Ogg.pause(channel) -- Pauses a currently playing Ogg file.
Ogg.unload(channel) -- Unloads/deletes a currently playing Ogg file.
Ogg.volume(volume, channel) -- Set the volume of the currently playing Ogg file (float) - 1.0 = max volume | 0.0 = mute.
Ogg.speed(speed, channel) - Set the playback speed of the currently playing Ogg file. - Speed : 1.0 = normal speed | 0.0 slowest speed.
Ogg.endOfStream(speed, channel) - Returns true upon the Ogg file reaching the end of its stream (Ogg finishing).
```

#### WAV Functions

```
Wav.load(fileName, channel) --Loads an Wav file.
Wav.play(loop, channel) -- Plays an Wav file, loop : true/false.
Wav.stop(channel) -- Stops a currently playing Wav file.
Wav.pause(channel) -- Pauses a currently playing Wav file.
Wav.unload(channel) -- Unloads/deletes a currently playing Wav file.
Wav.volume(volume, channel) -- Set the volume of the currently playing Wav file (float) - 1.0 = max volume | 0.0 = mute.
Wav.speed(speed, channel) - Set the playback speed of the currently playing Wav file. - Speed : 1.0 = normal speed | 0.0 slowest speed.
Wav.endOfStream(speed, channel) - Returns true upon the Wav file reaching the end of its stream (Wav finishing).
```

### Help

If you need help with using these features or LuaPlayer Euphoria in general please make a post at the [official site](http://www.retroemu.com/forum/forumdisplay.php?f=148). We will be glad to help :)
