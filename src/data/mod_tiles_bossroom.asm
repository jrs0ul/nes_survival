;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF

mod_tiles_boss_room:
    .byte 12, $22, $8C, 0, 20, 12, $69, $C9
    .byte 12, $22, $8D, 0, 20, 13, $69, $CA

