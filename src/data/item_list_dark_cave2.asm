;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

dark_cave_2_items:
    .byte ITEM_COUNT_LOC17
    .byte %00001101, 1, 80,  100 ; rock
    .byte %00111101, 1, 72,  64  ; shroom
    .byte %00001101, 1, 64,  184 ; rock
    .byte %00111101, 0, 16,  96  ; shroom
    .byte %00111101, 0, 120, 48  ; shroom
    .byte %00111101, 0, 176, 112 ; shroom


