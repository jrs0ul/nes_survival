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
#ifndef _SHADER_PROGRAM_H
#define _SHADER_PROGRAM_H

#include "Extensions.h"
#include "Shader.h"

class ShaderProgram{
    GLuint program;

public:

    void create();
    void destroy();
    void getLog(char* string, int len);
    void attach(Shader& sh);
    void link();
    void use();
    int  getUniformID(const char* name);

    ShaderProgram(){
        program = 0;
    }

};


#endif //_SHADER_PROGRAM_H
