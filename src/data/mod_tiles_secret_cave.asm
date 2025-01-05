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
    .byte 1,  $21, $88, 0, 12, 8, $5E, $F5
    .byte 1,  $21, $89, 0, 12, 9, $5E, $F6
    .byte 1,  $21, $A8, 0, 13, 8, $5E, $F8
    .byte 1,  $21, $A9, 0, 13, 9, $5E, $F9

    .byte 13, $20, $CC, 0, 6, 12, $59, $D2
    .byte 13, $20, $CD, 0, 6, 13, $59, $D3
    .byte 13, $20, $EC, 0, 7, 12, $59, $D0
    .byte 13, $20, $ED, 0, 7, 13, $59, $D1
