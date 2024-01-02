player_sprites_not_flip:
    ;LEFT
    ;head
    .byte 0, 0,  %00000011, 0 ;1st sprite
    .byte 0, 1,  %00000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, 16, %00000011, 0 ;3rd
    .byte 8, 17, %00000011, 8 ;4th
    ;frame 1
    .byte 8, 32, %00000011, 0 ;3rd
    .byte 8, 33, %00000011, 8 ;4th
    ;frame 2
    .byte 8, 48, %00000011, 0 ;3rd
    .byte 8, 49, %00000011, 8 ;4th
    ;frame 3
    .byte 8, 32, %00000011, 0 ;3rd
    .byte 8, 33, %00000011, 8 ;4th
    ;attack
    .byte 8, 64, %00000011, 0 ;3rd
    .byte 8, 65, %00000011, 8 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0

    ;---------------------------------
    ;UP
    ;head
    .byte 0, 2,  %00000011, 0 ;1st sprite
    .byte 0, 2,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, 18, %00000011, 0 ;3rd
    .byte 8, 50, %01000011, 8 ;4th
    ;frame 1
    .byte 8, 34, %00000011, 0 ;3rd
    .byte 8, 34, %01000011, 8 ;4th
    ;frame 2
    .byte 8, 50, %00000011, 0 ;3rd
    .byte 8, 18, %01000011, 8 ;4th
    ;frame 3
    .byte 8, 34, %00000011, 0 ;3rd
    .byte 8, 34, %01000011, 8 ;4th
    ;attack
    .byte 8, 66, %00000011, 0 ;3rd
    .byte 8, 67, %00000011, 8 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0


    ;---------------------------------
    ;DOWN
    .byte 0, 3,  %00000011, 0 ;1st sprite
    .byte 0, 3,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, 19, %00000011, 0 ;3rd
    .byte 8, 51, %01000011, 8 ;4th
    ;frame 1
    .byte 8, 35, %00000011, 0 ;3rd
    .byte 8, 35, %01000011, 8 ;4th
    ;frame 2
    .byte 8, 51, %00000011, 0 ;3rd
    .byte 8, 19, %01000011, 8 ;4th
    ;frame 3
    .byte 8, 35, %00000011, 0 ;3rd
    .byte 8, 35, %01000011, 8 ;4th
    ;attack
    .byte 8, 68, %00000011, 0 ;3rd
    .byte 8, 69, %00000011, 8 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0


player_sprites_flip:
    ;RIGHT
    ;head
    .byte 0, 1,  %01000011, 0 ;1st
    .byte 0, 0,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, 17, %01000011, 0 ;3rd
    .byte 8, 16, %01000011, 8 ;4th
    ;frame 1
    .byte 8, 33, %01000011, 0 ;3rd
    .byte 8, 32, %01000011, 8 ;4th
    ;frame 2
    .byte 8, 49, %01000011, 0 ;3rd
    .byte 8, 48, %01000011, 8 ;4th
    ;frame 3
    .byte 8, 33, %01000011, 0 ;3rd
    .byte 8, 32, %01000011, 8 ;4th
    ;attack
    .byte 8, 65, %01000011, 0 ;3rd
    .byte 8, 64, %01000011, 8 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0

    ;----------------------------------
    ;UP
    ;head
    .byte 0, 2,  %01000011, 8 ;1st sprite
    .byte 0, 2,  %00000011, 0 ;2nd
    ;body
    ;frame 0
    .byte 8, 18, %01000011, 8 ;3rd
    .byte 8, 50, %00000011, 0 ;4th
    ;frame 1
    .byte 8, 34, %01000011, 8 ;3rd
    .byte 8, 34, %00000011, 0 ;4th
    ;frame 2
    .byte 8, 50, %01000011, 8 ;3rd
    .byte 8, 18, %00000011, 0 ;4th
    ;frame 3
    .byte 8, 34, %01000011, 8 ;3rd
    .byte 8, 34, %00000011, 0 ;4th
    ;attack
    .byte 8, 66, %01000011, 8 ;3rd
    .byte 8, 67, %01000011, 0 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0

    ;---------------------------------
    ;DOWN
    ;head
    .byte 0, 3,  %01000011, 8 ;1st sprite
    .byte 0, 3,  %00000011, 0 ;2nd
    ;body
    ;frame 0
    .byte 8, 51, %01000011, 8 ;3rd
    .byte 8, 19, %00000011, 0 ;4th
    ;frame 1
    .byte 8, 35, %01000011, 8 ;3rd
    .byte 8, 35, %00000011, 0 ;4th
    ;frame 2
    .byte 8, 19, %01000011, 8 ;3rd
    .byte 8, 51, %00000011, 0 ;4th
    ;frame 3
    .byte 8, 35, %01000011, 8 ;3rd
    .byte 8, 35, %00000011, 0 ;4th
    ;attack
    .byte 8, 69, %01000011, 0 ;3rd
    .byte 8, 68, %01000011, 8 ;4th

    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,0



