location_spawns_low:
    .byte <spawnpoints_base_loc_1
    .byte <spawnpoints_loc_2 ;Bjorn's hut is here
    .byte <spawnpoints_loc_3 ; Erika's location
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte <spawnpoints_loc_9 ; granny's house is here

location_spawns_high:
    .byte >spawnpoints_base_loc_1
    .byte >spawnpoints_loc_2
    .byte >spawnpoints_loc_3
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte >spawnpoints_loc_9


spawnpoints_base_loc_1:
    .byte 208, 48
    .byte 208, 120
    .byte 232, 144
    .byte 224, 192

    .byte 120, 72
    .byte 168, 176
    .byte 48, 128
    .byte 98, 200

    .byte 48, 144
    .byte 136, 80
    .byte 224, 120
    .byte 184, 200

    .byte 40, 88
    .byte 200, 72
    .byte 112, 160
    .byte 216, 152

spawnpoints_loc_2:
    .byte 56, 136
    .byte 176, 180
    .byte 232, 56
    .byte 160, 144

    .byte 56, 56
    .byte 32, 192
    .byte 184, 192
    .byte 216, 96

spawnpoints_loc_3:
    .byte 64, 180
    .byte 232, 72
    .byte 232, 176
    .byte 40, 56

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

spawnpoints_loc_9:
    .byte 64, 180
    .byte 232, 72
    .byte 232, 176
    .byte 40, 56

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 120, 160
    .byte 8,   64
    .byte 48,  72
    .byte 98,  168

