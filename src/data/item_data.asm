;first tile index (0 means empty), palette index, type, power
;types:
;   0 - none,
;   1 - food,
;   2 - fuel,
;   3 - medicine,
;   4 - material,
;   5 - tool/weapon,
;   6 - clothing,
;   7 - document
;except for the weapons, the power is split in two parts 4 bit wide, for last two stat digits.
item_data: ;          ---||---
    .byte 0,   0, 0, %00000000  ; 0  empty
    .byte 6,   0, 2, %00100001  ; 1  stick
    .byte 22,  1, 1, %00000101  ; 2  raw meat
    .byte 22,  0, 1, %01000000  ; 3  cooked meat
    .byte 38,  2, 3, %00100101  ; 4  rowan berries
    .byte 102, 2, 1, %01000000  ; 5  jam
    .byte 54,  3, 4, 0          ; 6  rock
    .byte 224, 2, 5, 9          ; 7  spear
    .byte 86,  2, 5, 2          ; 8  knife
    .byte 118, 0, 2, %00010000  ; 9  poop
    .byte 134, 0, 4, 0          ; 10 hide
    .byte 150, 0, 6, 2          ; 11 coat
    .byte 70,  1, 1, %00010101  ; 12 jumbo meat
    .byte 70,  0, 1, %10000000  ; 13 cooked jumbo meat
    .byte 166, 2, 4, 0          ; 14 rope
    .byte 182, 2, 5, 0          ; 15 fishing rod
    .byte 198, 3, 2, %00010000  ; 16 reeds
    .byte 214, 1, 1, %00001000  ; 17 fish
    .byte 214, 0, 1, %00110010  ; 18 cooked fish
    .byte 8  , 0, 3, 0          ; 19 radio
    .byte 24 , 2, 5, 5          ; 20 hammer
    .byte 24 , 0, 5, 1          ; 21 wooden hammer
    .byte 40 , 2, 5, 5          ; 22 slingshot
    .byte 56 , 0, 1, %01100000  ; 23 pie
    .byte 72 , 2, 7, 0          ; 24 letter
    .byte 72 , 0, 7, 0          ; 25 first letter from Jon
    .byte 88 , 2, 4, 0          ; 26 lamp

;item id, width, address low, address high
document_item_data:
    .byte 24, 15, <LetterFromTheCave, >LetterFromTheCave
    .byte 25, 15, <FirstLetterFromJon, >FirstLetterFromJon

item_wear:
    .byte 0   ;empty
    .byte 0   ;stick
    .byte 0   ;raw meat
    .byte 0   ;cooked meat
    .byte 0   ;rowan berries
    .byte 0   ;jam
    .byte 0   ;rock
    .byte 1   ;spear
    .byte 10  ;knife
    .byte 0   ;poop
    .byte 0   ;hide
    .byte 5   ;coat
    .byte 0   ;jumbo meat
    .byte 0   ;cooked jumbo meat
    .byte 0   ;rope
    .byte 15  ;fishing rod
    .byte 0   ;reeds
    .byte 0   ;fish
    .byte 0   ;cooked fish
    .byte 0   ;radio
    .byte 25  ;hammer
    .byte 15  ;wooden hammer
    .byte 5   ;slingshot
    .byte 0   ;pie
    .byte 0   ;letter
    .byte 0   ;letter1
    .byte 0   ;lamp
