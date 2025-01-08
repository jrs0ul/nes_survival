;item_list_name:
; .byte ITEM_COUNT
; .byte (item index(7 bits) + active(1 bit), screen index, x, y

crashsite_path_items:
    .byte ITEM_COUNT_LOC19
    .byte %00001001, 0, 60, 150

