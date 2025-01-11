;8 bytes of data:
;tiles in a row
;rows
;collision offset Y
;type
;max_hp
;attack
;frame pointer high
;frame pointer low

;types: 1-predator, 0-timid, 2 - villager, 3 - inactive, 4 - agressive when attacked
npc_data:
    .byte 2, 3, 17, 1, 5,   9, <npc_DOGMAN_frames,  >npc_DOGMAN_frames      ;0  dogman
    .byte 2, 2, 9,  0, 2,   0, <npc_BUNNY_frames,   >npc_BUNNY_frames       ;1  bunny
    .byte 2, 3, 17, 2, 64,  0, <npc_BJORN_frames,   >npc_BJORN_frames       ;2  villager-Bjorn
    .byte 2, 2, 9,  1, 4,   3, <npc_HOUND_frames,   >npc_HOUND_frames       ;3  canid
    .byte 2, 3, 17, 2, 64,  0, <npc_ERIKA_frames,   >npc_ERIKA_frames       ;4  villager-Erika
    .byte 2, 2, 2,  2, 64,  0, <npc_GRANNY_frames,  >npc_GRANNY_frames      ;5  villager-granny
    .byte 2, 3, 17, 3, 8,   0, <npc_DEADMAN_frames, >npc_DEADMAN_frames     ;6  dead-villager
    .byte 2, 2, 9,  4, 16,  8, <npc_BOAR_frames,    >npc_BOAR_frames        ;7  wild-boar
    .byte 4, 5, 32, 1, 6,   9, <npc_BOSS_frames,    >npc_BOSS_frames        ;8  Boss
    .byte 2, 2, 9,  1, 4,   3, <npc_SPIDER_frames,  >npc_SPIDER_frames      ;9  Spider
    .byte 3, 2, 9,  1, 4,   5, <npc_SLIMER_frames,  >npc_SLIMER_frames      ;10 Slimer
    .byte 2, 3, 17, 1, 7,   8, <npc_BARAKA_frames,  >npc_BARAKA_frames      ;11 Baraka
    .byte 2, 2, 9,  0, 255, 0, <npc_CAT_frames,     >npc_CAT_frames         ;12 Cat

npc_bbox_width:
    .byte 0, 16 ;0
    .byte 0, 16 ;1
    .byte 0, 16 ;2
    .byte 0, 16 ;3
    .byte 0, 16 ;4
    .byte 0, 16 ;5
    .byte 0, 16 ;6
    .byte 0, 16 ;7
    .byte 5, 22 ;8
    .byte 0, 16 ;9
    .byte 0, 24 ;10
    .byte 0, 16 ;11
    .byte 0, 16 ;12

;0 reg. speed int
;1 reg. speed fraction,
;2 agitated speed int,
;3 agitated speed fraction,
;4 diagonal reg. speed int
;5 diagonal reg. speed fraction,
;6 diagonal agitated speed int,
;7 diagonal agitated speed fraction,

.if FAMISTUDIO_CFG_PAL_SUPPORT

npc_velocities:
    .byte 0, 252, 0, 252, 0, 179, 0, 179 ;0
    .byte 1,  44, 1, 154, 0, 213, 1,  34 ;1
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;2
    .byte 1,   2, 1,   2, 0, 183, 0, 183 ;3
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;4
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;5
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;6
    .byte 0, 240, 0, 240, 0, 170, 0, 170 ;7
    .byte 0, 252, 0, 252, 0, 179, 0, 179 ;8
    .byte 1,   8, 1,   8, 0, 187, 0, 187 ;9
    .byte 0, 228, 0, 228, 0, 162, 0, 162 ;10
    .byte 0, 252, 0, 252, 0, 179, 0, 179 ;11
    .byte 0,  60, 1, 112, 0,  43, 1,   4 ;12

.else ; NTSC speeds

npc_velocities:
    .byte 0, 210, 0, 210, 0, 149, 0, 149 ;0 dogman
    .byte 0, 250, 1, 128, 0, 177, 1,  16 ;1 bunny
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;2 bjorn
    .byte 0, 215, 0, 215, 0, 153, 0, 153 ;3 canid
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;4 erika
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;5 granny
    .byte 0,   0, 0,   0, 0,   0, 0,   0 ;6 deadman
    .byte 0, 200, 0, 200, 0, 142, 0, 142 ;7 boar
    .byte 0, 210, 0, 210, 0, 149, 0, 149 ;8 boss
    .byte 0, 220, 0, 220, 0, 156, 0, 156 ;9 spider
    .byte 0, 190, 0, 190, 0, 135, 0, 135 ;10 slimer
    .byte 0, 210, 0, 210, 0, 149, 0, 149 ;11 Baraka
    .byte 0,  50, 1,  50, 0,  36, 0, 217 ;12 cat

.endif

npc_vel_lookup:
    .byte 0 ;0
    .byte 8 ;1
    .byte 16 ;2
    .byte 24 ;3
    .byte 32 ;4
    .byte 40 ;5
    .byte 48 ;6
    .byte 56 ;7
    .byte 64 ;8
    .byte 72 ;9
    .byte 80 ;10
    .byte 88 ;11
    .byte 96 ;12

