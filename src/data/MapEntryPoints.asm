;where you enter a new location
;location index,
;CurrentMapSegmentIndex value,
;MinX,
;MaxX,
;GlobalScrollMin,
;GlobalScrollMax,
;MinY,
;MaxY,
;triggerValueAdressLow,
;triggerValueAdressHigh
;<unused bytes>

MapEntryPoints:
    ;Entry to player's house from outside
    .byte 0, 0, 64,  88,  0,   255,   102, 110, <MustLoadIndoorsAfterFadeout,     >MustLoadIndoorsAfterFadeout,     0, 0, 0, 0, 0, 0
    ;Bear's house entrance
    .byte 1, 0, $76, $79, $B6, $BE, $68, $6F, <MustLoadVillagerHutAfterFadeout, >MustLoadVillagerHutAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Second location entry point
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 0, 32, <MustLoadSecondLocationAfterFadeout, >MustLoadSecondLocationAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Third location entry point
    .byte 0, 1, 0, 255, 0, 255, 225, 255, <MustLoadThirdLocationAfterFadeout, >MustLoadThirdLocationAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Exit point of second location
    .byte 1, 0, 0, 255, 0, 255, 230, 255, <MustLoadFirstLocationAfterFadeout, >MustLoadFirstLocationAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Exit point of third location
    .byte 2, 0, 0, 255, 0, 255, 0,   32,  <MustLoadFirstLocationFromThirdAfterFadeout, >MustLoadFirstLocationFromThirdAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Bear's house exit
    .byte 3, 0, 0, 255, 0, 255, 168, 255, <MustLoadOutsideVillagerHutAfterFadeout, >MustLoadOutsideVillagerHutAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Player's house exit
    .byte 4, 0, 0, 255, 0, 255, 168, 255, <MustLoadOutsideHouseAfterFadeout, >MustLoadOutsideHouseAfterFadeout, 0, 0, 0, 0, 0, 0
;-----------------------------------------------------
;player's new position when entry point is activated
;PlayerX, PlayerY, LocationIndex, ScreenCount
MapSpawnPoint:
    ;Entry to player's house from outside
    .byte 128, 152, 4, 1
    ;Bear's house entrance
    .byte 128, 136, 3, 1
    ;Second location entry point
    .byte 80, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT
    ;Bear's house exit
    .byte $76, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT
