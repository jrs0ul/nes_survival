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
    .byte 2, 3, 17, 1, 6,   9, <npc_DOGMAN_frames,  >npc_DOGMAN_frames      ;0 dogman
    .byte 2, 2, 9,  0, 2,   0, <npc_BUNNY_frames,   >npc_BUNNY_frames       ;1 bunny
    .byte 2, 3, 17, 2, 255, 0, <npc_BJORN_frames,   >npc_BJORN_frames       ;2 villager-Bjorn
    .byte 2, 2, 9,  1, 4,   3, <npc_HOUND_frames,   >npc_HOUND_frames       ;3 canid
    .byte 2, 3, 17, 2, 255, 0, <npc_ERIKA_frames,   >npc_ERIKA_frames       ;4 villager-Erika
    .byte 2, 2, 2,  2, 255, 0, <npc_GRANNY_frames,  >npc_GRANNY_frames      ;5 villager-granny
    .byte 2, 3, 17, 3, 255, 0, <npc_DEADMAN_frames, >npc_DEADMAN_frames     ;6 dead-villager
    .byte 2, 2, 4,  4, 16,  8, <npc_BOAR_frames,    >npc_BOAR_frames        ;7 wild-boar
    .byte 4, 5, 32, 1, 6,   9, <npc_BOSS_frames,    >npc_BOSS_frames        ;8 Boss


