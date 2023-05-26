.include "maps/villager_hut_collision.asm"
.include "maps/villager_hut_collision_at_night.asm"
.include "maps/field2_bg_collision.asm"
.include "maps/field2_bg_collision1.asm"


collision_list_low2:
    .byte <bg2_collision
    .byte <bg2_collision1

collision_list_high2:
    .byte >bg2_collision
    .byte >bg2_collision1
