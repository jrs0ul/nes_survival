npc_anim_3_row_sequence:
    .byte 0
    .byte 3
    .byte 6
    .byte 9
    .byte 12
    .byte 15

npc_anim_2_row_sequence:
    .byte 0
    .byte 2
    .byte 4
    .byte 6
    .byte 8
    .byte 10

npc_anim_rows:
    .byte 0,                        0
    .byte 0,                        0
    .byte <npc_anim_2_row_sequence, >npc_anim_2_row_sequence
    .byte <npc_anim_3_row_sequence, >npc_anim_3_row_sequence

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


;Bunny
npc_BUNNY_sprite_data:

npc_BUNNY_frames:
    .byte <npc_BUNNY_frame_LEFT,  >npc_BUNNY_frame_LEFT
    .byte <npc_BUNNY_frame_RIGHT, >npc_BUNNY_frame_RIGHT
    .byte <npc_BUNNY_frame_UP,    >npc_BUNNY_frame_UP
    .byte <npc_BUNNY_frame_DOWN,  >npc_BUNNY_frame_DOWN


npc_BUNNY_frame_LEFT:
;frame 0
    .byte 0, $0A, %00000000, 0
    .byte 0, $0B, %00000000, 8
    .byte 8, $1A, %00000000, 0
    .byte 8, $1B, %00000000, 8
;frame 1
    .byte 0, $0E, %00000000, 0
    .byte 0, $0F, %00000000, 8
    .byte 8, $1E, %00000000, 0
    .byte 8, $1F, %00000000, 8
;frame 2
    .byte 0, $0A, %00000000, 0
    .byte 0, $0B, %00000000, 8
    .byte 8, $1A, %00000000, 0
    .byte 8, $1B, %00000000, 8
;frame 3
    .byte 0, $0E, %00000000, 0
    .byte 0, $0F, %00000000, 8
    .byte 8, $1E, %00000000, 0
    .byte 8, $1F, %00000000, 8
;unused
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8



npc_BUNNY_frame_RIGHT:
;frame 0
    .byte 0, $0B, %01000000, 0 ;must be 0
    .byte 0, $0A, %01000000, 8 ;must be 8, because second sprite can be skipped
    .byte 8, $1B, %01000000, 0
    .byte 8, $1A, %01000000, 8
;frame 1
    .byte 0, $0F, %01000000, 0
    .byte 0, $0E, %01000000, 8
    .byte 8, $1F, %01000000, 0
    .byte 8, $1E, %01000000, 8
;frame 2
    .byte 0, $0B, %01000000, 0
    .byte 0, $0A, %01000000, 8
    .byte 8, $1B, %01000000, 0
    .byte 8, $1A, %01000000, 8
;frame 3
    .byte 0, $0F, %01000000, 0
    .byte 0, $0E, %01000000, 8
    .byte 8, $1F, %01000000, 0
    .byte 8, $1E, %01000000, 8
;unused
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8


npc_BUNNY_frame_UP:
;frame 0
    .byte 0, $0C, %00000000, 0
    .byte 0, $0C, %01000000, 8
    .byte 8, $1C, %00000000, 0
    .byte 8, $1C, %01000000, 8
;frame 1
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2B, %00000000, 0
    .byte 8, $2B, %01000000, 8
;frame 2
    .byte 0, $0C, %00000000, 0
    .byte 0, $0C, %01000000, 8
    .byte 8, $1C, %00000000, 0
    .byte 8, $1C, %01000000, 8
;frame 3
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2B, %00000000, 0
    .byte 8, $2B, %01000000, 8
;unused
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8



npc_BUNNY_frame_DOWN:
;frame 0
    .byte 0, $0D, %00000000, 0
    .byte 0, $0D, %01000000, 8
    .byte 8, $1D, %00000000, 0
    .byte 8, $1D, %01000000, 8
;frame 1
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2A, %00000000, 0
    .byte 8, $2A, %01000000, 8
;frame 2
    .byte 0, $0D, %00000000, 0
    .byte 0, $0D, %01000000, 8
    .byte 8, $1D, %00000000, 0
    .byte 8, $1D, %01000000, 8
;frame 3
    .byte 0, $2C, %00000000, 0
    .byte 0, $2C, %01000000, 8
    .byte 8, $2A, %00000000, 0
    .byte 8, $2A, %01000000, 8
;unused
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8

;=============================================

npc_DOGMAN_frames:
    .byte <npc_DOGMAN_frame_LEFT,  >npc_DOGMAN_frame_LEFT
    .byte <npc_DOGMAN_frame_RIGHT, >npc_DOGMAN_frame_RIGHT
    .byte <npc_DOGMAN_frame_UP,    >npc_DOGMAN_frame_UP
    .byte <npc_DOGMAN_frame_DOWN,  >npc_DOGMAN_frame_DOWN


npc_DOGMAN_sprite_data:

npc_DOGMAN_frame_LEFT:
;frame 0
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $60, %00000000, 0
    .byte 8,  $61, %00000000, 8
    .byte 16, $70, %00000000, 0
    .byte 16, $71, %00000000, 8
;frame 1
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $80, %00000000, 0
    .byte 8,  $81, %00000000, 8
    .byte 16, $90, %00000000, 0
    .byte 16, $91, %00000000, 8
;frame 2
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $A0, %00000000, 0
    .byte 8,  $A1, %00000000, 8
    .byte 16, $B0, %00000000, 0
    .byte 16, $B1, %00000000, 8
;frame 3
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $80, %00000000, 0
    .byte 8,  $81, %00000000, 8
    .byte 16, $90, %00000000, 0
    .byte 16, $91, %00000000, 8
;attack
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $C0, %00000000, 0
    .byte 8,  $C1, %00000000, 8
    .byte 16, $D0, %00000000, 0
    .byte 16, $D1, %00000000, 8
;dead
    .byte 0,  $B8, %00000000, 0
    .byte 0,  $B9, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $C8, %00000000, 0
    .byte 16, $C9, %00000000, 8


npc_DOGMAN_frame_RIGHT:
;frame 0
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $61, %01000000, 0
    .byte 8,  $60, %01000000, 8
    .byte 16, $71, %01000000, 0
    .byte 16, $70, %01000000, 8
;frame 1
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $81, %01000000, 0
    .byte 8,  $80, %01000000, 8
    .byte 16, $91, %01000000, 0
    .byte 16, $90, %01000000, 8
;frame 2
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $A1, %01000000, 0
    .byte 8,  $A0, %01000000, 8
    .byte 16, $B1, %01000000, 0
    .byte 16, $B0, %01000000, 8
;frame 3
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $81, %01000000, 0
    .byte 8,  $80, %01000000, 8
    .byte 16, $91, %01000000, 0
    .byte 16, $90, %01000000, 8
;attack
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $C1, %01000000, 0
    .byte 8,  $C0, %01000000, 8
    .byte 16, $D1, %01000000, 0
    .byte 16, $D0, %01000000, 8
;dead
    .byte 0,  $B8, %00000000, 0
    .byte 0,  $B9, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $C8, %00000000, 0
    .byte 16, $C9, %00000000, 8



npc_DOGMAN_frame_UP:
;frame 0
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $62, %00000000, 0
    .byte 8,  $63, %00000000, 8
    .byte 16, $72, %00000000, 0
    .byte 16, $B2, %01000000, 8
;frame 1
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $82, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $92, %00000000, 0
    .byte 16, $92, %01000000, 8
;frame 2
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $A2, %00000000, 0
    .byte 8,  $A3, %00000000, 8
    .byte 16, $B2, %00000000, 0
    .byte 16, $72, %01000000, 8
;frame 1
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $82, %00000000, 0
    .byte 8,  $83, %00000000, 8
    .byte 16, $92, %00000000, 0
    .byte 16, $92, %01000000, 8
;attack
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $A4, %00000000, 0
    .byte 8,  $A5, %00000000, 8
    .byte 16, $B4, %00000000, 0
    .byte 16, $B5, %00000000, 8
;dead
    .byte 0,  $B8, %00000000, 0
    .byte 0,  $B9, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $C8, %00000000, 0
    .byte 16, $C9, %00000000, 8


npc_DOGMAN_frame_DOWN:
;frame 0
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $64, %00000000, 0
    .byte 8,  $55, %00000000, 8
    .byte 16, $73, %00000000, 0
    .byte 16, $B3, %01000000, 8
;frame 1
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $65, %00000000, 0
    .byte 8,  $65, %01000000, 8
    .byte 16, $93, %00000000, 0
    .byte 16, $93, %01000000, 8
;frame 2
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $74, %00000000, 0
    .byte 8,  $75, %00000000, 8
    .byte 16, $B3, %00000000, 0
    .byte 16, $73, %01000000, 8
;frame 3
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $65, %00000000, 0
    .byte 8,  $65, %01000000, 8
    .byte 16, $93, %00000000, 0
    .byte 16, $93, %01000000, 8
;attack
    .byte 0,  $54, %00000000, 0
    .byte 0,  $54, %01000000, 8
    .byte 8,  $84, %00000000, 0
    .byte 8,  $85, %00000000, 8
    .byte 16, $94, %00000000, 0
    .byte 16, $95, %00000000, 8
;dead
    .byte 0,  $B8, %00000000, 0
    .byte 0,  $B9, %00000000, 8
    .byte 8,  $C8, %00000000, 0
    .byte 8,  $C9, %00000000, 8
    .byte 16, $C8, %00000000, 0
    .byte 16, $C9, %00000000, 8



;===================================================
npc_HOUND_sprite_data:

npc_HOUND_frames:
    .byte <npc_HOUND_frame_LEFT,  >npc_HOUND_frame_LEFT
    .byte <npc_HOUND_frame_RIGHT, >npc_HOUND_frame_RIGHT
    .byte <npc_HOUND_frame_UP,    >npc_HOUND_frame_UP
    .byte <npc_HOUND_frame_DOWN,  >npc_HOUND_frame_DOWN

npc_HOUND_frame_LEFT:
;frame 0
    .byte 0, $9D, %00000000, 0
    .byte 0, $9E, %00000000, 8
    .byte 8, $AD, %00000000, 0
    .byte 8, $AE, %00000000, 8
;frame 1
    .byte 0, $AA, %00000000, 0
    .byte 0, $AB, %00000000, 8
    .byte 8, $BA, %00000000, 0
    .byte 8, $BB, %00000000, 8
;frame 2
    .byte 0, $9D, %00000000, 0
    .byte 0, $9E, %00000000, 8
    .byte 8, $CA, %00000000, 0
    .byte 8, $CB, %00000000, 8
;frame 3
    .byte 0, $AA, %00000000, 0
    .byte 0, $AB, %00000000, 8
    .byte 8, $BA, %00000000, 0
    .byte 8, $BB, %00000000, 8
;attack
    .byte 0, $DA, %00000000, 0
    .byte 0, $DB, %00000000, 8
    .byte 8, $EA, %00000000, 0
    .byte 8, $EB, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8


npc_HOUND_frame_RIGHT:
;frame 0
    .byte 0, $9E, %01000000, 0
    .byte 0, $9D, %01000000, 8
    .byte 8, $AE, %01000000, 0
    .byte 8, $AD, %01000000, 8
;frame 1
    .byte 0, $AB, %01000000, 0
    .byte 0, $AA, %01000000, 8
    .byte 8, $BB, %01000000, 0
    .byte 8, $BA, %01000000, 8
;frame 2
    .byte 0, $9E, %01000000, 0
    .byte 0, $9D, %01000000, 8
    .byte 8, $CB, %01000000, 0
    .byte 8, $CA, %01000000, 8
;frame 3
    .byte 0, $AB, %01000000, 0
    .byte 0, $AA, %01000000, 8
    .byte 8, $BB, %01000000, 0
    .byte 8, $BA, %01000000, 8
;attack
    .byte 0, $DB, %01000000, 0
    .byte 0, $DA, %01000000, 8
    .byte 8, $EB, %01000000, 0
    .byte 8, $EA, %01000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8

npc_HOUND_frame_UP:
;frame 0
    .byte 0, $9F, %00000000, 0
    .byte 0, $BC, %01000000, 8
    .byte 8, $AF, %00000000, 0
    .byte 8, $CC, %01000000, 8
;frame 1
    .byte 0, $BD, %00000000, 0
    .byte 0, $BE, %00000000, 8
    .byte 8, $CE, %00000000, 0
    .byte 8, $CE, %01000000, 8
;frame 2
    .byte 0, $BC, %00000000, 0
    .byte 0, $9F, %01000000, 8
    .byte 8, $CC, %00000000, 0
    .byte 8, $AF, %01000000, 8
;frame 3
    .byte 0, $BD, %00000000, 0
    .byte 0, $BE, %00000000, 8
    .byte 8, $CE, %00000000, 0
    .byte 8, $CE, %01000000, 8
;attack
    .byte 0, $DC, %00000000, 0
    .byte 0, $DD, %00000000, 8
    .byte 8, $EC, %00000000, 0
    .byte 8, $ED, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8

npc_HOUND_frame_DOWN:
;frame 0
    .byte 0, $BF, %00000000, 0
    .byte 0, $BF, %01000000, 8
    .byte 8, $CF, %00000000, 0
    .byte 8, $EF, %01000000, 8
;frame 1
    .byte 0, $CD, %00000000, 0
    .byte 0, $CD, %01000000, 8
    .byte 8, $DF, %00000000, 0
    .byte 8, $DF, %01000000, 8
;frame 2
    .byte 0, $BF, %00000000, 0
    .byte 0, $BF, %01000000, 8
    .byte 8, $EF, %00000000, 0
    .byte 8, $CF, %01000000, 8
;frame 3
    .byte 0, $CD, %00000000, 0
    .byte 0, $CD, %01000000, 8
    .byte 8, $DF, %00000000, 0
    .byte 8, $DF, %01000000, 8
;attack
    .byte 0, $DE, %00000000, 0
    .byte 0, $DE, %01000000, 8
    .byte 8, $EE, %00000000, 0
    .byte 8, $EE, %01000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8


;================================================
npc_BJORN_sprite_data:

npc_BJORN_frames:
    .byte <npc_BJORN_frame_LEFT,  >npc_BJORN_frame_LEFT
    .byte <npc_BJORN_frame_RIGHT, >npc_BJORN_frame_RIGHT
    .byte <npc_BJORN_frame_UP,    >npc_BJORN_frame_UP
    .byte <npc_BJORN_frame_DOWN,  >npc_BJORN_frame_DOWN


npc_BJORN_frame_LEFT:
;frame 0
    .byte 0,  $8A, %00000000, 0
    .byte 0,  $8B, %00000000, 8
    .byte 8,  $9A, %00000000, 0
    .byte 8,  $9B, %00000000, 8
    .byte 16, $AA, %00000000, 0
    .byte 16, $AB, %00000000, 8

npc_BJORN_frame_RIGHT:
;frame 1
    .byte 0,  $8B, %01000000, 0
    .byte 0,  $8A, %01000000, 8
    .byte 8,  $9B, %01000000, 0
    .byte 8,  $9A, %01000000, 8
    .byte 16, $AB, %01000000, 0
    .byte 16, $AA, %01000000, 8

npc_BJORN_frame_UP:
;frame 0
    .byte 0,  $8C, %00000000, 0
    .byte 0,  $8D, %00000000, 8
    .byte 8,  $9C, %00000000, 0
    .byte 8,  $9D, %00000000, 8
    .byte 16, $AC, %00000000, 0
    .byte 16, $AD, %00000000, 8

npc_BJORN_frame_DOWN:
;frame 0
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
;frame 0
    .byte 0,  $50, %00000000, 0
    .byte 0,  $51, %00000000, 8
    .byte 8,  $60, %00000000, 0
    .byte 8,  $61, %00000000, 8
    .byte 16, $70, %00000000, 0
    .byte 16, $71, %00000000, 8

npc_ERIKA_frame_RIGHT:
;frame 0
    .byte 0,  $51, %01000000, 0
    .byte 0,  $50, %01000000, 8
    .byte 8,  $61, %01000000, 0
    .byte 8,  $60, %01000000, 8
    .byte 16, $71, %01000000, 0
    .byte 16, $70, %01000000, 8

npc_ERIKA_frame_UP:
;frame 0
    .byte 0,  $52, %00000000, 0
    .byte 0,  $53, %00000000, 8
    .byte 8,  $62, %00000000, 0
    .byte 8,  $63, %00000000, 8
    .byte 16, $72, %00000000, 0
    .byte 16, $73, %00000000, 8

npc_ERIKA_frame_DOWN:
;frame 0
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
;frame 0
    .byte 0, $6A, %00000000, 0
    .byte 0, $6B, %00000000, 8
    .byte 8, $7A, %00000000, 0
    .byte 8, $7B, %00000000, 8

npc_GRANNY_frame_RIGHT:
;frame 0
    .byte 0, $6B, %01000000, 0
    .byte 0, $6A, %01000000, 8
    .byte 8, $7B, %01000000, 0
    .byte 8, $7A, %01000000, 8

npc_GRANNY_frame_UP:
;frame 0
    .byte 0, $6C, %00000000, 0
    .byte 0, $6D, %00000000, 8
    .byte 8, $7C, %00000000, 0
    .byte 8, $7D, %00000000, 8

npc_GRANNY_frame_DOWN:
;frame 0
    .byte 0, $6E, %00000000, 0
    .byte 0, $6F, %00000000, 8
    .byte 8, $7E, %00000000, 0
    .byte 8, $7F, %00000000, 8
;====================================

npc_DEADMAN_sprite_data:

npc_DEADMAN_frames:
    .byte <npc_DEADMAN_frame_LEFT, >npc_DEADMAN_frame_LEFT
    .byte <npc_DEADMAN_frame_RIGHT, >npc_DEADMAN_frame_RIGHT

npc_DEADMAN_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
npc_DEADMAN_frame_RIGHT:
;frame 0
    .byte 0,  $0A, %00000000, 0
    .byte 0,  $0B, %00000000, 8
    .byte 8,  $1A, %00000000, 0
    .byte 8,  $1B, %00000000, 8
    .byte 16, $2A, %00000000, 0
    .byte 16, $2B, %00000000, 8
;======================================
npc_BOAR_sprite_data:

npc_BOAR_frames:
    .byte <npc_BOAR_frames_LEFT,  >npc_BOAR_frames_LEFT
    .byte <npc_BOAR_frames_RIGHT, >npc_BOAR_frames_RIGHT
    .byte <npc_BOAR_frames_UP,    >npc_BOAR_frames_UP
    .byte <npc_BOAR_frames_DOWN,  >npc_BOAR_frames_DOWN

npc_BOAR_frames_LEFT:
;frame 0
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8
;frame 1
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8
;frame 2
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8
;frame 3
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8
;attack
    .byte 0, $3A, %00000000, 0
    .byte 0, $3B, %00000000, 8
    .byte 8, $4A, %00000000, 0
    .byte 8, $4B, %00000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8
;----------------------------------
npc_BOAR_frames_RIGHT:
;frame 0
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 1
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 2
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 3
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;attack
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8
;-------------------------------
npc_BOAR_frames_UP:
;frame 0
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 1
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 2
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;frame 3
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;attack
    .byte 0, $3B, %01000000, 0
    .byte 0, $3A, %01000000, 8
    .byte 8, $4B, %01000000, 0
    .byte 8, $4A, %01000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8
;------------------------------
npc_BOAR_frames_DOWN:
;frame 0
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8
;frame 1
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8
;frame 2
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8
;frame 3
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8
;attack
    .byte 0, $3C, %00000000, 0
    .byte 0, $3C, %01000000, 8
    .byte 8, $4C, %00000000, 0
    .byte 8, $4C, %01000000, 8
;death
    .byte 0, $B8, %00000000, 0
    .byte 0, $B9, %00000000, 8
    .byte 8, $C8, %00000000, 0
    .byte 8, $C9, %00000000, 8


