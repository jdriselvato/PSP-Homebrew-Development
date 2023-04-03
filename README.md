# LuaPlayer Homebrew Development

## Examples

Below are common game development examples I wrote to help jump start anyone interested in making PSP games:

1. PSP Controls 1 - prints button pressed on the PSP.
2. PSP Controls 2 - prints button pressed on the PSP dynamically.
3. Moving Sprite - control a sprite on the screen with the d-pad.
4. Player Follower - a simple game that shows drawing two spites. One sprite is controlled by the player, the second sprite follows the player with a simple `easeInEaseOut` algo.
5. Player Collision - crude way to detect sprite collision.
6. Tile Map Engine - a very basic tile map engine importing from `.csv`
7. Orbiting NPC - a basic node orbiting another node example

## Development flow

Since LuaPlayer Euphoria v7 isn't setup for destop development I recommend downloading PPSSPP and running your project through emulation. PPSSPP is cross platform and even works on Android and iOS phones.

Download: https://www.ppsspp.org/download/

Some of the primitive drawing functions (`screen:print`, `screen:drawLine`, `image:pixel`, etc) don't work on PPSSPP without a few graphics setting changes, here's a working setup in PPSSPP settings:

```
Graphics:
	backend = OpenGL
	Software render (slow,accurate) = on
	VSync = on
	Frame Skipping = off
	Auto frameskip = off
	Alternative speed = Unlimited
	Alternative speed 2 = off
	Spline/Bezier curves quality = High
	Buffer graphics command = Up to 2
```




# Other projects to checkout

- [The Labyrinth](https://github.com/Yonaba/the-labyrinth/tree/4f44523ee48362b537ca74e413f6a5cda7c41f6a) - A minimalistic raycasting engine technical demonstration

-----

#### Thought log


**04/02/2023**

It seems that the current version (1.14.3-28) of PPSSPP doesn't handle LuaPlayer drawing correctly. I thought that `screen:print`, `screen:drawLine`, and `image:pixel` were broken in Euphoria V7 until I ran my scripts on an actual device. I'll have to research a better emulator for PSP testing because I have some ideas that require the more primitive functions. Plus, debugging with `screen:print` is so much easier than importing the entire Font like Euphoria recommends.

UPDATE: see `Development flow` above on how I fixed this.


**03/31/2023:**

I went two days writing Lua without the language installed on my Mac. `brew install lua` but then I soon learned that Lua has it's own package manager via `brew install luarocks`. For some reason Lua seems like such an old language since it was one of the first I learned as a teenager. `luarocks` makes me happy, good to know there's folks out there push Lua as a modern language.

