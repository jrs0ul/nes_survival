;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF


mod_tiles_dark_cave2:
    .byte 10,  $27, $2C, 1, 25,  12, $59, $9C
    .byte 10,  $27, $2D, 1, 25,  13, $59, $9D
    .byte 10,  $27, $4C, 1, 26,  12, $59, $AC
    .byte 10,  $27, $4D, 1, 26,  13, $59, $AD

mod_tiles_scroll_dark_cave2:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
