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
    ;0.Entry to player's house from outside
    .byte 0, 0, 64,  88,  0,   255,   102, 110
    ;1.Second location entry point
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 0, 22
    ;2.Third location entry point
    .byte 0, 1, 0, 255, 0, 255, 222, 255
    ;3.granny location
    .byte 0, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 222, 255
    ;---------------------------------------
    ;4.Bear's house entrance
    .byte 1, 0, 118, 122, 177, 190, $68, $6F
    ;5.Exit point of second location
    .byte 1, 0, 0, 255, 0, 255, 222, 255
    ;6.entrance to cave location
    .byte 1, 0, 0, 255, 0, 255, 0, 20
    ;----------------------------------------
    ;7.Exit point of third location
    .byte 2, 0, 0, 255, 0, 255, 0,   20
    ;8.Second villager's house
    .byte 2, 0, 118, 122, 48, 66, 122, 142
    ;------------------------
    ;9.Bjorn's house exit
    .byte 3, 0, 0, 255, 0, 255, 152, 255
    ;-----------------------
    ;10.Player's house exit
    .byte 4, 0, 0, 255, 0, 255, 160, 255
    ;-----------------------
    ;11.Second villager house's exit
    .byte 5, 0, 0, 255, 0, 255, 152, 255
    ;------------------------
    ;12.crashsite entrance from cave
    .byte 6, 0, 0, 255, 0, 255, 0, 22
    ;13.cave exit to cave location
    .byte 6, 0, 0, 255, 0, 255, 222, 255
    ;14.alien base entrance bottom
    .byte 6, 2, 232, 255, 0, 255, 160, 199
    ;15.alien base entrance top
    .byte 6, 2, 232, 255, 0, 255, 88, 111
    ;--------------------------
    ;16.crashsite exit to cave
    .byte 7, 0, 0, 255, 0, 255, 222, 255
    ;--------------------------
    ;17.exit from granny's location to the main one
    .byte 8, 0, 0, 255, 0, 255, 0, 32
    ;18.granny's house
    .byte 8, 0, 118, 122, 150, 155, 104, 111
    ;-------------------
    ;19.exit from grannys house
    .byte 9, 0, 0, 255, 0, 255, 151, 255
    ;--------------------
    ;20.alien base exit top
    .byte 10, 0, 0, 5, 0, 255, 88, 111
    ;21.alien base exit bottom
    .byte 10, 0, 0, 5, 0, 255, 160, 200
    ;--------------------------
    ;22.exit from cave location to bjorn's location
    .byte 11, 0, 0, 255, 0,255, 222, 255
    ;23.cave entrance from location 11
    .byte 11, 0, 140, 151, 0, 255, 40, 50


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
;location bank number
;scroll X
;active screen
;isInterrriorMap?
;mapLow (only interrior maps work)
;mapHigh
;max generated npc count per screen
;Premade Npcs Low
;Premade NpcsHigh
;currentMapSegment we are entering (only used for animal generation now)

MapSpawnPoint:
    ;Entry to player's house from outside
    .byte 128, 152, 4, 1, <House_items, >House_items, 0, 0, 0
    .byte 1, <house, >house, 0, <House_npcs, >House_npcs, 0
    ;Second location entry point
    .byte 80, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 5, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT, <Outside3_items, >Outside3_items, 0, 0, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;granny location
    .byte 77, 42, 8, 2, <House_items, >House_items, 5,  0, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;---------------------
    ;Bear's house entrance
    .byte 128, 136, 3, 1, <House_items, >House_items, 5, 0, 0
    .byte 1, <villager_hut, >villager_hut, 0, <Hut_npcs, >Hut_npcs, 0
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, 0, 0, 3, 0, 0, 3
    ;entrance to cave location
    .byte 138, 210, 11, 1, <House_items, >House_items, 5, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;-----------------
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 103, 1
    .byte 0, 0, 0, 3, 0, 0, 1
    ;Second villager's house
    .byte 128, 136, 5, 1, <House_items, >House_items, 0, 0, 0
    .byte 1, <villager2_hut, >villager2_hut, 0, <villager2_npcs, >villager2_npcs, 0
    ;------------------
    ;Bear's house exit
    .byte $76, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 5, $B8, 0
    .byte 0, 0, 0, 3, 0, 0, 1
    ;-----------------
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT, <Outside1_items, >Outside1_items, 0, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;-----------------
    ;Second villager house's exit
    .byte 119, 151, 2, OUTDOORS_LOC3_SCREEN_COUNT, <Outside3_items, >Outside3_items, 0, 57, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;---------------
    ;entrance to place where the plane is
    .byte 57, 210, 7, 1, <Crashsite_items, >Crashsite_items, 5, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;cave exit to cave location
    .byte 144, 63, 11, 1, <House_items, >House_items, 5, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;alien base entrance bottom
    .byte 15, 170, 10, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;alien base entrance top
    .byte 15, 90, 10, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;---------------------
    ;crashsite exit to cave
    .byte 121, 34, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, 194, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;---------------------
    ;exit from granny's location to main
    .byte 127, 205, 0, OUTDOORS_LOC1_SCREEN_COUNT,<Outside1_items, >Outside1_items, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, 0, 0, 3, 0, 0, 3
    ;granny's house
    .byte 123, 148, 9, 1, <House_items, >House_items, 0, 0, 0
    .byte 1, <grannys_hut, >grannys_hut, 0, <villager3_npcs, >villager3_npcs, 0
    ;--------------------
    ;granny's house exit to the location 8
    .byte 119, 126, 8, 2, <House_items, >House_items, 5, 154, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;------------
    ;alien base exit top
    .byte 230, 100, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, 0, 2
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;alien base exit bottom
    .byte 230, 180, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, 0, 2
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;--------------
    ;exit from cave location to bjorn's location
    .byte 135, 38, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 5, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;cave entrance
    .byte 120, 207, 6, OUTDOORS_LOC7_SCREEN_COUNT, <House_items, >House_items, 4, 194, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0





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
    .byte 2                          ; 10 alien base
    .byte 1                          ; 11 location where cave is

;what is index for entry points for each location
LocationEntryPointsPos:
    .byte 0   ;0
    .byte 4   ;1
    .byte 7   ;2
    .byte 9   ;3
    .byte 10  ;4
    .byte 11  ;5
    .byte 12  ;6
    .byte 16  ;7
    .byte 17  ;8
    .byte 19  ;9
    .byte 20  ;10
    .byte 22  ;11


;which location in which bank
LocationBanks:
    .byte 0  ;0
    .byte 5  ;1
    .byte 0  ;2
    .byte 0  ;3
    .byte 0  ;4
    .byte 0  ;5
    .byte 4  ;6
    .byte 5  ;7
    .byte 5  ;8
    .byte 0  ;9
    .byte 4  ;10
    .byte 5  ;11


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
    .byte 0
    .byte 0

