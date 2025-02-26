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
    .byte $42, 0, 2, %00100001  ; 1  stick
    .byte $64, 1, 1, %00000101  ; 2  raw meat
    .byte $64, 0, 1, %01000000  ; 3  cooked meat
    .byte $44, 2, 3, %00010001  ; 4  rowan berries
    .byte $5A, 2, 3, %01000010  ; 5  potion
    .byte $68, 3, 4, 0          ; 6  rock
    .byte $3E, 2, 5, 9          ; 7  spear
    .byte $56, 2, 5, 2          ; 8  knife
    .byte $66, 0, 2, %00010000  ; 9  poop
    .byte $62, 0, 4, 0          ; 10 hide
    .byte $60, 0, 6, 2          ; 11 coat
    .byte $46, 1, 1, %00010101  ; 12 jumbo meat
    .byte $46, 0, 1, %10000000  ; 13 cooked jumbo meat
    .byte $52, 2, 4, 0          ; 14 rope
    .byte $50, 2, 5, 0          ; 15 fishing rod
    .byte $4E, 3, 2, %00010000  ; 16 reeds
    .byte $4A, 1, 1, %00001000  ; 17 fish
    .byte $4A, 0, 1, %00110010  ; 18 cooked fish
    .byte $54, 0, 3, 0          ; 19 radio
    .byte $2F, 2, 5, 5          ; 20 hammer
    .byte $6C, 0, 1, %01000000  ; 21 cooked mushroom
    .byte $4C, 2, 5, 5          ; 22 slingshot
    .byte $5E, 0, 1, %01100000  ; 23 pie
    .byte $48, 2, 7, 0          ; 24 letter
    .byte $48, 0, 7, 0          ; 25 first letter from Jon
    .byte $58, 2, 4, 0          ; 26 lamp
    .byte $5C, 2, 4, 0          ; 27 granny's head
    .byte $48, 1, 7, 0          ; 28 letter about the rock
    .byte $6A, 2, 4, 0          ; 29 key
    .byte $6C, 1, 1, %00010101  ; 30 mushroom
    .byte $40, 2, 3, %00100101  ; 31 medicinal shroom

items_with_progressbars: ;item type is index here
    .byte 0 ; 0
    .byte 1 ; 1
    .byte 0 ; 2
    .byte 0 ; 3
    .byte 0 ; 4
    .byte 1 ; 5
    .byte 1 ; 6
    .byte 0 ; 7

;item id, width, address low, address high
document_item_data:
    .byte 24, 15, <LetterFromTheCave, >LetterFromTheCave
    .byte 25, 15, <FirstLetterFromJon, >FirstLetterFromJon
    .byte 28, 15, <LetterAboutTheRock, >LetterAboutTheRock

item_wear:
    .byte 0   ;empty
    .byte 0   ;stick
    .byte 6   ;raw meat
    .byte 3   ;cooked meat
    .byte 0   ;rowan berries
    .byte 0   ;jam
    .byte 0   ;rock
    .byte 1   ;spear
    .byte 10  ;knife
    .byte 0   ;poop
    .byte 0   ;hide
    .byte 5   ;coat
    .byte 6   ;jumbo meat
    .byte 3   ;cooked jumbo meat
    .byte 0   ;rope
    .byte 15  ;fishing rod
    .byte 0   ;reeds
    .byte 7   ;fish
    .byte 4   ;cooked fish
    .byte 0   ;radio
    .byte 15  ;hammer
    .byte 4   ;cooked mushroom
    .byte 5   ;slingshot
    .byte 2   ;pie
    .byte 0   ;letter
    .byte 0   ;letter1
    .byte 0   ;lamp
    .byte 0   ;granny's head
    .byte 0   ;letter2
    .byte 0   ;key
    .byte 8   ;mushroom
    .byte 0   ;medicinal shroom

;items the player character should display above its head
important_items:
    .byte 0   ;empty
    .byte 0   ;stick
    .byte 0   ;raw meat
    .byte 0   ;cooked meat
    .byte 0   ;rowan berries
    .byte 0   ;potion
    .byte 0   ;rock
    .byte 0   ;spear
    .byte 1   ;knife
    .byte 0   ;poop
    .byte 0   ;hide
    .byte 1   ;coat
    .byte 1   ;jumbo meat
    .byte 1   ;cooked jumbo meat
    .byte 0   ;rope
    .byte 1   ;fishing rod
    .byte 0   ;reeds
    .byte 0   ;fish
    .byte 1   ;cooked fish
    .byte 1   ;radio
    .byte 1   ;hammer
    .byte 0   ;cooked mushroom
    .byte 1   ;slingshot
    .byte 1   ;pie
    .byte 0   ;letter
    .byte 0   ;letter1
    .byte 1   ;lamp
    .byte 1   ;granny's head
    .byte 0   ;letter2
    .byte 1   ;key
    .byte 0   ;mushroom
    .byte 0   ;medicinal shroom

