TARGET = effect
OBJS = main.o luaplayer.o

# Define to build this as a prx (instead of a static elf)
BUILD_PRX=1
# Define the name of our custom exports (minus the .exp extension)
PRX_EXPORTS=exports.exp

USE_NEWLIB_LIBC = 1

INCDIR = -I ..  
CFLAGS = -O2 -G0 -Wall -mno-explicit-relocs $(shell freetype-config --cflags)
CXXFLAGS = $(CFLAGS) -mno-explicit-relocs -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)
LIBS = -lc
LIBDIR =

PSPSDK=$(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak


EXTRA_CLEAN = luaplayer.S exports.o effect.elf

release: all
	cp effect.prx ../effect.lrx

luaplayer.S: ../../src/exports.exp
	$(shell psp-config --pspdev-path)/bin/psp-build-exports --build-stubs $<

