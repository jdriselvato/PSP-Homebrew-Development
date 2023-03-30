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
 * $Id: main.cpp 357 2006-06-03 17:54:53Z shine $
 */

#include <pspkernel.h>
#include <pspdebug.h>
#include <pspdisplay.h>
#include <pspctrl.h>
#include <pspsdk.h>
#include <psputility.h>
#include <psprtc.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "graphics.h"
#include "sound.h"
#include "luaplayer.h"

/* the boot.lua */
#include "boot.cpp"

/* Define the module info section */
PSP_MODULE_INFO(LUAPLAYER, 0, 1, 1);
PSP_MAIN_THREAD_ATTR(0);
PSP_HEAP_SIZE_KB(10024); /* 10MB */

// startup path
char path[256];

// timezone
static char tz[20];

/* Exit callback */
int exit_callback(int arg1, int arg2, void *common)
{

	// Unload modules
	unloadMikmod();
		
	sceKernelExitGame();
	return 0;
}

/* Callback thread */
int CallbackThread(SceSize args, void *argp)
{
	int cbid;

	cbid = sceKernelCreateCallback("Exit Callback", exit_callback, NULL);
	sceKernelRegisterExitCallback(cbid);

	sceKernelSleepThreadCB();

	return 0;
}

/* Sets up the callback thread and returns its thread id */
int SetupCallbacks(void)
{
	int thid = 0;

	thid = sceKernelCreateThread("update_thread", CallbackThread, 0x11, 0xFA0, 0, 0);
	if(thid >= 0)
	{
		sceKernelStartThread(thid, 0, 0);
	}

	return thid;
}

static int debugInitialized = 0;

void debugResetScreen()
{
	debugInitialized = 0;
}

int debugOutput(const char *format, ...)
{
	va_list opt;
	char buffer[2048];
	int bufsz;

	if (!debugInitialized) {
		disableGraphics();
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
		return retVal;
	}

	int fd;
	retVal = sceKernelStartModule( retVal, 0, NULL, &fd, NULL );
	if ( retVal < 0 )
	{
		return retVal;
	}

	return 0;
}

void initTimezone()
{
	// calculate the difference between UTC and local time
	u64 tick, localTick;
	sceRtcGetCurrentTick(&tick);
	sceRtcConvertUtcToLocalTime(&tick, &localTick);
	int minutesDelta;
	if (tick < localTick) {
		u64 delta = localTick - tick;
		delta /= sceRtcGetTickResolution();
		minutesDelta = delta;
		minutesDelta = -minutesDelta;
	} else {
		u64 delta = tick - localTick;
		delta /= sceRtcGetTickResolution();
		minutesDelta = delta;
	}
	minutesDelta = minutesDelta / 60;

	// calculate the timezone offset
	int tzOffsetAbs = minutesDelta < 0 ? -minutesDelta : minutesDelta;
	int hours = tzOffsetAbs / 60;
	int minutes = tzOffsetAbs - hours * 60;
	sprintf(tz, "GMT%s%02i:%02i", minutesDelta < 0 ? "-" : "+", hours, minutes);
	setenv("TZ", tz, 1);
	tzset();
}

int user_main( SceSize argc, void *argp )
{
	SetupCallbacks();
	initTimezone();

	// init modules
	initGraphics();
	initMikmod();

	// execute Lua script (according to boot sequence)
	getcwd(path, 256);
	char* bootStringWith0 = (char*) malloc(size_bootString + 1);
	memcpy(bootStringWith0, bootString, size_bootString);
	bootString[size_bootString] = 0;

	while(1) { // reload on error
		chdir(path); // set base path luaplater/
		clearScreen(0);
		flipScreen();
		clearScreen(0);

		const char * errMsg = runScript(bootStringWith0, true);
		if ( errMsg != NULL);
		{
			debugOutput("Error: %s\n", errMsg );
		}
		debugOutput("\nPress start to restart\n");

		SceCtrlData pad; int i;
		sceCtrlReadBufferPositive(&pad, 1); 
		for(i = 0; i < 40; i++) sceDisplayWaitVblankStart();
		while(!(pad.Buttons&PSP_CTRL_START)) sceCtrlReadBufferPositive(&pad, 1); 
		
		debugResetScreen();
		initGraphics();
	}

	free(bootStringWith0);
	
	// wait until user ends the program
	sceKernelSleepThread();

	return 0;
}

int main(SceSize argc, char **argv)
{
	// create user thread, tweek stack size here if necessary
	SceUID thid = sceKernelCreateThread("User Mode Thread", user_main,
	    0x11, // default priority
	    256 * 1024, // stack size (256KB is regular default)
	    PSP_THREAD_ATTR_USER, NULL);
	
	// start user thread, then wait for it to do everything else
	sceKernelStartThread(thid, 0, NULL);
	sceKernelWaitThreadEnd(thid, NULL);

	sceKernelExitGame();
	return 0;
}

