.include "data/field_bg.asm"
.include "data/field_bg1.asm"
.include "data/field_bg2.asm"
.include "data/field_bg3.asm"
.include "data/field_bg4.asm"

map_list_low:
    .byte <field_bg
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg3
    .byte <field_bg4

map_list_high:
    .byte >field_bg
    .byte >field_bg1
    .byte >field_bg2
    .byte >field_bg3
    .byte >field_bg4

