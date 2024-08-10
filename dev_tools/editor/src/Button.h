#ifndef MYGTAS_H
#define MYGTAS_H

#include "TextureLoader.h"

class Mygtas{
 int x;
 int y;
 int height;
 int width;

 public:
  
  bool pressed;

 void init(int dx=0, int dy=0, int w=50, int h=50){
    x =dx; y=dy; width=w; height=h; pressed=false;
 }
  void draw(PicsContainer& pics, int picindex ,int frame = 0, float r=1.0f, float g=1.0f, float b=1.0f);
  bool pointerOntop(int px,int py);
  void set(int dx, int dy, int w, int h){x=dx; y=dy; width=w; height=h;}
  void shiftstate();

};

#endif //MYGTAS_H

