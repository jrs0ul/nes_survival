
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include "Image.h"


bool Image::loadTga(const char *name, unsigned short& imageBits ){
    FILE* TGAfile;
    TGAfile=fopen(name,"rb");
    if (!TGAfile)
        return false;

    unsigned char fieldDescSize;
    if (!fread(&fieldDescSize,sizeof(unsigned char),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }
    fseek(TGAfile,1,SEEK_CUR);
    unsigned char imageCode;
    if (!fread(&imageCode,sizeof(unsigned char),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    if ((imageCode != 2)&&(imageCode != 10)){
        fclose(TGAfile);
        return false;
    }
    fseek(TGAfile,2,SEEK_CUR);
    unsigned short mapLength;
    if (!fread(&mapLength,sizeof(unsigned short), 1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }
    fseek(TGAfile,1,SEEK_CUR);

    unsigned short xStart, yStart;
    if (!fread(&xStart,sizeof(unsigned short),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }
    if (!fread(&yStart,sizeof(unsigned short),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    if (!fread(&width,sizeof(unsigned short),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    if (!fread(&height,sizeof(unsigned short),1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    //unsigned char imageBits;

    if (!fread(&imageBits,sizeof(unsigned char), 1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    if (imageBits<24){
        fclose(TGAfile);
        return false;
    }
    unsigned char imageDesc;

    if (!fread(&imageDesc,sizeof(unsigned char), 1,TGAfile))
    {
        fclose(TGAfile);
        return false;
    }

    fseek(TGAfile,fieldDescSize,SEEK_CUR);
    fseek(TGAfile,mapLength*(imageBits/8),SEEK_CUR);

    data = (unsigned char *)malloc(width*height*(imageBits/8));

    if ( imageCode == 2){ //uncompressed TGA
        unsigned char* tmp_data = (unsigned char*)malloc(width*height*(imageBits/8));
        
        if (!fread(tmp_data, sizeof(unsigned char),
                       width * height * (imageBits/8), TGAfile))
        {

            fclose(TGAfile);
            return false;
        }

        for (int i = 0; i<height*width*(imageBits/8); i+=(imageBits/8)){

            data [i] = tmp_data[i+2]; //R
            data [i+1] = tmp_data[i+1]; //G
            data [i+2] = tmp_data[i]; //B
            if (imageBits>24)
                data [i+3] = tmp_data[i+3]; //A
        }

        if (tmp_data){
                free(tmp_data);
        }
    }

    else{ //RLE compressed
        int n = 0;
        int j = 0;
        unsigned char p[5];

         while (n < width * height) 
         {

            if (!fread(p,1,imageBits/8+1,TGAfile))
            {
                fclose(TGAfile);
                return false;
            }

            j = p[0] & 0x7f;

            data [n*(imageBits/8)] = p[3]; //R
            data [n*(imageBits/8)+1] = p[2]; //G
            data [n*(imageBits/8)+2] = p[1]; //B
            if (imageBits>24)
                data [n*(imageBits/8)+3] = p[4]; //A

            n++;
            if (p[0] & 0x80) {
                for (int i=0;i<j;i++) {
                    data [n*(imageBits/8)] = p[3]; //R
                    data [n*(imageBits/8)+1] = p[2]; //G
                    data [n*(imageBits/8)+2] = p[1]; //B
                    if (imageBits>24)
                        data [n*(imageBits/8)+3] = p[4]; //A

                    n++;
                }
            }
            else{
                for (int i=0; i<j; i++)
                {
                    if (!fread(p,1,imageBits/8,TGAfile))
                    {

                        fclose(TGAfile);
                        return false;
                    }

                    data [n*(imageBits/8)] = p[2]; //R
                    data [n*(imageBits/8)+1] = p[1]; //G
                    data [n*(imageBits/8)+2] = p[0]; //B
                    if (imageBits > 24)
                        data [n*(imageBits/8)+3] = p[3]; //A
                    n++;
                }
            }



         }
    }
    fclose(TGAfile);
    return true;
}


//--------------------------------
void Image::destroy(){
    if (data){
        free(data);
        data = 0;
    }
    width = 0;
    height = 0;
}
//-------------------------------
bool Image::saveTga(const char *name){

    unsigned char uselessChar;
    short int uselessInt;
    unsigned char imageType;
    unsigned char tempColors;

    FILE *file;
    file = fopen(name, "wb");

    if(!file){ 
        fclose(file);
        return false; 
    }

    imageType = 2;
    unsigned colorMode = 4;
    unsigned char bits = 32;

    uselessChar = 0; uselessInt = 0;

    fwrite(&uselessChar, sizeof(unsigned char), 1, file);
    fwrite(&uselessChar, sizeof(unsigned char), 1, file);
    fwrite(&imageType, sizeof(unsigned char), 1, file);

    fwrite(&uselessInt, sizeof(short int), 1, file);
    fwrite(&uselessInt, sizeof(short int), 1, file);
    fwrite(&uselessChar, sizeof(unsigned char), 1, file);
    fwrite(&uselessInt, sizeof(short int), 1, file);
    fwrite(&uselessInt, sizeof(short int), 1, file);

    fwrite(&width, sizeof(short int), 1, file);
    fwrite(&height, sizeof(short int), 1, file);
    fwrite(&bits, sizeof(unsigned char), 1, file);

    fwrite(&uselessChar, sizeof(unsigned char), 1, file);

    unsigned long size = width * height * colorMode;

    for(unsigned i = 0; i < size; i += colorMode){
         tempColors = data[i];
         data[i] = data[i + 2];
         data[i + 2] = tempColors;
    }

   fwrite(data, sizeof(unsigned char), size, file);

   fclose(file);

   return true;
}
//-------------------------------------
bool Image::loadChr(const char* name, unsigned char* palette, unsigned char paletteIdx)
{
    const unsigned CHR_HEIGHT = 128;
    const unsigned CHR_WIDTH = 128;
    const unsigned TILE_WIDTH = 8;

    if (palette)
    {
        printf("go:\n");
        printf("PAL1 %u\n", palette[3]);
    }


    width = 128;
    height = 128;

    FILE* ChrFile = 0;

    ChrFile = fopen(name, "rb");

    printf("LOADING CHR: %s\n", name);

    if (!ChrFile)
    {
        printf("FAIL OPENING\n");
        return false;
    }

    data = (unsigned char*)malloc(CHR_HEIGHT * CHR_WIDTH * 3);


    if (fseek(ChrFile, 4096, SEEK_SET))
    {
        printf("FAIL FSEEK\n");
        free(data);
        return false;
    }

    unsigned char firstBytes[TILE_WIDTH];
    unsigned char secondBytes[TILE_WIDTH];


    unsigned x = 0;
    unsigned y = 0;

    printf("LOOP\n");

    for (int i = 255; i >= 0; --i)
    {
        y = floor(i / 16.f) * 8 + 7;
        x = (i - (floor(i / 16.f) * 16)) * 8 + 8;


        for (unsigned j = 0; j < TILE_WIDTH; ++j)
        {
            if (!fread(&firstBytes[j], sizeof(unsigned char), 1, ChrFile))
            {
                fclose(ChrFile);
                free(data);
                printf("FAIL first bytes FREAD at %u\n", j);
                return false;
            }
        }

        for (unsigned j = 0; j < TILE_WIDTH; ++j)
        {
            if (!fread(&secondBytes[j], sizeof(unsigned char), 1, ChrFile))
            {
                fclose(ChrFile);
                free(data);
                printf("FAIL second bytes FREAD\n");
                return false;
            }

        }

        for (unsigned j = 0; j < 8; ++j)
        {
            for (unsigned k = 0; k < 8; ++k)
            {

                unsigned char firstPart = firstBytes[j];

                firstPart = ((firstPart << k) & 128) >> 7;

                unsigned char secondPart = secondBytes[j];

                secondPart = ((secondPart << k) & 128) >> 6;

                unsigned idx = (y * 128 + (128 - x)) * 3;
                unsigned paletteColorIdx = firstPart | secondPart;

                data[idx]     = palette[12 * paletteIdx + paletteColorIdx * 3];
                data[idx + 1] = palette[12 * paletteIdx + paletteColorIdx * 3 + 1];
                data[idx + 2] = palette[12 * paletteIdx + paletteColorIdx * 3 + 2];
                --x;
            }
            x = (i - (floor(i / 16.f) * 16)) * 8 + 8;
            --y;
        }
    }

    fclose(ChrFile);
    printf("DONE loading\n");
    return true;
}


