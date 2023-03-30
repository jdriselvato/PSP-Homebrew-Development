/*
 * Lua Player for PSP
 * ------------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE for details.
 *
 * Copyright (c) 2005 Frank Buss <fb@frank-buss.de> (aka Shine)
 *
 * Credits:
 *   many thanks to the authors of the PSPSDK from http://forums.ps2dev.org
 *   and to the hints and discussions from #pspdev on freenode.net
 *
 * $Id: main.cpp 290 2005-12-03 08:49:10Z shine $
 */

#include <pspkernel.h>
#include <pspdebug.h>
#include <pspdisplay.h>
#include <pspctrl.h>
#include <pspsdk.h>
#include <psputility.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdarg.h>

#include "sio.h"

/* Define the module info section */
PSP_MODULE_INFO(LUABOOT, 0x1000, 1, 1);
PSP_MAIN_THREAD_ATTR(0);
PSP_MAIN_THREAD_STACK_SIZE_KB(32); 
PSP_HEAP_SIZE_KB(32);

// startup path
char path[256];

int debugOutput(const char *format, ...)
{
	va_list opt;
	char buffer[2048];
	int bufsz;

	static int debugInitialized = 0;
	if(!format) {
		debugInitialized = 0;
		return 0;
	}
	if (!debugInitialized) {
		//disableGraphics();
		pspDebugScreenInit();
		debugInitialized = 1;
	}
	va_start(opt, format);
	bufsz = vsnprintf( buffer, (size_t) sizeof(buffer), format, opt);
	return pspDebugScreenPrintData(buffer, bufsz);
}


int loadModule( char * moduleLocation )
{
	char path[256];	
	getcwd(path, 256);
	strcat(path, moduleLocation );

	int retVal = sceKernelLoadModule( path, 0, NULL );
	if (retVal < 0)
	{
		debugOutput("Error: loadModule %s %x\n", path, retVal);
		debugOutput("Loading from %s\n", path );
		return retVal;
	}

	int fd;
	retVal = sceKernelStartModule( retVal, strlen(path)+1, path, &fd, NULL );
	if ( retVal < 0 )
	{
		debugOutput("Error: strtModule %s %x\n", path, retVal);
		return retVal;
	}

	return 0;
}

int main( SceSize args, void *argp )
{
	pspSdkInstallNoDeviceCheckPatch();
	pspSdkInstallNoPlainModuleCheckPatch();
	registerSIODriver();
	

	getcwd(path, 256);
	int err = pspSdkLoadInetModules();
	if (err != 0) {
		pspDebugScreenInit();
		pspDebugScreenPrintf("pspSdkLoadInetModules failed with %x\n", err);
	        sceKernelDelayThread(5*1000000); // 5 sec to read error
	}

	int retVal = loadModule( "/loadlib.prx" );
	if (retVal < 0 )
	{
		debugOutput("Error: failed loadModule loadlib.prx\n");
		sceKernelSleepThread();
	}

	retVal = loadModule( "/luaplayer.prx" );
	if (retVal < 0)
	{
		debugOutput("Error: failed loadModule luaplayer.prx\n");
		sceKernelSleepThread();
	}

	sceKernelSleepThread();
	return 0;
}

