.include "data/maps/field_bg.asm"
.include "data/maps/field_bg1.asm"
.include "data/maps/field_bg2.asm"
.include "data/maps/field_bg4.asm"

.include "data/maps/LOC3_bg0.asm"

map_list_low:
    .byte <field_bg
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg4

map_list_high:
    .byte >field_bg
    .byte >field_bg1
    .byte >field_bg2
    .byte >field_bg4


map_list_3_low:
    .byte <LOC3_bg0
map_list_3_high:
    .byte >LOC3_bg0
