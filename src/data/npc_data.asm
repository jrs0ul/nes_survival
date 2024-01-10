;<unused>, rows, collision offset Y, type(1-predator, 0-timid, 2 - villager, 3 - inactive), max_hp, attack
npc_data:
    .byte 255, 3, 17, 1, 6,   9, <npc_DOGMAN_frames,  >npc_DOGMAN_frames      ;dogman
    .byte 255, 2, 9,  0, 2,   0, <npc_BUNNY_frames,   >npc_BUNNY_frames       ;bunny
    .byte 255, 3, 17, 2, 255, 0, <npc_BJORN_frames,   >npc_BJORN_frames       ;villager-Bjorn
    .byte 255, 2, 9,  1, 4,   3, <npc_HOUND_frames,   >npc_HOUND_frames       ;canid
    .byte 255, 3, 17, 2, 255, 0, <npc_ERIKA_frames,   >npc_ERIKA_frames       ;villager-Erika
    .byte 255, 2, 2,  2, 255, 0, <npc_GRANNY_frames,  >npc_GRANNY_frames      ;villager-granny
    .byte 255, 3, 17, 3, 255, 0, <npc_DEADMAN_frames, >npc_DEADMAN_frames     ;dead-villager
    .byte 255, 2, 4,  0, 10,  5, <npc_BOAR_frames,    >npc_BOAR_frames        ;wild-boar
