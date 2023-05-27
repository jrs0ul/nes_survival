;where you enter a new location
;location index,
;CurrentMapSegmentIndex value,
;MinX,
;MaxX,
;GlobalScrollMin,
;GlobalScrollMax,
;MinY,
;MaxY
;<unused bytes>

MapEntryPoints:
    ;Entry to player's house from outside
    .byte 0, 0, 64,  88,  0,   255,   102, 110, 0, 0, 0, 0, 0, 0, 0, 0
    ;Bear's house entrance
    .byte 1, 0, $76, $79, $B6, $BE, $68, $6F, 0, 0, 0, 0, 0, 0, 0, 0
    ;Second location entry point
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 0, 32, 0, 0, 0, 0, 0, 0, 0, 0
    ;Third location entry point
    .byte 0, 1, 0, 255, 0, 255, 225, 255, 0, 0, 0, 0, 0, 0, 0, 0
    ;Exit point of second location
    .byte 1, 0, 0, 255, 0, 255, 230, 255, 0, 0, 0, 0, 0, 0, 0, 0
    ;Exit point of third location
    .byte 2, 0, 0, 255, 0, 255, 0,   32,  0, 0, 0, 0, 0, 0, 0, 0
    ;Bear's house exit
    .byte 3, 0, 0, 255, 0, 255, 168, 255, 0, 0, 0, 0, 0, 0, 0, 0
    ;Player's house exit
    .byte 4, 0, 0, 255, 0, 255, 168, 255, 0, 0, 0, 0, 0, 0, 0, 0
    ;Second villager's house
    .byte 2, 0, 171, 192, 0, 255, 136, 142, 0, 0, 0, 0, 0, 0, 0, 0
    ;Second villager house's exit
    .byte 5, 0, 0, 255, 0, 255, 168, 255, 0, 0, 0, 0, 0, 0, 0, 0


;-----------------------------------------------------
;The data of the new location the player has entered 
;PlayerX,
;PlayerY,
;LocationIndex,
;ScreenCount,
;ItemListLow,
;ItemListHigh
;<unused bytes>

MapSpawnPoint:
    ;Entry to player's house from outside
    .byte 128, 152, 4, 1, <House_items, >House_items, 0, 0
    ;Bear's house entrance
    .byte 128, 136, 3, 1, <House_items, >House_items, 0, 0
    ;Second location entry point
    .byte 80, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 0, 0
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT, <House_items, >House_items, 0, 0
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 0
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 0
    ;Bear's house exit
    .byte $76, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 0, 0
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 0
    ;Second villager's house
    .byte 128, 136, 5, 1, <House_items, >House_items, 0, 0
    ;Second villager house's exit
    .byte 176, 145, 2, OUTDOORS_LOC3_SCREEN_COUNT, <House_items, >House_items, 0, 0

