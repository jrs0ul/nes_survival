player_frame_indexes:
    .byte 0  ; LEFT
    .byte 12 ; RIGHT
    .byte 24 ; UP
    .byte 36 ; DOWN

spearSprites:
          ;+Y,frame,attributes,+X
    .byte 248, $E2, %00000000, 252, 0, $E3, %00000000, 252 ;up
    .byte 248, $E3, %10000000, 252, 0, $E2, %10000000, 252 ;down
    .byte 252, $E0, %00000000, 248, 252, $E1, %00000000, 0 ;left
    .byte 252, $E1, %01000000, 248, 252, $E0, %01000000, 0 ;right


fishingRodSprites:
    .byte   8, $E7, %00000000, 0,   8, $E8, %00000000, 248 ;left
    .byte   8, $E7, %01000000, 8,   8, $E8, %01000000, 16 ;right
    .byte   8, $E6, %00000000, 0,  16, $D8, %00000000, 0  ;down
    .byte   0, $E6, %10000000, 0,  248, $D8, %10000000, 0 ;up

hammerSprites:
    .byte   7,   $A9, %00000000, 0,   7,  $A8, %00000000, 248 ;left
    .byte   7,   $A9, %01000000, 8,   7,  $A8, %01000000, 16  ;right
    .byte   255, $99, %11000000, 8,  250, $98, %11000000, 8   ;up
    .byte   9,   $99, %00000000, 0,  17,  $98, %00000000, 0   ;down


player_sprites:
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

    ;------------------------------
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
;=========================================
player_sprites_coat:
    ;LEFT
    ;head
    .byte 0, 0,  %00000011, 0 ;1st sprite
    .byte 0, 1,  %00000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $04, %00000011, 0 ;3rd
    .byte 8, $05, %00000011, 8 ;4th
    ;frame 1
    .byte 8, $14, %00000011, 0 ;3rd
    .byte 8, $15, %00000011, 8 ;4th
    ;frame 2
    .byte 8, $24, %00000011, 0 ;3rd
    .byte 8, $25, %00000011, 8 ;4th
    ;frame 3
    .byte 8, $14, %00000011, 0 ;3rd
    .byte 8, $15, %00000011, 8 ;4th
    ;attack
    .byte 8, $34, %00000011, 0 ;3rd
    .byte 8, $35, %00000011, 8 ;4th

    ;------------------------------
    ;RIGHT
    ;head
    .byte 0, 1,  %01000011, 0 ;1st
    .byte 0, 0,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $05, %01000011, 0 ;3rd
    .byte 8, $04, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $15, %01000011, 0 ;3rd
    .byte 8, $14, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $25, %01000011, 0 ;3rd
    .byte 8, $24, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $15, %01000011, 0 ;3rd
    .byte 8, $14, %01000011, 8 ;4th
    ;attack
    .byte 8, $35, %01000011, 0 ;3rd
    .byte 8, $34, %01000011, 8 ;4th

    ;---------------------------------
    ;UP
    ;head
    .byte 0, 2,  %00000011, 0 ;1st sprite
    .byte 0, 2,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $C2, %00000011, 0 ;3rd
    .byte 8, $C4, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $C3, %00000011, 0 ;3rd
    .byte 8, $C3, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $C4, %00000011, 0 ;3rd
    .byte 8, $C2, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $C3, %00000011, 0 ;3rd
    .byte 8, $C3, %01000011, 8 ;4th
    ;attack
    .byte 8, $D2, %00000011, 0 ;3rd
    .byte 8, $D3, %00000011, 8 ;4th

    ;---------------------------------
    ;DOWN
    .byte 0, 3,  %00000011, 0 ;1st sprite
    .byte 0, 3,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $E4, %00000011, 0 ;3rd
    .byte 8, $E5, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $C5, %00000011, 0 ;3rd
    .byte 8, $C5, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $E5, %00000011, 0 ;3rd
    .byte 8, $E4, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $C5, %00000011, 0 ;3rd
    .byte 8, $C5, %01000011, 8 ;4th
    ;attack
    .byte 8, $D4, %00000011, 0 ;3rd
    .byte 8, $D5, %00000011, 8 ;4th
