location_spawns_low:
    .byte <spawnpoints_base_loc_1
    .byte <spawnpoints_loc_2 ;bears hut is here
    .byte <spawnpoints_loc_3 ; headgehog
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0

location_spawns_high:
    .byte >spawnpoints_base_loc_1
    .byte >spawnpoints_loc_2
    .byte >spawnpoints_loc_3
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0


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
    .byte 176, 200
    .byte 232, 56
    .byte 160, 144

    .byte 56, 56
    .byte 32, 192
    .byte 184, 192
    .byte 216, 96

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

spawnpoints_loc_3:
    .byte 64, 200
    .byte 232, 72
    .byte 232, 176
    .byte 40, 56

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0





