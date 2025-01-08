;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF
mod_tiles_mine:
    .byte 3,  $22, $32, 0, 17, 18, $51, $B8
    .byte 3,  $22, $33, 0, 17, 19, $51, $B9
    .byte 3,  $22, $52, 0, 18, 18, $51, $C8
    .byte 3,  $22, $53, 0, 18, 19, $51, $C9

mod_tile_scroll_mine:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
