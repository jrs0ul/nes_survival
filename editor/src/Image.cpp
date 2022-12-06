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
#include "Image.h"


bool Image::loadTga(const char *name, unsigned short& imageBits ){
    FILE* TGAfile;
    TGAfile=fopen(name,"rb");
    if (!TGAfile)
        return false;

    int result = 0;
    unsigned char fieldDescSize;
    result = fread(&fieldDescSize,sizeof(unsigned char),1,TGAfile);
    fseek(TGAfile,1,SEEK_CUR);
    unsigned char imageCode;
    result = fread(&imageCode,sizeof(unsigned char),1,TGAfile);

    if ((imageCode != 2)&&(imageCode != 10)){
        fclose(TGAfile);
        return false;
    }
    fseek(TGAfile,2,SEEK_CUR);
    unsigned short mapLength;
    result = fread(&mapLength,sizeof(unsigned short), 1,TGAfile);
    fseek(TGAfile,1,SEEK_CUR);

    unsigned short xStart, yStart;
    result = fread(&xStart,sizeof(unsigned short),1,TGAfile);
    result = fread(&yStart,sizeof(unsigned short),1,TGAfile);
    result = fread(&width,sizeof(unsigned short),1,TGAfile);
    result = fread(&height,sizeof(unsigned short),1,TGAfile);

    //unsigned char imageBits;
    result = fread(&imageBits,sizeof(unsigned char), 1,TGAfile);
    if (imageBits<24){
        fclose(TGAfile);
        return false;
    }
    unsigned char imageDesc;
    result = fread(&imageDesc,sizeof(unsigned char), 1,TGAfile);
    fseek(TGAfile,fieldDescSize,SEEK_CUR);
    fseek(TGAfile,mapLength*(imageBits/8),SEEK_CUR);

    data = (unsigned char *)malloc(width*height*(imageBits/8));

    if ( imageCode == 2){ //uncompressed TGA
        unsigned char* tmp_data = (unsigned char*)malloc(width*height*(imageBits/8));
        result = fread(tmp_data, sizeof(unsigned char),
                       width * height * (imageBits/8), TGAfile);

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

         while (n < width * height) {
            result = fread(p,1,imageBits/8+1,TGAfile);
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
                for (int i=0;i<j;i++) {
                    result = fread(p,1,imageBits/8,TGAfile);

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


