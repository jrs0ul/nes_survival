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
    .byte 2, 2, 4,  4, 16,  8, <npc_BOAR_frames,    >npc_BOAR_frames        ;7  wild-boar
    .byte 4, 5, 32, 1, 6,   9, <npc_BOSS_frames,    >npc_BOSS_frames        ;8  Boss
    .byte 2, 2, 4,  1, 4,   3, <npc_SPIDER_frames,  >npc_SPIDER_frames      ;9  Spider
    .byte 3, 2, 4,  1, 4,   5, <npc_SLIMER_frames,  >npc_SLIMER_frames      ;10 Slimer
    .byte 2, 3, 17, 1, 7,   8, <npc_BARAKA_frames,  >npc_BARAKA_frames      ;11 Baraka
    .byte 2, 2, 9,  0, 255, 0, <npc_CAT_frames,     >npc_CAT_frames         ;12 Cat


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
    .byte   0,  0, 0,   0, 0,   0, 0,  0 ;0
    .byte   1, 44, 1, 154, 0, 212, 1, 34 ;1
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;2
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;3
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;4
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;5
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;6
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;7
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;8
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;9
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;10
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;11
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;12

.else ; NTSC speeds

npc_velocities:
    .byte 0,   0, 0,   0, 0,   0, 0,  0 ;0
    .byte 0, 250, 1, 128, 0, 177, 1, 16 ;1
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;2
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;3
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;4
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;5
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;6
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;7
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;8
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;9
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;10
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;11
    .byte 0, 0, 0, 0, 0, 0, 0, 0 ;12

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

