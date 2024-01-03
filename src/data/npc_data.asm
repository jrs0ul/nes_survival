;first sprite index, rows, collision offset Y, type(1-predator, 0-timid, 2 - villager, 3 - inactive), max_hp, attack
npc_data:
    .byte 80,  3, 17, 1, 6,   9, <npc_dogman_sprite_data, >npc_dogman_sprite_data      ;werewolf
    .byte 10,  2, 9,  0, 2,   0, <npc_bunny_sprite_data,  >npc_bunny_sprite_data       ;bunny
    .byte 138, 3, 17, 2, 255, 0, <npc_bjorn_sprite_data,  >npc_bjorn_sprite_data       ;villager-bear
    .byte $7A, 2, 9,  1, 4,   3, <npc_hound_sprite_data,  >npc_hound_sprite_data       ;canid
    .byte 80,  3, 17, 2, 255, 0, <npc_ezzie_sprite_data,  >npc_ezzie_sprite_data       ;villager-hedgehog
    .byte 106, 2, 2,  2, 255, 0, <npc_granny_sprite_data, >npc_granny_sprite_data      ;villager-granny
    .byte $0A, 3, 17, 3, 255, 0, <npc_deadman_sprite_data,>npc_deadman_sprite_data     ;dead-villager
