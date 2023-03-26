.include "data/field2_bg.asm"
.include "data/field2_bg1.asm"

map_list_low2:
    .byte <field2_bg
    .byte <field2_bg1

map_list_high2:
    .byte >field2_bg
    .byte >field2_bg1
