;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF
mod_tiles_first:
    .byte 0,  $27, $30, 3, 25, 16, $7C, $9C
    .byte 0,  $27, $31, 3, 25, 17, $7C, $9D
    .byte 0,  $27, $50, 3, 26, 16, $7C, $AC
    .byte 0,  $27, $51, 3, 26, 17, $7C, $AD

mod_tiles_scroll_first:
    .byte 17
    .byte 17
    .byte 17
    .byte 17
