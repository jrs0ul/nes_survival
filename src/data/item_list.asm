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
    .byte %00010001, 1, 70, 95 ; knife
    .byte %00001101, 1, 150,130 ; rock
    .byte %00110001, 1, 65, 120 ; letter

Outside1_items:
    .byte ITEM_COUNT_LOC1
    .byte %00000011, 3, 50,  170
    .byte %00001001, 3, 0,   66
    .byte %00000011, 3, 220, 100
    .byte %00001101, 2, 125, 58 ; rock
    .byte %00000011, 1, 128, 55
    .byte %00000011, 2, 20, 125
    .byte %00001101, 0, 135, 200 ; rock

Outside2_items:
    .byte ITEM_COUNT_LOC2
    .byte %00000011, 0, 50, 130
    .byte %00001101, 1, 100, 164
    .byte %00000011, 1, 100, 64
    .byte %00000011, 1, 200, 64
    .byte %00100001, 1, 200, 144
    .byte %00001001, 1, 160, 72

Outside3_items:
    .byte ITEM_COUNT_LOC3
    .byte %00001101, 0, 50, 150
    .byte %00100001, 1, 180, 78
    .byte %00000011, 1, 80, 120
    .byte %00001001, 0, 160, 72

granny_location_items:
    .byte ITEM_COUNT_LOC9
    .byte %00001001, 0, 184, 104
