/*
 * PSP Software Development Kit - http://www.pspdev.org
 * -----------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE in PSPSDK root for details.
 *
 * main.c - Simple PRX example.
 *
 * Copyright (c) 2005 James Forshaw <tyranid@gmail.com>
 *
 * $Id: main.c 1531 2005-12-07 18:27:12Z tyranid $
 */
#include <stdlib.h>
#include <pspkernel.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>

extern "C" {
#include "luamodule.h"
}

#include "sound.h"

PSP_MODULE_INFO("SOUND", 0, 1, 1);
PSP_HEAP_SIZE_KB(240);
PSP_NO_CREATE_MAIN_THREAD(); 


int init( lua_State * L )
{
	luaSound_init( L );
}

int main(int argc, char *argv[] )
{
	printf( "sound.lrx loaded\n" );


	return 0;
}

