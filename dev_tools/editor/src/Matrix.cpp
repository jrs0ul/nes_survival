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
#include "Matrix.h"


void RotationY(float angle, Matrix& mat){
	mat[0][0]=cos(angle);	mat[0][1]=0.0f; mat[0][2]=-sin(angle);	mat[0][3]=0.0f;
	mat[1][0]=0.0f;			mat[1][1]=1.0f; mat[1][2]=0.0f;			mat[1][3]=0.0f;
	mat[2][0]=sin(angle);	mat[2][1]=0.0f;	mat[2][2]=cos(angle);	mat[2][3]=0.0f;
	mat[3][0]=0.0f;			mat[3][1]=0.0f; mat[3][2]=0.0f;			mat[3][3]=1.0f;
}

void RotationAxis(float angle, Vector3D axis, Matrix& mat){
	Vector3D V = axis;
	V.normalize();
	float x = V.x();
	float y = V.y();
	float z = V.z();

	
	float s= sin(angle);
	float c= cos(angle);
	float t= 1-c;
	mat[0][0]=t*(x*x)+c;	mat[0][1]=t*x*y-s*z;	mat[0][2]=t*x*z+s*y;	mat[0][3]=	0;
	mat[1][0]=t*x*y+s*z;	mat[1][1]=t*y*y+c;		mat[1][2]=t*y*z-s*x;	mat[1][3]=	0;
	mat[2][0]=t*x*z-s*y;	mat[2][1]=t*y*z+s*x;	mat[2][2]=t*z*z+c;		mat[2][3]=0;
	mat[3][0]=0;			mat[3][1]=0;			mat[3][2]=0;			mat[3][3]=1;
}



