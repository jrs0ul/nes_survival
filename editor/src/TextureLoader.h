#ifndef TEXTURE_LOADER_H
#define TEXTURE_LOADER_H

#ifdef WIN32
    #ifdef _MSC_VER
        #include <SDL_opengl.h>
    #else
        #include <SDL/SDL_opengl.h>
    #endif
#else
    #include <SDL/SDL_opengl.h>
#endif


#include "Image.h"
#include "DArray.h"
#include "Colors.h"
#include "ShaderProgram.h"

struct PicData{
    char name[255];
    int twidth;
    int theight;
    int width;
    int height;
    int filter;
    int type; //tga or CHR
    //additional data for faster rendering
    float htilew;
    float htileh;
    int vframes;
    int hframes;
    float partX;
    float partY;
};
//-------------------------
struct SpriteBatchItem{
    float x;
    float y;
    long textureIndex;
    unsigned int frame;
    bool useCenter;
    float scaleX ;
    float scaleY ;
    float rotationAngle;
    COLOR upColor;
    COLOR dwColor;

    SpriteBatchItem(){
        x = 0;
        y = 0;
        textureIndex = 0;
        frame = 0;
        useCenter = false;
        scaleX = 1.0f;
        scaleY = 1.0f ;
        rotationAngle = 0.0f;
        upColor = COLOR(1.0f, 1.0f, 1.0f, 1.0f);
        dwColor = COLOR(1.0f, 1.0f, 1.0f, 1.0f);
    }
};
//==================================

class PicsContainer{
    DArray<GLuint> TexNames;
    DArray<PicData> PicInfo;
    DArray<SpriteBatchItem> batch;

    void drawVA(void * vertices, void * uvs, void *colors,
                unsigned uvsCount, unsigned vertexCount);

public:
    PicsContainer(){}
    bool initContainer(const char* list);
    //load textures from list in textfile
    bool load(const char* list);


    void destroy();

    void drawSingle(long index, float x, float y,
                    int frame = 0, bool center=false,
                    float scalex = 1.0f, float scaley = 1.0f,
                    float angle = 0.0f,
                    COLOR c = COLOR(1.0f, 1.0f, 1.0f, 1.0f),
                    COLOR c2 = COLOR(1.0f, 1.0f, 1.0f, 1.0f));
    //adds sprite to batch
    void draw( long textureIndex,
                float x, float y,
                unsigned int frame = 0,
                bool useCenter = false,
                float scaleX = 1.0f, float scaleY = 1.0f,
                float rotationAngle = 0.0f,
                COLOR upColor = COLOR(1.0f, 1.0f, 1.0f, 1.0f),
                COLOR dwColor = COLOR(1.0f, 1.0f, 1.0f, 1.0f)
               );
    //draws all sprites in batch
    void drawBatch(ShaderProgram * justcolor,
                   ShaderProgram * texcolor,
                   int method = 0);

    GLuint getname(unsigned long index);
    PicData* getInfo(unsigned long index);
    unsigned long count(){return PicInfo.count();}
    int findByName(const char* picname, bool debug = false);

    //adds info to PicInfo and loads image
    bool loadFile(const char* file,
                  unsigned long index,
                  unsigned imageType, // 0 - TGA, 1 - Nes CHR
                  int tsize,
                  const char * basePath, int filter = 0);
    //loads images using special array loaded from file
    bool loadFile(unsigned long index, const char * BasePath);
    //no need for base folder
    bool loadFile(const char* file, 
                  unsigned long index,
                  unsigned imageType, // 0 - TGA, 1 - Nes CHR
                  int tsize, int filter = 0);
    void remove(unsigned long index);

};


#endif //TEXTURE_LOADER_H



