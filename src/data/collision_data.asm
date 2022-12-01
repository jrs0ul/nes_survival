x_collision_pattern:
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001

hut_collision:
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%11111111,%11111111,%00000000
    .byte %00000000,%11111111,%11111111,%00000000
    .byte %00000000,%11111111,%11111111,%00000000
    .byte %00000000,%10000111,%10000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%11100000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%11100000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%10000000,%00000001,%00000000
    .byte %00000000,%11111111,%00011111,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000

bg_collision:
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %01100000,%00000000,%00000000,%00000000
    .byte %00011000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%11000000,%00000000,%00000000
    .byte %00000001,%11100000,%00000000,%00000000
    .byte %00000011,%11110000,%01100000,%11000000
    .byte %00000011,%11110000,%01100000,%11000000
    .byte %00000011,%10010000,%01100000,%11000000
    .byte %00000011,%10010000,%00011000,%00000000
    .byte %00000000,%00000000,%00011000,%00000000
    .byte %00000000,%00000000,%00011000,%00000000
    .byte %00000000,%00000000,%00000011,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %11000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000

bg_collision1:
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%11000000
    .byte %00000000,%00000000,%01100000,%00000000
    .byte %00000110,%00001100,%01100000,%00001100
    .byte %00000110,%00000000,%01100000,%00111111
    .byte %00000110,%00110011,%00000000,%00111111
    .byte %00000001,%10000000,%00000000,%00110011
    .byte %00000001,%10000000,%00011000,%00000000
    .byte %00000001,%10000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00001100,%00000000,%00000000,%00110000
    .byte %00001100,%00000001,%10000011,%00000000
    .byte %00001100,%00000001,%10000011,%00000011
    .byte %00000000,%00000111,%10000011,%00110011
    .byte %00000001,%10000110,%00000000,%00111111
    .byte %00110001,%10000110,%00110000,%00111100
    .byte %00000001,%10000000,%00001100,%00001100
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000

bg_collision2:
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%11000000
    .byte %00000000,%00000000,%01100000,%00000000
    .byte %00000110,%00001100,%01100000,%00001100
    .byte %00000110,%00000000,%01100000,%00111111
    .byte %00000110,%00110011,%00000000,%00111111
    .byte %00000001,%10000000,%00000000,%00110011
    .byte %00000001,%10000000,%00011000,%00000000
    .byte %00000001,%10000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00001100,%00000000,%00000000,%00110000
    .byte %00001100,%00000001,%10000011,%00000000
    .byte %00001100,%00000001,%10000011,%00000011
    .byte %00000000,%00000111,%10000011,%00110011
    .byte %00000001,%10000110,%00000000,%00111111
    .byte %00110001,%10000110,%00110000,%00111100
    .byte %00000001,%10000000,%00001100,%00001100
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000

bg_collision3:
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00110000,%00000000,%00000000,%11000000
    .byte %00000000,%00000000,%01100000,%00000000
    .byte %00000110,%00001100,%01100000,%00001100
    .byte %00000110,%00000000,%01100000,%00111111
    .byte %00000110,%00110011,%00000000,%00111111
    .byte %00000001,%10000000,%00000000,%00110011
    .byte %00000001,%10000000,%00011000,%00000000
    .byte %00000001,%10000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00001100,%00000000,%00000000,%00110000
    .byte %00001100,%00000001,%10000011,%00000000
    .byte %00001100,%00000001,%10000011,%00000011
    .byte %00000000,%00000111,%10000011,%00110011
    .byte %00000001,%10000110,%00000000,%00111111
    .byte %00110001,%10000110,%00110000,%00111100
    .byte %00000001,%10000000,%00001100,%00001100
    .byte %00000000,%00000000,%00000000,%00000000
    .byte %00000000,%00000000,%00000000,%00000000

collision_list_low:
    .byte <bg_collision
    .byte <bg_collision1
    .byte <bg_collision2
    .byte <bg_collision3

collision_list_high:
    .byte >bg_collision
    .byte >bg_collision1
    .byte >bg_collision2
    .byte >bg_collision3
