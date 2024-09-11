;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

wood_location_items:
    .byte ITEM_COUNT_LOC23
    .byte %00000101, 0, 200, 190
    .byte %00000101, 1, 220, 180
