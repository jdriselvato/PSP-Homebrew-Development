
## Examples

1. PSP Controls 1 - prints button pressed on the PSP.
2. PSP Controls 2 - prints button pressed on the PSP dynamically.
3. Moving Sprite - control a sprite on the screen with the d-pad.
4. Player Follower - a simple game that shows drawing two spites. One sprite is controlled by the player, the second sprite follows the player with a simple `easeInEaseOut` algo.
5. Player Collision - Crude way to detect sprite collision.

# Development flow

Since LuaPlayer Euphoria v7 isn't setup for destop development I recommend downloading PPSSPP and running your project through emulation. PPSSPP is cross platform and even works on Android and iOS phones.

Download: https://www.ppsspp.org/download/


## Customizing the eboot

While initially testing LuaPlayer Euphoria v7 on PPSSPP, I became annoyed at the fact that every eboot has the same icon and the PPSSPP display doesn't make it obvious which icon is the one I'm working with.

In this section I'll document how to change the eboot icon and eboot display name.

Nearly every tool to do this works on Windows. If I remember correctly, when I was super into PSP development when the life-cycle was still active, I had to use wine on my Mac.

In my case, I'm going to use PSPBPacker on my physical PSP to edit the icon. 

If you have windows, I recommend [POPstation GUI](https://wololo.net/downloads/index.php/download/8163).


