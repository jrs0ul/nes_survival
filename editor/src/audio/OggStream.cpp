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
#include "OggStream.h"


bool OggStream::open(const char* path){
    int result;

    if(!(oggFile = fopen(path, "rb"))){
       printf("Could not open %s\n", path);
       return false;
    }

    if((result = ov_open(oggFile, &oggStream, NULL, 0)) < 0){
        fclose(oggFile);
        printf("Could not open %s\n", path);
    }

    vorbisInfo = ov_info(&oggStream, -1);


    if(vorbisInfo->channels == 1)
        format = AL_FORMAT_MONO16;
    else
        format = AL_FORMAT_STEREO16;


    alGenBuffers(BUFFERCOUNT, buffers);

    alGenSources(1, &source);


    char pDecodeBuffer[BUFFER_SIZE];

    for (int i = 0; i < BUFFERCOUNT; i++){
        long bytes = 0;
        bytes = stream(pDecodeBuffer);
        if (bytes){
            alBufferData(buffers[i], format, pDecodeBuffer, bytes, vorbisInfo->rate);
            alSourceQueueBuffers(source, 1, &buffers[i]);
        }
    }

    alSource3f(source, AL_POSITION,        0.0, 0.0, 0.0);
    alSource3f(source, AL_VELOCITY,        0.0, 0.0, 0.0);
    alSource3f(source, AL_DIRECTION,       0.0, 0.0, 0.0);
    alSourcef (source, AL_ROLLOFF_FACTOR,  0.0          );
    alSourcei (source, AL_SOURCE_RELATIVE, AL_TRUE      );

    return true;
}



//----------------------------------------
void OggStream::release()
{

    alSourceStop(source);

    empty();

    alDeleteSources(1, &source);
    check("releasing");
    alDeleteBuffers(BUFFERCOUNT, buffers);
    check("releasing");
    ov_clear(&oggStream);
    check("releasing");

}


//------------------------------------


bool OggStream::playback(){

    int iState;
    alGetSourcei(source, AL_SOURCE_STATE, &iState);
    if (iState != AL_PLAYING){

        int iQueuedBuffers = 0;
        alGetSourcei(source, AL_BUFFERS_QUEUED, &iQueuedBuffers);
        printf("Buffers queued: %d\n", iQueuedBuffers);
        if (iQueuedBuffers){
            alSourcePlay(source);
        }
    }

    return true;
}


//------------------------------

bool OggStream::playing(){
    ALenum state;

    alGetSourcei(source, AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);
}


//---------------------------------

bool OggStream::update(){

    int processed = 0;
    bool active = true;

    alGetSourcei(source, AL_BUFFERS_PROCESSED, &processed);

    while(processed){
        ALuint buffer;

        alSourceUnqueueBuffers(source, 1, &buffer);


        char pcm[BUFFER_SIZE];
        long siz;
        siz = stream(pcm);

        if (siz){
            alBufferData(buffer, format, pcm, siz, vorbisInfo->rate);
            alSourceQueueBuffers(source, 1, &buffer);
            //puts("ading extra buffer");
        }

        check("updating");
        processed--;
    }

    return active;
}


//-------------------------------------------------

long OggStream::stream(char* decbuff){

    int  size = 0;
    int  section;
    int  result=1;


    while((result) && (size < BUFFER_SIZE)){

        result = ov_read(&oggStream, decbuff + size, BUFFER_SIZE - size, 0, 2, 1, &section);

        if(result > 0)
            size += result;
        else
            if(result < 0){
                break;
            }

    }
    if (result<=0){
        result = 1;
        size = 0;
        ov_pcm_seek(&oggStream, 0);
        while((result) && (size<BUFFER_SIZE)){
            result = ov_read(&oggStream, decbuff + size, BUFFER_SIZE - size, 0, 2, 1, &section);

            if(result > 0)
                size += result;
            else
                if(result < 0){
                    break;
                }
        }
    }
    return size;
}

//-------------------------------------
void OggStream::empty(){

    int queued = 0;

    alGetSourcei(source, AL_BUFFERS_QUEUED, &queued);
    printf("Buffers queued:%d\n", queued);

    int a = 0;
    while( queued--){
        a++;
        printf("buff %d\n", a);

        ALuint buffer;

        alSourceUnqueueBuffers(source, 1, &buffer);
        check("emptying");
    }
}

//---------------------------------
void OggStream::check(const char* place){
        ALenum r=0;
        r=alGetError();
        if ( r != AL_NO_ERROR){
            printf("Error: %x while %s\n",r,place);
        }
}
