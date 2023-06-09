# Eboot Editor

While initially testing LuaPlayer Euphoria v7 on PPSSPP, I became annoyed at the fact that every eboot has the same icon and the PPSSPP display doesn't make it obvious which icon is the one I'm working with.

Using a modified version of LuaPBPLib this command-line editor can:

- Edit EBOOT display name
- Edit icon0

This should work on any OS (Windows, MacOS, Linux) that has [Lua](https://www.lua.org) installed.

#### Example:

```
lua index.lua EBOOT.PBP icon0.png 
```

#### Output:

```
Eboot Editor$ lua index.lua EBOOT.PBP icon0.png 
Directory path:	nil
File name:	EBOOT.PBP
icon0:	icon0.png
Current EBOOT name:	New name
Enter a new EBOOT name: Tile Map Engine 1
Changing Eboot name to: Tile Map Engine 1
Stating editBoot	EBOOT.PBP	./output/	Tile Map Engine 1	icon0.png	icon0.png
```

Outputs to `./output/`.

Note: PPSSPP needs to be rebooted to see new icon as it seems it caches icons on discovery.

## icon0

Size: 144 x 80 pixels

# Screenshot

<img width="322" alt="patched" src="https://user-images.githubusercontent.com/950825/229311749-7cf9a713-2b9d-4b40-b5ea-d0edf962a002.png">

LuaPlayer Euphoria V7 Patched with new name and icon0 on PPSSPP

# Other

If you have windows, try [POPstation GUI](https://wololo.net/downloads/index.php/download/8163) instead.
