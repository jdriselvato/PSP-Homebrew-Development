Here you can place custom PSX icon packs.

To do so, you need to have a folder in here with the
Game ID, and inside, include the custom files.

For example:

/PSXCust
    |-- /SCUS94476
    |        |--- /ICON0.PNG
    |        |--- /ICON1.PMF
    |        |--- /PIC1.PNG
    |        |--- /Gameboot.PNG
    |-- /SLUS00150
    |        |--- /PIC1.PNG

Also, an alternative structure is supported.

/PSXCust
    |-- /ICON0
    |      |--- /SCUS94476.PNG
    |-- /ICON1
    |      |--- /SCUS94476.PMF
    |-- /PIC1
    |      |--- /SCUS94476.PMF
    |      |--- /SLUS00150.PNG
    |-- /Gameboot
    |      |--- /SCUS94476.PNG

(both can be used together, however the first
will take precedence)