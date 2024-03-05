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

#ifndef CINI_H
#define CINI_H

#include <cstdio>
#include "DArray.h"
#include <wchar.h>

struct Setting{
	wchar_t name[128];
	wchar_t value[256];
};

class CIniFile{
	DArray<Setting> settings;
public:
	bool read(const char* fname);
	void create(const char* fname);
	void write(const char* fname);
	void get(const wchar_t* name, wchar_t* value);
	void set(const wchar_t* name, const wchar_t* value);
	void destroy();
	
};


#endif //CINI_H

