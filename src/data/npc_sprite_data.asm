npc_anim_2_3_row_sequence: ; 3 rows * ( 4 * 2 )
    .byte 0
    .byte 24
    .byte 48
    .byte 72
    .byte 96
    .byte 120


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


;Bunny

npc_BUNNY_frames:
    .byte <npc_BUNNY_frame_LEFT,  >npc_BUNNY_frame_LEFT
    .byte <npc_BUNNY_frame_RIGHT, >npc_BUNNY_frame_RIGHT
    .byte <npc_BUNNY_frame_UP,    >npc_BUNNY_frame_UP
    .byte <npc_BUNNY_frame_DOWN,  >npc_BUNNY_frame_DOWN


npc_BUNNY_frame_DTH:
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8

npc_BUNNY_frame_LEFT:
    .byte <npc_BUNNY_frame_LEFT_0,   >npc_BUNNY_frame_LEFT_0
    .byte <npc_BUNNY_frame_LEFT_1,   >npc_BUNNY_frame_LEFT_1
    .byte <npc_BUNNY_frame_LEFT_2,   >npc_BUNNY_frame_LEFT_2
    .byte <npc_BUNNY_frame_LEFT_1,   >npc_BUNNY_frame_LEFT_1
    .byte                       0,   0
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH


npc_BUNNY_frame_LEFT_0:
    .byte 0, $0A, %00000000, 0
    .byte 0, $0B, %00000000, 8
    .byte 8, $1A, %00000000, 0
    .byte 8, $1B, %00000000, 8

npc_BUNNY_frame_LEFT_1:
    .byte 0, $0E, %00000000, 0
    .byte 0, $0F, %00000000, 8
    .byte 8, $1E, %00000000, 0
    .byte 8, $1F, %00000000, 8

npc_BUNNY_frame_LEFT_2:
    .byte 0, $0A, %00000000, 0
    .byte 0, $0B, %00000000, 8
    .byte 8, $1A, %00000000, 0
    .byte 8, $1B, %00000000, 8


npc_BUNNY_frame_RIGHT:
    .byte <npc_BUNNY_frame_RIGHT_0,  >npc_BUNNY_frame_RIGHT_0
    .byte <npc_BUNNY_frame_RIGHT_1,  >npc_BUNNY_frame_RIGHT_1
    .byte <npc_BUNNY_frame_RIGHT_2,  >npc_BUNNY_frame_RIGHT_2
    .byte <npc_BUNNY_frame_RIGHT_1,  >npc_BUNNY_frame_RIGHT_1
    .byte                        0,  0
    .byte <npc_BUNNY_frame_DTH,      >npc_BUNNY_frame_DTH


npc_BUNNY_frame_RIGHT_0:
    .byte 0, $0B, %01000000, 0 ;must be 0
    .byte 0, $0A, %01000000, 8 ;must be 8, because second sprite can be skipped
    .byte 8, $1B, %01000000, 0
    .byte 8, $1A, %01000000, 8

npc_BUNNY_frame_RIGHT_1:
    .byte 0, $0F, %01000000, 0
    .byte 0, $0E, %01000000, 8
    .byte 8, $1F, %01000000, 0
    .byte 8, $1E, %01000000, 8

npc_BUNNY_frame_RIGHT_2:
    .byte 0, $0B, %01000000, 0
    .byte 0, $0A, %01000000, 8
    .byte 8, $1B, %01000000, 0
    .byte 8, $1A, %01000000, 8


npc_BUNNY_frame_UP:
    .byte <npc_BUNNY_frame_UP_0,  >npc_BUNNY_frame_UP_0
    .byte <npc_BUNNY_frame_UP_1,  >npc_BUNNY_frame_UP_1
    .byte <npc_BUNNY_frame_UP_2,  >npc_BUNNY_frame_UP_2
    .byte <npc_BUNNY_frame_UP_1,  >npc_BUNNY_frame_UP_1
    .byte                     0,  0
    .byte <npc_BUNNY_frame_DTH,   >npc_BUNNY_frame_DTH

npc_BUNNY_frame_UP_0:
    .byte 0, $0C, %00000000, 0
    .byte 0, $0C, %01000000, 8
    .byte 8, $1C, %00000000, 0
    .byte 8, $1C, %01000000, 8

npc_BUNNY_frame_UP_1:
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2B, %00000000, 0
    .byte 8, $2B, %01000000, 8

npc_BUNNY_frame_UP_2:
    .byte 0, $0C, %00000000, 0
    .byte 0, $0C, %01000000, 8
    .byte 8, $1C, %00000000, 0
    .byte 8, $1C, %01000000, 8


npc_BUNNY_frame_DOWN:
    .byte <npc_BUNNY_frame_DOWN_0,  >npc_BUNNY_frame_DOWN_0
    .byte <npc_BUNNY_frame_DOWN_1,  >npc_BUNNY_frame_DOWN_1
    .byte <npc_BUNNY_frame_DOWN_2,  >npc_BUNNY_frame_DOWN_2
    .byte <npc_BUNNY_frame_DOWN_1,  >npc_BUNNY_frame_DOWN_1
    .byte                       0,  0
    .byte <npc_BUNNY_frame_DTH,     >npc_BUNNY_frame_DTH

npc_BUNNY_frame_DOWN_0:
    .byte 0, $0D, %00000000, 0
    .byte 0, $0D, %01000000, 8
    .byte 8, $1D, %00000000, 0
    .byte 8, $1D, %01000000, 8

npc_BUNNY_frame_DOWN_1:
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2A, %00000000, 0
    .byte 8, $2A, %01000000, 8

npc_BUNNY_frame_DOWN_2:
    .byte 0, $0D, %00000000, 0
    .byte 0, $0D, %01000000, 8
    .byte 8, $1D, %00000000, 0
    .byte 8, $1D, %01000000, 8

;=============================================

npc_DOGMAN_frames:
    .byte <npc_DOGMAN_frame_LEFT,  >npc_DOGMAN_frame_LEFT
    .byte <npc_DOGMAN_frame_RIGHT, >npc_DOGMAN_frame_RIGHT
    .byte <npc_DOGMAN_frame_UP,    >npc_DOGMAN_frame_UP
    .byte <npc_DOGMAN_frame_DOWN,  >npc_DOGMAN_frame_DOWN


npc_DOGMAN_frame_DTH:
    .byte 0,  $B8, %00000000, 0
    .byte 0,  $B9, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $C8, %00000000, 0
    .byte 16, $C9, %00000000, 8



npc_DOGMAN_frame_LEFT:
    .byte <npc_DOGMAN_frame_LEFT_0,   >npc_DOGMAN_frame_LEFT_0
    .byte <npc_DOGMAN_frame_LEFT_1,   >npc_DOGMAN_frame_LEFT_1
    .byte <npc_DOGMAN_frame_LEFT_2,   >npc_DOGMAN_frame_LEFT_2
    .byte <npc_DOGMAN_frame_LEFT_1,   >npc_DOGMAN_frame_LEFT_1
    .byte <npc_DOGMAN_frame_LEFT_ATK, >npc_DOGMAN_frame_LEFT_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH


npc_DOGMAN_frame_LEFT_0:
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $60, %00000000, 0
    .byte 8,  $61, %00000000, 8
    .byte 16, $70, %00000000, 0
    .byte 16, $71, %00000000, 8

npc_DOGMAN_frame_LEFT_1:
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $80, %00000000, 0
    .byte 8,  $81, %00000000, 8
    .byte 16, $90, %00000000, 0
    .byte 16, $91, %00000000, 8

npc_DOGMAN_frame_LEFT_2:
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $A0, %00000000, 0
    .byte 8,  $A1, %00000000, 8
    .byte 16, $B0, %00000000, 0
    .byte 16, $B1, %00000000, 8

npc_DOGMAN_frame_LEFT_ATK:
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $C0, %00000000, 0
    .byte 8,  $C1, %00000000, 8
    .byte 16, $D0, %00000000, 0
    .byte 16, $D1, %00000000, 8


npc_DOGMAN_frame_RIGHT:
    .byte <npc_DOGMAN_frame_RIGHT_0,   >npc_DOGMAN_frame_RIGHT_0
    .byte <npc_DOGMAN_frame_RIGHT_1,   >npc_DOGMAN_frame_RIGHT_1
    .byte <npc_DOGMAN_frame_RIGHT_2,   >npc_DOGMAN_frame_RIGHT_2
    .byte <npc_DOGMAN_frame_RIGHT_1,   >npc_DOGMAN_frame_RIGHT_1
    .byte <npc_DOGMAN_frame_RIGHT_ATK, >npc_DOGMAN_frame_RIGHT_ATK
    .byte <npc_DOGMAN_frame_DTH,       >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_RIGHT_0:
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $61, %01000000, 0
    .byte 8,  $60, %01000000, 8
    .byte 16, $71, %01000000, 0
    .byte 16, $70, %01000000, 8

npc_DOGMAN_frame_RIGHT_1:
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $81, %01000000, 0
    .byte 8,  $80, %01000000, 8
    .byte 16, $91, %01000000, 0
    .byte 16, $90, %01000000, 8

npc_DOGMAN_frame_RIGHT_2:
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $A1, %01000000, 0
    .byte 8,  $A0, %01000000, 8
    .byte 16, $B1, %01000000, 0
    .byte 16, $B0, %01000000, 8

npc_DOGMAN_frame_RIGHT_ATK:
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $C1, %01000000, 0
    .byte 8,  $C0, %01000000, 8
    .byte 16, $D1, %01000000, 0
    .byte 16, $D0, %01000000, 8


npc_DOGMAN_frame_UP:
    .byte <npc_DOGMAN_frame_UP_0,   >npc_DOGMAN_frame_UP_0
    .byte <npc_DOGMAN_frame_UP_1,   >npc_DOGMAN_frame_UP_1
    .byte <npc_DOGMAN_frame_UP_2,   >npc_DOGMAN_frame_UP_2
    .byte <npc_DOGMAN_frame_UP_1,   >npc_DOGMAN_frame_UP_1
    .byte <npc_DOGMAN_frame_UP_ATK, >npc_DOGMAN_frame_UP_ATK
    .byte <npc_DOGMAN_frame_DTH,    >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_UP_0:
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $62, %00000000, 0
    .byte 8,  $63, %00000000, 8
    .byte 16, $72, %00000000, 0
    .byte 16, $B2, %01000000, 8

npc_DOGMAN_frame_UP_1:
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $82, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $92, %00000000, 0
    .byte 16, $92, %01000000, 8

npc_DOGMAN_frame_UP_2:
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $A2, %00000000, 0
    .byte 8,  $A3, %00000000, 8
    .byte 16, $B2, %00000000, 0
    .byte 16, $72, %01000000, 8

npc_DOGMAN_frame_UP_ATK:
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $A4, %00000000, 0
    .byte 8,  $A5, %00000000, 8
    .byte 16, $B4, %00000000, 0
    .byte 16, $B5, %00000000, 8


npc_DOGMAN_frame_DOWN:
    .byte <npc_DOGMAN_frame_DOWN_0,   >npc_DOGMAN_frame_DOWN_0
    .byte <npc_DOGMAN_frame_DOWN_1,   >npc_DOGMAN_frame_DOWN_1
    .byte <npc_DOGMAN_frame_DOWN_2,   >npc_DOGMAN_frame_DOWN_2
    .byte <npc_DOGMAN_frame_DOWN_1,   >npc_DOGMAN_frame_DOWN_1
    .byte <npc_DOGMAN_frame_DOWN_ATK, >npc_DOGMAN_frame_DOWN_ATK
    .byte <npc_DOGMAN_frame_DTH,      >npc_DOGMAN_frame_DTH

npc_DOGMAN_frame_DOWN_0:
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $64, %00000000, 0
    .byte 8,  $55, %00000000, 8
    .byte 16, $73, %00000000, 0
    .byte 16, $B3, %01000000, 8

npc_DOGMAN_frame_DOWN_1:
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $65, %00000000, 0
    .byte 8,  $65, %01000000, 8
    .byte 16, $93, %00000000, 0
    .byte 16, $93, %01000000, 8

npc_DOGMAN_frame_DOWN_2:
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $74, %00000000, 0
    .byte 8,  $75, %00000000, 8
    .byte 16, $B3, %00000000, 0
    .byte 16, $73, %01000000, 8

npc_DOGMAN_frame_DOWN_ATK:
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $84, %00000000, 0
    .byte 8,  $85, %00000000, 8
    .byte 16, $94, %00000000, 0
    .byte 16, $95, %00000000, 8


;===================================================
npc_HOUND_sprite_data:

npc_HOUND_frames:
    .byte <npc_HOUND_frame_LEFT,  >npc_HOUND_frame_LEFT
    .byte <npc_HOUND_frame_RIGHT, >npc_HOUND_frame_RIGHT
    .byte <npc_HOUND_frame_UP,    >npc_HOUND_frame_UP
    .byte <npc_HOUND_frame_DOWN,  >npc_HOUND_frame_DOWN

npc_HOUND_frame_DTH:
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8


npc_HOUND_frame_LEFT:
    .byte <npc_HOUND_frame_LEFT_0,   >npc_HOUND_frame_LEFT_0
    .byte <npc_HOUND_frame_LEFT_1,   >npc_HOUND_frame_LEFT_1
    .byte <npc_HOUND_frame_LEFT_2,   >npc_HOUND_frame_LEFT_2
    .byte <npc_HOUND_frame_LEFT_1,   >npc_HOUND_frame_LEFT_1
    .byte <npc_HOUND_frame_LEFT_ATK, >npc_HOUND_frame_LEFT_ATK
    .byte <npc_HOUND_frame_DTH,      >npc_HOUND_frame_DTH

npc_HOUND_frame_LEFT_0:
    .byte 0, $9D, %00000000, 0
    .byte 0, $9E, %00000000, 8
    .byte 8, $AD, %00000000, 0
    .byte 8, $AE, %00000000, 8

npc_HOUND_frame_LEFT_1:
    .byte 0, $AA, %00000000, 0
    .byte 0, $AB, %00000000, 8
    .byte 8, $BA, %00000000, 0
    .byte 8, $BB, %00000000, 8

npc_HOUND_frame_LEFT_2:
    .byte 0, $9D, %00000000, 0
    .byte 0, $9E, %00000000, 8
    .byte 8, $CA, %00000000, 0
    .byte 8, $CB, %00000000, 8

npc_HOUND_frame_LEFT_ATK:
    .byte 0, $DA, %00000000, 0
    .byte 0, $DB, %00000000, 8
    .byte 8, $EA, %00000000, 0
    .byte 8, $EB, %00000000, 8


npc_HOUND_frame_RIGHT:
    .byte <npc_HOUND_frame_RIGHT_0,   >npc_HOUND_frame_RIGHT_0
    .byte <npc_HOUND_frame_RIGHT_1,   >npc_HOUND_frame_RIGHT_1
    .byte <npc_HOUND_frame_RIGHT_2,   >npc_HOUND_frame_RIGHT_2
    .byte <npc_HOUND_frame_RIGHT_1,   >npc_HOUND_frame_RIGHT_1
    .byte <npc_HOUND_frame_RIGHT_ATK, >npc_HOUND_frame_RIGHT_ATK
    .byte <npc_HOUND_frame_DTH,       >npc_HOUND_frame_DTH

npc_HOUND_frame_RIGHT_0:
    .byte 0, $9E, %01000000, 0
    .byte 0, $9D, %01000000, 8
    .byte 8, $AE, %01000000, 0
    .byte 8, $AD, %01000000, 8

npc_HOUND_frame_RIGHT_1:
    .byte 0, $AB, %01000000, 0
    .byte 0, $AA, %01000000, 8
    .byte 8, $BB, %01000000, 0
    .byte 8, $BA, %01000000, 8

npc_HOUND_frame_RIGHT_2:
    .byte 0, $9E, %01000000, 0
    .byte 0, $9D, %01000000, 8
    .byte 8, $CB, %01000000, 0
    .byte 8, $CA, %01000000, 8

npc_HOUND_frame_RIGHT_ATK:
    .byte 0, $DB, %01000000, 0
    .byte 0, $DA, %01000000, 8
    .byte 8, $EB, %01000000, 0
    .byte 8, $EA, %01000000, 8

npc_HOUND_frame_UP:
    .byte <npc_HOUND_frame_UP_0,   >npc_HOUND_frame_UP_0
    .byte <npc_HOUND_frame_UP_1,   >npc_HOUND_frame_UP_1
    .byte <npc_HOUND_frame_UP_2,   >npc_HOUND_frame_UP_2
    .byte <npc_HOUND_frame_UP_1,   >npc_HOUND_frame_UP_1
    .byte <npc_HOUND_frame_UP_ATK, >npc_HOUND_frame_UP_ATK
    .byte <npc_HOUND_frame_DTH,    >npc_HOUND_frame_DTH

npc_HOUND_frame_UP_0:
    .byte 0, $9F, %00000000, 0
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
    .byte 0, $9F, %01000000, 8
    .byte 8, $CC, %00000000, 0
    .byte 8, $AF, %01000000, 8

npc_HOUND_frame_UP_ATK:
    .byte 0, $DC, %00000000, 0
    .byte 0, $DD, %00000000, 8
    .byte 8, $EC, %00000000, 0
    .byte 8, $ED, %00000000, 8

npc_HOUND_frame_DOWN:
    .byte <npc_HOUND_frame_DOWN_0,   >npc_HOUND_frame_DOWN_0
    .byte <npc_HOUND_frame_DOWN_1,   >npc_HOUND_frame_DOWN_1
    .byte <npc_HOUND_frame_DOWN_2,   >npc_HOUND_frame_DOWN_2
    .byte <npc_HOUND_frame_DOWN_1,   >npc_HOUND_frame_DOWN_1
    .byte <npc_HOUND_frame_DOWN_ATK, >npc_HOUND_frame_DOWN_ATK
    .byte <npc_HOUND_frame_DTH,      >npc_HOUND_frame_DTH

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

npc_HOUND_frame_DOWN_ATK:
    .byte 0, $DE, %00000000, 0
    .byte 0, $DE, %01000000, 8
    .byte 8, $EE, %00000000, 0
    .byte 8, $EE, %01000000, 8


;================================================

npc_BJORN_frames:
    .byte <npc_BJORN_frame_LEFT,  >npc_BJORN_frame_LEFT
    .byte <npc_BJORN_frame_RIGHT, >npc_BJORN_frame_RIGHT
    .byte <npc_BJORN_frame_UP,    >npc_BJORN_frame_UP
    .byte <npc_BJORN_frame_DOWN,  >npc_BJORN_frame_DOWN


npc_BJORN_frame_LEFT:
    .byte <npc_BJORN_frame_LEFT_0,   >npc_BJORN_frame_LEFT_0

npc_BJORN_frame_LEFT_0:
    .byte 0,  $8A, %00000000, 0
    .byte 0,  $8B, %00000000, 8
    .byte 8,  $9A, %00000000, 0
    .byte 8,  $9B, %00000000, 8
    .byte 16, $AA, %00000000, 0
    .byte 16, $AB, %00000000, 8

npc_BJORN_frame_RIGHT:
    .byte <npc_BJORN_frame_RIGHT_0,   >npc_BJORN_frame_RIGHT_0

npc_BJORN_frame_RIGHT_0:
    .byte 0,  $8B, %01000000, 0
    .byte 0,  $8A, %01000000, 8
    .byte 8,  $9B, %01000000, 0
    .byte 8,  $9A, %01000000, 8
    .byte 16, $AB, %01000000, 0
    .byte 16, $AA, %01000000, 8

npc_BJORN_frame_UP:
    .byte <npc_BJORN_frame_UP_0,   >npc_BJORN_frame_UP_0

npc_BJORN_frame_UP_0:
    .byte 0,  $8C, %00000000, 0
    .byte 0,  $8D, %00000000, 8
    .byte 8,  $9C, %00000000, 0
    .byte 8,  $9D, %00000000, 8
    .byte 16, $AC, %00000000, 0
    .byte 16, $AD, %00000000, 8

npc_BJORN_frame_DOWN:
    .byte <npc_BJORN_frame_DOWN_0,   >npc_BJORN_frame_DOWN_0

npc_BJORN_frame_DOWN_0:
    .byte 0,  $8E, %00000000, 0
    .byte 0,  $8F, %00000000, 8
    .byte 8,  $9E, %00000000, 0
    .byte 8,  $9F, %00000000, 8
    .byte 16, $AE, %00000000, 0
    .byte 16, $AF, %00000000, 8
;================================================
npc_ERIKA_sprite_data:

npc_ERIKA_frames:
    .byte <npc_ERIKA_frame_LEFT,  >npc_ERIKA_frame_LEFT
    .byte <npc_ERIKA_frame_RIGHT, >npc_ERIKA_frame_RIGHT
    .byte <npc_ERIKA_frame_UP,    >npc_ERIKA_frame_UP
    .byte <npc_ERIKA_frame_DOWN,  >npc_ERIKA_frame_DOWN

npc_ERIKA_frame_LEFT:
    .byte <npc_ERIKA_frame_LEFT_0,   >npc_ERIKA_frame_LEFT_0

npc_ERIKA_frame_LEFT_0:
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $60, %00000000, 0
    .byte 8,  $61, %00000000, 8
    .byte 16, $70, %00000000, 0
    .byte 16, $71, %00000000, 8

npc_ERIKA_frame_RIGHT:
    .byte <npc_ERIKA_frame_RIGHT_0,   >npc_ERIKA_frame_RIGHT_0

npc_ERIKA_frame_RIGHT_0:
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $61, %01000000, 0
    .byte 8,  $60, %01000000, 8
    .byte 16, $71, %01000000, 0
    .byte 16, $70, %01000000, 8

npc_ERIKA_frame_UP:
    .byte <npc_ERIKA_frame_UP_0,   >npc_ERIKA_frame_UP_0

npc_ERIKA_frame_UP_0:
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $62, %00000000, 0
    .byte 8,  $63, %00000000, 8
    .byte 16, $72, %00000000, 0
    .byte 16, $73, %00000000, 8

npc_ERIKA_frame_DOWN:
    .byte <npc_ERIKA_frame_DOWN_0,   >npc_ERIKA_frame_DOWN_0

npc_ERIKA_frame_DOWN_0:
    .byte 0,  $54, %00000000, 0
    .byte 0,  $55, %00000000, 8
    .byte 8,  $64, %00000000, 0
    .byte 8,  $65, %00000000, 8
    .byte 16, $74, %00000000, 0
    .byte 16, $75, %00000000, 8
;========================================
npc_GRANNY_sprite_data:

npc_GRANNY_frames:
    .byte <npc_GRANNY_frame_LEFT,  >npc_GRANNY_frame_LEFT
    .byte <npc_GRANNY_frame_RIGHT, >npc_GRANNY_frame_RIGHT
    .byte <npc_GRANNY_frame_UP,    >npc_GRANNY_frame_UP
    .byte <npc_GRANNY_frame_DOWN,  >npc_GRANNY_frame_DOWN

npc_GRANNY_frame_LEFT:
    .byte <npc_GRANNY_frame_LEFT_0, >npc_GRANNY_frame_LEFT_0

npc_GRANNY_frame_LEFT_0:
    .byte 0, $6A, %00000000, 0
    .byte 0, $6B, %00000000, 8
    .byte 8, $7A, %00000000, 0
    .byte 8, $7B, %00000000, 8

npc_GRANNY_frame_RIGHT:
    .byte <npc_GRANNY_frame_RIGHT_0, >npc_GRANNY_frame_RIGHT_0

npc_GRANNY_frame_RIGHT_0:
    .byte 0, $6B, %01000000, 0
    .byte 0, $6A, %01000000, 8
    .byte 8, $7B, %01000000, 0
    .byte 8, $7A, %01000000, 8

npc_GRANNY_frame_UP:
    .byte <npc_GRANNY_frame_UP_0, >npc_GRANNY_frame_UP_0

npc_GRANNY_frame_UP_0:
    .byte 0, $6C, %00000000, 0
    .byte 0, $6D, %00000000, 8
    .byte 8, $7C, %00000000, 0
    .byte 8, $7D, %00000000, 8

npc_GRANNY_frame_DOWN:
    .byte <npc_GRANNY_frame_DOWN_0, >npc_GRANNY_frame_DOWN_0

npc_GRANNY_frame_DOWN_0:
    .byte 0, $6E, %00000000, 0
    .byte 0, $6F, %00000000, 8
    .byte 8, $7E, %00000000, 0
    .byte 8, $7F, %00000000, 8
;====================================

npc_DEADMAN_frames:
    .byte                        0, 0
    .byte <npc_DEADMAN_frame_RIGHT, >npc_DEADMAN_frame_RIGHT

npc_DEADMAN_frame_RIGHT:
    .byte <npc_DEADMAN_frame_RIGHT_0, >npc_DEADMAN_frame_RIGHT_0

npc_DEADMAN_frame_RIGHT_0:
    .byte 0,  $0A, %00000000, 0
    .byte 0,  $0B, %00000000, 8
    .byte 8,  $1A, %00000000, 0
    .byte 8,  $1B, %00000000, 8
    .byte 16, $2A, %00000000, 0
    .byte 16, $2B, %00000000, 8
;======================================

npc_BOAR_frames:
    .byte <npc_BOAR_frames_LEFT,  >npc_BOAR_frames_LEFT
    .byte <npc_BOAR_frames_RIGHT, >npc_BOAR_frames_RIGHT
    .byte <npc_BOAR_frames_UP,    >npc_BOAR_frames_UP
    .byte <npc_BOAR_frames_DOWN,  >npc_BOAR_frames_DOWN

npc_BOAR_frame_DTH:
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8

npc_BOAR_frames_LEFT:
    .byte <npc_BOAR_frame_LEFT_0,   >npc_BOAR_frame_LEFT_0
    .byte <npc_BOAR_frame_LEFT_1,   >npc_BOAR_frame_LEFT_1
    .byte <npc_BOAR_frame_LEFT_2,   >npc_BOAR_frame_LEFT_2
    .byte <npc_BOAR_frame_LEFT_1,   >npc_BOAR_frame_LEFT_1
    .byte <npc_BOAR_frame_LEFT_ATK, >npc_BOAR_frame_LEFT_ATK
    .byte <npc_BOAR_frame_DTH,      >npc_BOAR_frame_DTH

npc_BOAR_frame_LEFT_0:
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8

npc_BOAR_frame_LEFT_1:
    .byte 0, $5E, %00000000, 0
    .byte 0, $5F, %00000000, 8
    .byte 8, $6E, %00000000, 0
    .byte 8, $6F, %00000000, 8

npc_BOAR_frame_LEFT_2:
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $2E, %00000000, 0
    .byte 8, $2F, %00000000, 8

npc_BOAR_frame_LEFT_ATK:
    .byte 0, $5A, %00000000, 0
    .byte 0, $5B, %00000000, 8
    .byte 8, $6A, %00000000, 0
    .byte 8, $6B, %00000000, 8

;----------------------------------
npc_BOAR_frames_RIGHT:
    .byte <npc_BOAR_frame_RIGHT_0,   >npc_BOAR_frame_RIGHT_0
    .byte <npc_BOAR_frame_RIGHT_1,   >npc_BOAR_frame_RIGHT_1
    .byte <npc_BOAR_frame_RIGHT_2,   >npc_BOAR_frame_RIGHT_2
    .byte <npc_BOAR_frame_RIGHT_1,   >npc_BOAR_frame_RIGHT_1
    .byte <npc_BOAR_frame_RIGHT_ATK, >npc_BOAR_frame_RIGHT_ATK
    .byte <npc_BOAR_frame_DTH,       >npc_BOAR_frame_DTH

npc_BOAR_frame_RIGHT_0:
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8

npc_BOAR_frame_RIGHT_1:
    .byte 0, $5F, %01000000, 0
    .byte 0, $5E, %01000000, 8
    .byte 8, $6F, %01000000, 0
    .byte 8, $6E, %01000000, 8

npc_BOAR_frame_RIGHT_2:
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $2F, %01000000, 0
    .byte 8, $2E, %01000000, 8

npc_BOAR_frame_RIGHT_ATK:
    .byte 0, $5B, %01000000, 0
    .byte 0, $5A, %01000000, 8
    .byte 8, $6B, %01000000, 0
    .byte 8, $6A, %01000000, 8

;-------------------------------
npc_BOAR_frames_UP:
    .byte <npc_BOAR_frame_UP_0,   >npc_BOAR_frame_UP_0
    .byte <npc_BOAR_frame_UP_1,   >npc_BOAR_frame_UP_1
    .byte <npc_BOAR_frame_UP_2,   >npc_BOAR_frame_UP_2
    .byte <npc_BOAR_frame_UP_1,   >npc_BOAR_frame_UP_1
    .byte <npc_BOAR_frame_UP_ATK, >npc_BOAR_frame_UP_ATK
    .byte <npc_BOAR_frame_DTH,    >npc_BOAR_frame_DTH

npc_BOAR_frame_UP_0:
    .byte 0, $7B, %00000000, 0
    .byte 0, $7C, %00000000, 8
    .byte 8, $7D, %00000000, 0
    .byte 8, $7E, %00000000, 8

npc_BOAR_frame_UP_1:
    .byte 0, $3D, %00000000, 0
    .byte 0, $3E, %00000000, 8
    .byte 8, $4D, %00000000, 0
    .byte 8, $4E, %00000000, 8

npc_BOAR_frame_UP_2:
    .byte 0, $8B, %00000000, 0
    .byte 0, $8C, %00000000, 8
    .byte 8, $9B, %00000000, 0
    .byte 8, $9C, %00000000, 8

npc_BOAR_frame_UP_ATK:
    .byte 0, $5C, %00000000, 0
    .byte 0, $5D, %00000000, 8
    .byte 8, $6C, %00000000, 0
    .byte 8, $6D, %00000000, 8

;------------------------------
npc_BOAR_frames_DOWN:
    .byte <npc_BOAR_frame_DOWN_0,   >npc_BOAR_frame_DOWN_0
    .byte <npc_BOAR_frame_DOWN_1,   >npc_BOAR_frame_DOWN_1
    .byte <npc_BOAR_frame_DOWN_2,   >npc_BOAR_frame_DOWN_2
    .byte <npc_BOAR_frame_DOWN_1,   >npc_BOAR_frame_DOWN_1
    .byte <npc_BOAR_frame_DOWN_ATK, >npc_BOAR_frame_DOWN_ATK
    .byte <npc_BOAR_frame_DTH,      >npc_BOAR_frame_DTH

npc_BOAR_frame_DOWN_0:
    .byte 0, $7A, %00000000, 0
    .byte 0, $7A, %01000000, 8
    .byte 8, $8A, %00000000, 0
    .byte 8, $2D, %01000000, 8

npc_BOAR_frame_DOWN_1:
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8

npc_BOAR_frame_DOWN_2:
    .byte 0, $7A, %00000000, 0
    .byte 0, $7A, %01000000, 8
    .byte 8, $2D, %00000000, 0
    .byte 8, $8A, %01000000, 8

npc_BOAR_frame_DOWN_ATK:
    .byte 0, $3F, %00000000, 0
    .byte 0, $3F, %01000000, 8
    .byte 8, $4F, %00000000, 0
    .byte 8, $4F, %01000000, 8

;=======================================================
;BOSS

npc_BOSS_frames:
    .byte <npc_BOSS_frame_LEFT,  >npc_BOSS_frame_LEFT
    .byte <npc_BOSS_frame_RIGHT, >npc_BOSS_frame_RIGHT
    .byte <npc_BOSS_frame_UP,    >npc_BOSS_frame_UP
    .byte <npc_BOSS_frame_DOWN,  >npc_BOSS_frame_DOWN

npc_BOSS_frame_DTH:
    .byte 0,  $fe, %00000000, 0
    .byte 0,  $b8, %00000000, 8
    .byte 0,  $b9, %00000000, 16
    .byte 0,  $fe, %01000000, 24

    .byte 8,  $b8, %00000000, 0
    .byte 8,  $b8, %00000000, 8
    .byte 8,  $b9, %00000000, 16
    .byte 8,  $b9, %01000000, 24

    .byte 16, $b8, %00000000, 0
    .byte 16, $fe, %00000000, 8
    .byte 16, $fe, %00000000, 16
    .byte 16, $b9, %01000000, 24

    .byte 24, $c8, %00000000, 0
    .byte 24, $c8, %00000000, 8
    .byte 24, $fe, %00000000, 16
    .byte 24, $c9, %01000000, 24

    .byte 32, $c8, %10000000, 0
    .byte 32, $c8, %10000000, 8
    .byte 32, $c9, %10000000, 16
    .byte 32, $fe, %11000000, 24



npc_BOSS_frame_LEFT:
    .byte <npc_BOSS_frame_LEFT_0,   >npc_BOSS_frame_LEFT_0
    .byte <npc_BOSS_frame_LEFT_1,   >npc_BOSS_frame_LEFT_1
    .byte <npc_BOSS_frame_LEFT_2,   >npc_BOSS_frame_LEFT_2
    .byte <npc_BOSS_frame_LEFT_1,   >npc_BOSS_frame_LEFT_1
    .byte <npc_BOSS_frame_LEFT_ATK, >npc_BOSS_frame_LEFT_ATK
    .byte <npc_BOSS_frame_DTH,      >npc_BOSS_frame_DTH

npc_BOSS_frame_LEFT_0:
    .byte 0,  $6e, %00000000, 0
    .byte 0,  $6f, %00000000, 8
    .byte 0,  $7e, %00000000, 16
    .byte 0,  $7f, %00000000, 24

    .byte 8,  $8e, %00000000, 0
    .byte 8,  $8f, %00000000, 8
    .byte 8,  $9e, %00000000, 16
    .byte 8,  $9f, %00000000, 24

    .byte 16, $fe, %00000000, 0
    .byte 16, $ae, %00000000, 8
    .byte 16, $af, %00000000, 16
    .byte 16, $ac, %00000000, 24

    .byte 24, $fe, %00000000, 0
    .byte 24, $fe, %00000000, 8
    .byte 24, $3a, %00000000, 16
    .byte 24, $3b, %00000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $cb, %00000000, 8
    .byte 32, $eb, %00000000, 16
    .byte 32, $ec, %00000000, 24


npc_BOSS_frame_LEFT_1:
    .byte 0,  $6e, %00000000, 0
    .byte 0,  $6f, %00000000, 8
    .byte 0,  $7e, %00000000, 16
    .byte 0,  $7f, %00000000, 24

    .byte 8,  $8e, %00000000, 0
    .byte 8,  $8f, %00000000, 8
    .byte 8,  $9e, %00000000, 16
    .byte 8,  $9f, %00000000, 24

    .byte 16, $fe, %00000000, 0
    .byte 16, $ae, %00000000, 8
    .byte 16, $af, %00000000, 16
    .byte 16, $ac, %00000000, 24

    .byte 24, $fe, %00000000, 0
    .byte 24, $fe, %00000000, 8
    .byte 24, $3a, %00000000, 16
    .byte 24, $3b, %00000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $4a, %00000000, 8
    .byte 32, $4b, %00000000, 16
    .byte 32, $fe, %00000000, 24

npc_BOSS_frame_LEFT_2:
    .byte 0,  $6e, %00000000, 0
    .byte 0,  $6f, %00000000, 8
    .byte 0,  $7e, %00000000, 16
    .byte 0,  $7f, %00000000, 24

    .byte 8,  $8e, %00000000, 0
    .byte 8,  $8f, %00000000, 8
    .byte 8,  $9e, %00000000, 16
    .byte 8,  $9f, %00000000, 24

    .byte 16, $fe, %00000000, 0
    .byte 16, $ae, %00000000, 8
    .byte 16, $af, %00000000, 16
    .byte 16, $ac, %00000000, 24

    .byte 24, $fe, %00000000, 0
    .byte 24, $fe, %00000000, 8
    .byte 24, $3a, %00000000, 16
    .byte 24, $3b, %00000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $da, %00000000, 8
    .byte 32, $db, %00000000, 16
    .byte 32, $bb, %00000000, 24

npc_BOSS_frame_LEFT_ATK:
    .byte 0,  $6e, %00000000, 0
    .byte 0,  $5a, %00000000, 8
    .byte 0,  $7e, %00000000, 16
    .byte 0,  $7f, %00000000, 24

    .byte 8,  $5b, %00000000, 0
    .byte 8,  $6a, %00000000, 8
    .byte 8,  $6b, %00000000, 16
    .byte 8,  $9f, %00000000, 24

    .byte 16, $7a, %00000000, 0
    .byte 16, $7b, %00000000, 8
    .byte 16, $8a, %00000000, 16
    .byte 16, $8b, %00000000, 24

    .byte 24, $9a, %00000000, 0
    .byte 24, $9b, %00000000, 8
    .byte 24, $aa, %00000000, 16
    .byte 24, $ab, %00000000, 24

    .byte 32, $ca, %00000000, 0
    .byte 32, $fe, %00000000, 8
    .byte 32, $ba, %00000000, 16
    .byte 32, $bb, %00000000, 24


npc_BOSS_frame_RIGHT:
    .byte <npc_BOSS_frame_RIGHT_0,   >npc_BOSS_frame_RIGHT_0
    .byte <npc_BOSS_frame_RIGHT_1,   >npc_BOSS_frame_RIGHT_1
    .byte <npc_BOSS_frame_RIGHT_2,   >npc_BOSS_frame_RIGHT_2
    .byte <npc_BOSS_frame_RIGHT_1,   >npc_BOSS_frame_RIGHT_1
    .byte <npc_BOSS_frame_RIGHT_ATK, >npc_BOSS_frame_RIGHT_ATK
    .byte <npc_BOSS_frame_DTH,       >npc_BOSS_frame_DTH

npc_BOSS_frame_RIGHT_0:
    .byte 0,  $6e, %01000000, 24
    .byte 0,  $6f, %01000000, 16
    .byte 0,  $7e, %01000000, 8
    .byte 0,  $7f, %01000000, 0

    .byte 8,  $8e, %01000000, 24
    .byte 8,  $8f, %01000000, 16
    .byte 8,  $9e, %01000000, 8
    .byte 8,  $9f, %01000000, 0

    .byte 16, $fe, %01000000, 24
    .byte 16, $ae, %01000000, 16
    .byte 16, $af, %01000000, 8
    .byte 16, $ac, %01000000, 0

    .byte 24, $fe, %01000000, 24
    .byte 24, $fe, %01000000, 16
    .byte 24, $3a, %01000000, 8
    .byte 24, $3b, %01000000, 0

    .byte 32, $fe, %01000000, 24
    .byte 32, $cb, %01000000, 16
    .byte 32, $eb, %01000000, 8
    .byte 32, $ec, %01000000, 0


npc_BOSS_frame_RIGHT_1:
    .byte 0,  $6e, %01000000, 24
    .byte 0,  $6f, %01000000, 16
    .byte 0,  $7e, %01000000, 8
    .byte 0,  $7f, %01000000, 0

    .byte 8,  $8e, %01000000, 24
    .byte 8,  $8f, %01000000, 16
    .byte 8,  $9e, %01000000, 8
    .byte 8,  $9f, %01000000, 0

    .byte 16, $fe, %01000000, 24
    .byte 16, $ae, %01000000, 16
    .byte 16, $af, %01000000, 8
    .byte 16, $ac, %01000000, 0

    .byte 24, $fe, %01000000, 24
    .byte 24, $fe, %01000000, 16
    .byte 24, $3a, %01000000, 8
    .byte 24, $3b, %01000000, 0

    .byte 32, $fe, %01000000, 24
    .byte 32, $4a, %01000000, 16
    .byte 32, $4b, %01000000, 8
    .byte 32, $fe, %01000000, 0

npc_BOSS_frame_RIGHT_2:
    .byte 0,  $6e, %01000000, 24
    .byte 0,  $6f, %01000000, 16
    .byte 0,  $7e, %01000000, 8
    .byte 0,  $7f, %01000000, 0

    .byte 8,  $8e, %01000000, 24
    .byte 8,  $8f, %01000000, 16
    .byte 8,  $9e, %01000000, 8
    .byte 8,  $9f, %01000000, 0

    .byte 16, $fe, %01000000, 24
    .byte 16, $ae, %01000000, 16
    .byte 16, $af, %01000000, 8
    .byte 16, $ac, %01000000, 0

    .byte 24, $fe, %01000000, 24
    .byte 24, $fe, %01000000, 16
    .byte 24, $3a, %01000000, 8
    .byte 24, $3b, %01000000, 0

    .byte 32, $fe, %01000000, 24
    .byte 32, $da, %01000000, 16
    .byte 32, $db, %01000000, 8
    .byte 32, $bb, %01000000, 0

npc_BOSS_frame_RIGHT_ATK:
    .byte 0,  $6e, %01000000, 24
    .byte 0,  $5a, %01000000, 16
    .byte 0,  $7e, %01000000, 8
    .byte 0,  $7f, %01000000, 0

    .byte 8,  $5b, %01000000, 24
    .byte 8,  $6a, %01000000, 16
    .byte 8,  $6b, %01000000, 8
    .byte 8,  $9f, %01000000, 0

    .byte 16, $7a, %01000000, 24
    .byte 16, $7b, %01000000, 16
    .byte 16, $8a, %01000000, 8
    .byte 16, $8b, %01000000, 0

    .byte 24, $9a, %01000000, 24
    .byte 24, $9b, %01000000, 16
    .byte 24, $aa, %01000000, 8
    .byte 24, $ab, %01000000, 0

    .byte 32, $ca, %01000000, 24
    .byte 32, $fe, %01000000, 16
    .byte 32, $ba, %01000000, 8
    .byte 32, $bb, %01000000, 0


npc_BOSS_frame_UP:
    .byte <npc_BOSS_frame_UP_0,   >npc_BOSS_frame_UP_0
    .byte <npc_BOSS_frame_UP_1,   >npc_BOSS_frame_UP_1
    .byte <npc_BOSS_frame_UP_2,   >npc_BOSS_frame_UP_2
    .byte <npc_BOSS_frame_UP_1,   >npc_BOSS_frame_UP_1
    .byte <npc_BOSS_frame_UP_ATK, >npc_BOSS_frame_UP_ATK
    .byte <npc_BOSS_frame_DTH,    >npc_BOSS_frame_DTH

npc_BOSS_frame_UP_0:
    .byte 0,  $6c, %00000000, 0
    .byte 0,  $6d, %00000000, 8
    .byte 0,  $6d, %01000000, 16
    .byte 0,  $6c, %01000000, 24

    .byte 8,  $7c, %00000000, 0
    .byte 8,  $7d, %00000000, 8
    .byte 8,  $7d, %01000000, 16
    .byte 8,  $3f, %01000000, 24

    .byte 16, $0f, %01000000, 0
    .byte 16, $8d, %00000000, 8
    .byte 16, $8d, %01000000, 16
    .byte 16, $4f, %01000000, 24

    .byte 24, $8c, %00000000, 0
    .byte 24, $dd, %00000000, 8
    .byte 24, $9d, %01000000, 16
    .byte 24, $5f, %01000000, 24

    .byte 32, $9c, %00000000, 0
    .byte 32, $ed, %00000000, 8
    .byte 32, $ee, %00000000, 16
    .byte 32, $fe, %01000000, 24

npc_BOSS_frame_UP_1:
    .byte 0,  $6c, %00000000, 0
    .byte 0,  $6d, %00000000, 8
    .byte 0,  $6d, %01000000, 16
    .byte 0,  $6c, %01000000, 24

    .byte 8,  $7c, %00000000, 0
    .byte 8,  $7d, %00000000, 8
    .byte 8,  $7d, %01000000, 16
    .byte 8,  $7c, %01000000, 24

    .byte 16, $0f, %01000000, 0
    .byte 16, $8d, %00000000, 8
    .byte 16, $8d, %01000000, 16
    .byte 16, $0f, %00000000, 24

    .byte 24, $8c, %00000000, 0
    .byte 24, $9d, %00000000, 8
    .byte 24, $9d, %01000000, 16
    .byte 24, $8c, %01000000, 24

    .byte 32, $9c, %00000000, 0
    .byte 32, $ad, %00000000, 8
    .byte 32, $ad, %01000000, 16
    .byte 32, $9c, %01000000, 24

npc_BOSS_frame_UP_2:
    .byte 0,  $6c, %00000000, 0
    .byte 0,  $6d, %00000000, 8
    .byte 0,  $6d, %01000000, 16
    .byte 0,  $6c, %01000000, 24

    .byte 8,  $3f, %00000000, 0
    .byte 8,  $7d, %00000000, 8
    .byte 8,  $7d, %01000000, 16
    .byte 8,  $7c, %01000000, 24

    .byte 16, $4f, %00000000, 0
    .byte 16, $8d, %00000000, 8
    .byte 16, $8d, %01000000, 16
    .byte 16, $0f, %00000000, 24

    .byte 24, $5f, %00000000, 0
    .byte 24, $9d, %00000000, 8
    .byte 24, $dd, %01000000, 16
    .byte 24, $8c, %01000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $ee, %01000000, 8
    .byte 32, $ed, %01000000, 16
    .byte 32, $9c, %01000000, 24


npc_BOSS_frame_UP_ATK:
    .byte 0,  $6c, %00000000, 0
    .byte 0,  $6d, %00000000, 8
    .byte 0,  $6d, %01000000, 16
    .byte 0,  $6c, %01000000, 24

    .byte 8,  $bc, %00000000, 0
    .byte 8,  $bd, %00000000, 8
    .byte 8,  $7d, %01000000, 16
    .byte 8,  $bf, %00000000, 24

    .byte 16, $cc, %00000000, 0
    .byte 16, $cd, %00000000, 8
    .byte 16, $ce, %00000000, 16
    .byte 16, $cf, %00000000, 24

    .byte 24, $fe, %00000000, 0
    .byte 24, $dd, %00000000, 8
    .byte 24, $de, %00000000, 16
    .byte 24, $df, %00000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $ed, %00000000, 8
    .byte 32, $ee, %00000000, 16
    .byte 32, $ef, %01000000, 24


npc_BOSS_frame_DOWN:
    .byte <npc_BOSS_frame_DOWN_0,   >npc_BOSS_frame_DOWN_0
    .byte <npc_BOSS_frame_DOWN_1,   >npc_BOSS_frame_DOWN_1
    .byte <npc_BOSS_frame_DOWN_2,   >npc_BOSS_frame_DOWN_2
    .byte <npc_BOSS_frame_DOWN_1,   >npc_BOSS_frame_DOWN_1
    .byte <npc_BOSS_frame_DOWN_ATK, >npc_BOSS_frame_DOWN_ATK
    .byte <npc_BOSS_frame_DTH,      >npc_BOSS_frame_DTH

npc_BOSS_frame_DOWN_0:
    .byte 0,  $0d, %01000000, 0
    .byte 0,  $0c, %01000000, 8
    .byte 0,  $0c, %00000000, 16
    .byte 0,  $0d, %00000000, 24

    .byte 8,  $1d, %01000000, 0
    .byte 8,  $1c, %01000000, 8
    .byte 8,  $1c, %00000000, 16
    .byte 8,  $3f, %01000000, 24

    .byte 16, $0f, %01000000, 0
    .byte 16, $0e, %01000000, 8
    .byte 16, $0e, %00000000, 16
    .byte 16, $4f, %01000000, 24

    .byte 24, $1f, %01000000, 0
    .byte 24, $1e, %01000000, 8
    .byte 24, $1e, %00000000, 16
    .byte 24, $5f, %01000000, 24

    .byte 32, $2f, %01000000, 0
    .byte 32, $2c, %01000000, 8
    .byte 32, $2e, %00000000, 16
    .byte 32, $fe, %00000000, 24

npc_BOSS_frame_DOWN_1:
    .byte 0,  $0d, %01000000, 0
    .byte 0,  $0c, %01000000, 8
    .byte 0,  $0c, %00000000, 16
    .byte 0,  $0d, %00000000, 24

    .byte 8,  $1d, %01000000, 0
    .byte 8,  $1c, %01000000, 8
    .byte 8,  $1c, %00000000, 16
    .byte 8,  $1d, %00000000, 24

    .byte 16, $0f, %01000000, 0
    .byte 16, $0e, %01000000, 8
    .byte 16, $0e, %00000000, 16
    .byte 16, $0f, %00000000, 24

    .byte 24, $1f, %01000000, 0
    .byte 24, $1e, %01000000, 8
    .byte 24, $1e, %00000000, 16
    .byte 24, $1f, %00000000, 24

    .byte 32, $2f, %01000000, 0
    .byte 32, $2e, %01000000, 8
    .byte 32, $2e, %00000000, 16
    .byte 32, $2f, %00000000, 24

npc_BOSS_frame_DOWN_2:
    .byte 0,  $0d, %01000000, 0
    .byte 0,  $0c, %01000000, 8
    .byte 0,  $0c, %00000000, 16
    .byte 0,  $0d, %00000000, 24

    .byte 8,  $3f, %00000000, 0
    .byte 8,  $1c, %01000000, 8
    .byte 8,  $1c, %00000000, 16
    .byte 8,  $1d, %00000000, 24

    .byte 16, $4f, %00000000, 0
    .byte 16, $0e, %01000000, 8
    .byte 16, $0e, %00000000, 16
    .byte 16, $0f, %00000000, 24

    .byte 24, $5f, %00000000, 0
    .byte 24, $1e, %01000000, 8
    .byte 24, $1e, %00000000, 16
    .byte 24, $1f, %00000000, 24

    .byte 32, $fe, %01000000, 0
    .byte 32, $2e, %01000000, 8
    .byte 32, $2c, %00000000, 16
    .byte 32, $2f, %00000000, 24

npc_BOSS_frame_DOWN_ATK:
    .byte 0,  $2d, %01000000, 0
    .byte 0,  $0c, %01000000, 8
    .byte 0,  $0c, %00000000, 16
    .byte 0,  $2d, %00000000, 24

    .byte 8,  $3f, %00000000, 0
    .byte 8,  $3c, %01000000, 8
    .byte 8,  $3c, %00000000, 16
    .byte 8,  $3d, %00000000, 24

    .byte 16, $4f, %00000000, 0
    .byte 16, $4c, %00000000, 8
    .byte 16, $4d, %00000000, 16
    .byte 16, $4e, %00000000, 24

    .byte 24, $5f, %00000000, 0
    .byte 24, $5c, %00000000, 8
    .byte 24, $5d, %00000000, 16
    .byte 24, $5e, %00000000, 24

    .byte 32, $fe, %00000000, 0
    .byte 32, $3e, %00000000, 8
    .byte 32, $2c, %00000000, 16
    .byte 32, $fe, %00000000, 24

