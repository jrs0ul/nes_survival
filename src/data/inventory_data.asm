;first tile index (0 means empty), palette index, type, power
;types: 0 - none, 1 - food, 2 - fuel
;power is only the second digit of a stat, if it's 2 then if stat is 000 it will become 020
inventory_data:
    .byte 0,  0, 0, 0 ; empty
    .byte 6,  0, 2, 2 ; stick
    .byte 22, 1, 1, 0 ; raw meat
    .byte 22, 0, 1, 4 ; cooked meat
