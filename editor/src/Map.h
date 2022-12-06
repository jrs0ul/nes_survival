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
#ifndef __MAP_H
#define __MAP_H

#include "Vectors.h"
#include "TextureLoader.h"
#ifdef WIN32
    #ifdef _MSC_VER
        #include <SDL.h>
    #else
        #include <SDL/SDL.h>
    #endif
#else
    #include <SDL/SDL.h>
#endif

//#include <GL/glext.h>



class Map{
    unsigned        ** tiles;
    bool            ** colision;
    unsigned long     _width;
    unsigned long     _height;
    unsigned int      tilesize;

    bool              tilesetInfo[512];
    Vector3D mappos;

public:

    Map()
        {   tiles = 0;  
            colision = 0; 
            tilesize=32;

        }
    unsigned long   width(){return _width;}
    unsigned long   height(){return _height;}
    bool            load(const char* tilesPath, const char* collisionPath);
    void            draw(PicsContainer &pics,
                         int layer, int screenh,
                         int screenw, 
                         COLOR c = COLOR(),
                         bool donthide = true);
    void            destroy();
    bool            colide(unsigned long x,unsigned long y);
    Vector3D        getMapPos(){return mappos;}
    void            move(Vector3D dir, float d);
    unsigned char   tile(unsigned long x, unsigned long y);
    void            setTile(unsigned long x, unsigned long y, unsigned char val);
    void            setCollision(unsigned long x, unsigned long y, bool val);
    void            save(const char* tilePath, const char* collisionPath);
};



#endif //__MAP_H
