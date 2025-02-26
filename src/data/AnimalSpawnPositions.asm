location_spawns_low:
    .byte <spawnpoints_base_loc_1   ; 0 starting location
    .byte <spawnpoints_loc_2        ; 1 Bjorn's hut is here
    .byte <spawnpoints_loc_3        ; 2 Erika's location
    .byte 0                         ; 3
    .byte 0                         ; 4
    .byte 0                         ; 5
    .byte 0                         ; 6
    .byte 0                         ; 7
    .byte <spawnpoints_loc_9        ; 8 granny's house is here
    .byte 0                         ; 9
    .byte 0                         ; 10
    .byte <spawnpoints_loc_12       ; 11 mine entrance loc
    .byte 0                         ; 12
    .byte <spawnpoints_loc_13       ; 13 dark cave
    .byte 0                         ; 14
    .byte 0                         ; 15
    .byte <spawnpoints_loc_17       ; 16
    .byte 0                         ; 17
    .byte 0                         ; 18
    .byte <spawnpoints_loc_20       ; 19 puzzle room
    .byte 0                         ; 20
    .byte 0                         ; 21
    .byte 0                         ; 22
    .byte <spawnpoints_loc_24       ; 23

location_spawns_high:
    .byte >spawnpoints_base_loc_1   ;0
    .byte >spawnpoints_loc_2        ;1
    .byte >spawnpoints_loc_3        ;2
    .byte 0                         ;3
    .byte 0                         ;4
    .byte 0                         ;5
    .byte 0                         ;6
    .byte 0                         ;7
    .byte >spawnpoints_loc_9        ;8
    .byte 0                         ;9
    .byte 0                         ;10
    .byte >spawnpoints_loc_12       ;11
    .byte 0                         ;12
    .byte >spawnpoints_loc_13       ;13
    .byte 0                         ;14
    .byte 0                         ;15
    .byte >spawnpoints_loc_17       ;16
    .byte 0                         ;17
    .byte 0                         ;18
    .byte >spawnpoints_loc_20       ;19
    .byte 0                         ;20
    .byte 0                         ;21
    .byte 0                         ;22
    .byte >spawnpoints_loc_24       ;23


spawnpoints_base_loc_1:
    .byte 208, 48
    .byte 208, 120
    .byte 232, 144
    .byte 224, 192

    .byte 120, 72
    .byte 168, 168
    .byte 48, 128
    .byte 98, 190

    .byte 48, 144
    .byte 136, 80
    .byte 224, 120
    .byte 184, 200

    .byte 40, 88
    .byte 200, 72
    .byte 112, 160
    .byte 216, 152

spawnpoints_loc_2:
    .byte 40, 48
    .byte 88, 184
    .byte 152, 184
    .byte 128, 64

    .byte 88, 64
    .byte 192, 96
    .byte 144, 192
    .byte 64, 168

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
    .byte 64, 150
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

spawnpoints_loc_12:
    .byte 64, 180
    .byte 232, 115
    .byte 232, 176
    .byte 40, 56

    .byte 120, 115
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 120, 115
    .byte 168, 184
    .byte 48, 128
    .byte 98, 160

    .byte 88, 115
    .byte 168, 168
    .byte 48, 128
    .byte 98, 160

spawnpoints_loc_13:
    .byte 200, 192
    .byte 168, 48
    .byte 56 , 192
    .byte 144, 128

    .byte 32 , 80
    .byte 200, 120
    .byte 64 , 176
    .byte 200, 192

    .byte 24 , 72
    .byte 56 , 152
    .byte 200, 48
    .byte 200, 192


spawnpoints_loc_17:
    .byte 32, 56
    .byte 132, 48
    .byte 200, 132
    .byte 88, 128

    .byte 72, 72
    .byte 56, 176
    .byte 208, 185
    .byte 8, 96

    .byte 72, 72
    .byte 56, 184
    .byte 208, 190
    .byte 8, 96

spawnpoints_loc_20:
    .byte 80, 56    ;10 7
    .byte 145, 144  ;18
    .byte 232, 86   ;29 11
    .byte 232, 192  ;29 24

    .byte 112, 112
    .byte 215, 96
    .byte 224, 192
    .byte 24, 184

    .byte 208, 64
    .byte 136, 160
    .byte 32, 56
    .byte 24, 192

spawnpoints_loc_24:
    .byte 80, 88
    .byte 56, 160
    .byte 200, 88
    .byte 184, 160

    .byte 232, 192 ;29 24
    .byte 160, 80  ;20 10
    .byte 112, 120 ;14 15
    .byte 240, 64  ;30 8

    .byte 160, 80  ;20 10
    .byte 136, 144 ;17 18
    .byte 48, 80   ;6 10
    .byte 40, 192  ;5 24
