/*
 * SIO driver, based on TyRaNiD's SIO driver for GDB support.
 */

#include <pspkernel.h>
#include <pspdebug.h>
#include <string.h>
#include "sio.h"

static int io_init(PspIoDrvArg *arg)
{
	return 0;
}

static int io_exit(PspIoDrvArg *arg)
{
	return 0;
}

static int io_open(PspIoDrvFileArg *arg, char *file, int mode, SceMode mask)
{
	pspKernelSetKernelPC();
	pspDebugSioInit();
	pspKernelSetKernelPC();
	return 0;
}

static int io_close(PspIoDrvFileArg *arg)
{
	return 0;
}

static int io_read(PspIoDrvFileArg *arg, char *data, int len)
{
	int ret = 0;
	int ch;

	pspKernelSetKernelPC();
	while(ret < len)
	{
		ch = pspDebugSioGetchar();
		if(ch != -1)
		{
			data[ret++] = ch & 0xFF;
		}
		else
		{
			break;
		}
	}

	return ret;
}

static int io_write(PspIoDrvFileArg *arg, const char *data, int len)
{
	int ret = 0;

	pspKernelSetKernelPC();
	while(ret < len)
	{
		pspDebugSioPutchar(data[ret++]);
	}

	return ret;
}

static int io_lseek(PspIoDrvFileArg *arg, u32 unk, long long ofs, int whence)
{
	return 0;
}

static int io_ioctl(PspIoDrvFileArg *arg, unsigned int cmd, void *indata, int inlen, void *outdata, int outlen)
{
	pspKernelSetKernelPC();
	if (cmd == SIO_IOCTL_SET_BAUD_RATE && indata && inlen == sizeof(int))
		pspDebugSioSetBaud(*((int*) indata));
	return 0;
}

static int io_remove(PspIoDrvFileArg *arg, const char *name)
{
	return 0;
}

static int io_mkdir(PspIoDrvFileArg *arg, const char *name, SceMode mode)
{
	return 0;
}

static int io_rmdir(PspIoDrvFileArg *arg, const char *name)
{
	return 0;
}

static int io_dopen(PspIoDrvFileArg *arg, const char *dir)
{
	return 0;
}

static int io_dclose(PspIoDrvFileArg *arg)
{
	return 0;
}

static int io_dread(PspIoDrvFileArg *arg, SceIoDirent *dir)
{
	return 0;
}

static int io_getstat(PspIoDrvFileArg *arg, const char *file, SceIoStat *stat)
{
	return 0;
}

static int io_chstat(PspIoDrvFileArg *arg, const char *file, SceIoStat *stat, int bits)
{
	return 0;
}

static int io_rename(PspIoDrvFileArg *arg, const char *oldname, const char *newname)
{
	return 0;
}

static int io_chdir(PspIoDrvFileArg *arg, const char *dir)
{
	return 0;
}

static int io_mount(PspIoDrvFileArg *arg)
{
	return 0;
}

static int io_umount(PspIoDrvFileArg *arg)
{
	return 0;
}

static int io_devctl(PspIoDrvFileArg *arg,  const char * devname, unsigned int cmd, void *indata, int inlen, void *outdata, int outlen)
{
	return 0;
}

static int io_unknown(PspIoDrvFileArg *arg)
{
	return 0;
}

static PspIoDrvFuncs sio_funcs = 
{
	io_init,
	io_exit,
	io_open,
	io_close,
	io_read,
	io_write,
	io_lseek,
	io_ioctl,
	io_remove,
	io_mkdir,
	io_rmdir,
	io_dopen,
	io_dclose,
	io_dread,
	io_getstat,
	io_chstat,
	io_rename,
	io_chdir,
	io_mount,
	io_umount,
	io_devctl,
	io_unknown,
};

static PspIoDrv sio_driver = 
{
	"sio", 0x10, 0x800, "SIO", &sio_funcs
};

int registerSIODriver(void)
{
	int ret;

	pspKernelSetKernelPC();
	(void) sceIoDelDrv("sio"); /* Ignore error */
	ret = sceIoAddDrv(&sio_driver);
	if(ret < 0)
	{
		return ret;
	}

	return 0;
}
