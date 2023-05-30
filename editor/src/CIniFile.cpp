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

