House_npcs:
    .byte 0

Hut_npcs:
    .byte 1
    .byte %00001001, 104, 94, 0, 100

villager2_npcs:
    .byte 1
    .byte %00010001, 104, 94, 0, 100

cave_npcs:
    .byte 6
    .byte %00000001, 50, 80, 0, 10
    .byte %00000001, 100, 80, 0, 10
    .byte %00000001, 100, 180, 0, 10
    .byte %00000001, 50, 80, 1, 10
    .byte %00000001, 100, 80, 1, 10
    .byte %00000001, 100, 180, 1, 10

Hut_npcs_night:
    .byte 1
    .byte %00001001, 152, 77, 0, 100
