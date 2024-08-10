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
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <vorbis/vorbisfile.h>
#include "Utils.h"




void DrawText(int x, int y,const char* text, PicsContainer& pic, int imgindex,
            float scale, COLOR color){
    for (unsigned i=0;i<strlen(text);i++){
        pic.draw( imgindex, x+i*(12*scale), y, text[i]-32, true, scale, scale, 0.0f, color, color);
    }
}
//------------------------------------------------------------------
void DrawBlock(PicsContainer& pic, int x, int y, int width, int height, COLOR c, COLOR c2){
    pic.draw(-1, x, y, 0, false, width, height, 0.0f, c, c2);
}
//----------------------------------------------------------------
int _round(double x){
    return int(x > 0.0 ? x + 0.5 : x - 0.5);
}
//--------------------------------------------------------------


bool CirclesColide(float x1,float y1,float radius1, float x2, float y2, float radius2){

     float difx = (float) fabs (x1 - x2);
     float  dify = (float) fabs (y1 - y2);
     float   distance = (float) sqrt (difx * difx + dify * dify);

     if   (distance < (radius1 + radius2))
        return   true;

     return   false;

}

//-----------------------------------------------

_POINT* Line(int x1, int y1, int x2, int y2, int& count, int gridw){

    bool steep = abs(y2 - y1) > abs(x2 - x1);
    if (steep){
        int tmp=x1;
        x1=y1; y1=tmp;
        tmp=x2;
        x2=y2; y2=tmp;
    }
    if (x1 > x2){
        int tmp=x1;
        x1=x2; x2=tmp;
        tmp=y1;
        y1=y2; y2=tmp;

    }
    int deltax = x2 - x1;
    int deltay = abs(y2 - y1);
    float error = 0.0f;
    float deltaerr = deltay / (deltax*1.0f);
    int ystep;
    int y = y1;
    if (y1 < y2)
        ystep = 1*gridw;
    else
        ystep = -1*gridw;

    count=0;
    _POINT* mas=0;
    for (int x=x1;x<x2;x+=gridw){

        _POINT* tmp=0;
        if (mas){
            tmp=new _POINT[count];
            for (int i=0;i<count;i++){
                tmp[i]=mas[i];
            }
            delete []mas;
        }
        (count)++;
        mas=new _POINT[count];
        if (count>1){
            for (int i=0;i<count-1;i++)
                mas[i]=tmp[i];
            delete []tmp;
        }


        if (steep){
            mas[count-1].x=y/gridw;
            mas[count-1].y=x/gridw;


        }
        else{
            mas[count-1].x=x/gridw;
            mas[count-1].y=y/gridw;
        }
        error = error + deltaerr;
        if (error >= 0.5f){
            y = y + ystep;
            error = error - 1.0f;
        }
    }
    return mas;

}


