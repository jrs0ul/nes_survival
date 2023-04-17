.include "house_collision.asm"
.include "field_bg_collision.asm"
.include "field_bg_collision1.asm"
.include "field_bg_collision2.asm"
.include "field_bg_collision3.asm"
.include "field_bg_collision4.asm"


collision_list_low:
    .byte <bg_collision
    .byte <bg_collision1
    .byte <bg_collision2
    .byte <bg_collision3
    .byte <bg_collision4

collision_list_high:
    .byte >bg_collision
    .byte >bg_collision1
    .byte >bg_collision2
    .byte >bg_collision3
    .byte >bg_collision4
