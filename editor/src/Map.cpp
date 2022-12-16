#include <cstdio>


#include "Matrix.h"
#include "Map.h"

//----------------------------------------------
bool Map::load(const char* tilesPath, const char* collisionPath){
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

    char dname[255];

    if (!fscanf(file,"%s\n", dname))
    {
        fclose(file);
        return false;
    }
    printf("%s\n", dname);

    for (unsigned i = 0; i<_height; i++)
    {
        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return(false);
        }

        //printf("%s\n", dname);
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

    fclose(file);

    file = fopen(collisionPath,"rt");

    if (!file)
    {
        return false;
    }

    
    if (!fscanf(file, "%s\n", dname))
    {
        fclose(file);
        return false;
    }
    printf("%s\n", dname);


    colision = new bool*[_height];

    for (unsigned i = 0; i<_height; i++)
        colision[i] = new bool[_width];

    for (unsigned i = 0; i <_height; i++)
    {
        if (!fscanf(file, "%s ", dname))
        {
            fclose(file);
            return false;
        }
        printf("%s\n", dname);

        for (unsigned a = 0; a < _width / 8; a++)
        {
            char tmp;
            if (!fscanf(file, "%c", &tmp))
            {
                fclose(file);
                return false;
            }

            for (unsigned b = 0; b < 8; ++b)
            {
                if (!fscanf(file, "%c", &tmp))
                {
                    fclose(file);
                    return false;
                }
                colision[i][a*8 + b] = (bool)(tmp - '0');
                printf("%d ", tmp);
            }

            if (!fscanf(file, "%c", &tmp))
            {
                fclose(file);
                return false;
            }

        }
    }


    fclose(file);
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

                    pics.draw(1,
                              a*32+mappos.x(),
                              i*32+mappos.z(), 
                              tiles[i][a], true, 4.0f, 4.0f, 0.0, c, c);
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

//----------------------------------------------------------
void Map::save(const char *tilesPath, const char* collisionPath){
    FILE* f = 0;

    f = fopen(tilesPath,"wt+");

    if (f)
    {
        for (unsigned int i = 0; i<_height; i++)
        {
            for (unsigned int a = 0; a<_width; a++)
            {
                fprintf(f, "%4d", tiles[i][a]);
            }

            fprintf(f,"\n");
        }

        fclose(f);
        f = 0;
    }


    f = fopen(collisionPath,"wt+");

    if (f)
    {
        fprintf(f, "%s\n", "collision:");

        for (unsigned int i = 0; i<_height; i++)
        {
            int counter = 0;
            char thebyte[9];
            int byteCounter = 0;
            fprintf(f, "    %s", ".byte ");

            for (unsigned int a = 0; a <_width; a++)
            {
                thebyte[counter] = '0' + colision[i][a];
                ++counter;

                if (counter == 8)
                {
                    thebyte[counter] = 0;
                    fprintf(f,"%c%s", '%', thebyte);
                    counter = 0;
                    ++byteCounter;
                    if (byteCounter < 4)
                    {
                        fprintf(f, "%s", ",");
                    }
                }
            }
            fprintf(f,"\n");
        }

        fclose(f);
    }

}




