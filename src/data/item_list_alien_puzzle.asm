;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

item_list_alien_puzzle:
    .byte ITEM_COUNT_LOC20
    .byte %00111101, 2, 200, 190
    .byte %00111101, 2, 220, 180
    .byte %00111101, 2, 215, 203

