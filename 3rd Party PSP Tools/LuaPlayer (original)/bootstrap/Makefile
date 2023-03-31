TARGET = luaboot
OBJS = bootstrap.o sio.o 

PSP_EBOOT_TITLE = LuaPlayer 0.20
PSP_EBOOT_ICON = title-icon.png

INCDIR = 
CFLAGS = -O0 -G0 -Wall
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)
LIBS = -lpspdebug -lpsphprm_driver 
LIBDIR =
LDFLAGS = 

PSPSDK=$(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak

