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


cave_npcs:
    .byte 6
    .byte %00000001, 50, 80, 0, 10
    .byte %00000001, 100, 80, 0, 10
    .byte %00000001, 100, 180, 0, 10
    .byte %00000001, 50, 80, 1, 10
    .byte %00000001, 100, 48, 1, 10
    .byte %00000001, 100, 180, 1, 10

alien_base_npcs:
    .byte 6
    .byte %00000001, 184, 80, 0, 10
    .byte %00000001, 200, 160, 0, 10
    .byte %00000001, 160, 180, 0, 10

    .byte %00000001, 50, 80, 1, 10
    .byte %00000001, 50, 160, 1, 10
    .byte %00000001, 200, 80, 1, 10

Hut_npcs_night:
    .byte 1
    .byte %00010001, 152, 77, 0, 100
