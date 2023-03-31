/*
 * PSP Software Development Kit - http://www.pspdev.org
 * -----------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE in PSPSDK root for details.
 *
 * main.c - Kernel mode loadlib PRX.
 *
 * Copyright (c) 2005 David Ryan <oobles@hotmail.com>
 *
 * $Id: main.c 1531 2005-12-07 18:27:12Z tyranid $
 */
#include <stdlib.h>
#include <pspkernel.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include "luamodule.h"
#include "libs.h"

PSP_MODULE_INFO("LOADLIB", 0x1000, 1, 1);
PSP_HEAP_SIZE_KB(1);
PSP_NO_CREATE_MAIN_THREAD(); 

static char modulePath[256];

static void setModulePath()
{
        getcwd( modulePath, 256 );
}

void** findFunction( SceUID id, const char *library, const char * name )
{
	return libsFindExportAddrByName( id, library, name );
}


SceUID psploadlib( char * name, char * init )
{
        char path[256];
        u32 loadResult;
        u32 startResult;
        int status;


        if (!name) return -1;

	// check if the module is already loaded.
	SceModule *pMod;
	pMod = sceKernelFindModuleByName( name );
	if (pMod != NULL ) {
		loadResult = pMod->modid;
		return loadResult;
	}

        strcpy( path, modulePath );
        strcat( path, "/" );
        strcat( path, name );
        strcat( path, ".lrx" );

        loadResult = sceKernelLoadModule(path,0, NULL);
        if (loadResult & 0x80000000)
        {
                return loadResult;
        }

        startResult = sceKernelStartModule( loadResult, strlen(path)+1,(void*) path, &status, NULL );
        if ( loadResult != startResult )
        {
                return -1;
        }

        return loadResult;
}


int main(int argc, char *argv[] )
{
	setModulePath();
	return 0;
}

