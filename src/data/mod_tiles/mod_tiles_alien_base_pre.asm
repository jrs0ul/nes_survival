;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF
mod_tiles_alien_base_pre:
    .byte 4, $20, $A6, 0, 5,  6,  $50, $C9
    .byte 4, $20, $A7, 0, 5,  7,  $6B, $CA

    .byte 5, $20, $E6, 0, 7,  6,  $50, $C9
    .byte 5, $20, $E7, 0, 7,  7,  $6B, $CA

    .byte 6, $21, $26, 0, 9,  6,  $50, $C9
    .byte 6, $21, $27, 0, 9,  7,  $6B, $CA

    .byte 7, $21, $73, 0, 11, 19, $D9, $A9
    .byte 7, $21, $74, 0, 11, 20, $DA, $AA
    .byte 7, $21, $93, 0, 12, 19, $E9, $B9
    .byte 7, $21, $94, 0, 12, 20, $EA, $BA

    .byte 8, $25, $69, 1, 11,  9, $D9, $A9
    .byte 8, $25, $6A, 1, 11, 10, $DA, $AA
    .byte 8, $25, $89, 1, 12,  9, $E9, $B9
    .byte 8, $25, $8A, 1, 12, 10, $EA, $BA

    .byte 9, $21, $61, 2, 11, 1,  $D9, $A9
    .byte 9, $21, $62, 2, 11, 2,  $DA, $AA
    .byte 9, $21, $81, 2, 12, 1,  $E9, $B9
    .byte 9, $21, $82, 2, 12, 2,  $EA, $BA

mod_tiles_scroll_alien_base_pre:
    .byte 165
    .byte 165
    
    .byte 165
    .byte 165
    
    .byte 165
    .byte 165

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 230
    .byte 230
    .byte 230
    .byte 230
