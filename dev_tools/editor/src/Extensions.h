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
#ifndef GL_EXTENSIONS_H_
#define GL_EXTENSIONS_H_

#ifdef WIN32
    #ifdef _MSC_VER
        #include <SDL.h>
        #include <SDL_opengl.h>
    #else
        #include <SDL/SDL.h>
        #include <SDL/SDL_opengl.h>
    #endif
#else
    #include <SDL/SDL.h>
    #include <SDL/SDL_opengl.h>
#endif

#ifndef __APPLE__ //OSX already has VBO and shaders
//---------------VBO----------------------------------------
extern PFNGLGENBUFFERSARBPROC               glGenBuffers;
extern PFNGLDELETEBUFFERSPROC               glDeleteBuffers;
extern PFNGLBINDBUFFERPROC                  glBindBuffer;
extern PFNGLBUFFERDATAPROC                  glBufferData;
extern PFNGLMAPBUFFERPROC                   glMapBuffer;
extern PFNGLUNMAPBUFFERPROC                 glUnmapBuffer;
//----------------GLSL---------------------------------
extern PFNGLCREATESHADERPROC                glCreateShader;
extern PFNGLSHADERSOURCEPROC                glShaderSource;
extern PFNGLCOMPILESHADERPROC               glCompileShader;
extern PFNGLCREATEPROGRAMPROC               glCreateProgram;
extern PFNGLDELETEPROGRAMPROC               glDeleteProgram;
extern PFNGLATTACHSHADERPROC                glAttachShader;
extern PFNGLLINKPROGRAMPROC                 glLinkProgram;
extern PFNGLUSEPROGRAMPROC                  glUseProgram;
extern PFNGLGETUNIFORMLOCATIONPROC          glGetUniformLocation;
extern PFNGLUNIFORM1FPROC                   glUniform1f;
extern PFNGLUNIFORM2FPROC                   glUniform2f;
extern PFNGLUNIFORM3FPROC                   glUniform3f;
extern PFNGLUNIFORM4FPROC                   glUniform4f;
extern PFNGLUNIFORM1IPROC                   glUniform1i;
#endif

extern PFNGLGETINFOLOGARBPROC               glGetInfoLogARB;
//------------------FBO--------------------------------
extern PFNGLGENFRAMEBUFFERSEXTPROC          glGenFramebuffersEXT;
extern PFNGLDELETEFRAMEBUFFERSEXTPROC       glDeleteFramebuffersEXT;
extern PFNGLBINDFRAMEBUFFEREXTPROC          glBindFramebufferEXT;
extern PFNGLFRAMEBUFFERTEXTURE2DEXTPROC     glFramebufferTexture2DEXT;
extern PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC   glCheckFramebufferStatusEXT;

#ifndef __APPLE__
//-----------------Multitexturing------------------------------------
#ifdef WIN32 
extern PFNGLACTIVETEXTUREPROC            glActiveTexture;
#endif
#endif

extern void LoadExtensions();
extern void UnloadExtensions();

#endif //GL_EXTENSIONS_H_
