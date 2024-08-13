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
    .byte 0,  $27, $70, 3, 27, 16, $7C, $0
    .byte 0,  $27, $71, 3, 27, 17, $7C, $0
    .byte 0,  $27, $90, 3, 28, 16, $7C, $0
    .byte 0,  $27, $91, 3, 28, 17, $7C, $0

mod_tiles_scroll_first:
    .byte 17
    .byte 17
    .byte 17
    .byte 17
