;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

wood_location_items:
    .byte ITEM_COUNT_LOC23
    .byte %00000011, 0, 200, 190
    .byte %00000011, 1, 220, 180
    .byte %00000011, 0, 100, 80
    .byte %00000011, 1, 180, 80
