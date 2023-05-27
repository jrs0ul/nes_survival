.include "maps/house_collision.asm"
.include "maps/field_bg_collision.asm"
.include "maps/field_bg_collision1.asm"
.include "maps/field_bg_collision2.asm"
.include "maps/field_bg_collision4.asm"
.include "maps/villager2_hut_collision.asm"

.include "maps/LOC3_collision0.asm"


collision_list_low:
    .byte <bg_collision
    .byte <bg_collision1
    .byte <bg_collision2
    .byte <bg_collision4

collision_list_high:
    .byte >bg_collision
    .byte >bg_collision1
    .byte >bg_collision2
    .byte >bg_collision4
