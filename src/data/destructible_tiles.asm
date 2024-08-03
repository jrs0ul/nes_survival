;Tiles that can be destroyed:
;   location,
;   tile address high, (in video memory)
;   tile address low,
;   screen
;   tile row
;   tile column
;   tile value after destruction
;   scrollx amount to activate screen update
destructible_tiles_list:                 ;sc  y   x
    .byte LOCATION_FIRST,       $27, $70, 3, 27, 16, $7C, 17
    .byte LOCATION_FIRST,       $27, $71, 3, 27, 17, $7C, 17
    .byte LOCATION_FIRST,       $27, $90, 3, 28, 16, $7C, 17
    .byte LOCATION_FIRST,       $27, $91, 3, 28, 17, $7C, 17

    .byte LOCATION_SECRET_CAVE, $21, $88, 0, 12, 8,  $5E, 0
    .byte LOCATION_SECRET_CAVE, $21, $89, 0, 12, 9,  $5E, 0
    .byte LOCATION_SECRET_CAVE, $21, $A8, 0, 13, 8,  $5E, 0
    .byte LOCATION_SECRET_CAVE, $21, $A9, 0, 13, 9,  $5E, 0

    .byte LOCATION_ALIEN_BASE,  $25, $0D, 1, 8,  13, $D8, 0
    .byte LOCATION_ALIEN_BASE,  $25, $2D, 1, 9,  13, $5A, 0

    .byte LOCATION_MINE,        $22, $32, 0, 17, 18, $51, 0
    .byte LOCATION_MINE,        $22, $33, 0, 17, 19, $51, 0
    .byte LOCATION_MINE,        $22, $52, 0, 18, 18, $51, 0
    .byte LOCATION_MINE,        $22, $53, 0, 18, 19, $51, 0

    .byte LOCATION_ALIEN_BASE_PRE, $20, $A6, 0, 5, 6, $50, 0
    .byte LOCATION_ALIEN_BASE_PRE, $20, $A7, 0, 5, 7, $6B, 0

    .byte LOCATION_ALIEN_BASE_PRE, $20, $E6, 0, 7, 6, $50, 0
    .byte LOCATION_ALIEN_BASE_PRE, $20, $E7, 0, 7, 7, $6B, 0

    .byte LOCATION_ALIEN_BASE_PRE, $21, $26, 0, 9, 9, $50, 0
    .byte LOCATION_ALIEN_BASE_PRE, $21, $27, 0, 9, 7, $6B, 0

    .byte LOCATION_ALIEN_BASE_PRE, $21, $77, 0, 11, 23, $D9, 0
    .byte LOCATION_ALIEN_BASE_PRE, $21, $28, 0, 11, 24, $DA, 0
    .byte LOCATION_ALIEN_BASE_PRE, $21, $97, 0, 12, 23, $B9, 0
    .byte LOCATION_ALIEN_BASE_PRE, $21, $98, 0, 12, 24, $BA, 0

;indexes of destructible tiles for a location, 255 means there are no tiles
destructible_tile_location_lookup:
    .byte 0   ;0
    .byte 255 ;1
    .byte 255 ;2
    .byte 255 ;3
    .byte 255 ;4
    .byte 255 ;5
    .byte 10  ;6 abandoned mine
    .byte 255 ;7
    .byte 255 ;8
    .byte 255 ;9
    .byte 8   ;10 alien base
    .byte 255 ;11
    .byte 255 ;12
    .byte 255 ;13
    .byte 4   ;14
    .byte 255 ;15
    .byte 255 ;16
    .byte 255 ;17
    .byte 255 ;18
    .byte 14  ;19 alien base pre

;Destructible index assigned to a tile
linked_destructible_tiles:
    .byte 0 ;0 boulder
    .byte 0 ;1
    .byte 0 ;2
    .byte 0 ;3
    .byte 1 ;4 rock in secret cave
    .byte 1 ;5
    .byte 1 ;6
    .byte 1 ;7
    .byte 2 ;8 door in alien base
    .byte 3 ;9
    .byte 4 ;10 locked door in mine
    .byte 4 ;11
    .byte 4 ;12
    .byte 4 ;13
    .byte 5 ;14
    .byte 5 ;15
    .byte 6 ;16
    .byte 6 ;17
    .byte 7 ;18
    .byte 7 ;19
    .byte 8 ;20
    .byte 8 ;21
    .byte 8 ;22
    .byte 8 ;23

