#include <stdlib.h>
#include <string.h>
#include <pspkernel.h>

#include <pspusb.h>
#include <pspusbstor.h>
#include <psppower.h>
#include <pspdebug.h>
#include <unistd.h>
#include <sys/stat.h>
#include "luaplayer.h"

#define SIO_IOCTL_SET_BAUD_RATE 1

static int usbActivated = 0;
static SceUID sio_fd = -1;
static const char* sioNotInitialized = "SIO not initialized.";

SceUID irda_fd = -1;

static int lua_getCurrentDirectory(lua_State *L)
{
	char path[256];
	getcwd(path, 256);
	lua_pushstring(L, path);
	
	return 1;
}

static int lua_setCurrentDirectory(lua_State *L)
{
	const char *path = luaL_checkstring(L, 1);
	if(!path) return luaL_error(L, "Argument error: System.currentDirectory(file) takes a filename as string as argument.");

	lua_getCurrentDirectory(L);
	chdir(path);
	
	return 1;
}

static int lua_curdir(lua_State *L) {
	int argc = lua_gettop(L);
	if(argc == 0) return lua_getCurrentDirectory(L);
	if(argc == 1) return lua_setCurrentDirectory(L);
	return luaL_error(L, "Argument error: System.currentDirectory([file]) takes zero or one argument.");
}


// Move g_dir to the stack and MEET CERTAIN DOOM! If the SceIoDirent is found on the STACK instead of among the globals, the PSP WILL CRASH IN A VERY WEIRD WAY. You have been WARNED.
SceIoDirent g_dir;

static int lua_dir(lua_State *L)
{
	int argc = lua_gettop(L);
	if (argc != 0 && argc != 1) return luaL_error(L, "Argument error: System.listDirectory([path]) takes zero or one argument.");
	

	const char *path = "";
	if (argc == 0) {
		path = "";
	} else {
		path = luaL_checkstring(L, 1);
	}
	int fd = sceIoDopen(path);

	if (fd < 0) {
		lua_pushnil(L);  /* return nil */
		return 1;
	}
	lua_newtable(L);
	int i = 1;
	while (sceIoDread(fd, &g_dir) > 0) {
		lua_pushnumber(L, i++);  /* push key for file entry */

		lua_newtable(L);
			lua_pushstring(L, "name");
			lua_pushstring(L, g_dir.d_name);
			lua_settable(L, -3);
	
			lua_pushstring(L, "size");
			lua_pushnumber(L, g_dir.d_stat.st_size);
			lua_settable(L, -3);
	
			lua_pushstring(L, "directory");
			lua_pushboolean(L, FIO_S_ISDIR(g_dir.d_stat.st_mode));
			lua_settable(L, -3);

		lua_settable(L, -3);
	}

	sceIoDclose(fd);

	return 1;  /* table is already on top */
}

static int lua_createDir(lua_State *L)
{
	const char *path = luaL_checkstring(L, 1);
	if(!path) return luaL_error(L, "Argument error: System.createDirectory(directory) takes a directory name as string as argument.");

	mkdir(path, 0777);
	
	return 0;
}

static int lua_removeDir(lua_State *L)
{
	const char *path = luaL_checkstring(L, 1);
	if(!path) return luaL_error(L, "Argument error: System.removeDirectory(directory) takes a directory name as string as argument.");

	rmdir(path);
	
	return 0;
}

static int lua_removeFile(lua_State *L)
{
	const char *path = luaL_checkstring(L, 1);
	if(!path) return luaL_error(L, "Argument error: System.removeFile(filename) takes a filename as string as argument.");

	remove(path);
	
	return 0;
}

static int lua_rename(lua_State *L)
{
	const char *oldName = luaL_checkstring(L, 1);
	const char *newName = luaL_checkstring(L, 2);
	if(!oldName || !newName)
		return luaL_error(L, "Argument error: System.rename(source, destination) takes two filenames as strings as arguments.");

	// TODO: looks like the stdio "rename" doesn't work
	sceIoRename(oldName, newName);
	
	return 0;
}

static int LoadStartModule(char *path)
{
	u32 loadResult;
	u32 startResult;
	int status;

	loadResult = sceKernelLoadModule(path, 0, NULL);
	if (loadResult & 0x80000000)
		return -1;
	else
		startResult =
		sceKernelStartModule(loadResult, 0, NULL, &status, NULL);

	if (loadResult != startResult)
		return -2;

	return 0;
}

static char modulePath[256];

static void setModulePath()
{
	getcwd( modulePath, 256 );
}

extern "C" {
	extern SceUID psploadlib( const char * name, char * init );
	extern void **findFunction( SceUID id, const char * library, const char * name );
	extern int init( lua_State *L);
}

#define LOADMODULE_ARGERROR "Argument error: System.loadModule(module, init) takes a module name and init method as string arguments."

static int lua_loadModule(lua_State *L)
{
	const char *name = luaL_checkstring(L, 1);
	const char *init = luaL_checkstring(L, 2);

	SceUID uid = psploadlib( name, NULL );
	if ( uid >= 0 ) {
		lua_CFunction f = (lua_CFunction) *(findFunction( uid, name, init )); 
		if (f != NULL)
		{
			lua_pushlightuserdata(L,(void*)uid);
			lua_pushcclosure(L,f,1);
			return 1;
		}
	}

	lua_pushnil(L);
	lua_pushstring(L, LOADMODULE_ARGERROR );
	lua_pushstring(L, (uid >= 0) ? "init" : "open");

	return 3;
}

static int lua_usbActivate(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	if (usbActivated) return 0;
	
	static int modulesLoaded = 0;
	if (!modulesLoaded) {
		//start necessary drivers 
		LoadStartModule("flash0:/kd/semawm.prx"); 
		LoadStartModule("flash0:/kd/usbstor.prx"); 
		LoadStartModule("flash0:/kd/usbstormgr.prx"); 
		LoadStartModule("flash0:/kd/usbstorms.prx"); 
		LoadStartModule("flash0:/kd/usbstorboot.prx"); 
	
		//setup USB drivers 
		int retVal = sceUsbStart(PSP_USBBUS_DRIVERNAME, 0, 0); 
		if (retVal != 0) { 
			printf("Error starting USB Bus driver (0x%08X)\n", retVal); 
			sceKernelSleepThread(); 
		}
		retVal = sceUsbStart(PSP_USBSTOR_DRIVERNAME, 0, 0); 
		if (retVal != 0) { 
			printf("Error starting USB Mass Storage driver (0x%08X)\n", retVal); 
			sceKernelSleepThread(); 
		} 
		retVal = sceUsbstorBootSetCapacity(0x800000); 
		if (retVal != 0) { 
			printf("Error setting capacity with USB Mass Storage driver (0x%08X)\n", retVal); 
			sceKernelSleepThread(); 
		} 
		retVal = 0; 
		modulesLoaded = 1;
	}
	sceUsbActivate(0x1c8);
	usbActivated = 1;
	return 0;
}

static int lua_usbDeactivate(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	if (!usbActivated) return 0;

	sceUsbDeactivate( 0 );  // what value here?
	usbActivated = 0;
	return 0;
}

// battery functions
 
static int lua_powerIsPowerOnline(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushboolean(L, scePowerIsPowerOnline());
	return 1;
}

static int lua_powerIsBatteryExist(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushboolean(L, scePowerIsBatteryExist());
	return 1;
}

static int lua_powerIsBatteryCharging(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushboolean(L, scePowerIsBatteryCharging());
	return 1;
}

static int lua_powerGetBatteryChargingStatus(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushnumber(L, scePowerGetBatteryChargingStatus());
	return 1;
}

static int lua_powerIsLowBattery(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushboolean(L, scePowerIsLowBattery());
	return 1;
}

static int lua_powerGetBatteryLifePercent(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushnumber(L, scePowerGetBatteryLifePercent());
	return 1;
}

static int lua_powerGetBatteryLifeTime(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushnumber(L, scePowerGetBatteryLifeTime());
	return 1;
}

static int lua_powerGetBatteryTemp(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushnumber(L, scePowerGetBatteryTemp());
	return 1;
}

static int lua_powerGetBatteryVolt(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	lua_pushnumber(L, scePowerGetBatteryVolt());
	return 1;
}

static int lua_powerTick(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "wrong number of arguments");
	scePowerTick(0);
	return 0;
}

static int lua_md5sum(lua_State *L)
{
	size_t size;
	const char *string = luaL_checklstring(L, 1, &size);
	if (!string) return luaL_error(L, "Argument error: System.md5sum(string) takes a string as argument.");

	u8 digest[16];
	sceKernelUtilsMd5Digest((u8*)string, size, digest);
	int i;
	char result[33];
	for (i = 0; i < 16; i++) sprintf(result + 2 * i, "%02x", digest[i]);
	lua_pushstring(L, result);
	
	return 1;
}

static int lua_sioInit(lua_State *L)
{
	if (lua_gettop(L) != 1) return luaL_error(L, "baud rate expected.");
	int baudRate = luaL_checkint(L, 1);
	if (sio_fd < 0) sio_fd = sceIoOpen("sio:", PSP_O_RDWR, 0);
	if (sio_fd < 0) return luaL_error(L, "failed create SIO handle.");
	sceIoIoctl(sio_fd, SIO_IOCTL_SET_BAUD_RATE, &baudRate, sizeof(baudRate), NULL, 0);
	
	return 0;
}

static int lua_sioWrite(lua_State *L)
{
	if (sio_fd < 0) return luaL_error(L, sioNotInitialized);
	size_t size;
	const char *string = luaL_checklstring(L, 1, &size);
	if (!string) return luaL_error(L, "Argument error: System.sioWrite(string) takes a string as argument.");
	sceIoWrite(sio_fd, string, size);
	
	return 0;
}

static int lua_sioRead(lua_State *L)
{
	if (sio_fd < 0) return luaL_error(L, sioNotInitialized);
	if (lua_gettop(L) != 0) return luaL_error(L, "no arguments expected.");
	char data[256];
	int count = sceIoRead(sio_fd, data, 256);
	if (count > 0) {
		lua_pushlstring(L, data, count);
	} else {
		lua_pushstring(L, "");
	}
	
	return 1;
}

static int lua_irdaInit(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "no arguments expected.");
	if (irda_fd < 0) irda_fd = sceIoOpen("irda0:", PSP_O_RDWR, 0);
	if (irda_fd < 0) return luaL_error(L, "failed create IRDA handle.");
	
	return 0;
}

static int lua_irdaWrite(lua_State *L)
{
	if (irda_fd < 0) return luaL_error(L, "irda not initialized");
	size_t size;
	const char *string = luaL_checklstring(L, 1, &size);
	if (!string) return luaL_error(L, "Argument error: System.sioWrite(string) takes a string as argument.");
	sceIoWrite(irda_fd, string, size);
	
	return 0;
}

static int lua_irdaRead(lua_State *L)
{
	if (irda_fd < 0) return luaL_error(L, "irda not initialized");
	if (lua_gettop(L) != 0) return luaL_error(L, "no arguments expected.");
	char data[256];
	int count = sceIoRead(irda_fd, &data, 256);
	if (count > 0) {
		lua_pushlstring(L, data, count);
	} else {
		lua_pushstring(L, "");
	}
	
	return 1;
}

static int lua_sleep(lua_State *L)
{
	if (lua_gettop(L) != 1) return luaL_error(L, "milliseconds expected.");
	int milliseconds = luaL_checkint(L, 1);
	sceKernelDelayThread(milliseconds * 1000);
	return 0;
}

static int lua_getFreeMemory(lua_State *L)
{
	if (lua_gettop(L) != 0) return luaL_error(L, "no arguments expected.");
	
	// for a realistic number, try to allocate 1 mb blocks until out of memory
	void* buf[64];
	int i = 0;
	for (i = 0; i < 64; i++) {
		buf[i] = malloc(1024 * 1024);
		if (!buf[i]) break;
	}
	int result = i;
	for (; i >= 0; i--) {
		free(buf[i]);
	}
	lua_pushnumber(L, result * 1024 * 1024);
	return 1;
}

static const luaL_reg System_functions[] = {
  {"currentDirectory",              lua_curdir},
  {"listDirectory",           	    lua_dir},
  {"createDirectory",               lua_createDir},
  {"removeDirectory",               lua_removeDir},
  {"removeFile",                    lua_removeFile},
  {"rename",                        lua_rename},
  {"usbDiskModeActivate",           lua_usbActivate},
  {"usbDiskModeDeactivate",    	    lua_usbDeactivate},
  {"powerIsPowerOnline",            lua_powerIsPowerOnline},
  {"powerIsBatteryExist",           lua_powerIsBatteryExist},
  {"powerIsBatteryCharging",        lua_powerIsBatteryCharging},
  {"powerGetBatteryChargingStatus", lua_powerGetBatteryChargingStatus},
  {"powerIsLowBattery",             lua_powerIsLowBattery},
  {"powerGetBatteryLifePercent",    lua_powerGetBatteryLifePercent},
  {"powerGetBatteryLifeTime",       lua_powerGetBatteryLifeTime},
  {"powerGetBatteryTemp",           lua_powerGetBatteryTemp},
  {"powerGetBatteryVolt",           lua_powerGetBatteryVolt},
  {"powerTick",                     lua_powerTick},
  {"md5sum",                        lua_md5sum},
  {"sioInit",                       lua_sioInit},
  {"sioRead",                       lua_sioRead},
  {"sioWrite",                      lua_sioWrite},
  {"irdaInit",                      lua_irdaInit},
  {"irdaRead",                      lua_irdaRead},
  {"irdaWrite",                     lua_irdaWrite},
  {"sleep",                         lua_sleep},
  {"getFreeMemory",                 lua_getFreeMemory},
  {0, 0}
};
void luaSystem_init(lua_State *L) {
	setModulePath();
	luaL_openlib(L, "System", System_functions, 0);
	lua_register(L, "loadlib", lua_loadModule);
}

