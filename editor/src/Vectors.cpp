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
#include <cmath>
#include <cstring>
#include "Vectors.h"

void Vector3D::transform(float matrix[4][4]){
    float nw[4];
    nw[0] = v[0] * matrix[0][0] + 
             v[1] * matrix[1][0] + 
             v[2] * matrix[2][0] +
             v[3] * matrix[3][0];
    nw[1] = v[0] * matrix[0][1] +
             v[1] * matrix[1][1] +
             v[2] * matrix[2][1] +
             v[3] * matrix[3][1];
    nw[2] = v[0] * matrix[0][2] +
             v[1] * matrix[1][2] +
             v[2] * matrix[2][2]+
             v[3] * matrix[3][2];

    nw[3] = v[0] * matrix[0][3] +
             v[1] * matrix[1][3] +
             v[2] * matrix[2][3]+
             v[3] * matrix[3][3];


     memcpy(v, nw, 4 * sizeof(float));
}
//----------------------------
float Vector3D::length(){
    return sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
}
//----------------------------
void Vector3D::normalize(){
    float l = length();
    v[0] = v[0] / l;
    v[1] = v[1] / l;
    v[2] = v[2] / l;
}
//----------------------
const Vector3D operator ^ (const Vector3D& left,
                                const Vector3D& right){ //cross
        return Vector3D(left.v[1] * right.v[2] - left.v[2] * right.v[1],
                        left.v[2] * right.v[0] - left.v[0] * right.v[2],
                        left.v[0] * right.v[1] - left.v[1] * right.v[0] );
}
//----------------------
float operator * (const Vector3D& left,
                                const Vector3D& right){ //dot
        return left.v[0] * right.v[0] + 
               left.v[1] * right.v[1] + 
               left.v[2] * right.v[2];
}

//----------------------------------
const Vector3D operator - (const Vector3D& left, const Vector3D& right ){
    return Vector3D(left.v[0] - right.v[0],
                    left.v[1] - right.v[1],
                    left.v[2] - right.v[2]);
}
//--------------------------------------
const Vector3D operator + (const Vector3D& left, const Vector3D& right ){
    return Vector3D(left.v[0] + right.v[0],
                    left.v[1] + right.v[1],
                    left.v[2] + right.v[2]);
}


