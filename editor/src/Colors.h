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
#ifndef _COLORS_H__
#define _COLORS_H__

#include <cstring>

struct COLOR{

    float c[4];
    
    COLOR(float nr, float ng, float nb, float na = 1.0f){
        c[0] = nr; c[1] = ng; c[2] = nb; c[3] = na;
    }

    COLOR(const float* nc){
        memcpy(c, nc, sizeof(float)*4);
    }

    COLOR(){
        c[0] = 1.0f; c[1] = 1.0f; c[2] = 1.0f; c[3] = 1.0f;
    }

    float r() {return c[0];}
    float g() {return c[1];}
    float b() {return c[2];}
    float a() {return c[3];}
};
#endif //_COLORS_H__
