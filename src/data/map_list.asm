;4 screens per location max

map_list_low:
    .byte <field_bg
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg4
;---
    .byte <field2_bg
    .byte <field2_bg1
    .byte 0
    .byte 0
;---
    .byte <LOC3_bg0
    .byte <LOC3_bg1
    .byte 0
    .byte 0



map_list_high:
    .byte >field_bg
    .byte >field_bg1
    .byte >field_bg2
    .byte >field_bg4
;---
    .byte >field2_bg
    .byte >field2_bg1
    .byte 0
    .byte 0
;---
    .byte >LOC3_bg0
    .byte >LOC3_bg1
    .byte 0
    .byte 0
