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
#ifndef VECTORS_H
#define VECTORS_H


struct Vector3D{

    float v[4];

    Vector3D(float nx, float ny, float nz){
        v[0] = nx; v[1] = ny; v[2] = nz; v[3] = 1.0f;
    }
    Vector3D(float nx, float ny, float nz, float nw){
        v[0] = nx; v[1] = ny; v[2] = nz; v[3] = nw;
    }
    Vector3D(){v[0] = 0; v[1] = 0; v[2] = 0; v[3] = 1.0f;}
    float x(){return v[0];}
    float y(){return v[1];}
    float z(){return v[2];}
    float w(){return v[3];}
    void set(float nx, float ny, float nz, float nw = 1.0f){
        v[0] = nx; v[1] = ny; v[2] = nz; v[3] = nw;
    }
    void transform(float matrix[4][4]);
    void normalize();
    float length();
    
    friend const Vector3D operator + (const Vector3D& left, const Vector3D& right );

    friend const Vector3D operator - (const Vector3D& left, const Vector3D& right );

    friend const Vector3D operator ^ (const Vector3D& left, //cross
                                const Vector3D& right);

    friend  float operator * (const Vector3D& left, //dot
                                const Vector3D& right);

};


#endif //VECTORS_H


