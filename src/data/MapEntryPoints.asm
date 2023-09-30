;where you enter a new location
;----------------------------------
;location index, where this entry point is
;CurrentMapSegmentIndex value,
;MinX,
;MaxX,
;GlobalScrollMin,
;GlobalScrollMax,
;MinY,
;MaxY

;entry point count is stored in ENTRY_POINT_COUNT

MapEntryPoints:
    ;Entry to player's house from outside
    .byte 0, 0, 64,  88,  0,   255,   102, 110
    ;Bear's house entrance
    .byte 1, 0, 118, 122, 177, 190, $68, $6F
    ;Second location entry point
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 0, 32
    ;Third location entry point
    .byte 0, 1, 0, 255, 0, 255, 225, 255
    ;Exit point of second location
    .byte 1, 0, 0, 255, 0, 255, 230, 255
    ;Exit point of third location
    .byte 2, 0, 0, 255, 0, 255, 0,   32
    ;Bear's house exit
    .byte 3, 0, 0, 255, 0, 255, 168, 255
    ;Player's house exit
    .byte 4, 0, 0, 255, 0, 255, 168, 255
    ;Second villager's house
    .byte 2, 0, 118, 121, 48, 66, 136, 142
    ;Second villager house's exit
    .byte 5, 0, 0, 255, 0, 255, 168, 255
    ;cave entrance from location 2
    .byte 1, 0, 118, 121, 20, 30, 40, 50
    ;crashsite entrance from cave
    .byte 6, 0, 0, 255, 0, 255, 0, 32
    ;crashsite exit to cave
    .byte 7, 0, 0, 255, 0, 255, 230, 255
    ;cave exit to second location
    .byte 6, 0, 0, 255, 0, 255, 230, 255
    ;location to the south of the bear's location
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 225, 255
    ;exit from granny's location to the main one
    .byte 8, 0, 0, 255, 0, 255, 0, 32
    ;granny's house
    .byte 8, 0, 118, 121, 150, 154, 104, 111
    ;exit from grannys house
    .byte 9, 0, 0, 255, 0, 255, 168, 255


.segment "ROM0"
;-----------------------------------------------------
;The data of the new location the player has entered 
;---------------------------------------
;PlayerX,
;PlayerY,
;LocationIndex,
;ScreenCount,
;ItemListLow,
;ItemListHigh
;collision data bank
;CollisionMapLow
;CollisionMapHigh
;isInterrriorMap?
;mapLow (only interrior maps work)
;mapHigh
;max generated npc count per screen
;Premade Npcs Low
;Premade NpcsHigh
;currentMapSegment we are entering (only used for animal generation now)

MapSpawnPoint:
    ;Entry to player's house from outside
    .byte 128, 152, 4, 1, <House_items, >House_items, 0, <hut_collision, >hut_collision
    .byte 1, <house, >house, 0, <House_npcs, >House_npcs, 0
    ;Bear's house entrance
    .byte 128, 136, 3, 1, <House_items, >House_items, 4, <villager_hut_collision, >villager_hut_collision
    .byte 1, <villager_hut, >villager_hut, 0, <Hut_npcs, >Hut_npcs, 0
    ;Second location entry point
    .byte 80, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 4, <bg2_collision, >bg2_collision
    .byte 0, 0, 0, 3, 0, 0, 0
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT, <Outside3_items, >Outside3_items, 0, <LOC3_collision0, >LOC3_collision0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, <bg_collision4, >bg_collision4
    .byte 0, 0, 0, 3, 0, 0, 3
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, <bg_collision1, >bg_collision1
    .byte 0, 0, 0, 3, 0, 0, 1
    ;Bear's house exit
    .byte $76, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 4, <bg2_collision1, >bg2_collision1
    .byte 0, 0, 0, 3, 0, 0, 1
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, <bg_collision, >bg_collision
    .byte 0, 0, 0, 3, 0, 0, 0
    ;Second villager's house
    .byte 128, 136, 5, 1, <House_items, >House_items, 0, <villager2_hut_collision, >villager2_hut_collision
    .byte 1, <villager2_hut, >villager2_hut, 0, <villager2_npcs, >villager2_npcs, 0
    ;Second villager house's exit
    .byte 119, 151, 2, OUTDOORS_LOC3_SCREEN_COUNT, <Outside3_items, >Outside3_items, 0, <LOC3_collision0, >LOC3_collision0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;cave entrance
    .byte 56, 207, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, <cave1_collision, >cave1_collision
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;entrance to place where the plane is
    .byte 57, 210, 7, 1, <Crashsite_items, >Crashsite_items, 4, <crashsite_collision, >crashsite_collision
    .byte 0, 0, 0, 0, 0, 0, 0
    ;crashsite exit to cave
    .byte 57, 34, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, <cave1_collision, >cave1_collision
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;cave exit to second location
    .byte 120, 63, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 4, <bg2_collision, >bg2_collision
    .byte 0, 0, 0, 3, 0, 0, 0
    ;granny location
    .byte 100, 100, 8, 2, <House_items, >House_items, 4,  <babloc1_collision, >babloc1_collision
    .byte 0, 0, 0, 2, 0, 0, 0
    ;exit from granny's to main
    .byte 100, 200, 0, OUTDOORS_LOC1_SCREEN_COUNT,<Outside1_items, >Outside1_items, 0, <bg_collision4, >bg_collision4
    .byte 0, 0, 0, 3, 0, 0, 3
    ;granny's house
    .byte 100, 136, 9, 1, <House_items, >House_items, 0, <grannys_hut_collision, >grannys_hut_collision
    .byte 1, <grannys_hut, >grannys_hut, 0, <villager2_npcs, >villager2_npcs, 0
    ;granny's house exit to the location 8
    .byte 119, 115, 8, 2, <House_items, >House_items, 4, <babloc1_collision, >babloc1_collision
    .byte 0, 0, 0, 2, 0, 0, 0



.segment "RODATA"

LocationScreenCountList:
    .byte OUTDOORS_LOC1_SCREEN_COUNT ; 0
    .byte OUTDOORS_LOC2_SCREEN_COUNT ; 1
    .byte OUTDOORS_LOC3_SCREEN_COUNT ; 2
    .byte 1                          ; 3 Bjorn's house
    .byte 1                          ; 4 Player's house
    .byte 1                          ; 5 Hedgehog
    .byte OUTDOORS_LOC7_SCREEN_COUNT ; 6 cave
    .byte 1                          ; 7 crashsite
    .byte 2                          ; 8 granny location
    .byte 1                          ; 9 granny's hut

;which location in which bank
LocationBanks:
    .byte 0  ;0
    .byte 4  ;1
    .byte 0  ;2
    .byte 0  ;3
    .byte 0  ;4
    .byte 0  ;5
    .byte 4  ;6
    .byte 4  ;7
    .byte 4  ;8
    .byte 0  ;10


;indexes in Item_Location1_Collection_times
LocationItemIndexes:
    .byte 0
    .byte ITEM_COUNT_LOC1
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3
    .byte 0
    .byte 0

LocationItemCounts:
    .byte ITEM_COUNT_LOC1
    .byte ITEM_COUNT_LOC2
    .byte ITEM_COUNT_LOC3
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte ITEM_COUNT_LOC8
    .byte 0
    .byte 0

