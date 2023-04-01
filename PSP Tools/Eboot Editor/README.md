# Eboot Editor

Using a modified version of LuaPBPLib this command-line editor can:

- Edit icon0
- Edit EBOOT display name

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

Outputs to ``./output`.

Note: PPSSPP needs to be rebooted to see new icon as it seems it caches icons on discovery.

## icon0

Size: 144 x 80 pixels

# Screenshot

<img width="322" alt="patched" src="https://user-images.githubusercontent.com/950825/229311749-7cf9a713-2b9d-4b40-b5ea-d0edf962a002.png">

LuaPlayer Euphoria V7 Patched with new name and icon0 on PPSSPP
