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


#ifdef WIN32
#pragma comment(lib,"SDL.lib")
#pragma comment(lib,"SDLmain.lib")
#pragma comment(lib,"OpenGl32.lib")
#pragma comment(lib,"GLU32.lib")
#endif
//--------------------------------------


#ifdef WIN32
    #ifdef _MSC_VER
        #include <SDL.h>
        #include <SDL_opengl.h>
    #else
        #include <SDL/SDL.h>
        #include <SDL/SDL_opengl.h>
    #endif
#else
    #include <SDL/SDL.h>
    #include <SDL/SDL_opengl.h>
#endif





#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <cmath>


#include "Image.h"
#include "TextureLoader.h"
#include "Map.h"
#include "Utils.h"
#include "mygtas.h"
#include "CIniFile.h"


#ifdef WIN32
#ifdef _DEBUG
#include <crtdbg.h>
#endif
#endif


int SCREENW = 640;
int SCREENH = 480;

Uint32 tick = 0;


PicsContainer pics;


bool _QuitApp = false;


Map map;


Mygtas mygtai[30];

Vector3D Cross;

int tilex,tiley;
bool SHOW_LEV1= true;
bool SELECT_LEV1= true;
bool SHOW_COL= true;
bool SELECT_COL= false;


unsigned char GlobalKey;
int oldmousekey,bm;
int mx,my;

unsigned char currenttile=0;
int currentchar = 0;
unsigned char firsttile=0;

int charsIDs[]={1,4,7,8};

CIniFile INI;

char MapTilesIn[255];
char MapCollisionIn[255];
char MapTilesOut[255];
char MapCollisionOut[255];


//=======================================================================

static void QuitApp()
{

    _QuitApp = true;

}

//----------------------------------------------------------

static void process_events ( void ){

    SDL_Event event;

    while ( SDL_PollEvent ( &event ) )
    {

        switch ( event.type ){
            case SDL_KEYDOWN:
                switch ( event.key.keysym.sym ){
                    case SDLK_ESCAPE:{
                        QuitApp();
                    }
                    break;
                    default:{}
                }
                break;
            case SDL_QUIT:

                QuitApp();
                break;
            default:{}
        }

    }

}

//------------------------------------------------------
int FPS ( void )
{
    static int time = 0, FPS = 0, frames = 0, frames0 = 0;
    if ( ( int ) SDL_GetTicks() >= time )
    {
        FPS = frames-frames0;
        time = SDL_GetTicks() +1000;
        frames0 = frames;
    }
    frames = frames+1;
    return FPS;
}

//-------------------------------------------
void DrawPanel(){

    DrawBlock (pics, 0, 0, SCREENW, 100,
                COLOR(0, 0, 1, 0.5f),
                COLOR(0, 0, 1, 0.5f)
                );
    char buf[100];
    sprintf ( buf,"FPS: %d ",FPS() );
    DrawText ( SCREENW-128,10,buf,pics,0,0.7f );

    sprintf ( buf,"tilex:%d tiley:%d ",tilex, tiley );
    DrawText ( 10,10,buf,pics,0, 0.7f );

    if ( SHOW_LEV1 )
        mygtai[0].draw ( pics,2, 5 );
    else
        mygtai[0].draw ( pics,2, 4 );

    /*if ( SHOW_LEV2 )
        mygtai[1].draw ( pics,5,5 );
    else
        mygtai[1].draw ( pics,5,4 );

    if ( SHOW_LEV3 )
        mygtai[2].draw ( pics,5,5 );
    else
        mygtai[2].draw ( pics,5,4 );*/

    if ( SHOW_COL )
        mygtai[11].draw ( pics,2, 5 );
    else
        mygtai[11].draw ( pics,2, 4 );

   /* if ( SHOW_DUDE )
        mygtai[19].draw ( pics,5,5 );
    else
        mygtai[19].draw ( pics,5,4 );

    if ( SHOW_PD )
        mygtai[20].draw ( pics,5,5 );
    else
        mygtai[20].draw ( pics,5,4 );

    if ( SHOW_SLAUGHTER )
        mygtai[21].draw ( pics,5,5 );
    else
        mygtai[21].draw ( pics,5,4 );

    if ( SELECT_DUDE )
        mygtai[22].draw ( pics,3,0,1.0f,0,0 );
    else
        mygtai[22].draw ( pics,3,0 );

    if ( SELECT_PD )
        mygtai[23].draw ( pics,5,10,1.0f,0,0 );
    else
        mygtai[23].draw ( pics,5, 10 );

    if ( SELECT_SLAUGHTER )
        mygtai[24].draw ( pics,5,11,1.0f,0,0 );
    else
        mygtai[24].draw ( pics,5,11 );

    if ( SHOW_ENTITIES )
        mygtai[13].draw ( pics,5,5 );
    else
        mygtai[13].draw ( pics,5,4 );*/

    if ( SELECT_LEV1 )
        mygtai[6].draw ( pics,2,0,1.0f,0,0 );
    else
        mygtai[6].draw ( pics,2, 0 );

   /* if ( SELECT_LEV2 )
        mygtai[7].draw ( pics,5,1,1.0f,0,0 );
    else
        mygtai[7].draw ( pics,5,1 );

    if ( SELECT_LEV3 )
        mygtai[8].draw ( pics,5,2,1.0f,0,0 );
    else
        mygtai[8].draw ( pics,5,2 );*/

    if ( SELECT_COL )
        mygtai[12].draw ( pics,2, 3,1.0f,0,0 );
    else
        mygtai[12].draw ( pics,2, 3 );

   /* if ( SELECT_ENT )
        mygtai[14].draw ( pics,5,8,1.0f,0,0 );
    else
        mygtai[14].draw ( pics,5,8 );*/

    mygtai[3].draw ( pics,1,firsttile );
    mygtai[4].draw ( pics,1,firsttile+1 );
    mygtai[5].draw ( pics,1,firsttile+2 );

    mygtai[9].draw ( pics,2,6 );
    mygtai[10].draw ( pics,2,7 );


    /*mygtai[15].draw ( pics,5,6 );
    mygtai[16].draw ( pics,charsIDs[currentchar],0 );
    mygtai[17].draw ( pics,5,7 );*/


    mygtai[18].draw ( pics,2,9 );

}

//-----------------------------------------------------------

static void RenderScreen ( void ){


    glClear ( GL_COLOR_BUFFER_BIT );

    if ( SHOW_LEV1 )
        map.draw ( pics, 1, SCREENW, SCREENH);

    if ( SHOW_COL )
    {
        for (unsigned a = 0; a < map.height(); a++ )
            for (unsigned i = 0; i < map.width(); i++ )
                if ( map.colide ( i,a ) )
                    DrawBlock (pics, (int)(map.getMapPos().x())-16+i*32,
                                (int)(map.getMapPos().z())-16+a*32, 
                                32, 32,
                                COLOR(1.0f, 0, 0, 0.5f),
                                COLOR(1.0f, 0, 0, 0.5f)
                                );
    }

    

    DrawPanel();
    pics.draw ( 3, Cross.x(),Cross.z() );

    pics.draw(4, 0, 0);


    pics.drawBatch(0, 0, 666);


    //glDisable ( GL_BLEND );

    glFlush();

    //----------------------

    SDL_GL_SwapBuffers( );
}








//--------------------------------------------------------
static void SetupOpengl ( int width, int height )
{


    glEnable ( GL_TEXTURE_2D );


    glDisable ( GL_DEPTH_TEST );
    glDisable ( GL_LIGHTING );
    glDisable ( GL_DITHER );

    glMatrixMode ( GL_PROJECTION );
    glLoadIdentity ();

    gluOrtho2D ( 0.0, ( GLdouble ) SCREENW, ( GLdouble ) SCREENH, 0.0 );

    glMatrixMode ( GL_MODELVIEW );
    glPushMatrix();
    glLoadIdentity();
    glTranslatef ( 0.375, 0.375, 0. );

    glPushAttrib ( GL_DEPTH_BUFFER_BIT );

    glClearColor ( 0, 0, 0, 1.0 );
    glEnable ( GL_BLEND );
    glBlendFunc ( GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA );


    if (!pics.load ( "pics/clist.txt" )){
        puts("Cannot find picture list!");
        _QuitApp = true;
    }





}





//----------------------------------------------------------------

void CheckKeys()
{
    Uint8 * keys;
    keys = SDL_GetKeyState ( NULL );

    oldmousekey = bm;
    bm = SDL_GetMouseState ( &mx,&my );

    //------------------------------
    GlobalKey = 0;
    if ( keys[SDLK_UP] == SDL_PRESSED )
        GlobalKey = 38;
    if ( keys[SDLK_DOWN] == SDL_PRESSED )
        GlobalKey = 40;
    if ( keys[SDLK_RETURN] == SDL_PRESSED )
        GlobalKey = 13;


    //------------------------------

    if ( keys[SDLK_UP] )
    {
        Vector3D v ( 0, 0, 1.0f );
        map.move ( v, 2.0f );
    }
    if ( keys[SDLK_LEFT] )
    {
        Vector3D v ( 1.0f,0,0 );
        map.move ( v, 2.0f );
    }
    if ( keys[SDLK_DOWN] )
    {
        Vector3D v ( 0,0,-1.0f );
        map.move ( v, 2.0f );
    }
    if ( keys[SDLK_RIGHT] )
    {
        Vector3D v ( -1.0f,0,0 );
        map.move ( v, 2.0f );
    }



    if ( ( mx<SCREENW ) && ( mx>0 )
            && ( my<SCREENH ) && ( my>0 ) )
    {
        Cross.set ( mx,0,my );
        if ( Cross.z() >100 )
        {
            tilex= ( (int)(Cross.x()-map.getMapPos().x()) +16 ) /32;
            tiley= ( (int)(Cross.z()-map.getMapPos().z()) +16 ) /32;
        }
    }

    if ( Cross.z() >100 )
    {
        if ( ( bm & SDL_BUTTON ( 1 ) ) )
        {
            if ( SELECT_LEV1 )
                map.setTile ( tilex,tiley,currenttile+1 );
            if ( SELECT_COL )
                map.setCollision ( tilex,tiley,true );

        }

        
        if ( ( bm & SDL_BUTTON ( 3 ) ) )
        {
            if ( SELECT_LEV1 )
                map.setTile ( tilex,tiley,0 );
            if ( SELECT_COL )
                map.setCollision ( tilex,tiley,false );
        }

    }
    else
    {


        if ( ( !bm ) && ( oldmousekey & SDL_BUTTON ( 1 ) ) )
        {
            if ( ( mygtai[0].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                SHOW_LEV1 = !SHOW_LEV1;
            if ( ( mygtai[11].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                SHOW_COL = !SHOW_COL;
           
            if ( ( mygtai[3].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                currenttile = firsttile;
            if ( ( mygtai[4].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                currenttile = firsttile+1;
            if ( ( mygtai[5].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                currenttile = firsttile+2;

            if ( ( mygtai[6].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                SELECT_LEV1 = !SELECT_LEV1;

   
            if ( ( mygtai[12].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                SELECT_COL = !SELECT_COL;

      
            if ( ( mygtai[9].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( firsttile>0 )
                    firsttile--;

            if ( ( mygtai[10].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( firsttile+3<pics.getInfo ( 2 )->htileh*pics.getInfo ( 2 )->htilew )
                    firsttile++;
            if ( ( mygtai[15].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( currentchar>0 )
                    currentchar--;
            if ( ( mygtai[17].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( currentchar<3 )
                    currentchar++;
      
           
            if ( ( mygtai[18].pointerOntop ( (int)Cross.x(),(int)Cross.z() ) ) )
            {
                map.save (MapTilesOut, MapCollisionOut);
            }

        }



    }



}

//-----------------------------------------------------------------
int main ( int argc, char* argv[] )
{

    srand ( time ( 0 ) );

    INI.read ( "nesed.ini" );
    wchar_t buf[255];
    char abuf[255];
    INI.get ( L"width",buf );
    wcstombs(abuf,buf,255);
    SCREENW = atoi ( abuf );
    if ( !SCREENW )
        SCREENW = 640;
    INI.get ( L"height",buf );
    wcstombs(abuf,buf,255);
    SCREENH = atoi ( abuf );
    if ( !SCREENH )
        SCREENH = 480;
    INI.get ( L"mapTilesIN",buf );
    wcstombs ( MapTilesIn,buf,255 );
    INI.get ( L"mapCollisionIN",buf );
    wcstombs ( MapCollisionIn,buf,255 );

    INI.get ( L"mapTilesOUT",buf );
    wcstombs ( MapTilesOut,buf,255 );
    INI.get ( L"mapCollisionOUT",buf );
    wcstombs ( MapCollisionOut,buf,255 );




    mygtai[0].init ( 10,20,32,32 );
    mygtai[1].init ( 46,20,32,32 );
    mygtai[2].init ( 82,20,32,32 );
    mygtai[11].init ( 118,20,32,32 );
    mygtai[13].init ( 154,20,32,32 );

    mygtai[6].init ( 10,55,32,32 );
    mygtai[7].init ( 46,55,32,32 );
    mygtai[8].init ( 82,55,32,32 );
    mygtai[12].init ( 118,55,32,32 );
    mygtai[14].init ( 154,55,32,32 );


    mygtai[9].init ( 204,55,32,32 );
    mygtai[3].init ( 250,55,32,32 );
    mygtai[4].init ( 296,55,32,32 );
    mygtai[5].init ( 332,55,32,32 );
    mygtai[10].init ( 378,55,32,32 );

    mygtai[15].init ( 204,20,32,32 );
    mygtai[16].init ( 250,20,32,32 );
    mygtai[17].init ( 296,20,32,32 );

    mygtai[18].init ( 580,20,32,32 );


    mygtai[19].init ( 460,20,32,32 );
    mygtai[20].init ( 496,20,32,32 );
    mygtai[21].init ( 532,20,32,32 );
    mygtai[22].init ( 460,55,32,32 );
    mygtai[23].init ( 496,55,32,32 );
    mygtai[24].init ( 532,55,32,32 );


    const SDL_VideoInfo* info = NULL;

    int width = 0;
    int height = 0;
    int bpp = 0;

    // Flags we will pass into SDL_SetVideoMode.
    int flags = 0;

    // First, initialize SDL's video subsystem.
    puts ( "Trying SDL_INIT..." );
    if ( SDL_Init ( SDL_INIT_VIDEO ) < 0 )
    {

        fprintf ( stderr, "Video initialization failed: %s\n",
                  SDL_GetError( ) );
        QuitApp();
    }
    puts ( "SDL_INIT succsess!" );

    // Let's get some video information.
    info = SDL_GetVideoInfo( );

    if ( !info )
    {
        // This should probably never happen.
        fprintf ( stderr, "Video query failed: %s\n",
                  SDL_GetError( ) );
        QuitApp();
    }


    width = SCREENW;
    height = SCREENH;
    bpp = info->vfmt->BitsPerPixel;

    SDL_GL_SetAttribute ( SDL_GL_DOUBLEBUFFER, 1 );


    flags = SDL_OPENGL;//| SDL_FULLSCREEN;

    if ( SDL_SetVideoMode ( width, height, bpp, flags ) == 0 )
    {

        fprintf ( stderr, "Video mode set failed: %s\n",
                  SDL_GetError( ) );
        QuitApp();
    }

    SDL_ShowCursor ( 0 );
    SDL_WM_SetCaption ( "NESED", "SATAN" );

    SetupOpengl ( width, height );



    if ( !map.load(MapTilesIn, MapCollisionIn) )
    {
        _QuitApp = true;
        printf("Error loading maps %s %s !\n", MapTilesIn, MapCollisionIn);
    }

    while ( !_QuitApp )
    {



        if ( SDL_GetTicks() > tick )
        {


            CheckKeys();
            RenderScreen();


            tick = SDL_GetTicks() +11;
        }


        else SDL_Delay ( 1 );

        process_events();
    }





    pics.destroy();
    map.destroy();

    SDL_Quit();

#ifdef WIN32
#ifdef _DEBUG
    _CrtDumpMemoryLeaks();
#endif
#endif


    return 0;
}



