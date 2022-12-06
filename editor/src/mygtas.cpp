#include "mygtas.h"

void Mygtas::draw(PicsContainer& pics, int picindex ,int frame, float r, float g, float b){
  pics.draw(picindex, x+width/2, y+height/2, frame, true, 1.0f, 1.0f, 0.0f, COLOR(r, g, b, 1.0f));
 }

 bool Mygtas::pointerOntop(int px, int py){
	if ((px>x)&&(px<x+width)&&(py>y)&&(py<y+height))
	  return true;
	else
	  return false;
 }

 void Mygtas::shiftstate(){
	 if (pressed) pressed=false;
	 else pressed=true;
 }


