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
#include "SoundSystem.h"
#include <vorbis/vorbisfile.h>


//-------------------------------------------------------------------
char* SoundSystem::LoadOGG(char *fileName,  ALsizei & size,
                           ALenum &format, ALsizei &freq){

    char * buffer =0;
    const int BUFFER_SIZE = 16384 ;
    int endian = 0;

    long bytes;
    char data[BUFFER_SIZE];
    FILE *f = 0;

    f = fopen(fileName, "rb");

    if (!f){
        printf("Cannot open %s\n",fileName);
        return 0;
    }

    vorbis_info *pInfo;
    OggVorbis_File oggFile;

    if (ov_open(f, &oggFile, NULL, 0) != 0){
        printf("Error while opening %s\n",fileName);
        return 0;
    }

    pInfo = ov_info(&oggFile, -1);

    if (pInfo->channels == 1)
        format = AL_FORMAT_MONO16;
    else
        format = AL_FORMAT_STEREO16;

    freq = pInfo->rate;

    bytes = 1;
    buffer = 0;
    size = 0;
    int siz =0;
    int btmp = 1;
    while (bytes > 0){

        //uzpildome buferi
        siz = 0;
        while ((btmp) && (siz<BUFFER_SIZE)){

            btmp = ov_read(&oggFile, data+siz, BUFFER_SIZE-siz, endian, 2, 1, 0);
            siz+=btmp;
        }

        bytes = siz;
        if (bytes< 0){
            ov_clear(&oggFile);
            printf("Error while decoding %s\n",fileName);
            return 0;
        }
        printf("#");


        char * tmp = 0;
        if (size){
            tmp = new char[size+1];
            memcpy(tmp,buffer,size);
            delete []buffer;
        }
        size+=bytes;
        buffer=new char[size];
        memcpy(buffer,tmp,size-bytes);
        memcpy(&buffer[size-bytes],data,bytes);
        if (tmp){
            delete []tmp;
        }


    }

    ov_clear(&oggFile);
    puts("__");
    return buffer;
    }


//---------------------------------------------------
bool SoundSystem::init(ALCchar* dev){

 int r;

    alGetError();

    if (dev)
        printf("Using %s as sound device...\n", dev );


    alcdev = alcOpenDevice(dev);


    if (!alcdev){

        r = alGetError();
        if ( r != AL_NO_ERROR){
            printf("Error: %x while initialising SoundSystem\n",r);
        }
        return false;
    }

    alccont=alcCreateContext(alcdev,0);
    alcMakeContextCurrent(alccont);


    r = alGetError();
    if ( r != AL_NO_ERROR){
        printf("Error: %x while creating context\n",r);
        return false;
    }

    return true;
}
//---------------------------------------
void SoundSystem::exit(){
    if (alcdev){
        alccont=alcGetCurrentContext();
        alcdev=alcGetContextsDevice(alccont);
        alcMakeContextCurrent(0);
        alcDestroyContext(alccont);

        alcCloseDevice(alcdev);
    }
}
//--------------------------------------
    void SoundSystem::loadFiles(const char * BasePath, const char * list){

        char buf[255];
        sprintf(buf, "%s%s", BasePath, list);

        FILE* failas=fopen(buf,"rt");

        if (failas) {
            while (!feof(failas)){
                SoundData data;
                data.name[0]=0;
                int result = 0;
                result = fscanf(failas,"%s\n",data.name);
                audioInfo.add(data);
            }

            fclose(failas);
        }

        buffers = new ALuint[audioInfo.count()];
        alGenBuffers(audioInfo.count(), buffers);

        sources = new ALuint[audioInfo.count()];
        alGenSources(audioInfo.count(), sources);

        char * data = 0;
        ALenum format;
        ALsizei size, freq;
        //  ALboolean loop;


        for (unsigned int i = 0 ; i<audioInfo.count(); i++){

            sprintf(buf, "%s%s", BasePath, audioInfo[i].name);

            data = LoadOGG(buf, size, format, freq);

            if (data){
                alBufferData(buffers[i],format,data,size,freq);
                delete []data;
                data = 0;
            }
            else
                puts("No data");
            alSourcei(sources[i], AL_BUFFER, buffers[i]);
            alSource3f(sources[i], AL_POSITION,        0.0, 0.0, 0.0);
            alSource3f(sources[i], AL_VELOCITY,        0.0, 0.0, 0.0);
            alSource3f(sources[i], AL_DIRECTION,       0.0, 0.0, 0.0);
            alSourcef (sources[i], AL_ROLLOFF_FACTOR,  0.0          );
            alSourcei (sources[i], AL_SOURCE_RELATIVE, AL_TRUE      );
        }

    }

//--------------------------------------------
void SoundSystem::playsound(unsigned int index, bool loop){

    if (index < audioInfo.count()){
        if (loop)
            alSourcei(sources[index],AL_LOOPING,AL_TRUE);
        else
            alSourcei(sources[index],AL_LOOPING,AL_FALSE);

        alSourcePlay(sources[index]);
    }

}
//--------------------------------------------

void SoundSystem::freeData(){

    if (audioInfo.count()){


        alDeleteSources(audioInfo.count(),sources);
        alDeleteBuffers(audioInfo.count(),buffers);
        delete []buffers;
        delete []sources;
        buffers=0;
        sources=0;
    }
    audioInfo.destroy();
}

//----------------------------------------
bool SoundSystem::isPlaying(unsigned int index){


    ALenum state;

    alGetSourcei(sources[index], AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);

}

//-------------------------------------------
void SoundSystem::setupListener(Vector3D position, Vector3D orientation){
    alListener3f(AL_POSITION,position.x(),position.y(),position.z());
    //alListenerf(AL_GAIN,       2.0f);
    //alListener3f(AL_ORIENTATION,orientation.x(),orientation.y(),orientation.z());
}
//---------------------------------------------
void SoundSystem::stopAll(){
    alSourceStopv(audioInfo.count(),sources);
}
