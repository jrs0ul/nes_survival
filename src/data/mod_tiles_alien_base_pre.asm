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

    .byte 7, $21, $77, 0, 11, 23, $D9, $A9
    .byte 7, $21, $78, 0, 11, 24, $DA, $AA
    .byte 7, $21, $97, 0, 12, 23, $E9, $B9
    .byte 7, $21, $98, 0, 12, 24, $EA, $BA

    .byte 8, $25, $6F, 1, 11, 15, $D9, $A9
    .byte 8, $25, $70, 1, 11, 16, $DA, $AA
    .byte 8, $25, $8F, 1, 12, 15, $E9, $B9
    .byte 8, $25, $90, 1, 12, 16, $EA, $BA

    .byte 9, $25, $6F, 2, 11, 9,  $D9, $A9
    .byte 9, $25, $70, 2, 11, 10, $DA, $AA
    .byte 9, $25, $8F, 2, 12, 9,  $E9, $B9
    .byte 9, $25, $90, 2, 12, 10, $EA, $BA

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

    .byte 0
    .byte 0
    .byte 0
    .byte 0
