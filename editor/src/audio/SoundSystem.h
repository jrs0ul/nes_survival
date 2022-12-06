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
#ifndef SOUND_SYSTEM_H
#define SOUND_SYSTEM_H

#ifdef WIN32
    #ifdef _MSC_VER
        #include <alc.h>
        #include <al.h>
    #else
        #include <AL/alc.h>
        #include <AL/al.h>
    #endif
    #elif __APPLE__
        #include <OpenAL/alc.h>
        #include <OpenAL/al.h>
    #else
        #include <AL/alc.h>
        #include <AL/al.h>
#endif

#include "../DArray.h"
#include "../Vectors.h"

struct SoundData{
    char name[255];
};

//----------

class SoundSystem{

    ALCdevice* alcdev;
    ALCcontext* alccont;

    ALuint* buffers;
    ALuint* sources;
    DArray<SoundData> audioInfo;

    char* LoadOGG(char *fileName,  ALsizei & size, ALenum &format, ALsizei &freq);


public:
    SoundSystem(){alcdev=0; buffers=0; sources=0; }
    bool init(ALCchar* dev);
    void loadFiles(const char* BasePath, const char* list);
    void setupListener(Vector3D position, Vector3D orientation);
    void setSoundPos(unsigned int index, Vector3D pos);
    void playsound(unsigned int index, bool loop=false);
    void freeData();
    bool isPlaying(unsigned int index);
    ALuint getBuffer(unsigned int index){return buffers[index];}
    void stopAll();
    void exit();

};




#endif //SOUND_SYSTEM_H
