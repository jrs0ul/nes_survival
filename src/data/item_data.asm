;first tile index (0 means empty), palette index, type, power
;types: 0 - none, 1 - food, 2 - fuel, 3 - medicine, 4 - material, 5 - tool/weapon
;power is only the second digit of a stat, if it's 2 then if stat is 000 it will become 020
item_data:
    .byte 0,   0, 0, 0  ; 0  empty
    .byte 6,   0, 2, 2  ; 1  stick
    .byte 22,  1, 1, 0  ; 2  raw meat
    .byte 22,  0, 1, 4  ; 3  cooked meat
    .byte 38,  2, 3, 1  ; 4  rowan berries
    .byte 102, 2, 1, 3  ; 5  jam
    .byte 54,  3, 4, 0  ; 6  rock
    .byte 224, 2, 5, 9  ; 7  spear
    .byte 86,  0, 5, 2  ; 8  knife
    .byte 118, 0, 2, 1  ; 9  poop
    .byte 134, 0, 4, 0  ; 10 hide
    .byte 150, 0, 5, 2  ; 11 coat
    .byte 70,  1, 1, 1  ; 12 jumbo meat
    .byte 70,  0, 1, 8  ; 13 cooked jumbo meat
    .byte 166, 2, 4, 0  ; 14 rope
    .byte 182, 2, 5, 0  ; 15 fishing rod
    .byte 198, 3, 2, 1  ; 16 reeds
    .byte 214, 1, 1, 1  ; 17 fish
    .byte 214, 0, 1, 3  ; 18 cooked fish

