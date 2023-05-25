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
    .byte 0, 0, 64,  88,  0,   0,   102, 110, <MustLoadIndoorsAfterFadeout,     >MustLoadIndoorsAfterFadeout,     0, 0, 0, 0, 0, 0
    ;Bear's house entrance
    .byte 1, 0, $76, $79, $B6, $BE, $68, $6F, <MustLoadVillagerHutAfterFadeout, >MustLoadVillagerHutAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Second location entry point
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 0, 0, 32, <MustLoadSecondLocationAfterFadeout, >MustLoadSecondLocationAfterFadeout, 0, 0, 0, 0, 0, 0
    ;Third location entry point
    .byte 0, 1, 0, 255, 0, 255, 225, 255, <MustLoadThirdLocationAfterFadeout, >MustLoadThirdLocationAfterFadeout, 0, 0, 0, 0, 0, 0, 0
    ;Exit point of second location
    .byte 1
    ;Exit point of third location
    .byte 2
    ;Bear's house exit
    .byte 3
    ;Player's house exit
    .byte 4
