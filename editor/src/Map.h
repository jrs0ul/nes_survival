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
    unsigned char     mapName[512];
    unsigned char     collisionMapName[512];
    unsigned          attributes[64];
    Vector3D mappos;

public:

    Map()
        {
            tiles = 0;
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
    unsigned int    tileWidth(){return tilesize;}
    unsigned int    getAttribute(unsigned long x, unsigned long y);
    void            move(Vector3D dir, float d);
    unsigned char   tile(unsigned long x, unsigned long y);
    void            setTile(unsigned long x, unsigned long y, unsigned char val);
    void            setCollision(unsigned long x, unsigned long y, bool val);
    void            setAttribute(unsigned long x, unsigned long y, unsigned value);
    void            save(const char* tilePath, const char* collisionPath);
};



#endif //__MAP_H
