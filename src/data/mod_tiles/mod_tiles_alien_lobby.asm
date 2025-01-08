;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF

mod_tiles_alien_lobby:
    .byte 11, $20, $F0, 0, 7, 16, $59, $E0
    .byte 11, $20, $F1, 0, 7, 17, $59, $E1
    .byte 11, $21, $10, 0, 8, 16, $59, $F0
    .byte 11, $21, $11, 0, 8, 17, $59, $F1
