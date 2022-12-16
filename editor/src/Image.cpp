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
bool Image::loadChr(const char* name)
{
    const unsigned CHR_HEIGHT = 128;
    const unsigned CHR_WIDTH = 128;
    const unsigned TILE_WIDTH = 8;




    width = 128;
    height = 128;

    FILE* ChrFile = 0;

    ChrFile = fopen(name, "rb");

    if (!ChrFile)
    {
        return false;
    }

    data = (unsigned char*)malloc(CHR_HEIGHT * CHR_WIDTH * 3);


    fseek(ChrFile, 4096, SEEK_SET);
    
    unsigned char firstBytes[TILE_WIDTH];
    unsigned char secondBytes[TILE_WIDTH];


    unsigned x = 0;
    unsigned y = 0;

    for (unsigned i = 255; i >= 0; --i)
    {
        y = floor(i / 16.f) * 8 + 7;
        x = (i - (floor(i / 16.f) * 16)) * 8 + 8;


        for (unsigned j = 0; j < TILE_WIDTH; ++j)
        {
            if (!fread(&firstBytes[j], sizeof(unsigned char), 1, ChrFile))
            {
                fclose(ChrFile);
                return false;
            }
        }

        for (unsigned j = 0; j < TILE_WIDTH; ++j)
        {
            if (!fread(&secondBytes[j], sizeof(unsigned char), 1, ChrFile))
            {
                fclose(ChrFile);
                return false;
            }

        }



        for (unsigned j = 0; j < 8; ++j)
        {

            unsigned shift = 0;

            for (unsigned k = 0; k < 8; ++k)
            {
                unsigned shr = 7u - shift + shift;

                unsigned char firstPart = firstBytes[j];

                firstPart = firstPart << shift;
                firstPart = firstPart >> shr;

                unsigned char secondPart = secondBytes[j];

                secondPart = secondPart << shift;
                secondPart = secondPart >> shr;

                data[(y * 128 + (128 - x)) * 3]     = 85 * (firstPart + secondPart);
                data[(y * 128 + (128 - x)) * 3 + 1] = 85 * firstPart;
                data[(y * 128 + (128 - x)) * 3 + 2] = 85 * (firstPart + secondPart);
                ++shift;
                --x;
            }
            x = (i - (floor(i / 16.f) * 16)) * 8 + 8;
            --y;
        }
       
    }

    fclose(ChrFile);
    return true;
}


