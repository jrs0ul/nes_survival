;max 4 screens for a location
collision_list_low:
    .byte <bg_collision
    .byte <bg_collision1
    .byte <bg_collision2
    .byte <bg_collision4
;----
    .byte <bg2_collision
    .byte <bg2_collision1
    .byte 0
    .byte 0
;---
    .byte <LOC3_collision0

collision_list_high:
    .byte >bg_collision
    .byte >bg_collision1
    .byte >bg_collision2
    .byte >bg_collision4
;---
    .byte >bg2_collision
    .byte >bg2_collision1
    .byte 0
    .byte 0
;---
    .byte >LOC3_collision0
