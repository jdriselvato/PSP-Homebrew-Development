# LuaPlayer Homebrew Development

## Examples

1. PSP Controls 1 - prints button pressed on the PSP.
2. PSP Controls 2 - prints button pressed on the PSP dynamically.
3. Moving Sprite - control a sprite on the screen with the d-pad.
4. Player Follower - a simple game that shows drawing two spites. One sprite is controlled by the player, the second sprite follows the player with a simple `easeInEaseOut` algo.
5. Player Collision - crude way to detect sprite collision.
6. Tile Map Engine - a very basic tile map engine importing from .csv

## Development flow

Since LuaPlayer Euphoria v7 isn't setup for destop development I recommend downloading PPSSPP and running your project through emulation. PPSSPP is cross platform and even works on Android and iOS phones.

Download: https://www.ppsspp.org/download/


# Customizing the eboot

While initially testing LuaPlayer Euphoria v7 on PPSSPP, I became annoyed at the fact that every eboot has the same icon and the PPSSPP display doesn't make it obvious which icon is the one I'm working with.

In this section I'll document how to change the eboot icon and eboot display name.

Nearly every tool to do this works on Windows. If I remember correctly, when I was super into PSP development when the life-cycle was still active, I had to use wine on my Mac.

In my case, I'm going to use PSPBPacker on my physical PSP to edit the icon. 

If you have windows, I recommend [POPstation GUI](https://wololo.net/downloads/index.php/download/8163).

-----

#### Thought log

**03/31/2023:**

I went two days writing Lua without the language installed on my Mac. `brew install lua` but then I soon learned that Lua has it's own package manager via `brew install luarocks`. For some reason Lua seems like such an old language since it was one of the first I learned as a teenager. `luarocks` makes me happy, good to know there's folks out there push Lua as a modern language.

