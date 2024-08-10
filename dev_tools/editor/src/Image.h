
#ifndef IMAGE_H
#define IMAGE_H

class Image{
public:
    unsigned short width;
    unsigned short height;
    unsigned char* data;
    
    Image(){ data=0; width=0; height=0;}
    bool loadTga(const char* name, unsigned short& imageBits );
    bool saveTga(const char* name);
    bool loadChr(const char* name, unsigned char* palette, unsigned char paletteIdx);
    void destroy();
};


#endif //IMAGE_H



