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
#include <cassert>


#include "Image.h"
#include "TextureLoader.h"
#include "Map.h"
#include "Utils.h"
#include "Button.h"
#include "CIniFile.h"


#ifdef WIN32
#ifdef _DEBUG
#include <crtdbg.h>
#endif
#endif


int SCREENW = 640;
int SCREENH = 480;

const unsigned PANEL_HEIGHT = 100;
const unsigned MAX_BUTTON = 100;
const unsigned TILE_STEP = 32;

const unsigned BUTTON_TILES_DEC = 25;
const unsigned BUTTON_TILES_INC = 26;
const unsigned BUTTON_FIRST_TILE = 27;
const unsigned BUTTON_SAVE = 18;
const unsigned BUTTON_SHOW_COLLISION = 11;

const unsigned BUTTON_PALETTE_0 = 8;
const unsigned BUTTON_PALETTE_1 = 15;
const unsigned BUTTON_PALETTE_2 = 16;
const unsigned BUTTON_PALETTE_3 = 17;

const unsigned BUTTON_SHOW_GRID = 2;

const unsigned TILE_BUTTONS_ORIGIN_X = 300;


const unsigned BUTTON_IMG = 1;

const char CHR_BASEPATH[] = "../src/";


Uint32 tick = 0;


PicsContainer pics;


bool _QuitApp = false;


Map map;


COLOR tempAttributeColors[4] = {COLOR(1.f, 1.f, 0, 0.2f),
                                COLOR(0, 0, 1.f, 0.2f),
                                COLOR(0, 1.f, 0, 0.2f),
                                COLOR(0, 1.f, 1.f, 0.2f)};


Mygtas mygtai[MAX_BUTTON];

Vector3D Cross;

int tilex,tiley;
bool SHOW_LEV1= true;
bool SELECT_LEV1= true;
bool SHOW_COLISSION= true;
bool SELECT_COLISSION= false;
bool SHOW_ATTRIBUTES = true;
bool SELECT_ATTRIBUTES = false;
bool SHOW_GRID = true;


unsigned char GlobalKey;
int oldmousekey,bm;
int mx,my;

unsigned char currenttile=0;
int currentchar = 0;
unsigned char firsttile = 0;

unsigned char currentPalette = 0;

int charsIDs[]={1,4,7,8};

CIniFile INI;

char MapTiles[256];
char Tileset[256];

unsigned char Palettes[48] = {
                              0,0,0, 50,50,50, 50,50,255, 128,128,255,
                              0,0,0, 0,128,128, 50,50,255, 128,128,255,
                              0,0,0, 180,128,50, 50,50,128, 128,128,255,
                              255,0,0, 255,128,0, 0,0,128, 255,255,255,
                             };

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
    DrawText (130, 92, "Grid", pics, 0, 0.7f);

    if ( SHOW_LEV1 )
    {
        mygtai[0].draw ( pics, BUTTON_IMG, 5 );
    }
    else
    {
        mygtai[0].draw ( pics, BUTTON_IMG, 4 );
    }

    if ( SHOW_ATTRIBUTES )
    {
        mygtai[1].draw ( pics, BUTTON_IMG, 5 );
    }
    else
    {
        mygtai[1].draw ( pics, BUTTON_IMG, 4 );
    }

    
    if ( SHOW_GRID )
        mygtai[BUTTON_SHOW_GRID].draw ( pics, BUTTON_IMG, 5 );
    else
        mygtai[BUTTON_SHOW_GRID].draw ( pics, BUTTON_IMG, 4 );

    if ( SHOW_COLISSION )
    {
        mygtai[BUTTON_SHOW_COLLISION].draw ( pics, BUTTON_IMG, 5 );
    }
    else
    {
        mygtai[BUTTON_SHOW_COLLISION].draw ( pics, BUTTON_IMG, 4 );
    }

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


    mygtai[BUTTON_PALETTE_0].draw(pics, -1, 0, 
                                  tempAttributeColors[0].c[0],
                                  tempAttributeColors[0].c[1],
                                  tempAttributeColors[0].c[2]);
    mygtai[BUTTON_PALETTE_1].draw(pics, -1, 0, 
                                  tempAttributeColors[1].c[0],
                                  tempAttributeColors[1].c[1],
                                  tempAttributeColors[1].c[2]);
    mygtai[BUTTON_PALETTE_2].draw(pics, -1, 0, 
                                  tempAttributeColors[2].c[0],
                                  tempAttributeColors[2].c[1],
                                  tempAttributeColors[2].c[2]);
    mygtai[BUTTON_PALETTE_3].draw(pics, -1, 0, 
                                  tempAttributeColors[3].c[0],
                                  tempAttributeColors[3].c[1],
                                  tempAttributeColors[3].c[2]);




    if ( SELECT_LEV1 )
        mygtai[6].draw ( pics, BUTTON_IMG, 0, 1.0f, 0,0 );
    else
        mygtai[6].draw ( pics, BUTTON_IMG, 0 );

    if ( SELECT_ATTRIBUTES )
    {
        mygtai[7].draw ( pics, BUTTON_IMG,1,1.0f,0,0 );
    }
    else
    {
        mygtai[7].draw ( pics, BUTTON_IMG,1 );
    }

    /*if ( SELECT_LEV3 )
        mygtai[8].draw ( pics,5,2,1.0f,0,0 );
    else
        mygtai[8].draw ( pics,5,2 );*/

    if ( SELECT_COLISSION )
        mygtai[12].draw ( pics, BUTTON_IMG, 3, 1.0f, 0, 0 );
    else
        mygtai[12].draw ( pics, BUTTON_IMG, 3 );

   /* if ( SELECT_ENT )
        mygtai[14].draw ( pics,5,8,1.0f,0,0 );
    else
        mygtai[14].draw ( pics,5,8 );*/

    for (unsigned i = BUTTON_FIRST_TILE; i < BUTTON_FIRST_TILE + TILE_STEP; ++i)
    {
        mygtai[i].draw ( pics, 3 + currentPalette, firsttile + (i - BUTTON_FIRST_TILE));
    }

    mygtai[BUTTON_TILES_DEC].draw ( pics, BUTTON_IMG, 6 );
    mygtai[BUTTON_TILES_INC].draw ( pics, BUTTON_IMG, 7 );


    /*mygtai[15].draw ( pics,5,6 );
    mygtai[16].draw ( pics,charsIDs[currentchar],0 );
    mygtai[17].draw ( pics,5,7 );*/


    mygtai[BUTTON_SAVE].draw ( pics, BUTTON_IMG, 9 );

}

//---------------------------------------------

void DrawGrid2D(Map& GMap, int shiftX, int shiftY){

         int count = 0;

         float * vertices = 0;


         vertices = new float[(GMap.width() + 1) * 4 + (GMap.height() + 1) * 4];

         glBindTexture(GL_TEXTURE_2D, 0);

         for (unsigned i = 0; i < GMap.width() + 1; i++){

            vertices[i * 4    ] = i * GMap.tileWidth() - shiftX;
            vertices[i * 4 + 1] = -shiftY;

            vertices[i * 4 + 2] = i * GMap.tileWidth() - shiftX;
            vertices[i * 4 + 3] = GMap.height() * GMap.tileWidth() - shiftY;

            count ++;
         }

         for (unsigned i = 0; i < GMap.height() + 1; i++){

            int index = (GMap.width() + 1) * 4 + i * 4;
            vertices[index] = -shiftX;
            vertices[index + 1] = i * GMap.tileWidth() - shiftY;

            vertices[index + 2] = GMap.width() * GMap.tileWidth() - shiftX;
            vertices[index + 3] = i * GMap.tileWidth() - shiftY;

            count ++;


         }


         glLoadIdentity();
         glEnableClientState(GL_VERTEX_ARRAY);

         glVertexPointer(2, GL_FLOAT, 0, vertices);

         glDrawArrays(GL_LINES, 0, count*2 );

         glDisableClientState(GL_VERTEX_ARRAY);

         delete []vertices;

    }



//-----------------------------------------------------------

static void RenderScreen ( void ){


    glClear ( GL_COLOR_BUFFER_BIT );

    if ( SHOW_LEV1 )
        map.draw ( pics, 3, SCREENW, SCREENH);

    if (SHOW_ATTRIBUTES)
    {

        for (unsigned a = 0; a < map.height(); a+=2 )
        {
            for (unsigned i = 0; i < map.width(); i+=2 )
            {
                unsigned index = map.getAttribute(i, a);
                //printf("%u %u: index %u\n", i,a,index);
                assert(index < 4);

                DrawBlock (pics, (int)(map.getMapPos().x()) - 16 + i * 32,
                            (int)(map.getMapPos().z()) - 16 + a * 32, 
                            64, 64,
                            tempAttributeColors[index],
                            tempAttributeColors[index]
                            );
            }
        }


    }

    if ( SHOW_COLISSION )
    {
        for (unsigned a = 0; a < map.height(); a++ )
        {
            for (unsigned i = 0; i < map.width(); i++ )
            {
                if ( map.colide ( i,a ) )
                {
                    DrawBlock (pics, (int)(map.getMapPos().x())-16+i*32,
                                (int)(map.getMapPos().z())-16+a*32, 
                                32, 32,
                                COLOR(1.0f, 0, 0, 0.5f),
                                COLOR(1.0f, 0, 0, 0.5f)
                                );
                }
            }
        }
    }


    if (SHOW_GRID)
    {
        pics.drawBatch(0, 0, 666);  //  draw sprite batch

        DrawGrid2D(map, -1 * (int)map.getMapPos().x() + 16, -1 * (int)map.getMapPos().z() + 16);
    }

    DrawPanel();

    pics.draw ( 2, Cross.x(),Cross.z() );


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


    pics.loadFile(Tileset, 3, 1, 8, CHR_BASEPATH, 0, Palettes, 0);
    pics.loadFile(Tileset, 4, 1, 8, CHR_BASEPATH, 0, Palettes, 1);
    pics.loadFile(Tileset, 5, 1, 8, CHR_BASEPATH, 0, Palettes, 2);
    pics.loadFile(Tileset, 6, 1, 8, CHR_BASEPATH, 0, Palettes, 3);


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
        if ( Cross.z() > PANEL_HEIGHT )
        {
            tilex= ( (int)(Cross.x()-map.getMapPos().x()) +16 ) /32;
            tiley= ( (int)(Cross.z()-map.getMapPos().z()) +16 ) /32;
        }
    }

    if ( Cross.z() > PANEL_HEIGHT )
    {
        if ( ( bm & SDL_BUTTON ( 1 ) ) )
        {
            if ( SELECT_LEV1 )
            {
                map.setTile(tilex, tiley, currenttile);
            }

            if (SELECT_ATTRIBUTES)
            {
                map.setAttribute(tilex, tiley, currentPalette);
            }

            if ( SELECT_COLISSION )
            {
                map.setCollision ( tilex,tiley,true );
            }

        }

        
        if ( ( bm & SDL_BUTTON ( 3 ) ) )
        {
            if ( SELECT_LEV1 )
            {
                map.setTile ( tilex, tiley, 0 );
            }

            if (SELECT_ATTRIBUTES)
            {
                map.setAttribute(tilex, tiley, 0);
            }

        }

    }
    else
    {


        if ( ( !bm ) && ( oldmousekey & SDL_BUTTON ( 1 ) ) )
        {
            if ( ( mygtai[0].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SHOW_LEV1 = !SHOW_LEV1;
            }

            if ( ( mygtai[BUTTON_SHOW_GRID].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SHOW_GRID = !SHOW_GRID;
            }


            if ( ( mygtai[11].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SHOW_COLISSION = !SHOW_COLISSION;
            }

            for (unsigned i = BUTTON_FIRST_TILE; i < BUTTON_FIRST_TILE + TILE_STEP; ++i)
            {
                if ( ( mygtai[i].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                {
                    currenttile = firsttile + (i - BUTTON_FIRST_TILE);
                }
            }

            if ( ( mygtai[6].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SELECT_LEV1 = !SELECT_LEV1;
            }

            if ( ( mygtai[1].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SHOW_ATTRIBUTES = !SHOW_ATTRIBUTES;
            }
            

            if ( ( mygtai[7].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SELECT_ATTRIBUTES = !SELECT_ATTRIBUTES;
            }


            if (mygtai[BUTTON_PALETTE_0].pointerOntop((int)Cross.x(), (int)Cross.z()))
            {
                currentPalette = 0;
            }

            if (mygtai[BUTTON_PALETTE_1].pointerOntop((int)Cross.x(), (int)Cross.z()))
            {
                currentPalette = 1;
            }

            if (mygtai[BUTTON_PALETTE_2].pointerOntop((int)Cross.x(), (int)Cross.z()))
            {
                currentPalette = 2;
            }

            if (mygtai[BUTTON_PALETTE_3].pointerOntop((int)Cross.x(), (int)Cross.z()))
            {
                currentPalette = 3;
            }





   
            if ( ( mygtai[12].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                SELECT_COLISSION = !SELECT_COLISSION;
            }

      
            if ( ( mygtai[BUTTON_TILES_DEC].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                if (firsttile < TILE_STEP)
                {
                    firsttile = 0;
                }
                else
                {
                    //if ( firsttile - TILE_STEP >= 0 )
                        firsttile -= TILE_STEP;
                }
            }

            if ( ( mygtai[BUTTON_TILES_INC].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
            {
                if ( firsttile + TILE_STEP <= 255 )
                {
                    firsttile += TILE_STEP;
                }
            }

            if ( ( mygtai[15].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( currentchar>0 )
                    currentchar--;
            if ( ( mygtai[17].pointerOntop ( (int)Cross.x(), (int)Cross.z() ) ) )
                if ( currentchar<3 )
                    currentchar++;
      
           
            if ( ( mygtai[BUTTON_SAVE].pointerOntop ( (int)Cross.x(),(int)Cross.z() ) ) )
            {
                map.save (MapTiles);
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
    {
        SCREENW = 640;
    }

    INI.get ( L"height",buf );
    wcstombs(abuf,buf,255);
    SCREENH = atoi ( abuf );

    if ( !SCREENH )
    {
        SCREENH = 480;
    }

    INI.get(L"tileSet", buf);
    wcstombs(Tileset, buf, 255);

    INI.get ( L"mapTiles",buf );
    wcstombs ( MapTiles, buf, 255 );


    mygtai[0].init ( 10,20,32,32 );
    mygtai[1].init ( 46,20,32,32 );
    mygtai[BUTTON_SHOW_GRID].init ( 130,55,32,32 );
    mygtai[BUTTON_SHOW_COLLISION].init ( 82,20,32,32 );
    mygtai[13].init ( 154,20,32,32 );

    mygtai[6].init ( 10,55,32,32 );
    mygtai[7].init ( 46,55,32,32 );
    mygtai[14].init ( 154,55,32,32 );


   
    mygtai[BUTTON_PALETTE_0].init ( 130,20,32,32 );
    mygtai[BUTTON_PALETTE_1].init ( 166,20,32,32 );
    mygtai[BUTTON_PALETTE_2].init ( 202,20,32,32 );
    mygtai[BUTTON_PALETTE_3].init ( 238,20,32,32 );

    mygtai[BUTTON_SAVE].init ( SCREENW - 42, 20, 32, 32 );


    mygtai[19].init ( 460,20,32,32 );
    mygtai[20].init ( 496,20,32,32 );
    mygtai[21].init ( 532,20,32,32 );
    mygtai[22].init ( 460,55,32,32 );
    mygtai[23].init ( 496,55,32,32 );
    mygtai[24].init ( 532,55,32,32 );

    mygtai[BUTTON_TILES_DEC].init ( TILE_BUTTONS_ORIGIN_X, 55,32,32 );

    unsigned tileRow = 0;
    for (unsigned i = BUTTON_FIRST_TILE; i < BUTTON_FIRST_TILE + TILE_STEP; ++i)
    {
        mygtai[i].init(TILE_BUTTONS_ORIGIN_X + 40 + (i - BUTTON_FIRST_TILE - (16 * tileRow)) * 34, 10 + tileRow * 34, 32, 32);
        
        if (((i - BUTTON_FIRST_TILE) + 1) % 16 == 0 && (i - BUTTON_FIRST_TILE) > 0)
        {
            ++tileRow;
        }
    }
    
    mygtai[BUTTON_TILES_INC].init ( TILE_BUTTONS_ORIGIN_X + 48 + 16 * 34,55,32,32 );



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



    if ( !map.load(MapTiles) )
    {
        _QuitApp = true;
        printf("Error loading map %s !\n", MapTiles);
    }

    printf("\nStarting loop\n");
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



