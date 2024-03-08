.segment "ROM1"

;where you enter a new location
;----------------------------------
;location index, where this entry point is
;CurrentMapSegmentIndex value,
;MinX,
;MaxX,
;ScrollX Min,
;ScrollX Max,
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
    .byte 1, 0, 118, 136, 169, 192, $68, $6F
    ;5.Exit point of second location
    .byte 1, 0, 0, 255, 0, 255, 222, 255
    ;6.entrance to cave location
    .byte 1, 0, 0, 255, 0, 255, 0, 20
    ;----------------------------------------
    ;7.Exit point of third location
    .byte 2, 0, 0, 255, 0, 255, 0,   20
    ;8.Erika's house
    .byte 2, 0, 117, 124, 126, 135, 122, 135
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
    ;14.dark cave entrance bottom
    .byte 6, 1, 232, 255, 0, 255, 160, 199
    ;15.alien base entrance top
    .byte 6, 1, 232, 255, 0, 255, 24, 55
    ;--------------------------
    ;16.crashsite exit to cave
    .byte 7, 0, 0, 255, 0, 255, 222, 255
    ;--------------------------
    ;17.exit from granny's location to the main one
    .byte 8, 0, 0, 255, 0, 255, 0, 32
    ;18.granny's house
    .byte 8, 0, 118, 122, 150, 155, 104, 111
    ;19.secret cave
    .byte 8, 2, 156, 167,   0,   255, 130, 135
    ;-------------------
    ;20.exit from grannys house
    .byte 9, 0, 0, 255, 0, 255, 151, 255
    ;--------------------
    ;21.alien base exit top
    .byte 10, 0, 0, 5, 0, 255, 88, 111
    ;22.alien base exit bottom
    .byte 10, 0, 0, 5, 0, 255, 160, 200
    ;--------------------------
    ;23.exit from cave location to bjorn's location
    .byte 11, 0, 0, 255, 0,255, 222, 255
    ;24.cave entrance from location 11
    .byte 11, 0, 140, 151, 0, 255, 40, 50
    ;25. Boss room entrance
    .byte 10, 1, 238, 255, 0, 255, 112, 128
    ;-------------------------------------
    ;26 Boss room exit
    .byte 12, 0, 0, 4, 0, 255, 112, 127
    ;-------------------------------------
    ;27 Dark cave exit to light cave
    .byte 13, 0, 0, 5, 0, 255, 32, 55
    ;28 alien base entrance bottom
    .byte 13, 1, 232, 255, 0, 255, 32, 55
    ;-------------------------------------
    ;29 Secret cave exit
    .byte 14, 0, 0, 255, 0, 255, 222, 255


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
    .byte 77, 42, 8, OUTDOORS_LOC9_SCREEN_COUNT, <granny_location_items, >granny_location_items, 5,  0, 0
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
    .byte 119, 151, 2, OUTDOORS_LOC3_SCREEN_COUNT, <Outside3_items, >Outside3_items, 0, 128, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;---------------
    ;entrance to place where the plane is
    .byte 57, 210, 7, 2, <Crashsite_items, >Crashsite_items, 5, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;cave exit to cave location
    .byte 144, 63, 11, 1, <House_items, >House_items, 5, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;dark cave entrance
    .byte 15, 50, 13, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, <dark_cave_npcs, >dark_cave_npcs, 0
    ;alien base entrance top
    .byte 15, 90, 10, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;---------------------
    ;crashsite exit to cave
    .byte 56, 34, 6, OUTDOORS_LOC7_SCREEN_COUNT, <Cave_items, >Cave_items, 4, 0, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;---------------------
    ;exit from granny's location to main
    .byte 127, 205, 0, OUTDOORS_LOC1_SCREEN_COUNT,<Outside1_items, >Outside1_items, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, 0, 0, 3, 0, 0, 3
    ;granny's house
    .byte 123, 148, 9, 1, <House_items, >House_items, 0, 0, 0
    .byte 1, <grannys_hut, >grannys_hut, 0, <villager3_npcs, >villager3_npcs, 0
    ;secret cave
    .byte 127, 209, 14, 1, <secret_cave_items, >secret_cave_items, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;--------------------
    ;granny's house exit to the location 8
    .byte 119, 126, 8, OUTDOORS_LOC9_SCREEN_COUNT, <granny_location_items, >granny_location_items, 5, 154, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;------------
    ;alien base exit top
    .byte 230, 50, 6, OUTDOORS_LOC7_SCREEN_COUNT, <Cave_items, >Cave_items, 4, 0, 1
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;alien base exit to dark cave
    .byte 230, 50, 13, 2, <House_items, >House_items, 4, 0, 1
    .byte 0, 0, 0, 0, <dark_cave_npcs, >dark_cave_npcs, 0
    ;--------------
    ;exit from cave location to bjorn's location
    .byte 135, 38, 1, OUTDOORS_LOC2_SCREEN_COUNT, <Outside2_items, >Outside2_items, 5, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;cave entrance
    .byte 88, 207, 6, OUTDOORS_LOC7_SCREEN_COUNT, <Cave_items, >Cave_items, 4, 0, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;boss room entrance
    .byte 20, 120, 12, 1, <House_items, >House_items, 6, 0, 0
    .byte 0, <alien_bossroom, >alien_bossroom, 0, 0, 0, 0
    ;---------------
    ;boss room exit
    .byte 223, 120, 10, 2, <House_items, >House_items, 4, 0, 1
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;----------------
    ;Dark cave exit to light cave
    .byte 230, 180, 6, OUTDOORS_LOC7_SCREEN_COUNT, <Cave_items, >Cave_items, 4, 0, 1
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0

    ;alien base entrance bottom
    .byte 15, 170, 10, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;---------------------
    ;secret cave exit to location 8
    .byte 156, 140, 8, OUTDOORS_LOC9_SCREEN_COUNT, <granny_location_items, >granny_location_items, 5, 0 ,2
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
    .byte 2                          ; 7 crashsite
    .byte OUTDOORS_LOC9_SCREEN_COUNT ; 8 granny location
    .byte 1                          ; 9 granny's hut
    .byte 2                          ; 10 alien base
    .byte 1                          ; 11 location where cave is
    .byte 1                          ; 12 boss room
    .byte 2                          ; 13 dark cave
    .byte 1                          ; 14 secret cave

;what is index(0..N) for entry points for each location
;note: a loction can have multiple entry points
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
    .byte 20  ;9
    .byte 21  ;10
    .byte 23  ;11
    .byte 26  ;12
    .byte 27  ;13
    .byte 29  ;14


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
    .byte 6  ;12
    .byte 4  ;13
    .byte 6  ;14


;indexes in Item_Location1_Collection_times
LocationItemIndexes:
    .byte 0                                                   ;0
    .byte ITEM_COUNT_LOC1                                     ;1
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2                   ;2
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 ;3
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 ;4
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 ;5
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 ;6
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 + ITEM_COUNT_LOC7 ;7 crashsite
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 + ITEM_COUNT_LOC7 + ITEM_COUNT_LOC8
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2 + ITEM_COUNT_LOC3 + ITEM_COUNT_LOC7 + ITEM_COUNT_LOC8 + ITEM_COUNT_LOC9

LocationItemCounts:
    .byte ITEM_COUNT_LOC1  ; 0
    .byte ITEM_COUNT_LOC2  ; 1
    .byte ITEM_COUNT_LOC3  ; 2
    .byte 0                ; 3
    .byte 0                ; 4
    .byte 0                ; 5
    .byte ITEM_COUNT_LOC7  ; 6 cave
    .byte ITEM_COUNT_LOC8  ; 7 crashsite
    .byte ITEM_COUNT_LOC9  ; 8 granny location
    .byte 0                ; 9
    .byte 0                ; 10
    .byte 0                ; 11
    .byte 0                ; 12
    .byte 0                ; 13
    .byte ITEM_COUNT_LOC14 ; 14 secret cave

LocationsWithRespawnableItems:
    .byte 1 ; 0
    .byte 1 ; 1
    .byte 1 ; 2
    .byte 0 ; 3
    .byte 0 ; 4
    .byte 0 ; 5
    .byte 0 ; 6
    .byte 0 ; 7
    .byte 0 ; 8
    .byte 1 ; 9   granny location
    .byte 0 ; 10
    .byte 0 ; 11
    .byte 0 ; 12  boss
    .byte 0 ; 13  dark cave
    .byte 0 ; 14

