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
#include "Extensions.h"

#ifndef __APPLE__
PFNGLGENBUFFERSPROC                  glGenBuffers = 0;
PFNGLDELETEBUFFERSPROC               glDeleteBuffers = 0;
PFNGLBINDBUFFERPROC                  glBindBuffer = 0;
PFNGLBUFFERDATAPROC                  glBufferData = 0;
PFNGLMAPBUFFERPROC                   glMapBuffer = 0;
PFNGLUNMAPBUFFERPROC                 glUnmapBuffer = 0;

PFNGLCREATESHADERPROC                glCreateShader = 0; 
PFNGLSHADERSOURCEPROC                glShaderSource = 0;
PFNGLCOMPILESHADERPROC               glCompileShader = 0;
PFNGLCREATEPROGRAMPROC               glCreateProgram = 0;
PFNGLDELETEPROGRAMPROC               glDeleteProgram = 0;
PFNGLATTACHSHADERPROC                glAttachShader = 0;
PFNGLLINKPROGRAMPROC                 glLinkProgram = 0;
PFNGLUSEPROGRAMPROC                  glUseProgram  = 0;
PFNGLGETUNIFORMLOCATIONPROC          glGetUniformLocation = 0;
PFNGLUNIFORM1FPROC                   glUniform1f = 0;
PFNGLUNIFORM2FPROC                   glUniform2f = 0;
PFNGLUNIFORM3FPROC                   glUniform3f = 0;
PFNGLUNIFORM4FPROC                   glUniform4f = 0;
PFNGLUNIFORM1IPROC                   glUniform1i = 0;
#endif
PFNGLGETINFOLOGARBPROC               glGetInfoLogARB = 0;

PFNGLGENFRAMEBUFFERSEXTPROC          glGenFramebuffersEXT = 0;
PFNGLDELETEFRAMEBUFFERSEXTPROC       glDeleteFramebuffersEXT = 0;
PFNGLBINDFRAMEBUFFEREXTPROC          glBindFramebufferEXT = 0;
PFNGLFRAMEBUFFERTEXTURE2DEXTPROC     glFramebufferTexture2DEXT = 0;
PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC   glCheckFramebufferStatusEXT = 0;

#ifndef __APPLE__
#ifdef WIN32 
PFNGLACTIVETEXTUREPROC               glActiveTexture = 0;
#endif
#endif

void ParseExtensions(){

}

void LoadExtensions() {
#ifndef __APPLE__
//-------------VBO extensions-----------------------
    glGenBuffers    = (PFNGLGENBUFFERSPROC)
                          SDL_GL_GetProcAddress("glGenBuffersARB");
    glDeleteBuffers = (PFNGLDELETEBUFFERSPROC)
                          SDL_GL_GetProcAddress("glDeleteBuffersARB");
    glBindBuffer    = (PFNGLBINDBUFFERPROC)
                          SDL_GL_GetProcAddress("glBindBufferARB");
    glBufferData    = (PFNGLBUFFERDATAPROC)
                          SDL_GL_GetProcAddress("glBufferDataARB");

    glMapBuffer     = (PFNGLMAPBUFFERPROC)
                          SDL_GL_GetProcAddress("glMapBufferARB");
    glUnmapBuffer   = (PFNGLUNMAPBUFFERPROC)
                          SDL_GL_GetProcAddress("glUnmapBufferARB");
    //----------------Shader extensions----------------
    glCreateShader    = (PFNGLCREATESHADERPROC)
                         SDL_GL_GetProcAddress("glCreateShader");
    glShaderSource    = (PFNGLSHADERSOURCEPROC)
                         SDL_GL_GetProcAddress("glShaderSource");
    glCompileShader   = (PFNGLCOMPILESHADERPROC)
                         SDL_GL_GetProcAddress("glCompileShader");
    glCreateProgram   = (PFNGLCREATEPROGRAMPROC)
                         SDL_GL_GetProcAddress("glCreateProgram");
    glDeleteProgram   = (PFNGLDELETEPROGRAMPROC)
                         SDL_GL_GetProcAddress("glDeleteProgram");
    glAttachShader    = (PFNGLATTACHSHADERPROC)
                         SDL_GL_GetProcAddress("glAttachShader");
    glLinkProgram     = (PFNGLLINKPROGRAMPROC)
                         SDL_GL_GetProcAddress("glLinkProgram");
    glUseProgram      = (PFNGLUSEPROGRAMPROC)
                         SDL_GL_GetProcAddress("glUseProgram");
    glGetUniformLocation = (PFNGLGETUNIFORMLOCATIONPROC)
                            SDL_GL_GetProcAddress("glGetUniformLocation");
    glUniform1f  = (PFNGLUNIFORM1FPROC)SDL_GL_GetProcAddress("glUniform1f");
    glUniform2f  = (PFNGLUNIFORM2FPROC)SDL_GL_GetProcAddress("glUniform2f");
    glUniform3f  = (PFNGLUNIFORM3FPROC)SDL_GL_GetProcAddress("glUniform3f");
    glUniform4f  = (PFNGLUNIFORM4FPROC)SDL_GL_GetProcAddress("glUniform4f");
    glUniform1i  = (PFNGLUNIFORM1IPROC)SDL_GL_GetProcAddress("glUniform1i");
#endif
    glGetInfoLogARB = (PFNGLGETINFOLOGARBPROC)SDL_GL_GetProcAddress("glGetInfoLogARB");
    //--------------------------------------------
    glGenFramebuffersEXT        = (PFNGLGENFRAMEBUFFERSEXTPROC)SDL_GL_GetProcAddress("glGenFramebuffersEXT");
    glDeleteFramebuffersEXT = (PFNGLDELETEFRAMEBUFFERSEXTPROC)SDL_GL_GetProcAddress("glDeleteFramebuffersEXT");
    glBindFramebufferEXT        = (PFNGLBINDFRAMEBUFFEREXTPROC)SDL_GL_GetProcAddress("glBindFramebufferEXT");
    glFramebufferTexture2DEXT   = (PFNGLFRAMEBUFFERTEXTURE2DEXTPROC)SDL_GL_GetProcAddress("glFramebufferTexture2DEXT");
    glCheckFramebufferStatusEXT = (PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC)SDL_GL_GetProcAddress("glCheckFramebufferStatusEXT");

#ifndef __APPLE__
    //--------------------------------------------
    #ifdef WIN32
    glActiveTexture = (PFNGLACTIVETEXTUREPROC)SDL_GL_GetProcAddress("glActiveTexture");
    #endif
  #endif
}
//-----------------------------------------
void UnloadExtensions() {
#ifndef __APPLE__
    glGenBuffers    = 0;
    glDeleteBuffers = 0;
    glBindBuffer    = 0;
    glBufferData    = 0;
    glMapBuffer     = 0;
    glUnmapBuffer   = 0;


    glCreateShader       = 0;
    glShaderSource       = 0;
    glCompileShader      = 0;
    glCreateProgram      = 0;
    glAttachShader       = 0;
    glLinkProgram        = 0;
    glUseProgram         = 0;
    glGetUniformLocation = 0;
    glUniform1f          = 0;
    glUniform2f          = 0;
    glUniform3f          = 0;
    glUniform4f          = 0;
    glUniform1i          = 0;
    glGetInfoLogARB      = 0;

    #ifdef WIN32
        glActiveTexture = 0;
    #endif
#endif
}


