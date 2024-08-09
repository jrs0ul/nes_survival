;Tiles that can be modified:
;   state index in Destructibles
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value ON
;   tile value OFF

mod_tiles_secret_cave:
    .byte 1,  $21, $88, 0, 12, 8,  $5E, $0
    .byte 1,  $21, $89, 0, 12, 9,  $5E, $0
    .byte 1,  $21, $A8, 0, 13, 8,  $5E, $0
    .byte 1,  $21, $A9, 0, 13, 9,  $5E, $0
