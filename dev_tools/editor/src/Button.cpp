#include "Button.h"

void Mygtas::draw(PicsContainer& pics, int picindex ,int frame, float r, float g, float b)
{
    if (picindex >= 0)
    {
        PicData* info = pics.getInfo(picindex);
    
        float scaleX = width / info->twidth;
        float scaleY = height / info->theight;
        pics.draw(picindex, x + width/2, y + height/2, frame, true, 
              scaleX, scaleY, 0.0f, COLOR(r, g, b, 1.0f));
    }
    else
    {
        pics.draw(picindex, x, y, 0, false, width, height, 0.f, COLOR(r,g,b, 0.8f), COLOR(r,g,b, 0.8f));
    }
}

bool Mygtas::pointerOntop(int px, int py)
{
    if ((px>x)&&(px<x+width)&&(py>y)&&(py<y+height))
      return true;
    else
      return false;
}

void Mygtas::shiftstate()
{
     if (pressed) pressed=false;
     else pressed=true;
}


