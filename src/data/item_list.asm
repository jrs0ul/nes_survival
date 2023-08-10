;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y


House_items:
    .byte 0

Crashsite_items:
    .byte 1
    .byte %00100111, 0, 80, 96

Outside1_items:
    .byte ITEM_COUNT_LOC1
    .byte %00000011, 3, 50, 170
    .byte %00001001, 3, 0, 66
    .byte %00000011, 3, 220, 100
    .byte %00001101, 2, 125, 40
    .byte %00000011, 1, 128, 55
    .byte %00000011, 1, 250, 100
    .byte %00001101, 0, 135, 200

Outside2_items:
    .byte ITEM_COUNT_LOC2
    .byte %00000011, 0, 50, 130
    .byte %00001101, 1, 100, 164
    .byte %00000011, 1, 100, 64
    .byte %00000011, 1, 200, 64
    .byte %00100001, 1, 200, 144

Outside3_items:
    .byte ITEM_COUNT_LOC3
    .byte %00001101, 0, 50, 150
    .byte %00100001, 1, 180, 78
    .byte %00000011, 1, 80, 120
