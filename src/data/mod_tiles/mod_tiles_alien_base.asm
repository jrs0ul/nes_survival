;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF


mod_tiles_alien_base:
    .byte 2,  $25, $0D, 1, 8,  13, $D8, $D7
    .byte 2,  $25, $2D, 1, 9,  13, $5A, $E7

mod_tiles_scroll_alien_base:
    .byte 0
    .byte 0
