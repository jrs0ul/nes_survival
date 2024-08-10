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
#include "Utils.h"
#include "Shader.h"

    bool Shader::load(GLenum shaderType, const char* path){

        char * mbuf = 0;
        if (!ReadFileData(path, &mbuf))
            return false;

        char * backup = 0;
        backup = (char*)malloc(strlen(mbuf)+1);

        strcpy(backup, mbuf);
        //puts(backup);

        char * tmp = 0;
        tmp = strtok(mbuf,"\n\r");
        int lineCount = 0;
        while (tmp){
            lineCount++;
            tmp = strtok(0, "\n\r");
        }
        free(mbuf);

        char ** code = 0;

        code = new char*[lineCount];

        //puts("---------------");
        tmp = 0;
        tmp = strtok(backup, "\n\r");
        if (tmp){
            code[0] = new char[strlen(tmp)+1];
            strcpy(code[0], tmp);
            //puts(tmp);
        }
        for (int i = 1; i < lineCount; i++){
            tmp = strtok(0, "\n\r");
            if (tmp){
                int len = (int)strlen(tmp);
                code[i] = new char[len + 2];
                strcpy(code[i], tmp);
                code[i][len] = '\n';
                code[i][len+1] = 0;
                //puts(tmp);
            }
        }

        free(backup);

        id = glCreateShader(shaderType);

        glShaderSource(id, lineCount, (const GLchar**)code, 0);
        glCompileShader(id);

        for (int i = 0; i < lineCount; i++){
            //puts(code[i]);
            delete []code[i];
        }
        delete []code;

        
        return true;
    }

