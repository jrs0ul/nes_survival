/***************************************************************************
 *   Copyright (C) 2008 by jrs0ul   *
 *   jrs0ul@gmail.com   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/
#ifndef _UTILS_H
#define _UTILS_H


#include "TextureLoader.h"





struct _POINT{
    int x; int y;
};



int     _round(double x);

void    DrawText(int x, int y,const char* text, PicsContainer& pic, int imgindex,
                float scale=1.0f,
                COLOR color=COLOR(1.0f, 1.0f, 1.0f, 1.0f));

void    DrawBlock(PicsContainer& pics, int x, int y, int width, int height,
                  COLOR c = COLOR(0.0f, 0.0f, 0.0f, 1.0f), COLOR c2 = COLOR(0,0,0,0));

bool    CirclesColide(float x1,float y1,float radius1, float x2, float y2, float radius2);

_POINT* Line(int x1, int y1, int x2, int y2, int& count, int gridw);

#endif //UTILS_H
