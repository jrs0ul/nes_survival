
;lookup table for framelist indexes in npc_data
frame_list_index_lookup:
    .byte 6  ; dogman
    .byte 14 ; bunny
    .byte 22 ; bjorn
    .byte 30 ; canid
    .byte 38 ; erika
    .byte 46 ; granny
    .byte 54 ; deadman
    .byte 62 ; boar
    .byte 70 ; boss
    .byte 78 ; spider
    .byte 86 ; slimer
    .byte 94 ; baraka
    .byte 102; cat

;Cat
npc_CAT_frames:
    .byte <npc_CAT_frame_LEFT,  >npc_CAT_frame_LEFT
    .byte <npc_CAT_frame_RIGHT, >npc_CAT_frame_RIGHT
    .byte <npc_CAT_frame_UP,    >npc_CAT_frame_UP
    .byte <npc_CAT_frame_DOWN,  >npc_CAT_frame_DOWN

npc_CAT_frame_LEFT:
    .byte <npc_CAT_frame_LEFT_0,   >npc_CAT_frame_LEFT_0
    .byte <npc_CAT_frame_LEFT_1,   >npc_CAT_frame_LEFT_1
    .byte <npc_CAT_frame_LEFT_2,   >npc_CAT_frame_LEFT_2
    .byte <npc_CAT_frame_LEFT_1,   >npc_CAT_frame_LEFT_1
    .byte                     0,   0
    .byte                     0,   0
    .byte                     0,   0

npc_CAT_frame_LEFT_0:

    .byte    0,$d6,0, 0
    .byte    0,$da,0, 8
    .byte    8,$e9,0, 0
    .byte    8,$ea,0, 8

npc_CAT_frame_LEFT_1:
    .byte    0,$d1,0, 0
    .byte    0,$d2,0, 8
    .byte    8,$e1,0, 0
    .byte    8,$e2,0, 8

npc_CAT_frame_LEFT_2:
    .byte    0,$d6,0, 0
    .byte    0,$d7,0, 8
    .byte    8,$e6,0, 0
    .byte    8,$e7,0, 8


npc_CAT_frame_RIGHT:
    .byte <npc_CAT_frame_RIGHT_0,   >npc_CAT_frame_RIGHT_0
    .byte <npc_CAT_frame_RIGHT_1,   >npc_CAT_frame_RIGHT_1
    .byte <npc_CAT_frame_RIGHT_2,   >npc_CAT_frame_RIGHT_2
    .byte <npc_CAT_frame_RIGHT_1,   >npc_CAT_frame_RIGHT_1
    .byte                     0,   0
    .byte                     0,   0
    .byte                     0,   0

npc_CAT_frame_RIGHT_0:
    .byte    0,$d7,%01000000, 0
    .byte    0,$d1,%01000000, 8
    .byte    8,$e7,%01000000, 0
    .byte    8,$e6,%01000000, 8

npc_CAT_frame_RIGHT_1:
    .byte    0,$d2,%01000000, 0
    .byte    0,$d1,%01000000, 8
    .byte    8,$e2,%01000000, 0
    .byte    8,$e1,%01000000, 8

npc_CAT_frame_RIGHT_2:
    .byte    0,$da,%01000000, 0
    .byte    0,$d1,%01000000, 8
    .byte    8,$ea,%01000000, 0
    .byte    8,$e9,%01000000, 8


npc_CAT_frame_UP:
    .byte <npc_CAT_frame_UP_0,   >npc_CAT_frame_UP_0
    .byte <npc_CAT_frame_UP_1,   >npc_CAT_frame_UP_1
    .byte <npc_CAT_frame_UP_2,   >npc_CAT_frame_UP_2
    .byte <npc_CAT_frame_UP_1,   >npc_CAT_frame_UP_1
    .byte                     0,   0
    .byte                     0,   0
    .byte                     0,   0

npc_CAT_frame_UP_0:
    .byte    0,$d8,0        , 0
    .byte    0,$d9,0        , 8
    .byte    8,$e8,0        , 0
    .byte    8,$e3,%01000000, 8

npc_CAT_frame_UP_1:
    .byte    0,$d3,0        , 0
    .byte    0,$d3,%01000000, 8
    .byte    8,$e3,0        , 0
    .byte    8,$e3,%01000000, 8

npc_CAT_frame_UP_2:
    .byte    0,$d9,%01000000, 0
    .byte    0,$d8,%01000000, 8
    .byte    8,$e3,0        , 0
    .byte    8,$e8,%01000000, 8


npc_CAT_frame_DOWN:
    .byte <npc_CAT_frame_DOWN_0,   >npc_CAT_frame_DOWN_0
    .byte <npc_CAT_frame_DOWN_1,   >npc_CAT_frame_DOWN_1
    .byte <npc_CAT_frame_DOWN_2,   >npc_CAT_frame_DOWN_2
    .byte <npc_CAT_frame_DOWN_1,   >npc_CAT_frame_DOWN_1
    .byte                     0,   0
    .byte                     0,   0
    .byte                     0,   0

npc_CAT_frame_DOWN_0:
    .byte    0,$d4,0, 0
    .byte    0,$d5,0, 8
    .byte    8,$e4,0, 0
    .byte    8,$e5,0, 8

npc_CAT_frame_DOWN_1:
    .byte     0,$d0,0        ,0
    .byte     0,$d0,%01000000,8
    .byte     8,$e0,0        ,0
    .byte     8,$e0,%01000000,8

npc_CAT_frame_DOWN_2:
    .byte    0,$d5,%01000000, 0
    .byte    0,$d4,%01000000, 8
    .byte    8,$e5,%01000000, 0
    .byte    8,$e4,%01000000, 8



;===============================================
;Bunny

npc_BUNNY_frames:
    .byte <npc_BUNNY_frame_LEFT,  >npc_BUNNY_frame_LEFT
    .byte <npc_BUNNY_frame_RIGHT, >npc_BUNNY_frame_RIGHT
    .byte <npc_BUNNY_frame_UP,    >npc_BUNNY_frame_UP
    .byte <npc_BUNNY_frame_DOWN,  >npc_BUNNY_frame_DOWN


npc_BUNNY_frame_DTH:
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $3C, %00000000, 0
    .byte 8, $3D, %00000000, 8

npc_BUNNY_frame_LEFT:
    .byte <npc_BUNNY_frame_LEFT_0,   >npc_BUNNY_frame_LEFT_0
    .byte <npc_BUNNY_frame_LEFT_1,   >npc_BUNNY_frame_LEFT_1
    .byte <npc_BUNNY_frame_LEFT_0,   >npc_BUNNY_frame_LEFT_0
    .byte <npc_BUNNY_frame_LEFT_1,   >npc_BUNNY_frame_LEFT_1
    .byte                       0,   0
    .byte                       0,   0
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH


npc_BUNNY_frame_LEFT_0:
    .byte 0, $F2, %00000000, 0
    .byte 0, $F3, %00000000, 8
    .byte 8, $D3, %00000000, 0
    .byte 8, $D4, %00000000, 8

npc_BUNNY_frame_LEFT_1:
    .byte 0, $E2, %00000000, 0
    .byte 0, $E3, %00000000, 8
    .byte 8, $E0, %00000000, 0
    .byte 8, $E1, %00000000, 8


npc_BUNNY_frame_RIGHT:
    .byte <npc_BUNNY_frame_RIGHT_0,  >npc_BUNNY_frame_RIGHT_0
    .byte <npc_BUNNY_frame_RIGHT_1,  >npc_BUNNY_frame_RIGHT_1
    .byte <npc_BUNNY_frame_RIGHT_0,  >npc_BUNNY_frame_RIGHT_0
    .byte <npc_BUNNY_frame_RIGHT_1,  >npc_BUNNY_frame_RIGHT_1
    .byte                        0,  0
    .byte                        0,  0
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH


npc_BUNNY_frame_RIGHT_0:
    .byte 0, $F3, %01000000, 0 ;must be 0
    .byte 0, $F2, %01000000, 8 ;must be 8, because second sprite can be skipped
    .byte 8, $D4, %01000000, 0
    .byte 8, $D3, %01000000, 8

npc_BUNNY_frame_RIGHT_1:
    .byte 0, $E3, %01000000, 0
    .byte 0, $E2, %01000000, 8
    .byte 8, $E1, %01000000, 0
    .byte 8, $E0, %01000000, 8


npc_BUNNY_frame_UP:
    .byte <npc_BUNNY_frame_UP_0,  >npc_BUNNY_frame_UP_0
    .byte <npc_BUNNY_frame_UP_1,  >npc_BUNNY_frame_UP_1
    .byte <npc_BUNNY_frame_UP_0,  >npc_BUNNY_frame_UP_0
    .byte <npc_BUNNY_frame_UP_1,  >npc_BUNNY_frame_UP_1
    .byte                     0,  0
    .byte                     0,  0
    .byte <npc_BUNNY_frame_DTH,   >npc_BUNNY_frame_DTH

npc_BUNNY_frame_UP_0:
    .byte 0, $D2, %00000000, 0
    .byte 0, $D2, %01000000, 8
    .byte 8, $D1, %00000000, 0
    .byte 8, $D1, %01000000, 8

npc_BUNNY_frame_UP_1:
    .byte 0, $F0, %00000000, 0
    .byte 0, $F0, %01000000, 8
    .byte 8, $F4, %00000000, 0
    .byte 8, $F4, %01000000, 8


npc_BUNNY_frame_DOWN:
    .byte <npc_BUNNY_frame_DOWN_0,  >npc_BUNNY_frame_DOWN_0
    .byte <npc_BUNNY_frame_DOWN_1,  >npc_BUNNY_frame_DOWN_1
    .byte <npc_BUNNY_frame_DOWN_0,  >npc_BUNNY_frame_DOWN_0
    .byte <npc_BUNNY_frame_DOWN_1,  >npc_BUNNY_frame_DOWN_1
    .byte                       0,  0
    .byte                       0,  0
    .byte <npc_BUNNY_frame_DTH,     >npc_BUNNY_frame_DTH

npc_BUNNY_frame_DOWN_0:
    .byte 0, $D2, %00000000, 0
    .byte 0, $D2, %01000000, 8
    .byte 8, $D0, %00000000, 0
    .byte 8, $D0, %01000000, 8

npc_BUNNY_frame_DOWN_1:
    .byte 0, $F1, %00000000, 0
    .byte 0, $F1, %01000000, 8
    .byte 8, $F5, %00000000, 0
    .byte 8, $F5, %01000000, 8


;=============================================
npc_SLIMER_frames:
    .byte <npc_SLIMER_frame_LEFT,  >npc_SLIMER_frame_LEFT
    .byte <npc_SLIMER_frame_RIGHT, >npc_SLIMER_frame_RIGHT
    .byte <npc_SLIMER_frame_UP,    >npc_SLIMER_frame_UP
    .byte <npc_SLIMER_frame_DOWN,  >npc_SLIMER_frame_DOWN

npc_SLIMER_frame_DTH:
    .byte   0,$3a,0        ,  0
    .byte   0,$3b,%01000000,  8
    .byte   0,$3b,0        , 16
    .byte   8,$3c,0        ,  0
    .byte   8,$3d,0        ,  8
    .byte   8,$3d,0        , 16


npc_SLIMER_frame_LEFT:
    .byte <npc_SLIMER_frame_LEFT_0,   >npc_SLIMER_frame_LEFT_0
    .byte <npc_SLIMER_frame_LEFT_1,   >npc_SLIMER_frame_LEFT_1
    .byte <npc_SLIMER_frame_LEFT_0,   >npc_SLIMER_frame_LEFT_0
    .byte <npc_SLIMER_frame_LEFT_1,   >npc_SLIMER_frame_LEFT_1
    .byte <npc_SLIMER_frame_LEFT_WRN, >npc_SLIMER_frame_LEFT_WRN ; warning
    .byte <npc_SLIMER_frame_LEFT_1,   >npc_SLIMER_frame_LEFT_1
    .byte <npc_SLIMER_frame_DTH,      >npc_SLIMER_frame_DTH

npc_SLIMER_frame_LEFT_0:
    .byte   0,$d3,0,  0
    .byte   0,$d4,0,  8
    .byte   0,$d5,0, 16
    .byte   8,$e3,0,  0
    .byte   8,$e4,0,  8
    .byte   8,$e5,0, 16

npc_SLIMER_frame_LEFT_1:
    .byte   0,$a0,0,  0
    .byte   0,$a1,0,  8
    .byte   0,$a2,0, 16
    .byte   8,$b0,0,  0
    .byte   8,$b1,0,  8
    .byte   8,$b2,0, 16

npc_SLIMER_frame_LEFT_WRN:
    .byte   0,$f3,0,  0
    .byte   0,$f4,0,  8
    .byte   0,$a2,0, 16
    .byte   8,$f5,0,  0
    .byte   8,$f6,0,  8
    .byte   8,$b2,0, 16

npc_SLIMER_frame_RIGHT:
    .byte <npc_SLIMER_frame_RIGHT_0,   >npc_SLIMER_frame_RIGHT_0
    .byte <npc_SLIMER_frame_RIGHT_1,   >npc_SLIMER_frame_RIGHT_1
    .byte <npc_SLIMER_frame_RIGHT_0,   >npc_SLIMER_frame_RIGHT_0
    .byte <npc_SLIMER_frame_RIGHT_1,   >npc_SLIMER_frame_RIGHT_1
    .byte <npc_SLIMER_frame_RIGHT_WRN, >npc_SLIMER_frame_RIGHT_WRN ; warning
    .byte <npc_SLIMER_frame_RIGHT_1,   >npc_SLIMER_frame_RIGHT_1
    .byte <npc_SLIMER_frame_DTH,       >npc_SLIMER_frame_DTH

npc_SLIMER_frame_RIGHT_0:
    .byte   0,$d5,%01000000,  0
    .byte   0,$d4,%01000000,  8
    .byte   0,$d3,%01000000, 16
    .byte   8,$e5,%01000000,  0
    .byte   8,$e4,%01000000,  8
    .byte   8,$e3,%01000000, 16

npc_SLIMER_frame_RIGHT_1:
    .byte   0,$a2,%01000000,  0
    .byte   0,$a1,%01000000,  8
    .byte   0,$a0,%01000000, 16
    .byte   8,$b2,%01000000,  0
    .byte   8,$b1,%01000000,  8
    .byte   8,$b0,%01000000, 16

npc_SLIMER_frame_RIGHT_WRN:
    .byte   0,$a2,%01000000,  0
    .byte   0,$f4,%01000000,  8
    .byte   0,$f3,%01000000, 16
    .byte   8,$b2,%01000000,  0
    .byte   8,$f6,%01000000,  8
    .byte   8,$f5,%01000000, 16

npc_SLIMER_frame_UP:
    .byte <npc_SLIMER_frame_UP_0,   >npc_SLIMER_frame_UP_0
    .byte <npc_SLIMER_frame_UP_1,   >npc_SLIMER_frame_UP_1
    .byte <npc_SLIMER_frame_UP_0,   >npc_SLIMER_frame_UP_0
    .byte <npc_SLIMER_frame_UP_1,   >npc_SLIMER_frame_UP_1
    .byte <npc_SLIMER_frame_UP_WRN, >npc_SLIMER_frame_UP_WRN ; warning
    .byte <npc_SLIMER_frame_UP_1,   >npc_SLIMER_frame_UP_1
    .byte <npc_SLIMER_frame_DTH,    >npc_SLIMER_frame_DTH

npc_SLIMER_frame_UP_0:
    .byte   0,$d6,0        ,  0
    .byte   0,$d7,%01000000,  8
    .byte   0,$d6,%01000000, 16
    .byte   8,$e6,0        ,  0
    .byte   8,$e7,%01000000,  8
    .byte   8,$e6,%01000000, 16

npc_SLIMER_frame_UP_1:
    .byte   0,$e0,0        ,  0
    .byte   0,$e1,%01000000,  8
    .byte   0,$e0,%01000000, 16
    .byte   8,$f0,0        ,  0
    .byte   8,$f1,%01000000,  8
    .byte   8,$f0,%01000000, 16

npc_SLIMER_frame_UP_WRN:
    .byte   0,$d9,0,  0
    .byte   0,$da,0,  8
    .byte   0,$db,0, 16
    .byte   8,$f0,0,  0
    .byte   8,$f1,0,  8
    .byte   8,$f0,%01000000, 16

npc_SLIMER_frame_DOWN:
    .byte <npc_SLIMER_frame_DOWN_0,   >npc_SLIMER_frame_DOWN_0
    .byte <npc_SLIMER_frame_DOWN_1,   >npc_SLIMER_frame_DOWN_1
    .byte <npc_SLIMER_frame_DOWN_0,   >npc_SLIMER_frame_DOWN_0
    .byte <npc_SLIMER_frame_DOWN_1,   >npc_SLIMER_frame_DOWN_1
    .byte <npc_SLIMER_frame_DOWN_WRN, >npc_SLIMER_frame_DOWN_WRN ; warning
    .byte <npc_SLIMER_frame_DOWN_1,   >npc_SLIMER_frame_DOWN_1
    .byte <npc_SLIMER_frame_DTH,      >npc_SLIMER_frame_DTH

npc_SLIMER_frame_DOWN_0:
    .byte   0,$e9,0        ,  0
    .byte   0,$ea,%01000000,  8
    .byte   0,$e9,%01000000, 16
    .byte   8,$f7,0        ,  0
    .byte   8,$f8,%01000000,  8
    .byte   8,$f9,0        , 16

npc_SLIMER_frame_DOWN_1:
    .byte   0,$c0,0        ,  0
    .byte   0,$c1,%01000000,  8
    .byte   0,$c0,%01000000, 16
    .byte   8,$d0,0        ,  0
    .byte   8,$d1,%01000000,  8
    .byte   8,$d2,0        , 16

npc_SLIMER_frame_DOWN_WRN:
    .byte   0,$eb,0        ,  0
    .byte   0,$ec,0        ,  8
    .byte   0,$eb,%01000000, 16
    .byte   8,$fa,0        ,  0
    .byte   8,$fb,0        ,  8
    .byte   8,$fc,0        , 16


;=============================================

npc_DOGMAN_frames:
    .byte <npc_DOGMAN_frame_LEFT,  >npc_DOGMAN_frame_LEFT
    .byte <npc_DOGMAN_frame_RIGHT, >npc_DOGMAN_frame_RIGHT
    .byte <npc_DOGMAN_frame_UP,    >npc_DOGMAN_frame_UP
    .byte <npc_DOGMAN_frame_DOWN,  >npc_DOGMAN_frame_DOWN


npc_DOGMAN_frame_DTH:
    .byte 0,  $3A, %00000000, 0
    .byte 0,  $3B, %00000000, 8
    .byte 8,  $3C, %00000000, 0
    .byte 8,  $3D, %00000000, 8
    .byte 16, $3C, %00000000, 0
    .byte 16, $3D, %00000000, 8



npc_DOGMAN_frame_LEFT:
    .byte <npc_DOGMAN_frame_LEFT_0,   >npc_DOGMAN_frame_LEFT_0
    .byte <npc_DOGMAN_frame_LEFT_1,   >npc_DOGMAN_frame_LEFT_1
    .byte <npc_DOGMAN_frame_LEFT_2,   >npc_DOGMAN_frame_LEFT_2
    .byte <npc_DOGMAN_frame_LEFT_1,   >npc_DOGMAN_frame_LEFT_1
    .byte <npc_DOGMAN_frame_LEFT_1,   >npc_DOGMAN_frame_LEFT_1 ; warning
    .byte <npc_DOGMAN_frame_LEFT_ATK, >npc_DOGMAN_frame_LEFT_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH


npc_DOGMAN_frame_LEFT_0:
    .byte 0,  $76, %00000000, 0
    .byte 0,  $77, %00000000, 8
    .byte 8,  $7c, %00000000, 0
    .byte 8,  $7d, %00000000, 8
    .byte 16, $70, %00000000, 0
    .byte 16, $71, %00000000, 8

npc_DOGMAN_frame_LEFT_1:
    .byte 0,  $76, %00000000, 0
    .byte 0,  $77, %00000000, 8
    .byte 8,  $80, %00000000, 0
    .byte 8,  $81, %00000000, 8
    .byte 16, $90, %00000000, 0
    .byte 16, $91, %00000000, 8

npc_DOGMAN_frame_LEFT_2:
    .byte 0,  $76, %00000000, 0
    .byte 0,  $77, %00000000, 8
    .byte 8,  $7E, %00000000, 0
    .byte 8,  $7F, %00000000, 8
    .byte 16, $8B, %00000000, 0
    .byte 16, $8C, %00000000, 8

npc_DOGMAN_frame_LEFT_ATK:
    .byte 0,  $76, %00000000, 0
    .byte 0,  $77, %00000000, 8
    .byte 8,  $86, %00000000, 0
    .byte 8,  $87, %00000000, 8
    .byte 16, $96, %00000000, 0
    .byte 16, $97, %00000000, 8


npc_DOGMAN_frame_RIGHT:
    .byte <npc_DOGMAN_frame_RIGHT_0,   >npc_DOGMAN_frame_RIGHT_0
    .byte <npc_DOGMAN_frame_RIGHT_1,   >npc_DOGMAN_frame_RIGHT_1
    .byte <npc_DOGMAN_frame_RIGHT_2,   >npc_DOGMAN_frame_RIGHT_2
    .byte <npc_DOGMAN_frame_RIGHT_1,   >npc_DOGMAN_frame_RIGHT_1
    .byte <npc_DOGMAN_frame_RIGHT_1,   >npc_DOGMAN_frame_RIGHT_1 ; warning
    .byte <npc_DOGMAN_frame_RIGHT_ATK, >npc_DOGMAN_frame_RIGHT_ATK
    .byte <npc_DOGMAN_frame_DTH,       >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_RIGHT_0:
    .byte 0,  $77, %01000000, 0
    .byte 0,  $76, %01000000, 8
    .byte 8,  $7d, %01000000, 0
    .byte 8,  $7c, %01000000, 8
    .byte 16, $71, %01000000, 0
    .byte 16, $70, %01000000, 8

npc_DOGMAN_frame_RIGHT_1:
    .byte 0,  $77, %01000000, 0
    .byte 0,  $76, %01000000, 8
    .byte 8,  $81, %01000000, 0
    .byte 8,  $80, %01000000, 8
    .byte 16, $91, %01000000, 0
    .byte 16, $90, %01000000, 8

npc_DOGMAN_frame_RIGHT_2:
    .byte 0,  $77, %01000000, 0
    .byte 0,  $76, %01000000, 8
    .byte 8,  $7f, %01000000, 0
    .byte 8,  $7e, %01000000, 8
    .byte 16, $8c, %01000000, 0
    .byte 16, $8b, %01000000, 8

npc_DOGMAN_frame_RIGHT_ATK:
    .byte 0,  $77, %01000000, 0
    .byte 0,  $76, %01000000, 8
    .byte 8,  $87, %01000000, 0
    .byte 8,  $86, %01000000, 8
    .byte 16, $97, %01000000, 0
    .byte 16, $96, %01000000, 8


npc_DOGMAN_frame_UP:
    .byte <npc_DOGMAN_frame_UP_0,   >npc_DOGMAN_frame_UP_0
    .byte <npc_DOGMAN_frame_UP_1,   >npc_DOGMAN_frame_UP_1
    .byte <npc_DOGMAN_frame_UP_2,   >npc_DOGMAN_frame_UP_2
    .byte <npc_DOGMAN_frame_UP_1,   >npc_DOGMAN_frame_UP_1
    .byte <npc_DOGMAN_frame_UP_1,   >npc_DOGMAN_frame_UP_1 ; warning
    .byte <npc_DOGMAN_frame_UP_ATK, >npc_DOGMAN_frame_UP_ATK
    .byte <npc_DOGMAN_frame_DTH,    >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_UP_0:
    .byte 0,  $78, %00000000, 0
    .byte 0,  $79, %00000000, 8
    .byte 8,  $98, %00000000, 0
    .byte 8,  $99, %00000000, 8
    .byte 16, $72, %00000000, 0
    .byte 16, $8D, %01000000, 8

npc_DOGMAN_frame_UP_1:
    .byte 0,  $78, %00000000, 0
    .byte 0,  $79, %00000000, 8
    .byte 8,  $82, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $92, %00000000, 0
    .byte 16, $92, %01000000, 8

npc_DOGMAN_frame_UP_2:
    .byte 0,  $78, %00000000, 0
    .byte 0,  $79, %00000000, 8
    .byte 8,  $9C, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $8D, %00000000, 0
    .byte 16, $72, %01000000, 8

npc_DOGMAN_frame_UP_ATK:
    .byte 0,  $78, %00000000, 0
    .byte 0,  $79, %00000000, 8
    .byte 8,  $9A, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $89, %00000000, 0
    .byte 16, $8A, %00000000, 8


npc_DOGMAN_frame_DOWN:
    .byte <npc_DOGMAN_frame_DOWN_0,   >npc_DOGMAN_frame_DOWN_0
    .byte <npc_DOGMAN_frame_DOWN_1,   >npc_DOGMAN_frame_DOWN_1
    .byte <npc_DOGMAN_frame_DOWN_2,   >npc_DOGMAN_frame_DOWN_2
    .byte <npc_DOGMAN_frame_DOWN_1,   >npc_DOGMAN_frame_DOWN_1
    .byte <npc_DOGMAN_frame_DOWN_1,   >npc_DOGMAN_frame_DOWN_1 ; warning
    .byte <npc_DOGMAN_frame_DOWN_ATK, >npc_DOGMAN_frame_DOWN_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_DOWN_0:
    .byte 0,  $7A, %00000000, 0
    .byte 0,  $7A, %01000000, 8
    .byte 8,  $8E, %00000000, 0
    .byte 8,  $7B, %00000000, 8
    .byte 16, $73, %00000000, 0
    .byte 16, $88, %01000000, 8

npc_DOGMAN_frame_DOWN_1:
    .byte 0,  $7A, %00000000, 0
    .byte 0,  $7A, %01000000, 8
    .byte 8,  $74, %00000000, 0
    .byte 8,  $74, %01000000, 8
    .byte 16, $93, %00000000, 0
    .byte 16, $93, %01000000, 8

npc_DOGMAN_frame_DOWN_2:
    .byte 0,  $7A, %00000000, 0
    .byte 0,  $7A, %01000000, 8
    .byte 8,  $74, %00000000, 0
    .byte 8,  $75, %00000000, 8
    .byte 16, $88, %00000000, 0
    .byte 16, $73, %01000000, 8

npc_DOGMAN_frame_DOWN_ATK:
    .byte 0,  $7A, %00000000, 0
    .byte 0,  $7A, %01000000, 8
    .byte 8,  $84, %00000000, 0
    .byte 8,  $85, %00000000, 8
    .byte 16, $94, %00000000, 0
    .byte 16, $95, %00000000, 8


;=============================================
npc_BARAKA_frames:
    .byte <npc_BARAKA_frame_LEFT,  >npc_BARAKA_frame_LEFT
    .byte <npc_BARAKA_frame_RIGHT, >npc_BARAKA_frame_RIGHT
    .byte <npc_BARAKA_frame_UP,    >npc_BARAKA_frame_UP
    .byte <npc_BARAKA_frame_DOWN,  >npc_BARAKA_frame_DOWN

npc_BARAKA_frame_LEFT:
    .byte <npc_BARAKA_frame_LEFT_0,   >npc_BARAKA_frame_LEFT_0
    .byte <npc_BARAKA_frame_LEFT_1,   >npc_BARAKA_frame_LEFT_1
    .byte <npc_BARAKA_frame_LEFT_0,   >npc_BARAKA_frame_LEFT_0
    .byte <npc_BARAKA_frame_LEFT_1,   >npc_BARAKA_frame_LEFT_1
    .byte <npc_BARAKA_frame_LEFT_WRN, >npc_BARAKA_frame_LEFT_WRN ; warning
    .byte <npc_BARAKA_frame_LEFT_ATK, >npc_BARAKA_frame_LEFT_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH

npc_BARAKA_frame_LEFT_0:
    .byte    0,$ab,0, 0
    .byte    0,$ac,0, 8
    .byte    8,$bb,0, 0
    .byte    8,$bc,0, 8
    .byte   16,$c8,0, 0
    .byte   16,$c9,0, 8

npc_BARAKA_frame_LEFT_1:
    .byte    0,$a3,0, 0
    .byte    0,$a4,0, 8
    .byte    8,$b3,0, 0
    .byte    8,$b4,0, 8
    .byte   16,$c2,0, 0
    .byte   16,$c3,0, 8

npc_BARAKA_frame_LEFT_WRN:
    .byte    0,$ad,0, 0
    .byte    0,$ae,0, 8
    .byte    8,$bd,0, 0
    .byte    8,$be,0, 8
    .byte   16,$6f,0, 0
    .byte   16,$af,0, 8

npc_BARAKA_frame_LEFT_ATK:
    .byte    0,$dd,0, 0
    .byte    0,$de,0, 8
    .byte    8,$ed,0, 0
    .byte    8,$ee,0, 8
    .byte   16,$fd,0, 0
    .byte   16,$fe,0, 8

npc_BARAKA_frame_RIGHT:
    .byte <npc_BARAKA_frame_RIGHT_0,   >npc_BARAKA_frame_RIGHT_0
    .byte <npc_BARAKA_frame_RIGHT_1,   >npc_BARAKA_frame_RIGHT_1
    .byte <npc_BARAKA_frame_RIGHT_0,   >npc_BARAKA_frame_RIGHT_0
    .byte <npc_BARAKA_frame_RIGHT_1,   >npc_BARAKA_frame_RIGHT_1
    .byte <npc_BARAKA_frame_RIGHT_WRN, >npc_BARAKA_frame_RIGHT_WRN ; warning
    .byte <npc_BARAKA_frame_RIGHT_ATK, >npc_BARAKA_frame_RIGHT_ATK
    .byte <npc_DOGMAN_frame_DTH,       >npc_DOGMAN_frame_DTH

npc_BARAKA_frame_RIGHT_0:
    .byte    0,$ac,%01000000, 0
    .byte    0,$ab,%01000000, 8
    .byte    8,$bc,%01000000, 0
    .byte    8,$bb,%01000000, 8
    .byte   16,$c9,%01000000, 0
    .byte   16,$c8,%01000000, 8

npc_BARAKA_frame_RIGHT_1:
    .byte    0,$a4,%01000000, 0
    .byte    0,$a3,%01000000, 8
    .byte    8,$b4,%01000000, 0
    .byte    8,$b3,%01000000, 8
    .byte   16,$c3,%01000000, 0
    .byte   16,$c2,%01000000, 8

npc_BARAKA_frame_RIGHT_WRN:
    .byte    0,$ae,%01000000, 0
    .byte    0,$ad,%01000000, 8
    .byte    8,$be,%01000000, 0
    .byte    8,$bd,%01000000, 8
    .byte   16,$af,%01000000, 0
    .byte   16,$6f,%01000000, 8

npc_BARAKA_frame_RIGHT_ATK:
    .byte    0,$de,%01000000, 0
    .byte    0,$dd,%01000000, 8
    .byte    8,$ee,%01000000, 0
    .byte    8,$ed,%01000000, 8
    .byte   16,$fe,%01000000, 0
    .byte   16,$fd,%01000000, 8

npc_BARAKA_frame_UP:
    .byte <npc_BARAKA_frame_UP_0,   >npc_BARAKA_frame_UP_0
    .byte <npc_BARAKA_frame_UP_1,   >npc_BARAKA_frame_UP_1
    .byte <npc_BARAKA_frame_UP_2,   >npc_BARAKA_frame_UP_2
    .byte <npc_BARAKA_frame_UP_1,   >npc_BARAKA_frame_UP_1
    .byte <npc_BARAKA_frame_UP_WRN, >npc_BARAKA_frame_UP_WRN ; warning
    .byte <npc_BARAKA_frame_UP_ATK, >npc_BARAKA_frame_UP_ATK
    .byte <npc_DOGMAN_frame_DTH,    >npc_DOGMAN_frame_DTH

npc_BARAKA_frame_UP_0:
    .byte     0,$aa,0        ,0
    .byte     0,$aa,%01000000,8
    .byte     8,$ba,0        ,0
    .byte     8,$ba,%01000000,8
    .byte    16,$b8,0        ,0
    .byte    16,$b9,0        ,8

npc_BARAKA_frame_UP_1:
    .byte    0,$a6,0        , 0
    .byte    0,$a6,%01000000, 8
    .byte    8,$b7,0        , 0
    .byte    8,$b7,%01000000, 8
    .byte   16,$c5,0        , 0
    .byte   16,$c5,%01000000, 8

npc_BARAKA_frame_UP_2:
    .byte    0,$aa,0        , 0
    .byte    0,$aa,%01000000, 8
    .byte    8,$ba,0        , 0
    .byte    8,$ba,%01000000, 8
    .byte   16,$b9,%01000000, 0
    .byte   16,$b8,%01000000, 8

npc_BARAKA_frame_UP_WRN:
    .byte    0,$ca,0        , 0
    .byte    0,$ca,%01000000, 8
    .byte    8,$cb,0        , 0
    .byte    8,$cb,%01000000, 8
    .byte   16,$ef,0        , 0
    .byte   16,$ff,0        , 8

npc_BARAKA_frame_UP_ATK:
    .byte    0,$ce,0        , 0
    .byte    0,$ce,%01000000, 8
    .byte    8,$d8,0        , 0
    .byte    8,$d8,%01000000, 8
    .byte   16,$e8,0        , 0
    .byte   16,$f2,0        , 8


npc_BARAKA_frame_DOWN:
    .byte <npc_BARAKA_frame_DOWN_0,   >npc_BARAKA_frame_DOWN_0
    .byte <npc_BARAKA_frame_DOWN_1,   >npc_BARAKA_frame_DOWN_1
    .byte <npc_BARAKA_frame_DOWN_2,   >npc_BARAKA_frame_DOWN_2
    .byte <npc_BARAKA_frame_DOWN_1,   >npc_BARAKA_frame_DOWN_1
    .byte <npc_BARAKA_frame_DOWN_WRN, >npc_BARAKA_frame_DOWN_WRN ; warning
    .byte <npc_BARAKA_frame_DOWN_ATK, >npc_BARAKA_frame_DOWN_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH

npc_BARAKA_frame_DOWN_0:
    .byte    0,$a7,0        , 0
    .byte    0,$a7,%01000000, 8
    .byte    8,$a8,0        , 0
    .byte    8,$a9,0        , 8
    .byte   16,$c6,0        , 0
    .byte   16,$c7,0        , 8

npc_BARAKA_frame_DOWN_1:
    .byte   0,$a5,0        ,  0
    .byte   0,$a5,%01000000,  8
    .byte   8,$b5,0        ,  0
    .byte   8,$b6,0        ,  8
    .byte  16,$c4,0        ,  0
    .byte  16,$c4,%01000000,  8

npc_BARAKA_frame_DOWN_2:
    .byte    0,$a7,0        , 0
    .byte    0,$a7,%01000000, 8
    .byte    8,$a8,0        , 0
    .byte    8,$a9,0        , 8
    .byte   16,$c7,%01000000, 0
    .byte   16,$c6,%01000000, 8

npc_BARAKA_frame_DOWN_WRN:
    .byte    0,$bf,0        , 0
    .byte    0,$bf,%01000000, 8
    .byte    8,$cf,0        , 0
    .byte    8,$df,0        , 8
    .byte   16,$ef,0        , 0
    .byte   16,$ff,0        , 8

npc_BARAKA_frame_DOWN_ATK:
    .byte    0,$cc,0        , 0
    .byte    0,$cc,%01000000, 8
    .byte    8,$dc,0        , 0
    .byte    8,$e2,0        , 8
    .byte   16,$cd,0        , 0
    .byte   16,$cd,%01000000, 8

;===================================================
npc_SPIDER_sprite_data:

npc_SPIDER_frames:
    .byte <npc_SPIDER_frame_LEFT,  >npc_SPIDER_frame_LEFT
    .byte <npc_SPIDER_frame_RIGHT, >npc_SPIDER_frame_RIGHT
    .byte <npc_SPIDER_frame_UP,    >npc_SPIDER_frame_UP
    .byte <npc_SPIDER_frame_DOWN,  >npc_SPIDER_frame_DOWN

npc_SPIDER_frame_LEFT:
    .byte <npc_SPIDER_frame_LEFT_0,   >npc_SPIDER_frame_LEFT_0
    .byte <npc_SPIDER_frame_LEFT_1,   >npc_SPIDER_frame_LEFT_1
    .byte <npc_SPIDER_frame_LEFT_2,   >npc_SPIDER_frame_LEFT_2
    .byte <npc_SPIDER_frame_LEFT_1,   >npc_SPIDER_frame_LEFT_1
    .byte <npc_SPIDER_frame_LEFT_WARN,>npc_SPIDER_frame_LEFT_WARN
    .byte <npc_SPIDER_frame_LEFT_1,   >npc_SPIDER_frame_LEFT_1
    .byte <npc_BUNNY_frame_DTH,       >npc_BUNNY_frame_DTH

npc_SPIDER_frame_LEFT_0:
    .byte    0,$a4,%00000010, 0
    .byte    0,$a5,%00000010, 8
    .byte    8,$b4,%00000010, 0
    .byte    8,$b5,%00000010, 8

npc_SPIDER_frame_LEFT_1:
    .byte    0,$aa,%00000010, 0
    .byte    0,$ab,%00000010, 8
    .byte    8,$ba,%00000010, 0
    .byte    8,$bb,%00000010, 8

npc_SPIDER_frame_LEFT_2:
    .byte    0,$b6,%00000010, 0
    .byte    0,$b7,%00000010, 8
    .byte    8,$c6,%00000010, 0
    .byte    8,$c7,%00000010, 8

npc_SPIDER_frame_LEFT_WARN:
    .byte    0,$ca,%00000010, 0
    .byte    0,$cb,%00000010, 8
    .byte    8,$da,%00000010, 0
    .byte    8,$db,%00000010, 8

npc_SPIDER_frame_RIGHT:
    .byte <npc_SPIDER_frame_RIGHT_0,   >npc_SPIDER_frame_RIGHT_0
    .byte <npc_SPIDER_frame_RIGHT_1,   >npc_SPIDER_frame_RIGHT_1
    .byte <npc_SPIDER_frame_RIGHT_2,   >npc_SPIDER_frame_RIGHT_2
    .byte <npc_SPIDER_frame_RIGHT_1,   >npc_SPIDER_frame_RIGHT_1
    .byte <npc_SPIDER_frame_RIGHT_WARN,>npc_SPIDER_frame_RIGHT_WARN
    .byte <npc_SPIDER_frame_RIGHT_1,   >npc_SPIDER_frame_RIGHT_1
    .byte <npc_BUNNY_frame_DTH,        >npc_BUNNY_frame_DTH

npc_SPIDER_frame_RIGHT_0:
    .byte    0,$a4,%01000010, 8
    .byte    0,$a5,%01000010, 0
    .byte    8,$b4,%01000010, 8
    .byte    8,$b5,%01000010, 0

npc_SPIDER_frame_RIGHT_1:
    .byte    0,$aa,%01000010, 8
    .byte    0,$ab,%01000010, 0
    .byte    8,$ba,%01000010, 8
    .byte    8,$bb,%01000010, 0

npc_SPIDER_frame_RIGHT_2:
    .byte    0,$b6,%01000010, 8
    .byte    0,$b7,%01000010, 0
    .byte    8,$c6,%01000010, 8
    .byte    8,$c7,%01000010, 0

npc_SPIDER_frame_RIGHT_WARN:
    .byte    0,$ca, %01000010, 8
    .byte    0,$cb, %01000010, 0
    .byte    8,$da, %01000010, 8
    .byte    8,$db, %01000010, 0


npc_SPIDER_frame_UP:
    .byte <npc_SPIDER_frame_UP_0,   >npc_SPIDER_frame_UP_0
    .byte <npc_SPIDER_frame_UP_1,   >npc_SPIDER_frame_UP_1
    .byte <npc_SPIDER_frame_UP_2,   >npc_SPIDER_frame_UP_2
    .byte <npc_SPIDER_frame_UP_1,   >npc_SPIDER_frame_UP_1
    .byte <npc_SPIDER_frame_UP_WARN,>npc_SPIDER_frame_UP_WARN
    .byte <npc_SPIDER_frame_UP_1,   >npc_SPIDER_frame_UP_1
    .byte <npc_BUNNY_frame_DTH,     >npc_BUNNY_frame_DTH

npc_SPIDER_frame_UP_0:
    .byte   0,$b9,%00000010, 8
    .byte   0,$b8,%00000010, 0
    .byte   8,$c9,%00000010, 8
    .byte   8,$c8,%00000010, 0

npc_SPIDER_frame_UP_1:
    .byte    0,$dc,%00000010, 8
    .byte    0,$dd,%00000010, 0
    .byte    8,$ed,%01000010, 8
    .byte    8,$ed,%00000010, 0

npc_SPIDER_frame_UP_2:
    .byte    0,$bd,%00000010, 8
    .byte    0,$bc,%00000010, 0
    .byte    8,$cd,%00000010, 8
    .byte    8,$cc,%00000010, 0

npc_SPIDER_frame_UP_WARN:
    .byte    0,$af,%01000010, 8
    .byte    0,$af,%00000010, 0
    .byte    8,$bf,%01000010, 8
    .byte    8,$bf,%00000010, 0

npc_SPIDER_frame_DOWN:
    .byte <npc_SPIDER_frame_DOWN_0,   >npc_SPIDER_frame_DOWN_0
    .byte <npc_SPIDER_frame_DOWN_1,   >npc_SPIDER_frame_DOWN_1
    .byte <npc_SPIDER_frame_DOWN_2,   >npc_SPIDER_frame_DOWN_2
    .byte <npc_SPIDER_frame_DOWN_1,   >npc_SPIDER_frame_DOWN_1
    .byte <npc_SPIDER_frame_DOWN_WARN,>npc_SPIDER_frame_DOWN_WARN
    .byte <npc_SPIDER_frame_DOWN_1,   >npc_SPIDER_frame_DOWN_1
    .byte <npc_BUNNY_frame_DTH,       >npc_BUNNY_frame_DTH

npc_SPIDER_frame_DOWN_0:
    .byte    0,$ce,%00000010, 8
    .byte    0,$a8,%00000010, 0
    .byte    8,$de,%00000010, 8
    .byte    8,$de,%01000010, 0

npc_SPIDER_frame_DOWN_1:
    .byte    0,$a3,%00000010, 8
    .byte    0,$a2,%00000010, 0
    .byte    8,$b3,%00000010, 8
    .byte    8,$b3,%01000010, 0

npc_SPIDER_frame_DOWN_2:
    .byte    0,$ae,%00000010, 8
    .byte    0,$a9,%00000010, 0
    .byte    8,$be,%00000010, 8
    .byte    8,$be,%01000010, 0

npc_SPIDER_frame_DOWN_WARN:
    .byte    0,$df,%01000010, 8
    .byte    0,$df,%00000010, 0
    .byte    8,$ef,%01000010, 8
    .byte    8,$ef,%00000010, 0



;===================================================
npc_HOUND_sprite_data:

npc_HOUND_frames:
    .byte <npc_HOUND_frame_LEFT,  >npc_HOUND_frame_LEFT
    .byte <npc_HOUND_frame_RIGHT, >npc_HOUND_frame_RIGHT
    .byte <npc_HOUND_frame_UP,    >npc_HOUND_frame_UP
    .byte <npc_HOUND_frame_DOWN,  >npc_HOUND_frame_DOWN


npc_HOUND_frame_LEFT:
    .byte <npc_HOUND_frame_LEFT_0,   >npc_HOUND_frame_LEFT_0
    .byte <npc_HOUND_frame_LEFT_1,   >npc_HOUND_frame_LEFT_1
    .byte <npc_HOUND_frame_LEFT_2,   >npc_HOUND_frame_LEFT_2
    .byte <npc_HOUND_frame_LEFT_1,   >npc_HOUND_frame_LEFT_1
    .byte <npc_HOUND_frame_LEFT_WARN,>npc_HOUND_frame_LEFT_WARN
    .byte <npc_HOUND_frame_LEFT_ATK, >npc_HOUND_frame_LEFT_ATK
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH

npc_HOUND_frame_LEFT_0:
    .byte 0, $A8, %00000000, 0
    .byte 0, $A9, %00000000, 8
    .byte 8, $AD, %00000000, 0
    .byte 8, $AE, %00000000, 8

npc_HOUND_frame_LEFT_1:
    .byte 0, $AA, %00000000, 0
    .byte 0, $AB, %00000000, 8
    .byte 8, $BA, %00000000, 0
    .byte 8, $BB, %00000000, 8

npc_HOUND_frame_LEFT_2:
    .byte 0, $A8, %00000000, 0
    .byte 0, $A9, %00000000, 8
    .byte 8, $CA, %00000000, 0
    .byte 8, $CB, %00000000, 8

npc_HOUND_frame_LEFT_WARN:
    .byte 0, $DA, %00000000, 0
    .byte 0, $DB, %00000000, 8
    .byte 8, $EA, %00000000, 0
    .byte 8, $EB, %00000000, 8
npc_HOUND_frame_LEFT_ATK:
    .byte 0, $AC, %00000000, 0
    .byte 0, $DB, %00000000, 8
    .byte 8, $FD, %00000000, 0
    .byte 8, $EB, %00000000, 8



npc_HOUND_frame_RIGHT:
    .byte <npc_HOUND_frame_RIGHT_0,   >npc_HOUND_frame_RIGHT_0
    .byte <npc_HOUND_frame_RIGHT_1,   >npc_HOUND_frame_RIGHT_1
    .byte <npc_HOUND_frame_RIGHT_2,   >npc_HOUND_frame_RIGHT_2
    .byte <npc_HOUND_frame_RIGHT_1,   >npc_HOUND_frame_RIGHT_1
    .byte <npc_HOUND_frame_RIGHT_WARN,>npc_HOUND_frame_RIGHT_WARN
    .byte <npc_HOUND_frame_RIGHT_ATK, >npc_HOUND_frame_RIGHT_ATK
    .byte <npc_BUNNY_frame_DTH,       >npc_BUNNY_frame_DTH

npc_HOUND_frame_RIGHT_0:
    .byte 0, $A9, %01000000, 0
    .byte 0, $A8, %01000000, 8
    .byte 8, $AE, %01000000, 0
    .byte 8, $AD, %01000000, 8

npc_HOUND_frame_RIGHT_1:
    .byte 0, $AB, %01000000, 0
    .byte 0, $AA, %01000000, 8
    .byte 8, $BB, %01000000, 0
    .byte 8, $BA, %01000000, 8

npc_HOUND_frame_RIGHT_2:
    .byte 0, $A9, %01000000, 0
    .byte 0, $A8, %01000000, 8
    .byte 8, $CB, %01000000, 0
    .byte 8, $CA, %01000000, 8

npc_HOUND_frame_RIGHT_WARN:
    .byte 0, $DB, %01000000, 0
    .byte 0, $DA, %01000000, 8
    .byte 8, $EB, %01000000, 0
    .byte 8, $EA, %01000000, 8

npc_HOUND_frame_RIGHT_ATK:
    .byte 0, $DB, %01000000, 0
    .byte 0, $AC, %01000000, 8
    .byte 8, $EB, %01000000, 0
    .byte 8, $FD, %01000000, 8


npc_HOUND_frame_UP:
    .byte <npc_HOUND_frame_UP_0,   >npc_HOUND_frame_UP_0
    .byte <npc_HOUND_frame_UP_1,   >npc_HOUND_frame_UP_1
    .byte <npc_HOUND_frame_UP_2,   >npc_HOUND_frame_UP_2
    .byte <npc_HOUND_frame_UP_1,   >npc_HOUND_frame_UP_1
    .byte <npc_HOUND_frame_UP_WARN,>npc_HOUND_frame_UP_WARN
    .byte <npc_HOUND_frame_UP_ATK, >npc_HOUND_frame_UP_ATK
    .byte <npc_BUNNY_frame_DTH,    >npc_BUNNY_frame_DTH

npc_HOUND_frame_UP_0:
    .byte 0, $C9, %00000000, 0
    .byte 0, $BC, %01000000, 8
    .byte 8, $AF, %00000000, 0
    .byte 8, $CC, %01000000, 8

npc_HOUND_frame_UP_1:
    .byte 0, $BD, %00000000, 0
    .byte 0, $BE, %00000000, 8
    .byte 8, $CE, %00000000, 0
    .byte 8, $CE, %01000000, 8

npc_HOUND_frame_UP_2:
    .byte 0, $BC, %00000000, 0
    .byte 0, $C9, %01000000, 8
    .byte 8, $CC, %00000000, 0
    .byte 8, $AF, %01000000, 8

npc_HOUND_frame_UP_WARN:
    .byte 0, $DC, %00000000, 0
    .byte 0, $DD, %00000000, 8
    .byte 8, $EC, %00000000, 0
    .byte 8, $ED, %00000000, 8

npc_HOUND_frame_UP_ATK:
    .byte 0, $B9, %00000000, 0
    .byte 0, $B9, %01000000, 8
    .byte 8, $EC, %00000000, 0
    .byte 8, $ED, %00000000, 8


npc_HOUND_frame_DOWN:
    .byte <npc_HOUND_frame_DOWN_0,   >npc_HOUND_frame_DOWN_0
    .byte <npc_HOUND_frame_DOWN_1,   >npc_HOUND_frame_DOWN_1
    .byte <npc_HOUND_frame_DOWN_2,   >npc_HOUND_frame_DOWN_2
    .byte <npc_HOUND_frame_DOWN_1,   >npc_HOUND_frame_DOWN_1
    .byte <npc_HOUND_frame_DOWN_WARN,>npc_HOUND_frame_DOWN_WARN
    .byte <npc_HOUND_frame_DOWN_ATK, >npc_HOUND_frame_DOWN_ATK
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH

npc_HOUND_frame_DOWN_0:
    .byte 0, $BF, %00000000, 0
    .byte 0, $BF, %01000000, 8
    .byte 8, $CF, %00000000, 0
    .byte 8, $EF, %01000000, 8

npc_HOUND_frame_DOWN_1:
    .byte 0, $CD, %00000000, 0
    .byte 0, $CD, %01000000, 8
    .byte 8, $DF, %00000000, 0
    .byte 8, $DF, %01000000, 8

npc_HOUND_frame_DOWN_2:
    .byte 0, $BF, %00000000, 0
    .byte 0, $BF, %01000000, 8
    .byte 8, $EF, %00000000, 0
    .byte 8, $CF, %01000000, 8

npc_HOUND_frame_DOWN_WARN:
    .byte 0, $DE, %00000000, 0
    .byte 0, $DE, %01000000, 8
    .byte 8, $EE, %00000000, 0
    .byte 8, $EE, %01000000, 8

npc_HOUND_frame_DOWN_ATK:
    .byte 0, $CD, %00000000, 0
    .byte 0, $CD, %01000000, 8
    .byte 8, $EE, %00000000, 0
    .byte 8, $EE, %01000000, 8



;================================================

npc_BJORN_frames:
    .byte <npc_BJORN_frame_LEFT,  >npc_BJORN_frame_LEFT
    .byte <npc_BJORN_frame_RIGHT, >npc_BJORN_frame_RIGHT
    .byte <npc_BJORN_frame_UP,    >npc_BJORN_frame_UP
    .byte <npc_BJORN_frame_DOWN,  >npc_BJORN_frame_DOWN


npc_BJORN_frame_LEFT:
    .byte 0, 0
    .byte <npc_BJORN_frame_LEFT_0,   >npc_BJORN_frame_LEFT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_BJORN_frame_LEFT_0:
    .byte 0,  $BE, %00000000, 0
    .byte 0,  $BF, %00000000, 8
    .byte 8,  $C4, %00000000, 0
    .byte 8,  $C5, %00000000, 8
    .byte 16, $CA, %00000000, 0
    .byte 16, $CB, %00000000, 8

npc_BJORN_frame_RIGHT:
    .byte 0, 0
    .byte <npc_BJORN_frame_RIGHT_0,   >npc_BJORN_frame_RIGHT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_BJORN_frame_RIGHT_0:
    .byte 0,  $BF, %01000000, 0
    .byte 0,  $BE, %01000000, 8
    .byte 8,  $C5, %01000000, 0
    .byte 8,  $C4, %01000000, 8
    .byte 16, $CB, %01000000, 0
    .byte 16, $CA, %01000000, 8

npc_BJORN_frame_UP:
    .byte 0, 0
    .byte <npc_BJORN_frame_UP_0,   >npc_BJORN_frame_UP_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_BJORN_frame_UP_0:
    .byte 0,  $C0, %00000000, 0
    .byte 0,  $C1, %00000000, 8
    .byte 8,  $C6, %00000000, 0
    .byte 8,  $C7, %00000000, 8
    .byte 16, $CC, %00000000, 0
    .byte 16, $CD, %00000000, 8

npc_BJORN_frame_DOWN:
    .byte 0, 0
    .byte <npc_BJORN_frame_DOWN_0,   >npc_BJORN_frame_DOWN_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_BJORN_frame_DOWN_0:
    .byte 0,  $C2, %00000000, 0
    .byte 0,  $C3, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $CE, %00000000, 0
    .byte 16, $CF, %00000000, 8
;================================================
npc_ERIKA_sprite_data:

npc_ERIKA_frames:
    .byte <npc_ERIKA_frame_LEFT,  >npc_ERIKA_frame_LEFT
    .byte <npc_ERIKA_frame_RIGHT, >npc_ERIKA_frame_RIGHT
    .byte <npc_ERIKA_frame_UP,    >npc_ERIKA_frame_UP
    .byte <npc_ERIKA_frame_DOWN,  >npc_ERIKA_frame_DOWN

npc_ERIKA_frame_LEFT:
    .byte 0, 0
    .byte <npc_ERIKA_frame_LEFT_0,   >npc_ERIKA_frame_LEFT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_ERIKA_frame_LEFT_0:
    .byte 0,  $A0, %00000000, 0
    .byte 0,  $A1, %00000000, 8
    .byte 8,  $A6, %00000000, 0
    .byte 8,  $A7, %00000000, 8
    .byte 16, $AC, %00000000, 0
    .byte 16, $AD, %00000000, 8

npc_ERIKA_frame_RIGHT:
    .byte 0, 0
    .byte <npc_ERIKA_frame_RIGHT_0,   >npc_ERIKA_frame_RIGHT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_ERIKA_frame_RIGHT_0:
    .byte 0,  $A1, %01000000, 0
    .byte 0,  $A0, %01000000, 8
    .byte 8,  $A7, %01000000, 0
    .byte 8,  $A6, %01000000, 8
    .byte 16, $AD, %01000000, 0
    .byte 16, $AC, %01000000, 8

npc_ERIKA_frame_UP:
    .byte 0, 0
    .byte <npc_ERIKA_frame_UP_0,   >npc_ERIKA_frame_UP_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_ERIKA_frame_UP_0:
    .byte 0,  $A2, %00000000, 0
    .byte 0,  $A3, %00000000, 8
    .byte 8,  $A8, %00000000, 0
    .byte 8,  $A9, %00000000, 8
    .byte 16, $AE, %00000000, 0
    .byte 16, $AF, %00000000, 8

npc_ERIKA_frame_DOWN:
    .byte 0, 0
    .byte <npc_ERIKA_frame_DOWN_0,   >npc_ERIKA_frame_DOWN_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_ERIKA_frame_DOWN_0:
    .byte 0,  $A4, %00000000, 0
    .byte 0,  $A5, %00000000, 8
    .byte 8,  $AA, %00000000, 0
    .byte 8,  $AB, %00000000, 8
    .byte 16, $B0, %00000000, 0
    .byte 16, $B1, %00000000, 8
;========================================
npc_GRANNY_sprite_data:

npc_GRANNY_frames:
    .byte <npc_GRANNY_frame_LEFT,  >npc_GRANNY_frame_LEFT
    .byte <npc_GRANNY_frame_RIGHT, >npc_GRANNY_frame_RIGHT
    .byte <npc_GRANNY_frame_UP,    >npc_GRANNY_frame_UP
    .byte <npc_GRANNY_frame_DOWN,  >npc_GRANNY_frame_DOWN

npc_GRANNY_frame_LEFT:
    .byte 0, 0
    .byte <npc_GRANNY_frame_LEFT_0, >npc_GRANNY_frame_LEFT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_GRANNY_frame_LEFT_0:
    .byte 0, $B2, %00000000, 0
    .byte 0, $B3, %00000000, 8
    .byte 8, $B8, %00000000, 0
    .byte 8, $B9, %00000000, 8

npc_GRANNY_frame_RIGHT:
    .byte 0, 0
    .byte <npc_GRANNY_frame_RIGHT_0, >npc_GRANNY_frame_RIGHT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_GRANNY_frame_RIGHT_0:
    .byte 0, $B3, %01000000, 0
    .byte 0, $B2, %01000000, 8
    .byte 8, $B9, %01000000, 0
    .byte 8, $B8, %01000000, 8

npc_GRANNY_frame_UP:
    .byte 0, 0
    .byte <npc_GRANNY_frame_UP_0, >npc_GRANNY_frame_UP_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_GRANNY_frame_UP_0:
    .byte 0, $B4, %00000000, 0
    .byte 0, $B5, %00000000, 8
    .byte 8, $BA, %00000000, 0
    .byte 8, $BB, %00000000, 8

npc_GRANNY_frame_DOWN:
    .byte 0, 0
    .byte <npc_GRANNY_frame_DOWN_0, >npc_GRANNY_frame_DOWN_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH

npc_GRANNY_frame_DOWN_0:
    .byte 0, $B6, %00000000, 0
    .byte 0, $B7, %00000000, 8
    .byte 8, $BC, %00000000, 0
    .byte 8, $BD, %00000000, 8
;====================================

npc_DEADMAN_frames:
    .byte                        0, 0
    .byte <npc_DEADMAN_frame_RIGHT, >npc_DEADMAN_frame_RIGHT

npc_DEADMAN_frame_RIGHT:
    .byte 0, 0
    .byte <npc_DEADMAN_frame_RIGHT_0, >npc_DEADMAN_frame_RIGHT_0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte <npc_DOGMAN_frame_DTH, >npc_DOGMAN_frame_DTH


npc_DEADMAN_frame_RIGHT_0:
    .byte 0,  $A0, %00000000, 0
    .byte 0,  $A1, %00000000, 8
    .byte 8,  $A6, %00000000, 0
    .byte 8,  $A7, %00000000, 8
    .byte 16, $AC, %00000000, 0
    .byte 16, $AD, %00000000, 8
;======================================

npc_BOAR_frames:
    .byte <npc_BOAR_frames_LEFT,  >npc_BOAR_frames_LEFT
    .byte <npc_BOAR_frames_RIGHT, >npc_BOAR_frames_RIGHT
    .byte <npc_BOAR_frames_UP,    >npc_BOAR_frames_UP
    .byte <npc_BOAR_frames_DOWN,  >npc_BOAR_frames_DOWN


npc_BOAR_frames_LEFT:
    .byte <npc_BOAR_frame_LEFT_0,   >npc_BOAR_frame_LEFT_0
    .byte <npc_BOAR_frame_LEFT_1,   >npc_BOAR_frame_LEFT_1
    .byte <npc_BOAR_frame_LEFT_2,   >npc_BOAR_frame_LEFT_2
    .byte <npc_BOAR_frame_LEFT_1,   >npc_BOAR_frame_LEFT_1
    .byte <npc_BOAR_frame_LEFT_WARN,>npc_BOAR_frame_LEFT_WARN
    .byte <npc_BOAR_frame_LEFT_1,   >npc_BOAR_frame_LEFT_1 ; attack
    .byte <npc_BUNNY_frame_DTH,     >npc_BUNNY_frame_DTH

npc_BOAR_frame_LEFT_0:
    .byte 0, $D6, %00000000, 0
    .byte 0, $A1, %00000000, 8
    .byte 8, $F6, %00000000, 0
    .byte 8, $F7, %00000000, 8

npc_BOAR_frame_LEFT_1:
    .byte 0, $A0, %00000000, 0
    .byte 0, $A1, %00000000, 8
    .byte 8, $B0, %00000000, 0
    .byte 8, $B1, %00000000, 8

npc_BOAR_frame_LEFT_2:
    .byte 0, $D6, %00000000, 0
    .byte 0, $A1, %00000000, 8
    .byte 8, $E6, %00000000, 0
    .byte 8, $E7, %00000000, 8

npc_BOAR_frame_LEFT_WARN:
    .byte 0, $D6, %00000000, 0
    .byte 0, $D7, %00000000, 8
    .byte 8, $B2, %00000000, 0
    .byte 8, $B3, %00000000, 8


;----------------------------------
npc_BOAR_frames_RIGHT:
    .byte <npc_BOAR_frame_RIGHT_0,   >npc_BOAR_frame_RIGHT_0
    .byte <npc_BOAR_frame_RIGHT_1,   >npc_BOAR_frame_RIGHT_1
    .byte <npc_BOAR_frame_RIGHT_2,   >npc_BOAR_frame_RIGHT_2
    .byte <npc_BOAR_frame_RIGHT_1,   >npc_BOAR_frame_RIGHT_1
    .byte <npc_BOAR_frame_RIGHT_WARN,>npc_BOAR_frame_RIGHT_WARN
    .byte <npc_BOAR_frame_RIGHT_1,   >npc_BOAR_frame_RIGHT_1 ; attack
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH

npc_BOAR_frame_RIGHT_0:
    .byte 0, $A1, %01000000, 0
    .byte 0, $D6, %01000000, 8
    .byte 8, $F7, %01000000, 0
    .byte 8, $F6, %01000000, 8

npc_BOAR_frame_RIGHT_1:
    .byte 0, $A1, %01000000, 0
    .byte 0, $A0, %01000000, 8
    .byte 8, $B1, %01000000, 0
    .byte 8, $B0, %01000000, 8

npc_BOAR_frame_RIGHT_2:
    .byte 0, $A1, %01000000, 0
    .byte 0, $D6, %01000000, 8
    .byte 8, $E7, %01000000, 0
    .byte 8, $E6, %01000000, 8

npc_BOAR_frame_RIGHT_WARN:
    .byte 0, $D7, %01000000, 0
    .byte 0, $D6, %01000000, 8
    .byte 8, $B3, %01000000, 0
    .byte 8, $B2, %01000000, 8

;-------------------------------
npc_BOAR_frames_UP:
    .byte <npc_BOAR_frame_UP_0,   >npc_BOAR_frame_UP_0
    .byte <npc_BOAR_frame_UP_1,   >npc_BOAR_frame_UP_1
    .byte <npc_BOAR_frame_UP_2,   >npc_BOAR_frame_UP_2
    .byte <npc_BOAR_frame_UP_1,   >npc_BOAR_frame_UP_1
    .byte <npc_BOAR_frame_UP_WARN,>npc_BOAR_frame_UP_WARN
    .byte <npc_BOAR_frame_UP_ATK, >npc_BOAR_frame_UP_ATK
    .byte <npc_BUNNY_frame_DTH,   >npc_BUNNY_frame_DTH

npc_BOAR_frame_UP_0:
    .byte 0, $B5, %00000000, 0
    .byte 0, $B6, %00000000, 8
    .byte 8, $C7, %00000000, 0
    .byte 8, $C8, %00000000, 8

npc_BOAR_frame_UP_1:
    .byte 0, $A4, %00000000, 0
    .byte 0, $A5, %00000000, 8
    .byte 8, $E9, %00000000, 0
    .byte 8, $C6, %00000000, 8

npc_BOAR_frame_UP_2:
    .byte 0, $FB, %00000000, 0
    .byte 0, $FC, %00000000, 8
    .byte 8, $C5, %00000000, 0
    .byte 8, $C6, %00000000, 8

npc_BOAR_frame_UP_WARN:
    .byte 0, $D8, %00000000, 0
    .byte 0, $D9, %00000000, 8
    .byte 8, $A6, %00000000, 0
    .byte 8, $A7, %00000000, 8

npc_BOAR_frame_UP_ATK:
    .byte 0, $B7, %00000000, 0
    .byte 0, $B8, %00000000, 8
    .byte 8, $A6, %00000000, 0
    .byte 8, $A7, %00000000, 8


;------------------------------
npc_BOAR_frames_DOWN:
    .byte <npc_BOAR_frame_DOWN_0,   >npc_BOAR_frame_DOWN_0
    .byte <npc_BOAR_frame_DOWN_1,   >npc_BOAR_frame_DOWN_1
    .byte <npc_BOAR_frame_DOWN_2,   >npc_BOAR_frame_DOWN_2
    .byte <npc_BOAR_frame_DOWN_1,   >npc_BOAR_frame_DOWN_1
    .byte <npc_BOAR_frame_DOWN_WARN,>npc_BOAR_frame_DOWN_WARN
    .byte <npc_BOAR_frame_DOWN_ATK, >npc_BOAR_frame_DOWN_ATK
    .byte <npc_BUNNY_frame_DTH,     >npc_BUNNY_frame_DTH

npc_BOAR_frame_DOWN_0:
    .byte 0, $C2, %00000000, 0
    .byte 0, $C2, %01000000, 8
    .byte 8, $C1, %00000000, 0
    .byte 8, $C4, %01000000, 8

npc_BOAR_frame_DOWN_1:
    .byte 0, $B4, %00000000, 0
    .byte 0, $B4, %01000000, 8
    .byte 8, $E8, %00000000, 0
    .byte 8, $E8, %01000000, 8

npc_BOAR_frame_DOWN_2:
    .byte 0, $C2, %00000000, 0
    .byte 0, $C2, %01000000, 8
    .byte 8, $C4, %00000000, 0
    .byte 8, $C1, %01000000, 8

npc_BOAR_frame_DOWN_WARN:
    .byte 0, $FA, %00000000, 0
    .byte 0, $FA, %01000000, 8
    .byte 8, $F9, %00000000, 0
    .byte 8, $F9, %01000000, 8

npc_BOAR_frame_DOWN_ATK:
    .byte 0, $FA, %00000000, 0
    .byte 0, $FA, %01000000, 8
    .byte 8, $E8, %00000000, 0
    .byte 8, $E8, %01000000, 8


;=======================================================
;BOSS

npc_BOSS_frames:
    .byte <npc_BOSS_frame_LEFT,  >npc_BOSS_frame_LEFT
    .byte <npc_BOSS_frame_RIGHT, >npc_BOSS_frame_RIGHT
    .byte <npc_BOSS_frame_UP,    >npc_BOSS_frame_UP
    .byte <npc_BOSS_frame_DOWN,  >npc_BOSS_frame_DOWN

npc_BOSS_frame_DTH:
    .byte  0, $a0, 0,   0
    .byte  0, $3a, 0,   8
    .byte  0, $3b, 0,  16
    .byte  0, $a0, 0,  24

    .byte  8, $3a, 0,   0
    .byte  8, $3a, 0,   8
    .byte  8, $3b, 0,  16
    .byte  8, $3b, 0,  24

    .byte 16, $3a, 0,   0
    .byte 16, $a0, 0,   8
    .byte 16, $a0, 0,  16
    .byte 16, $3b, 0,  24

    .byte 24, $3c, 0,   0
    .byte 24, $3c, 0,   8
    .byte 24, $a0, 0,  16
    .byte 24, $3d, 0,  24

    .byte 32, $3c, 0,   0
    .byte 32, $3c, 0,   8
    .byte 32, $3d, 0,  16
    .byte 32, $a0, 0,  24


npc_BOSS_frame_LEFT:
    .byte <npc_BOSS_frame_LEFT_0,   >npc_BOSS_frame_LEFT_0
    .byte <npc_BOSS_frame_LEFT_1,   >npc_BOSS_frame_LEFT_1
    .byte <npc_BOSS_frame_LEFT_2,   >npc_BOSS_frame_LEFT_2
    .byte <npc_BOSS_frame_LEFT_1,   >npc_BOSS_frame_LEFT_1
    .byte <npc_BOSS_frame_LEFT_WARN,>npc_BOSS_frame_LEFT_WARN
    .byte <npc_BOSS_frame_LEFT_ATK, >npc_BOSS_frame_LEFT_ATK
    .byte <npc_BOSS_frame_DTH,      >npc_BOSS_frame_DTH

npc_BOSS_frame_LEFT_0:
    .byte   0, $c8, 0,  0
    .byte   0, $c9, 0,  8
    .byte   0, $ce, 0, 16
    .byte   0, $cf, 0, 24

    .byte   8, $d4, 0,  0
    .byte   8, $d5, 0,  8
    .byte   8, $da, 0, 16
    .byte   8, $db, 0, 24

    .byte  16, $a0, 0,  0
    .byte  16, $e0, 0,  8
    .byte  16, $e1, 0, 16
    .byte  16, $de, 0, 24

    .byte  24, $a0, 0,  0
    .byte  24, $fe, 0,  8
    .byte  24, $b2, 0, 16
    .byte  24, $b3, 0, 24

    .byte  32, $a0, 0,  0
    .byte  32, $e9, 0,  8
    .byte  32, $ef, 0, 16
    .byte  32, $f6, 0, 24

npc_BOSS_frame_LEFT_1:
    .byte   0, $c8, 0,  0
    .byte   0, $c9, 0,  8
    .byte   0, $ce, 0, 16
    .byte   0, $cf, 0, 24

    .byte   8, $d4, 0,  0
    .byte   8, $d5, 0,  8
    .byte   8, $da, 0, 16
    .byte   8, $db, 0, 24

    .byte  16, $a0, 0,  0
    .byte  16, $e0, 0,  8
    .byte  16, $e1, 0, 16
    .byte  16, $de, 0, 24

    .byte  24, $a0, 0,  0
    .byte  24, $fe, 0,  8
    .byte  24, $b2, 0, 16
    .byte  24, $b3, 0, 24

    .byte  32, $a0, 0,  0
    .byte  32, $b8, 0,  8
    .byte  32, $b9, 0, 16
    .byte  32, $a0, 0, 24

npc_BOSS_frame_LEFT_2:
    .byte   0, $c8, 0,  0
    .byte   0, $c9, 0,  8
    .byte   0, $ce, 0, 16
    .byte   0, $cf, 0, 24
    .byte   8, $d4, 0,  0
    .byte   8, $d5, 0,  8
    .byte   8, $da, 0, 16
    .byte   8, $db, 0, 24
    .byte  16, $a0, 0,  0
    .byte  16, $e0, 0,  8
    .byte  16, $e1, 0, 16
    .byte  16, $de, 0, 24
    .byte  24, $a0, 0,  0
    .byte  24, $fe, 0,  8
    .byte  24, $b2, 0, 16
    .byte  24, $b3, 0, 24
    .byte  32, $a0, 0,  0
    .byte  32, $ee, 0,  8
    .byte  32, $fa, 0, 16
    .byte  32, $f0, 0, 24

npc_BOSS_frame_LEFT_WARN:
	.byte   0, $c8, 0        ,  0
	.byte   0, $be, 0        ,  8
	.byte   0, $ce, 0        , 16
	.byte   0, $a5, %11000000, 24
	.byte   8, $cc, %11000000, 24
	.byte   8, $bf, 0        ,  0
	.byte   8, $c4, 0        ,  8
	.byte   8, $b2, 0        , 16
	.byte   8, $db, 0        , 24
	.byte  24, $fd, 0        ,  8
	.byte  16, $e8, 0        ,  8
	.byte  16, $e1, 0        , 16
	.byte  16, $d1, 0        , 24
	.byte 240, $d8, %11000000, 24
	.byte  24, $dc, 0        , 16
	.byte  24, $ef, 0        , 24
	.byte 248, $d2, %10000000, 24
	.byte  32, $a0, 0        ,  8
	.byte  32, $e2, 0        , 16
	.byte  32, $e3, 0        , 24

npc_BOSS_frame_LEFT_ATK: 
	.byte  24,$fb,0, 16
	.byte   0,$c8,0,  0
	.byte   0,$be,0,  8
	.byte   0,$ce,0, 16
	.byte   0,$cf,0, 24
	.byte   8,$bf,0,  0
	.byte   8,$c4,0,  8
	.byte   8,$c5,0, 16
	.byte   8,$db,0, 24
	.byte  16,$ca,0,  0
	.byte  16,$cb,0,  8
	.byte  16,$d0,0, 16
	.byte  16,$d1,0, 24
	.byte  24,$d6,0,  0
	.byte  24,$d7,0,  8
	.byte  24,$dc,0, 16
	.byte  24,$dd,0, 24
	.byte  32,$ff,0,  0
	.byte  32,$e2,0, 16
	.byte  32,$f0,0, 24


npc_BOSS_frame_RIGHT:
    .byte <npc_BOSS_frame_RIGHT_0,   >npc_BOSS_frame_RIGHT_0
    .byte <npc_BOSS_frame_RIGHT_1,   >npc_BOSS_frame_RIGHT_1
    .byte <npc_BOSS_frame_RIGHT_2,   >npc_BOSS_frame_RIGHT_2
    .byte <npc_BOSS_frame_RIGHT_1,   >npc_BOSS_frame_RIGHT_1
    .byte <npc_BOSS_frame_RIGHT_WARN,>npc_BOSS_frame_RIGHT_WARN
    .byte <npc_BOSS_frame_RIGHT_ATK, >npc_BOSS_frame_RIGHT_ATK
    .byte <npc_BOSS_frame_DTH,       >npc_BOSS_frame_DTH

npc_BOSS_frame_RIGHT_0:
    .byte   0, $c8, %01000000, 24
    .byte   0, $c9, %01000000, 16
    .byte   0, $ce, %01000000,  8
    .byte   0, $cf, %01000000,  0

    .byte   8, $d4, %01000000, 24
    .byte   8, $d5, %01000000, 16
    .byte   8, $da, %01000000,  8
    .byte   8, $db, %01000000,  0

    .byte  16, $a0, %01000000, 24
    .byte  16, $e0, %01000000, 16
    .byte  16, $e1, %01000000,  8
    .byte  16, $de, %01000000,  0

    .byte  24, $a0, %01000000, 24
    .byte  24, $fe, %01000000, 16
    .byte  24, $b2, %01000000,  8
    .byte  24, $b3, %01000000,  0

    .byte  32, $a0, %01000000, 24
    .byte  32, $e9, %01000000, 16
    .byte  32, $ef, %01000000,  8
    .byte  32, $f6, %01000000,  0

npc_BOSS_frame_RIGHT_1:
    .byte   0, $c8, %01000000, 24
    .byte   0, $c9, %01000000, 16
    .byte   0, $ce, %01000000,  8
    .byte   0, $cf, %01000000,  0

    .byte   8, $d4, %01000000, 24
    .byte   8, $d5, %01000000, 16
    .byte   8, $da, %01000000,  8
    .byte   8, $db, %01000000,  0

    .byte  16, $a0, %01000000, 24
    .byte  16, $e0, %01000000, 16
    .byte  16, $e1, %01000000,  8
    .byte  16, $de, %01000000,  0

    .byte  24, $a0, %01000000, 24
    .byte  24, $fe, %01000000, 16
    .byte  24, $b2, %01000000,  8
    .byte  24, $b3, %01000000,  0

    .byte  32, $a0, %01000000, 24
    .byte  32, $b8, %01000000, 16
    .byte  32, $b9, %01000000,  8
    .byte  32, $a0, %01000000,  0

npc_BOSS_frame_RIGHT_2:
    .byte   0, $c8, %01000000, 24
    .byte   0, $c9, %01000000, 16
    .byte   0, $ce, %01000000,  8
    .byte   0, $cf, %01000000,  0

    .byte   8, $d4, %01000000, 24
    .byte   8, $d5, %01000000, 16
    .byte   8, $da, %01000000,  8
    .byte   8, $db, %01000000,  0

    .byte  16, $a0, %01000000, 24
    .byte  16, $e0, %01000000, 16
    .byte  16, $e1, %01000000,  8
    .byte  16, $de, %01000000,  0

    .byte  24, $a0, %01000000, 24
    .byte  24, $fe, %01000000, 16
    .byte  24, $b2, %01000000,  8
    .byte  24, $b3, %01000000,  0

    .byte  32, $a0, %01000000, 24
    .byte  32, $ee, %01000000, 16
    .byte  32, $fa, %01000000,  8
    .byte  32, $f0, %01000000,  0

npc_BOSS_frame_RIGHT_WARN:
    .byte   0, $c8, %01000000 , 24
	.byte   0, $be, %01000000 , 16
	.byte   0, $ce, %01000000 ,  8
	.byte   0, $a5, %10000000 ,  0
	.byte   8, $cc, %10000000 ,  0
	.byte   8, $bf, %01000000 , 24
	.byte   8, $c4, %01000000 , 16
	.byte   8, $b2, %01000000 ,  8
	.byte   8, $db, %01000000 ,  0
	.byte  24, $fd, %01000000 , 16
	.byte  16, $e8, %01000000 , 16
	.byte  16, $e1, %01000000 ,  8
	.byte  16, $d1, %01000000 ,  0
	.byte 240, $d8, %10000000 ,  0
	.byte  24, $dc, %01000000 ,  8
	.byte  24, $ef, %01000000 ,  0
	.byte 248, $d2, %11000000 ,  0
	.byte  32, $a0, %01000000 , 16
	.byte  32, $e2, %01000000 ,  8
	.byte  32, $e3, %01000000 ,  0

npc_BOSS_frame_RIGHT_ATK:
    .byte  24,$fb, %01000000, 8
	.byte   0,$c8, %01000000, 24
	.byte   0,$be, %01000000, 16
	.byte   0,$ce, %01000000, 8
	.byte   0,$cf, %01000000, 0
	.byte   8,$bf, %01000000, 24
	.byte   8,$c4, %01000000, 16
	.byte   8,$c5, %01000000, 8
	.byte   8,$db, %01000000, 0
	.byte  16,$ca, %01000000, 24
	.byte  16,$cb, %01000000, 16
	.byte  16,$d0, %01000000, 8
	.byte  16,$d1, %01000000, 0
	.byte  24,$d6, %01000000, 24
	.byte  24,$d7, %01000000, 16
	.byte  24,$dc, %01000000, 8
	.byte  24,$dd, %01000000, 0
	.byte  32,$ff, %01000000, 24
	.byte  32,$e2, %01000000, 8
	.byte  32,$f0, %01000000, 0



npc_BOSS_frame_UP:
    .byte <npc_BOSS_frame_UP_0,   >npc_BOSS_frame_UP_0
    .byte <npc_BOSS_frame_UP_1,   >npc_BOSS_frame_UP_1
    .byte <npc_BOSS_frame_UP_2,   >npc_BOSS_frame_UP_2
    .byte <npc_BOSS_frame_UP_1,   >npc_BOSS_frame_UP_1
    .byte <npc_BOSS_frame_UP_WARN,>npc_BOSS_frame_UP_WARN
    .byte <npc_BOSS_frame_UP_ATK, >npc_BOSS_frame_UP_ATK
    .byte <npc_BOSS_frame_DTH,    >npc_BOSS_frame_DTH

npc_BOSS_frame_UP_0:
	.byte   0,$c6,0        ,  0
	.byte   0,$c7,0        ,  8
	.byte   0,$c7,%01000000, 16
	.byte   0,$c6,%01000000, 24
	.byte   8,$cc,0        ,  0
	.byte   8,$cd,0        ,  8
	.byte   8,$cd,%01000000, 16
	.byte   8,$b7,%01000000, 24
	.byte  16,$a5,%01000000,  0
	.byte  16,$d3,0        ,  8
	.byte  16,$d3,%01000000, 16
	.byte  16,$bd,%01000000, 24
	.byte  24,$d2,0        ,  0
	.byte  24,$f1,0        ,  8
	.byte  24,$d9,%01000000, 16
	.byte  24,$c3,%01000000, 24
	.byte  32,$d8,0        ,  0
	.byte  32,$f7,0        ,  8
	.byte  32,$f8,0        , 16
	.byte  32,$a0,%01000000, 24

npc_BOSS_frame_UP_1:
	.byte   0,$c6,0        ,  0
	.byte   0,$c7,0        ,  8
	.byte   0,$c7,%01000000, 16
	.byte   0,$c6,%01000000, 24
	.byte   8,$cc,0        ,  0
	.byte   8,$cd,0        ,  8
	.byte   8,$cd,%01000000, 16
	.byte   8,$cc,%01000000, 24
	.byte  16,$a5,%01000000,  0
	.byte  16,$d3,0        ,  8
	.byte  16,$d3,%01000000, 16
	.byte  16,$a5,0        , 24
	.byte  24,$d2,0        ,  0
	.byte  24,$d9,0        ,  8
	.byte  24,$d9,%01000000, 16
	.byte  24,$d2,%01000000, 24
	.byte  32,$d8,0        ,  0
	.byte  32,$df,0        ,  8
	.byte  32,$df,%01000000, 16
	.byte  32,$d8,%01000000, 24

npc_BOSS_frame_UP_2:
	.byte   0,$c6,0        ,  0
	.byte   0,$c7,0        ,  8
	.byte   0,$c7,%01000000, 16
	.byte   0,$c6,%01000000, 24
	.byte   8,$b7,0        ,  0
	.byte   8,$cd,0        ,  8
	.byte   8,$cd,%01000000, 16
	.byte   8,$cc,%01000000, 24
	.byte  16,$bd,0        ,  0
	.byte  16,$d3,0        ,  8
	.byte  16,$d3,%01000000, 16
	.byte  16,$a5,0        , 24
	.byte  24,$c3,0        ,  0
	.byte  24,$d9,0        ,  8
	.byte  24,$f1,%01000000, 16
	.byte  24,$d2,%01000000, 24
	.byte  32,$a0,0        ,  0
	.byte  32,$f8,%01000000,  8
	.byte  32,$f7,%01000000, 16
	.byte  32,$d8,%01000000, 24


npc_BOSS_frame_UP_WARN:
    .byte    0,$c6, 0        , 0
    .byte    0,$c7, 0        , 8
    .byte    0,$c7, %01000000,16
    .byte    0,$c6, %01000000,24
    .byte    8,$c2, %01000000, 0
    .byte    8,$e5, 0        , 8
    .byte    8,$cd, %01000000,16
    .byte    8,$e7, 0        ,24
    .byte    0,$a5, %10000000, 2
    .byte   16,$d3, 0        , 8
    .byte   16,$ec, 0        ,16
    .byte   16,$ed, 0        ,24
    .byte  249,$ab, %11000000, 3
    .byte   24,$f1, 0        , 8
    .byte   24,$f2, 0        ,16
    .byte   24,$f3, 0        ,24
    .byte  241,$b1, %11000000, 3
    .byte   32,$f7, 0        , 8
    .byte   32,$f8, 0        ,16
    .byte   32,$f9, %01000000,24

npc_BOSS_frame_UP_ATK:
    .byte   0, $c6, 0        ,  0
    .byte   0, $c7, 0        ,  8
    .byte   0, $c7, %01000000, 16
    .byte   0, $c6, %01000000, 24
    .byte   8, $c2, %01000000,  0
    .byte   8, $e5, 0        ,  8
    .byte   8, $cd, %01000000, 16
    .byte   8, $e7, 0        , 24
    .byte   0, $cc, 0        ,  0
    .byte  16, $d3, 0        ,  8
    .byte  16, $ec, 0        , 16
    .byte  16, $ed, 0        , 24
    .byte 252, $c1, %11000000,  8
    .byte  24, $f1, 0        ,  8
    .byte  24, $f2, 0        , 16
    .byte  24, $f3, 0        , 24
    .byte 252, $c0, %11000000, 16
    .byte  32, $f7, 0        ,  8
    .byte  32, $f8, 0        , 16
    .byte  32, $f9, %01000000, 24


npc_BOSS_frame_DOWN:
    .byte <npc_BOSS_frame_DOWN_0,   >npc_BOSS_frame_DOWN_0
    .byte <npc_BOSS_frame_DOWN_1,   >npc_BOSS_frame_DOWN_1
    .byte <npc_BOSS_frame_DOWN_2,   >npc_BOSS_frame_DOWN_2
    .byte <npc_BOSS_frame_DOWN_1,   >npc_BOSS_frame_DOWN_1
    .byte <npc_BOSS_frame_DOWN_WARN,>npc_BOSS_frame_DOWN_WARN
    .byte <npc_BOSS_frame_DOWN_ATK, >npc_BOSS_frame_DOWN_ATK
    .byte <npc_BOSS_frame_DTH,      >npc_BOSS_frame_DTH

npc_BOSS_frame_DOWN_0:
    .byte 0,  $a3, %01000000, 0
    .byte 0,  $a2, %01000000, 8
    .byte 0,  $a2, %00000000, 16
    .byte 0,  $a3, %00000000, 24

    .byte 8,  $b5, %01000000, 0
    .byte 8,  $a8, %01000000, 8
    .byte 8,  $a8, %00000000, 16
    .byte 8,  $b7, %01000000, 24

    .byte 16, $a5, %01000000, 0
    .byte 16, $a4, %01000000, 8
    .byte 16, $a4, %00000000, 16
    .byte 16, $bd, %01000000, 24

    .byte 24, $ab, %01000000, 0
    .byte 24, $aa, %01000000, 8
    .byte 24, $aa, %00000000, 16
    .byte 24, $c3, %01000000, 24

    .byte 32, $b1, %01000000, 0
    .byte 32, $ae, %01000000, 8
    .byte 32, $b0, %00000000, 16
    .byte 32, $a0, %00000000, 24

npc_BOSS_frame_DOWN_1:
    .byte 0,  $a3, %01000000, 0
    .byte 0,  $a2, %01000000, 8
    .byte 0,  $a2, %00000000, 16
    .byte 0,  $a3, %00000000, 24

    .byte 8,  $b5, %01000000, 0
    .byte 8,  $a8, %01000000, 8
    .byte 8,  $a8, %00000000, 16
    .byte 8,  $a9, %00000000, 24

    .byte 16, $a5, %01000000, 0
    .byte 16, $a4, %01000000, 8
    .byte 16, $a4, %00000000, 16
    .byte 16, $a5, %00000000, 24

    .byte 24, $ab, %01000000, 0
    .byte 24, $aa, %01000000, 8
    .byte 24, $aa, %00000000, 16
    .byte 24, $ab, %00000000, 24

    .byte 32, $b1, %01000000, 0
    .byte 32, $b0, %01000000, 8
    .byte 32, $b0, %00000000, 16
    .byte 32, $b1, %00000000, 24

npc_BOSS_frame_DOWN_2:
    .byte 0,  $a3, %01000000, 0
    .byte 0,  $a2, %01000000, 8
    .byte 0,  $a2, %00000000, 16
    .byte 0,  $a3, %00000000, 24

    .byte 8,  $b7, %00000000, 0
    .byte 8,  $a8, %01000000, 8
    .byte 8,  $a8, %00000000, 16
    .byte 8,  $a9, %00000000, 24

    .byte 16, $bd, %00000000, 0
    .byte 16, $a4, %01000000, 8
    .byte 16, $a4, %00000000, 16
    .byte 16, $a5, %00000000, 24

    .byte 24, $c3, %00000000, 0
    .byte 24, $aa, %01000000, 8
    .byte 24, $aa, %00000000, 16
    .byte 24, $ab, %00000000, 24

    .byte 32, $a0, %01000000, 0
    .byte 32, $b0, %01000000, 8
    .byte 32, $ae, %00000000, 16
    .byte 32, $b1, %00000000, 24

npc_BOSS_frame_DOWN_WARN:
    .byte   0,$af, %01000000,  0
    .byte   0,$a2, %01000000,  8
    .byte   0,$a2, 0        , 16
    .byte   0,$bd, %11000000, 24
    .byte   8,$b7, 0        ,  0
    .byte   8,$b4, %01000000,  8
    .byte   8,$b4, 0        , 16
    .byte   8,$b7, %11000000, 24
    .byte  16,$bd, 0        ,  0
    .byte  16,$ba, 0        ,  8
    .byte  16,$ba, %01000000, 16
    .byte 240,$b1, %10000000, 24
    .byte  24,$c3, 0        ,  0
    .byte  24,$aa, %01000000,  8
    .byte  24,$aa, 0        , 16
    .byte  32,$a0, 0        ,  0
    .byte  32,$b0, %01000000,  8
    .byte  32,$b0, 0        , 16
    .byte   0,$af, 0        , 24
    .byte 248,$d2, %10000000, 24

npc_BOSS_frame_DOWN_ATK:
    .byte   0,$af,%01000000,  0
	.byte   0,$a2,%01000000,  8
	.byte   0,$a2,0        , 16
	.byte   0,$af,0        , 24
	.byte   8,$b7,0        ,  0
	.byte   8,$b4,%01000000,  8
	.byte   8,$b4,0        , 16
	.byte   8,$b5,0        , 24
	.byte  16,$bd,0        ,  0
	.byte  16,$ba,0        ,  8
	.byte  16,$bb,0        , 16
	.byte  16,$bc,0        , 24
	.byte  24,$c3,0        ,  0
	.byte  25,$c0,0        ,  9
	.byte  24,$d7,0        , 16
	.byte  24,$c2,0        , 24
	.byte  24,$aa,%01000000,  8
	.byte  32,$b0,0        ,  8
	.byte  32,$ae,0        , 16
	.byte  24,$aa,0        , 16



