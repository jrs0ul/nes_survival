.segment "ROM1"

;where you enter a new location
;----------------------------------
;Entry point index
;CurrentMapSegmentIndex value,
;MinX,
;MaxX,
;ScrollX Min,
;ScrollX Max,
;MinY,
;MaxY


MapEntryPoints:

entry_points_loc0:
    ;0.Entry to player's house from outside
    .byte 0, 0, 64,  88,  0,   255,   102, 110
    ;1.Second location entry point
    .byte 1, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 0, 22
    ;2.Third location entry point
    .byte 2, 1, 0, 255, 0, 255, 222, 255
    ;3.granny location
    .byte 3, OUTDOORS_LOC1_SCREEN_COUNT - 1, 0, 255, 0, 255, 222, 255
    ;---------------------------------------
entry_points_loc1:
    ;4.Bjorn's house entrance
    .byte 4, 0, 118, 136, 168, 192, $68, $6F
    ;5.Exit point of second location
    .byte 5, 0, 0, 255, 0, 255, 222, 255
    ;6.entrance to mine location
    .byte 6, 0, 0, 255, 0, 255, 0, 20
    ;----------------------------------------
entry_points_loc2:
    ;7.Exit point of third location
    .byte 7, 0, 0, 255, 0, 255, 0,   20
    ;8.Erika's house
    .byte 8, 0, 117, 124, 126, 135, 122, 135
    ;------------------------
entry_points_loc3:
    ;9.Bjorn's house exit
    .byte 9, 0, 0, 255, 0, 255, 152, 255
    ;-----------------------
entry_points_loc4:
    ;10.Player's house exit
    .byte 10, 0, 0, 255, 0, 255, 160, 255
    ;-----------------------
entry_points_loc5:
    ;11.Second villager house's exit
    .byte 11, 0, 0, 255, 0, 255, 152, 255
    ;------------------------
entry_points_loc6:
    ;12.crashsite entrance from cave
    .byte 12, 0, 119, 125, 182, 204, 0, 22
    ;13.cave exit to cave location
    .byte 13, 0, 119, 125, 220, 230, 222, 255
    ;14.dark cave entrance bottom
    .byte 14, 2, 232, 255, 0, 255, 160, 199
    ;15.alien base entrance top
    .byte 15, 2, 207, 230, 0, 255, 43, 63
    ;16. Mine room entrance
    .byte 16, 0, 119, 123, 22, 28, 100, 138
    ;--------------------------
entry_points_loc7:
    ;17.crashsite exit to cave
    .byte 17, 1, 0, 255, 0, 255, 222, 255
    ;18.crashsite exit to path
    .byte 18, 0, 0, 255, 0, 255, 222, 255
    ;--------------------------
entry_points_loc8:
    ;19.exit from granny's location to the main one
    .byte 19, 0, 0, 255, 0, 255, 0, 32
    ;20.granny's house
    .byte 20, 0, 118, 122, 150, 155, 104, 111
    ;21.secret cave
    .byte 21, 2, 156, 167,   0,   255, 130, 135
    ;-------------------
entry_points_loc9:
    ;22.exit from grannys house
    .byte 22, 0, 0, 255, 0, 255, 151, 255
    ;--------------------
entry_points_loc10:
    ;23.alien base exit top
    .byte 23, 0, 23, 30, 0, 255, 99, 112
    ;24.alien base exit bottom
    .byte 24, 0, 0, 5, 0, 255, 160, 200
    ;25. Boss room entrance
    .byte 25, 1, 238, 255, 0, 255, 112, 128
    ;--------------------------
entry_points_loc11:
    ;26.exit from cave location to bjorn's location
    .byte 26, 2, 0, 255, 0,255, 222, 255
    ;27.cave entrance from location 11
    .byte 27, 2, 117, 122, 22, 28, 40, 50
    ;28. entrance to the path to the crashsite
    .byte 28, 0, 0, 255, 0, 255, 0, 22
    ;-------------------------------------
entry_points_loc12:
    ;29. Boss room exit
    .byte 29, 0, 0, 4, 0, 255, 112, 127
    ;-------------------------------------
entry_points_loc13:
    ;30. Dark cave exit to light cave
    .byte 30, 0, 0, 5, 0, 255, 32, 55
    ;31. entrance to dark cave second segment
    .byte 31, 1, 189, 240, 0, 255, 222, 255
    ;-------------------------------------
entry_points_loc14:
    ;32. Secret cave exit
    .byte 32, 0, 0, 255, 0, 255, 222, 255
    ;-------------------------------------
entry_points_loc15:
    ;33. Mine room exit
    .byte 33, 0, 0  , 255, 0, 255, 160, 255
    ;--------------------------------------
entry_points_loc16:
    ;34. Dark cave2 exit to dark cave 1
    .byte 34, 1, 189, 255, 0, 255, 0, 32
    ;35. alien base lobby entrance
    .byte 35, 0, 8, 32, 0, 255, 180, 200
    ;--------------------------------------
entry_points_loc17:
    ;36. alien base entrance bottom
    .byte 36, 0, 222, 255, 0, 255, 125, 140
    ;37. exit to dark cave 2
    .byte 37, 0, 32, 40, 0, 255, 119, 130
    ;--------------------------------------
entry_points_loc18:
    ;38. entrance to crashsite location
    .byte 38, 0, 0, 255, 0, 255, 0, 50
    ;39. entrance to location with mine
    .byte 39, 0, 0, 255, 0, 255, 222, 255

.segment "ROM0"
;-----------------------------------------------------
;The data of the new location the player has entered 
;---------------------------------------
;PlayerX,
;PlayerY,
;LocationIndex,
;ScreenCount,
;UNUSED,
;UNUSED,
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
    .byte 128, 152, 4, 1, UNUSED, UNUSED, 0, 0, 0
    .byte 1, <house, >house, 0, <House_npcs, >House_npcs, 0
    ;Second location entry point
    .byte 80, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT, UNUSED, UNUSED, 5, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT, UNUSED, UNUSED, 0, 0, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;granny location
    .byte 77, 42, 8, OUTDOORS_LOC9_SCREEN_COUNT, UNUSED, UNUSED, 5,  0, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;---------------------
    ;Bear's house entrance
    .byte 128, 136, 3, 1, UNUSED, UNUSED, 5, 0, 0
    .byte 1, <villager_hut, >villager_hut, 0, <Hut_npcs, >Hut_npcs, 0
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT, UNUSED, UNUSED, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, 0, 0, 3, 0, 0, 3
    ;entrance to mine location
    .byte 119, 210, 11, OUTDOORS_LOC12_SCREEN_COUNT, UNUSED, UNUSED, 5, 160, 2
    .byte 0, 0, 0, 2, 0, 0, 0
    ;-----------------
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT, UNUSED, UNUSED, 0, 103, 1
    .byte 0, 0, 0, 3, 0, 0, 1
    ;Second villager's house
    .byte 128, 136, 5, 1, UNUSED, UNUSED, 0, 0, 0
    .byte 1, <villager2_hut, >villager2_hut, 0, <villager2_npcs, >villager2_npcs, 0
    ;------------------
    ;Bear's house exit
    .byte $76, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT, UNUSED, UNUSED, 5, $B8, 0
    .byte 0, 0, 0, 3, 0, 0, 1
    ;-----------------
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT, UNUSED, UNUSED, 0, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;-----------------
    ;Second villager house's exit
    .byte 119, 151, 2, OUTDOORS_LOC3_SCREEN_COUNT, UNUSED, UNUSED, 0, 128, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;---------------
    ;The abandoned mine
    ;---------------
    ;entrance to place where the plane is
    .byte 120, 210, 7, OUTDOORS_LOC8_SCREEN_COUNT, UNUSED, UNUSED, 4, 121, 1
    .byte 0, 0, 0, 0, 0, 0, 0
    ;cave exit to cave location
    .byte 119, 63, 11, OUTDOORS_LOC12_SCREEN_COUNT, UNUSED, UNUSED, 5, 24, 2
    .byte 0, 0, 0, 2, 0, 0, 0
    ;dark cave entrance
    .byte 15, 50, 13, 2, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, <dark_cave_npcs, >dark_cave_npcs, 0
    ;alien base entrance top
    .byte 15, 90, 10, 2, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;Mine room entrance
    .byte 120, 152, 15, 1, UNUSED, UNUSED, 0, 0, 0
    .byte 1, <mine_room, >mine_room, 0, <House_npcs, >House_npcs, 0
    ;---------------------
    ;crashsite exit to cave
    .byte 120, 34, 6, OUTDOORS_LOC7_SCREEN_COUNT, UNUSED, UNUSED, 4, 192, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;crashsite exit to path
    .byte 120, 50, 18, 1, UNUSED, UNUSED, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;---------------------
    ;exit from granny's location to main
    .byte 127, 205, 0, OUTDOORS_LOC1_SCREEN_COUNT, UNUSED, UNUSED, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, 0, 0, 3, 0, 0, 3
    ;granny's house
    .byte 123, 148, 9, 1, UNUSED, UNUSED, 0, 0, 0
    .byte 1, <grannys_hut, >grannys_hut, 0, <villager3_npcs, >villager3_npcs, 0
    ;secret cave
    .byte 127, 209, 14, 1, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;--------------------
    ;granny's house exit to the location 8
    .byte 119, 126, 8, OUTDOORS_LOC9_SCREEN_COUNT, UNUSED, UNUSED, 5, 154, 0
    .byte 0, 0, 0, 2, 0, 0, 0
    ;------------
    ;alien base exit top
    .byte 200, 50, 6, OUTDOORS_LOC7_SCREEN_COUNT, UNUSED, UNUSED, 4, 0, 2
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;alien base exit to lobby
    .byte 190, 140, 17, 1, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;boss room entrance
    .byte 20, 120, 12, 1, UNUSED, UNUSED, 6, 0, 0
    .byte 1, <alien_bossroom, >alien_bossroom, 0, 0, 0, 0
    ;--------------
    ;A location with the mine entrance
    ;--------------
    ;exit from cave location to bjorn's location
    .byte 135, 38, 1, OUTDOORS_LOC2_SCREEN_COUNT, UNUSED, UNUSED, 5, 0, 0
    .byte 0, 0, 0, 3, 0, 0, 0
    ;cave entrance
    .byte 120, 207, 6, OUTDOORS_LOC7_SCREEN_COUNT, UNUSED, UNUSED, 4, 222, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;entrance to the path to the crashsite
    .byte 120, 180, 18, 1, <House_items, >House_items, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;---------------
    ;boss room exit
    .byte 223, 120, 10, 2, UNUSED, UNUSED, 4, 0, 1
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;----------------
    ;Dark cave exit to light cave
    .byte 230, 180, 6, OUTDOORS_LOC7_SCREEN_COUNT, UNUSED, UNUSED, 4, 0, 2
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0

    ;entrance to a second dark cave segment
    .byte 200, 60, 16, 2, UNUSED, UNUSED, 4, 0, 1
    .byte 0, 0, 0, 0, 0, 0, 0
    ;---------------------
    ;secret cave exit to location 8
    .byte 156, 140, 8, OUTDOORS_LOC9_SCREEN_COUNT, UNUSED, UNUSED, 5, 0 ,2
    .byte 0, 0, 0, 2, 0, 0, 2
    ;-----------------------
    ;exit of mine room
    .byte 120, 146, 6, OUTDOORS_LOC7_SCREEN_COUNT, UNUSED, UNUSED, 4, 24, 0
    .byte 0, 0, 0, 0, <cave_npcs, >cave_npcs, 0
    ;-----------------------
    ;exit to first dark cave
    .byte 200, 200, 13, 2, UNUSED, UNUSED, 4, 0, 1
    .byte 0, 0, 0, 0, <dark_cave_npcs, >dark_cave_npcs, 0
    ;alien base lobby entrance
    .byte 53, 129, 17, 1, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;------------
    ;alien base entrance bottom
    .byte 15, 170, 10, 2, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;exit to dark cave 2
    .byte 80, 170, 16, 2, <House_items, >House_items, 4, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;--------------------
    ;entrance to the crashsite from the path
    .byte 57, 210, 7, OUTDOORS_LOC8_SCREEN_COUNT, UNUSED, UNUSED, 4, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0
    ;entrance to the mine location
    .byte 119, 100, 11, OUTDOORS_LOC12_SCREEN_COUNT, UNUSED, UNUSED, 5, 0, 0
    .byte 0, 0, 0, 2, 0, 0, 0





;after adding new locations don't forget to change MAX_LOCATIONS

.segment "RODATA"

LocationScreenCountList:
    .byte OUTDOORS_LOC1_SCREEN_COUNT ; 0
    .byte OUTDOORS_LOC2_SCREEN_COUNT ; 1
    .byte OUTDOORS_LOC3_SCREEN_COUNT ; 2
    .byte 1                          ; 3 Bjorn's house
    .byte 1                          ; 4 Player's house
    .byte 1                          ; 5 Hedgehog
    .byte OUTDOORS_LOC7_SCREEN_COUNT ; 6 cave
    .byte OUTDOORS_LOC8_SCREEN_COUNT ; 7 crashsite
    .byte OUTDOORS_LOC9_SCREEN_COUNT ; 8 granny location
    .byte 1                          ; 9 granny's hut
    .byte 2                          ; 10 alien base
    .byte OUTDOORS_LOC12_SCREEN_COUNT; 11 location where the mine entrance is
    .byte 1                          ; 12 boss room
    .byte 2                          ; 13 dark cave
    .byte 1                          ; 14 secret cave
    .byte 1                          ; 15 mine room
    .byte 2                          ; 16 dark cave extension
    .byte 1                          ; 17 alien base lobby
    .byte 1                          ; 18 path to crashsite


LocationEntryPointPtrs:
    .byte <entry_points_loc0, >entry_points_loc0
    .byte <entry_points_loc1, >entry_points_loc1
    .byte <entry_points_loc2, >entry_points_loc2
    .byte <entry_points_loc3, >entry_points_loc3
    .byte <entry_points_loc4, >entry_points_loc4
    .byte <entry_points_loc5, >entry_points_loc5
    .byte <entry_points_loc6, >entry_points_loc6
    .byte <entry_points_loc7, >entry_points_loc7
    .byte <entry_points_loc8, >entry_points_loc8
    .byte <entry_points_loc9, >entry_points_loc9
    .byte <entry_points_loc10, >entry_points_loc10
    .byte <entry_points_loc11, >entry_points_loc11
    .byte <entry_points_loc12, >entry_points_loc12
    .byte <entry_points_loc13, >entry_points_loc13
    .byte <entry_points_loc14, >entry_points_loc14
    .byte <entry_points_loc15, >entry_points_loc15
    .byte <entry_points_loc16, >entry_points_loc16
    .byte <entry_points_loc17, >entry_points_loc17
    .byte <entry_points_loc18, >entry_points_loc18

EntryPointCountForLocation:
    .byte 4 ;0
    .byte 3 ;1
    .byte 2 ;2
    .byte 1 ;3
    .byte 1 ;4
    .byte 1 ;5
    .byte 5 ;6
    .byte 2 ;7 ; crashsite
    .byte 3 ;8
    .byte 1 ;9
    .byte 3 ;10 alien base
    .byte 3 ;11 location with the mine
    .byte 1 ;12
    .byte 2 ;13
    .byte 1 ;14
    .byte 1 ;15
    .byte 2 ;16 dark cave 2
    .byte 2 ;17
    .byte 2 ;18


;which location in which bank
LocationBanks:
    .byte 0  ;0
    .byte 5  ;1
    .byte 0  ;2
    .byte 0  ;3
    .byte 0  ;4
    .byte 0  ;5
    .byte 4  ;6
    .byte 4  ;7 crashsite
    .byte 5  ;8
    .byte 0  ;9
    .byte 4  ;10
    .byte 5  ;11
    .byte 3  ;12
    .byte 4  ;13
    .byte 4  ;14
    .byte 3  ;15
    .byte 4  ;16
    .byte 4  ;17
    .byte 0  ;18


;indexes in Item_Location1_Collection_times

ITEM_IDX_LOC3 = ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2
ITEM_IDX_LOC4 = ITEM_IDX_LOC3 + ITEM_COUNT_LOC3
ITEM_IDX_LOC8 = ITEM_IDX_LOC4 + ITEM_COUNT_LOC7
ITEM_IDX_LOC9 = ITEM_IDX_LOC8 + ITEM_COUNT_LOC8

LocationItemIndexes:
    .byte 0                                                                           ;0
    .byte ITEM_COUNT_LOC1                                                             ;1
    .byte ITEM_IDX_LOC3                                                               ;2
    .byte ITEM_IDX_LOC4                                                               ;3
    .byte ITEM_IDX_LOC4                                                               ;4
    .byte ITEM_IDX_LOC4                                                               ;5
    .byte ITEM_IDX_LOC4                                                               ;6
    .byte ITEM_IDX_LOC8                                                               ;7 crashsite
    .byte ITEM_IDX_LOC9                                                               ;8
    .byte 0                                                                           ;9
    .byte 0                                                                           ;10
    .byte ITEM_IDX_LOC9 + ITEM_COUNT_LOC9                                             ;11
    .byte 0                                                                           ;12
    .byte 0                                                                           ;13
    .byte ITEM_IDX_LOC9 + ITEM_COUNT_LOC9 + ITEM_COUNT_LOC12                          ;14
    .byte 0                                                                           ;15
    .byte ITEM_IDX_LOC9 + ITEM_COUNT_LOC9 + ITEM_COUNT_LOC12 + ITEM_COUNT_LOC15       ;16
    .byte 0                                                                           ;17
    .byte 0                                                                           ;18

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
    .byte ITEM_COUNT_LOC12 ; 11
    .byte 0                ; 12
    .byte 0                ; 13
    .byte ITEM_COUNT_LOC15 ; 14 secret cave
    .byte 0                ; 15
    .byte ITEM_COUNT_LOC17 ; 16
    .byte 0                ; 17
    .byte 0                ; 18 path to crashsite

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
    .byte 1 ; 11
    .byte 0 ; 12  boss
    .byte 0 ; 13  dark cave
    .byte 0 ; 14
    .byte 0 ; 15
    .byte 1 ; 16
    .byte 0 ; 17
    .byte 0 ; 18

LocationItems:
    .byte  <Outside1_items,        >Outside1_items              ; 0
    .byte  <Outside2_items,        >Outside2_items              ; 1
    .byte  <Outside3_items,        >Outside3_items              ; 2
    .byte  <House_items,           >House_items                 ; 3 Bjorn's house
    .byte  <House_items,           >House_items                 ; 4 Player's house
    .byte  <House_items,           >House_items                 ; 5 Erika
    .byte  <Cave_items,            >Cave_items                  ; 6 cave
    .byte  <Crashsite_items,       >Crashsite_items             ; 7 crashsite
    .byte  <granny_location_items, >granny_location_items       ; 8 granny location
    .byte  <House_items,           >House_items                 ; 9 granny's hut
    .byte  <House_items,           >House_items                 ; 10 alien base
    .byte  <mine_location_items,   >mine_location_items         ; 11 location where cave is
    .byte  <House_items,           >House_items                 ; 12 boss room
    .byte  <House_items,           >House_items                 ; 13 dark cave
    .byte  <secret_cave_items,     >secret_cave_items           ; 14 secret cave
    .byte  <House_items,           >House_items                 ; 15 mine room
    .byte  <dark_cave_2_items,     >dark_cave_2_items           ; 16 dark cave extension
    .byte  <House_items,           >House_items                 ; 17 alien base lobby
    .byte  <House_items,           >House_items                 ; 18 path to crashsite
