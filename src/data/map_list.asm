.include "data/field_bg.asm"
.include "data/field_bg1.asm"
.include "data/field_bg2.asm"
.include "data/field_bg3.asm"

map_list_low:
    .byte <background
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg3

map_list_high:
    .byte >background
    .byte >field_bg1
    .byte >field_bg2
    .byte >field_bg3

