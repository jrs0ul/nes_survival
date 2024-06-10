player_frame_indexes:
    .byte 0  ; LEFT
    .byte 12 ; RIGHT
    .byte 24 ; UP
    .byte 36 ; DOWN



fishingRodSprites:
    .byte   8, $E7, %00000000, 0,   8, $E8, %00000000, 248 ;left
    .byte   8, $E7, %01000000, 8,   8, $E8, %01000000, 16 ;right
    .byte   8, $E6, %00000000, 0,  16, $D8, %00000000, 0  ;down
    .byte   0, $E6, %10000000, 8,  248, $D8, %10000000, 8 ;up

hammerSprites:
    .byte   7,   $A9, %00000000, 0,   7,  $A8, %00000000, 248 ;left
    .byte   7,   $A9, %01000000, 8,   7,  $A8, %01000000, 16  ;right
    .byte   255, $99, %11000000, 8,  250, $98, %11000000, 8   ;up
    .byte   9,   $99, %00000000, 0,  17,  $98, %00000000, 0   ;down


player_sprites:
    ;LEFT
    ;head
    .byte 0, $01,  %00000011, 0 ;1st sprite
    .byte 0, $02,  %00000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $07, %00000011, 0 ;3rd
    .byte 8, $08, %00000011, 8 ;4th
    ;frame 1
    .byte 8, $0D, %00000011, 0 ;3rd
    .byte 8, $0E, %00000011, 8 ;4th
    ;frame 2
    .byte 8, $13, %00000011, 0 ;3rd
    .byte 8, $14, %00000011, 8 ;4th
    ;frame 3
    .byte 8, $0D, %00000011, 0 ;3rd
    .byte 8, $0E, %00000011, 8 ;4th
    ;attack
    .byte 8, $19, %00000011, 0 ;3rd
    .byte 8, $1A, %00000011, 8 ;4th

    ;------------------------------
    ;RIGHT
    ;head
    .byte 0, $02,  %01000011, 0 ;1st
    .byte 0, $01,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $08, %01000011, 0 ;3rd
    .byte 8, $07, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $0E, %01000011, 0 ;3rd
    .byte 8, $0D, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $14, %01000011, 0 ;3rd
    .byte 8, $13, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $0E, %01000011, 0 ;3rd
    .byte 8, $0D, %01000011, 8 ;4th
    ;attack
    .byte 8, $1A, %01000011, 0 ;3rd
    .byte 8, $19, %01000011, 8 ;4th

    ;---------------------------------
    ;UP
    ;head
    .byte 0, $03,  %00000011, 0 ;1st sprite
    .byte 0, $03,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $09, %00000011, 0 ;3rd
    .byte 8, $15, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $0F, %00000011, 0 ;3rd
    .byte 8, $0F, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $15, %00000011, 0 ;3rd
    .byte 8, $09, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $0F, %00000011, 0 ;3rd
    .byte 8, $0F, %01000011, 8 ;4th
    ;attack
    .byte 8, $1B, %00000011, 0 ;3rd
    .byte 8, $1C, %00000011, 8 ;4th

    ;---------------------------------
    ;DOWN
    .byte 0, $04,  %00000011, 0 ;1st sprite
    .byte 0, $04,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $0A, %00000011, 0 ;3rd
    .byte 8, $16, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $10, %00000011, 0 ;3rd
    .byte 8, $10, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $16, %00000011, 0 ;3rd
    .byte 8, $0A, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $10, %00000011, 0 ;3rd
    .byte 8, $10, %01000011, 8 ;4th
    ;attack
    .byte 8, $1d, %00000011, 0 ;3rd
    .byte 8, $1e, %00000011, 8 ;4th
;=========================================
player_sprites_coat:
    ;LEFT
    ;head
    .byte 0, $01,  %00000011, 0 ;1st sprite
    .byte 0, $02,  %00000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $05, %00000011, 0 ;3rd
    .byte 8, $06, %00000011, 8 ;4th
    ;frame 1
    .byte 8, $0b, %00000011, 0 ;3rd
    .byte 8, $0c, %00000011, 8 ;4th
    ;frame 2
    .byte 8, $11, %00000011, 0 ;3rd
    .byte 8, $12, %00000011, 8 ;4th
    ;frame 3
    .byte 8, $0b, %00000011, 0 ;3rd
    .byte 8, $0c, %00000011, 8 ;4th
    ;attack
    .byte 8, $17, %00000011, 0 ;3rd
    .byte 8, $18, %00000011, 8 ;4th

    ;------------------------------
    ;RIGHT
    ;head
    .byte 0, $02,  %01000011, 0 ;1st
    .byte 0, $01,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $06, %01000011, 0 ;3rd
    .byte 8, $05, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $0b, %01000011, 0 ;3rd
    .byte 8, $0c, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $12, %01000011, 0 ;3rd
    .byte 8, $11, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $0c, %01000011, 0 ;3rd
    .byte 8, $0b, %01000011, 8 ;4th
    ;attack
    .byte 8, $18, %01000011, 0 ;3rd
    .byte 8, $17, %01000011, 8 ;4th

    ;---------------------------------
    ;UP
    ;head
    .byte 0, $03,  %00000011, 0 ;1st sprite
    .byte 0, $03,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $1f, %00000011, 0 ;3rd
    .byte 8, $21, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $20, %00000011, 0 ;3rd
    .byte 8, $20, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $21, %00000011, 0 ;3rd
    .byte 8, $1f, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $20, %00000011, 0 ;3rd
    .byte 8, $20, %01000011, 8 ;4th
    ;attack
    .byte 8, $23, %00000011, 0 ;3rd
    .byte 8, $24, %00000011, 8 ;4th

    ;---------------------------------
    ;DOWN
    .byte 0, $04,  %00000011, 0 ;1st sprite
    .byte 0, $04,  %01000011, 8 ;2nd
    ;body
    ;frame 0
    .byte 8, $28, %00000011, 0 ;3rd
    .byte 8, $27, %01000011, 8 ;4th
    ;frame 1
    .byte 8, $22, %00000011, 0 ;3rd
    .byte 8, $22, %01000011, 8 ;4th
    ;frame 2
    .byte 8, $27, %00000011, 0 ;3rd
    .byte 8, $28, %01000011, 8 ;4th
    ;frame 3
    .byte 8, $22, %00000011, 0 ;3rd
    .byte 8, $22, %01000011, 8 ;4th
    ;attack
    .byte 8, $25, %00000011, 0 ;3rd
    .byte 8, $26, %00000011, 8 ;4th
