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



#include "CIniFile.h"
#include <cstring>



bool CIniFile::read(const char *fname){
    FILE * f;
    f=fopen(fname,"rt+, ccs=UTF-8");
    if (f){
        while (!feof(f)){
            wchar_t tmp[384];
            fgetws(tmp,384,f);
            Setting sett;
            wchar_t * p;
            wchar_t * state;

            #ifdef WIN32
                p=wcstok(tmp,L"=");
            #else
                p=wcstok(tmp,L"=",&state);
            #endif

            if (p){
                wcscpy(sett.name,p);
                #ifdef WIN32
                    p=wcstok(0,L"\r\n");
                #else
                    p=wcstok(0,L"\r\n",&state);
                #endif
                if (p){
                    wcscpy(sett.value,p);
                    settings.add(sett);
                }
            }
            
        }
        fclose(f);
        return true;


    }
    return false;
}
//-----------------------------------------------
void CIniFile::get(const wchar_t *name, wchar_t *value){
    if (settings.count()){
        for (unsigned long i = 0;i<settings.count();i++)
            if (wcscmp(name,settings[i].name)==0){
                wcscpy(value,settings[i].value);
                return;
            }
    }
    else value=0;
}
//-----------------------------------------------
void CIniFile::set(const wchar_t *name, const wchar_t *value){

    for (unsigned long i = 0;i<settings.count();i++)
        if (wcscmp(name,settings[i].name)==0){
            wcscpy(settings[i].value,value);
                return;
            }

    Setting set;
    wcscpy(set.name,name);
    wcscpy(set.value,value);
    settings.add(set);
    
}
//---------------------------------------------
void CIniFile::write(const char *fname){
    FILE* f;
    f=fopen(fname,"wt+, ccs=UTF-8");
    for (unsigned long i=0;i<settings.count();i++)
        fwprintf(f,L"%ls=%ls\n",settings[i].name,settings[i].value);
    fclose(f);

}


//-----------------------------------------------
void CIniFile::destroy(){
    settings.destroy();
}

