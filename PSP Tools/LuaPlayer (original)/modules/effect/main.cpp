/*
 * PSP Software Development Kit - http://www.pspdev.org
 * -----------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE in PSPSDK root for details.
 *
 * main.cpp - Image Effect PRX example with a Game Of Life implementation.
 *
 * Copyright (c) 2006 Frank Buss <fb@frank-buss.de> (aka Shine)
 */
#include <stdlib.h>
#include <pspkernel.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>

extern "C" {

#include "luamodule.h"
#include "../../src/graphics.h"

int init(lua_State *L );

}  // extern "C"

PSP_MODULE_INFO("EFFECT", 0, 1, 1);
PSP_HEAP_SIZE_KB(240);
PSP_NO_CREATE_MAIN_THREAD(); 

static int lua_lifeStep(lua_State *L)
{
	// check for correct number of arguments
	int argc = lua_gettop(L);
	if (argc != 2) return luaL_error(L, "lifeStep(currentImage, nextImage) takes two arguments.");

	// get images
	Image* current = (Image*) *((Image**)lua_touserdata(L, 1));
	if (!current) luaL_typerror(L, 1, "Image");
	Image* next = (Image*) *((Image**)lua_touserdata(L, 2));
	if (!next) luaL_typerror(L, 2, "Image");

	// the colors of the cellular automaton
	Color green = 0xff00ff00;
	Color black = 0xff000000;

	// get dimension
	int width = current->imageWidth;
	int height = current->imageHeight;

	// check dimensions
	if (width != next->imageWidth || height != next->imageHeight)
		return luaL_error(L, "current and next image must be of the same size.");
	
	// calculate next Game Of Life generation
	for (int y = 1; y < height - 2; y++) {
		for (int x = 1; x < width - 2; x++) {
			Color center = current->data[x + y * current->textureWidth];
			int result = center == green ? 1 : 0;

			// game of life rules
			int n = current->data[x + (y - 1) * current->textureWidth] == green ? 1 : 0;
			int ne = current->data[x + 1 + (y - 1) * current->textureWidth] == green ? 1 : 0;
			int e = current->data[x + 1 + y * current->textureWidth] == green ? 1 : 0;
			int se = current->data[x + 1 + (y + 1) * current->textureWidth] == green ? 1 : 0;
			int s = current->data[x + (y + 1) * current->textureWidth] == green ? 1 : 0;
			int sw = current->data[x - 1 + (y + 1) * current->textureWidth] == green ? 1 : 0;
			int w = current->data[x - 1 + y * current->textureWidth] == green ? 1 : 0;
			int nw = current->data[x - 1 + (y - 1) * current->textureWidth] == green ? 1 : 0;
			int sum = n + ne + e + se + s + sw + w + nw;
			if (sum == 3)
				result = 1;
			else if (sum != 2)
				result = 0;

			// set next state
			next->data[x + y * next->textureWidth] = result == 1 ? green : black;
		}
	}

	return 0;
}

static const luaL_reg Effect_functions[] = {
  {"lifeStep",	lua_lifeStep},
  {0,0}
};

int init(lua_State *L )
{
	luaL_openlib(L, "Effect", Effect_functions, 0);
	return 0;
}

int main(int argc, char *argv[] )
{
	return 0;
}

