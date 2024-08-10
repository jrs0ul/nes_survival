/***************************************************************************
 *   Copyright (C) 2008 by jrs0ul                                          *
 *   jrs0ul@gmail.com                                                      *
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
#ifndef __ogg_h__
#define __ogg_h__


#ifdef WIN32
    #ifdef _MSC_VER
        #include <al.h>
    #else
        #include <AL/al.h>
    #endif
#elif __APPLE__
    #include <OpenAL/al.h>
#else
    #include <AL/al.h>
#endif

#include <cstring>
#include <vorbis/vorbisfile.h>



#define BUFFER_SIZE (4096 * 8)
#define BUFFERCOUNT 8




class OggStream{
    public:

        //opens stream from ogg file
        OggStream(){
            //source = 0;
            //memset(buffers, 0 , sizeof(ALuint)*BUFFERCOUNT);
        }
        bool open(const char* path);
        void release();
        bool playback();
        bool playing();
        bool update();

    protected:

       long  stream(char* decbuff);
        void empty();
        void check(const char* place);

    private:


        FILE*           oggFile;
        OggVorbis_File  oggStream;
        vorbis_info*    vorbisInfo;

        ALuint buffers[BUFFERCOUNT];
        ALuint source;
        ALenum format;
};


#endif // __ogg_h__
