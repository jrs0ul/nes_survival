;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y


House_items:
    .byte 0

Crashsite_items:
    .byte ITEM_COUNT_LOC8
    .byte %00100111, 1, 80, 96

Cave_items:
    .byte ITEM_COUNT_LOC7
    .byte %00010001, 2, 70, 95 ; knife
    .byte %00001101, 2, 150,130 ; rock
    .byte %00110001, 2, 65, 120 ; letter


Outside2_items:
    .byte ITEM_COUNT_LOC2
    .byte %00000011, 0, 50, 130
    .byte %00001101, 1, 100, 164
    .byte %00000011, 1, 100, 64
    .byte %00000011, 1, 200, 64
    .byte %00100001, 1, 200, 144
    .byte %00001001, 1, 160, 72

secret_cave_items:
    .byte ITEM_COUNT_LOC14
    .byte %00001111, 0, 200, 60
    .byte %00001111, 0, 220, 68
    .byte %00001111, 0, 180, 76
    .byte %00001111, 0, 200, 78
    .byte %00001111, 0, 150, 65



granny_location_items:
    .byte ITEM_COUNT_LOC9
    .byte %00001001, 0, 184, 104
