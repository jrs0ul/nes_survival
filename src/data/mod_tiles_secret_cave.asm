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
    .byte 1,  $21, $31, 0, 9, 17, $5E, $F5
    .byte 1,  $21, $32, 0, 9, 18, $5E, $F6
    .byte 1,  $21, $51, 0, 10, 17, $5E, $F8
    .byte 1,  $21, $52, 0, 10, 18, $5E, $F9

    .byte 13, $21, $07, 0, 8, 7, $59, $D2
    .byte 13, $21, $08, 0, 8, 8, $59, $D3
    .byte 13, $21, $27, 0, 9, 7, $59, $D0
    .byte 13, $21, $28, 0, 9, 8, $59, $D1
