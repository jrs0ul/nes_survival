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

#include "ShaderProgram.h"

    void ShaderProgram::create(){
        program = glCreateProgram();
    }
//---------------------------
    void ShaderProgram::destroy(){
        glDeleteProgram(program);
    }
//--------------------------
    void ShaderProgram::getLog(char* string, int len){
        glGetInfoLogARB(program, len, 0, string);
    }
//-------------------------------------
    void ShaderProgram::attach(Shader & sh){
        
        glAttachShader(program, sh.id);
    }
//---------------------------------
    void ShaderProgram::link(){
        glLinkProgram(program);
    }
//--------------------------------
    void ShaderProgram::use(){
        glUseProgram(program);
        //printf("program id %u\n", program);
    }
//--------------------------------
    int ShaderProgram::getUniformID(const char* name){
        return  glGetUniformLocation(program, name);
    }
