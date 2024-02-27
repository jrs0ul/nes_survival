
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
#ifndef _DARRAY_H_
#define _DARRAY_H_

#include <cstdlib>
#include <cstdio>
#include <cstring>


template <class T>
class DArray{
    unsigned long _count;
    T* mas;
    unsigned long batch;
    unsigned long capacity;
public:


    DArray(){
        _count=0; mas=0; batch = 10;
        capacity = batch;

    }
    //----------------------------------
    /*DArray(DArray const & copy){
        this->destroy();
        for (unsigned long i=0;i<copy.count();i++){
            this->add(copy[i]);
        }
    }*/
    //---------------------
    void * getData(){
        return mas;
    }

    //---------------------------
    void add(const T& newitem){

        _count++;

        if (_count == 1)
            mas = (T *)malloc(capacity*sizeof(T));
        else
        if ( _count > capacity ){
            capacity += batch;
            mas = (T *)realloc(mas, sizeof(T)*capacity);
        }

        mas[_count-1]=newitem;

    }
    //---------------------------
    bool remove(unsigned long index){

        if (index >= _count)
            return false;

        if (_count == 1) {
            this->destroy();

            return true;
        }
        else{
            memmove(mas + index, mas + index + 1, sizeof(T)*((_count - 1) - index));

            _count--;
            if ((capacity - _count) > batch){
                capacity -= batch;
                mas = (T *)realloc(mas, sizeof(T)*capacity);
            }
            return true;

        }

    }
    //---------------------------
    void destroy(){
        if (mas){
            free(mas);
            mas=0;
            _count=0;
            capacity = batch;

        }
    }
    //---------------------------
    unsigned long count(){return _count;}

    //-----------------------------------------------
    T& operator[](unsigned long index) {

        if (index < _count)
            return mas[index];
        else
            return mas[_count - 1];
    }



};



#endif //_DARRAY_H_


