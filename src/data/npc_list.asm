;note npc type: 6 bits, state: 2 bits

House_npcs:
    .byte 0

Hut_npcs:
    .byte 1
    .byte %00100001, 104, 94, 0, 15

villager2_npcs:
    .byte 1
    .byte %01000001, 104, 94, 0, 15

villager3_npcs:
    .byte 1
    .byte %01010001, 104, 94, 0, 15

boss_npcs:
    .byte 1
    .byte %10000001, 150, 80, 0, 38

cave_npcs:
    .byte 1
    .byte %01100001, 45, 90, 2, 8

dark_cave_npcs:
    .byte 2
    .byte %00000001, 64,  70,  0, 7
    .byte %00000001, 62,  56,  1, 7

alien_base_npcs:
    .byte 5
    .byte %00000001, 184, 80, 0, 7
    .byte %00000001, 200, 160, 0, 7
    .byte %00000001, 160, 180, 0, 7

    .byte %00000001, 50, 80, 1, 7
    .byte %00000001, 50, 160, 1, 7

Hut_npcs_night:
    .byte 1
    .byte %00100001, 152, 77, 0, 15
