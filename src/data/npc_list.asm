;note npc type: 6 bits, state: 2 bits

House_npcs:
    .byte 0

Hut_npcs:
    .byte 1
    .byte %00010001, 104, 94, 0, 100

villager2_npcs:
    .byte 1
    .byte %00100001, 104, 94, 0, 100

villager3_npcs:
    .byte 1
    .byte %00101001, 104, 94, 0, 100

boss_npcs:
    .byte 1
    .byte %01000001, 150, 80, 0, 38

cave_npcs:
    .byte 1
    .byte %00110001, 45, 90, 1, 100

dark_cave_npcs:
    .byte 6
    .byte %00000001, 64,  70,  0, 10
    .byte %00000001, 200, 184, 0, 10
    .byte %00000001, 208, 104, 0, 10
    .byte %00000001, 62,  56,  1, 10
    .byte %00000001, 48,  176, 1, 10
    .byte %00000001, 200, 120,  1, 10

alien_base_npcs:
    .byte 5
    .byte %00000001, 184, 80, 0, 10
    .byte %00000001, 200, 160, 0, 10
    .byte %00000001, 160, 180, 0, 10

    .byte %00000001, 50, 80, 1, 10
    .byte %00000001, 50, 160, 1, 10

Hut_npcs_night:
    .byte 1
    .byte %00010001, 152, 77, 0, 100
