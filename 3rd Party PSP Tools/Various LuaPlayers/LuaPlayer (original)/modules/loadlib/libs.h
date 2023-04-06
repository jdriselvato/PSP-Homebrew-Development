/*
 * PSPLINK
 * -----------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE in PSPLINK root for details.
 *
 * libs.h - Module library code for psplink
 *
 * Copyright (c) 2005 James F <tyranid@gmail.com>
 *
 * $HeadURL: svn://svn.pspdev.org/psp/trunk/psplink/psplink/libs.h $
 * $Id: libs.h 1798 2006-02-11 13:55:19Z tyranid $
 */
#ifndef __LIBS_H__
#define __LIBS_H__

int libsPrintEntries(SceUID uid);
u32 libsFindExportByName(SceUID uid, const char *library, const char *name);
u32 libsFindExportByNid(SceUID uid, const char *library, u32 nid);
void* libsFindExportAddrByName(SceUID uid, const char *library, const char *name);
void* libsFindExportAddrByNid(SceUID uid, const char *library, u32 nid);

#endif
