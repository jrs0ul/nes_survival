;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

secret_cave_items:
    .byte ITEM_COUNT_LOC15
    .byte %00001111, 0, 200, 60
    .byte %00001111, 0, 220, 68
    .byte %00101111, 0, 180, 76
    .byte %00001111, 0, 200, 78
    .byte %00101001, 0, 160, 67
