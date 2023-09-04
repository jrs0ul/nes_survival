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
    .byte 208, 48
    .byte 208, 192

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 120, 72
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

spawnpoints_loc_2:
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

spawnpoints_loc_3:
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0

    .byte 0, 0
    .byte 0, 0
    .byte 0, 0
    .byte 0, 0






