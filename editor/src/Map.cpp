#include <cstdio>
#include <cassert>


#include "Matrix.h"
#include "Map.h"

//----------------------------------------------
bool Map::load(const char* tilesPath){
    FILE * file;
    file = fopen(tilesPath,"rt");
    
    if (!file)
    {
        return false;
    }


    _width = 32;
    _height = 30;

    tiles = new unsigned*[_height];

    for (unsigned i = 0; i<_height; i++)
    {
        tiles[i] = new unsigned[_width];
    }

    if (!fscanf(file,"%s\n", mapName))
    {
        fclose(file);
        return false;
    }
    printf("%s\n", mapName);

    unsigned char dname[255];

    for (unsigned i = 0; i<_height; i++)
    {
        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return(false);
        }

        int num;

        for (unsigned a = 0; a < _width / 2; a++)
        {
            if (!fscanf(file,"$%X,", &num))
            {
                fclose(file);
                return false;
            }

            tiles[i][a] = num;
            printf("%X[%u] ", num, tiles[i][a]);
        }

        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return(false);
        }

        //printf("%s\n", dname);

        for (unsigned a = _width / 2; a < _width; a++)
        {
            if (!fscanf(file,"$%X,", &num))
            {
                fclose(file);
                return false;
            }
            printf("%X ", num);

            tiles[i][a] = num;
        }

        printf("\n");


    }

    int attributeCounter = 0;

    for (unsigned i = 0; i < 2; ++i)
    {

        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return(false);
        }

        int num;

        for (unsigned a = 0; a < _width / 2; a++)
        {
            if (!fscanf(file,"$%X,", &num))
            {
                fclose(file);
                return false;
            }

            attributes[attributeCounter] = num;
            ++attributeCounter;
        }

        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return(false);
        }


        for (unsigned a = _width / 2; a < _width; a++)
        {
            if (!fscanf(file,"$%X,", &num))
            {
                fclose(file);
                return false;
            }

            attributes[attributeCounter] = num;
            ++attributeCounter;
        }




    }


    fclose(file);


    colision = new bool*[_height];

    for (unsigned i = 0; i<_height; i++)
    {
        colision[i] = new bool[_width];
    }

    for (unsigned i = 0; i <_height; i++)
    {

        for (unsigned a = 0; a < _width; a++)
        {

            colision[i][a] = tiles[i][a] >= 128;

        }
    }


    return true;
}


//---------------------------------------------
void Map::destroy(){
    if (tiles){
        for (unsigned i = 0; i<_height; i++)
            delete []tiles[i];
        delete []tiles;
        tiles = 0;
    }

    if (colision){
        for (unsigned int i = 0; i<_height; i++)
            delete []colision[i];
        delete []colision;
        colision = 0;


    }
}

//--------------------------------------------
void Map::draw(PicsContainer &pics, int layer, int screenw, int screenh, COLOR c, bool donthide){

    switch(layer)
    {
        default:
        {

            for (unsigned long i = 0;i < _height;i++)
            {
                for (unsigned long a = 0;a <_width; a++)
                {

                    pics.draw(3 + getAttribute(a, i),
                              a*32+mappos.x(),
                              i*32+mappos.z(), 
                              tiles[i][a], true, 4.0f, 4.0f, 0.0);
                }
            }
        } 
    }
}
//----------------------------------------------
bool Map::colide(unsigned long x,unsigned long y)
{
    if (((x>=0)&&(x<_width))&&((y>=0)&&(y<_height)))
    {
        return colision[y][x];
    }

    return false;

}
//---------------------------------------------
unsigned char Map::tile(unsigned long x,unsigned long y)
{
    if (((x>=0)&&(x<_width))&&((y>=0)&&(y<_height)))
    {
        return tiles[y][x];
    }

    return 0;

}
//------------------------------------------------
void Map::setTile(unsigned long x, unsigned long y, unsigned char val)
{
    if (((x>=0)&&(x<_width))&&((y>=0)&&(y<_height))&&(tiles))
    {
        tiles[y][x] = val;
    }
}


//------------------------------------------------
void Map::move(Vector3D dir, float d)
{
    mappos = mappos + Vector3D(dir.x()*d,dir.y()*d,dir.z()*d);
}

//------------------------------------------------
void Map::setCollision(unsigned long x, unsigned long y, bool val)
{
    if (((x>=0)&&(x<_width))&&((y>=0)&&(y<_height)))
    {
        colision[y][x] = val;
    }
}
//-----------------------------------------------------
static unsigned calcBitPairNumber(unsigned x, unsigned y, unsigned& attributeIndex)
{
    unsigned ix = x / 4;
    unsigned iy = y / 4;

    attributeIndex = iy * 8 + ix;

    unsigned bitpairX = (x - ix * 4) / 2;
    unsigned bitpairY = (y - iy * 4) / 2;
    return   bitpairY * 2 + bitpairX;

}

//---------------------------------------------------------------
void Map::setAttribute(unsigned long x, unsigned long y, unsigned value)
{

    unsigned targetAttribIndex = 0;
    unsigned bitPairNum = calcBitPairNumber(x, y, targetAttribIndex);

    assert(bitPairNum < 4);

    unsigned char mask = 3 << (bitPairNum * 2);
    unsigned char pl = value << (bitPairNum * 2);

    unsigned char attrib = attributes[targetAttribIndex];


    attributes[targetAttribIndex] = (attrib & ~mask) | pl;

}
//----------------------------------------------------------
unsigned int Map::getAttribute(unsigned long x, unsigned long y)
{

    unsigned attridx = 0;
    unsigned bitPairNum = 3 - calcBitPairNumber(x, y, attridx);

    unsigned char pl = attributes[attridx] << (bitPairNum * 2);

    return pl >> 6;
}

//----------------------------------------------------------
void Map::save(const char *tilesPath){
    FILE* f = 0;

    f = fopen(tilesPath,"wt+");

    if (f)
    {
        fprintf(f, "%s\n", mapName);

        for (unsigned int i = 0; i<_height; i++)
        {
            fprintf(f, "    %s", ".byte ");


            if (_width <= 16)
            {
                for (unsigned int a = 0; a < _width; a++)
                {
                    fprintf(f, "$%02x", tiles[i][a]);
                    
                    if (a < _width - 1)
                    {
                        fprintf(f, ",");
                    }
                }
            }
            else
            {
                for (unsigned int a = 0; a < 16; a++)
                {
                    fprintf(f, "$%02x", tiles[i][a]);
                    
                    if (a < 15)
                    {
                        fprintf(f, ",");
                    }

                }

                fprintf(f,"\n");
                fprintf(f, "    %s", ".byte ");

                for (unsigned int a = 16; a < _width; a++)
                {
                    fprintf(f, "$%02x", tiles[i][a]);
                    
                    if (a < _width - 1)
                    {
                        fprintf(f, ",");
                    }

                }


            }

            fprintf(f,"\n");
        }

        for (unsigned i = 0; i < 2; ++i)
        {
            fprintf(f, "    %s", ".byte ");

            for (unsigned int a = 0; a < 16; a++)
            {
                fprintf(f, "$%02x", attributes[i*32+a]);

                if (a < 15)
                {
                    fprintf(f, ",");
                }

            }

            fprintf(f,"\n");
            fprintf(f, "    %s", ".byte ");

            for (unsigned int a = 16; a < _width; a++)
            {
                fprintf(f, "$%02x", attributes[i * 32  + a]);

                if (a < _width - 1)
                {
                    fprintf(f, ",");
                }

            }
            fprintf(f,"\n");


        }

        fclose(f);
        f = 0;
    }

 
}




