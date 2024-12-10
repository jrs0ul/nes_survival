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
    .byte 4, 0, 117, 124, 85, 91, 112, 123
    ;5.Exit point of second location
    .byte 5, 0, 0, 255, 0, 255, 222, 255
    ;6.entrance to mine location (where path is)
    .byte 6, 1, 125, 146, 0, 255, 0, 20
    ;7.entrance to mine location (where Bjorn's house is)
    .byte 7, 0, 0, 255, 0, 255, 0, 20
    ;----------------------------------------
entry_points_loc2:
    ;8.Exit point of third location
    .byte 8, 0, 0, 255, 0, 255, 0,   20
    ;9.Erika's house
    .byte 9, 0, 117, 124, 126, 135, 122, 135
    ;------------------------
entry_points_loc3:
    ;10.Bjorn's house exit
    .byte 10, 0, 0, 255, 0, 255, 152, 255
    ;-----------------------
entry_points_loc4:
    ;11.Player's house exit
    .byte 11, 0, 0, 255, 0, 255, 160, 255
    ;-----------------------
entry_points_loc5:
    ;12.Second villager house's exit
    .byte 12, 0, 0, 255, 0, 255, 152, 255
    ;------------------------
entry_points_loc6:
    ;13.crashsite entrance from cave
    .byte 13, 0, 0, 255, 0, 255, 0, 22
    ;14.cave exit to cave location
    .byte 14, 0, 119, 125, 220, 230, 222, 255
    ;15.dark cave entrance bottom
    .byte 15, 2, 232, 255, 0, 255, 160, 199
    ;16.alien base entrance top
    .byte 16, 2, 207, 230, 0, 255, 43, 63
    ;17. Mine room entrance
    .byte 17, 0, 118, 123, 22, 28, 120, 130
    ;--------------------------
entry_points_loc7:
    ;18.crashsite exit to cave
    .byte 18, 1, 0, 255, 0, 255, 222, 255
    ;19.crashsite exit to path
    .byte 19, 0, 0, 255, 0, 255, 222, 255
    ;--------------------------
entry_points_loc8:
    ;20.exit from granny's location to the main one
    .byte 20, 0, 0, 255, 0, 255, 0, 32
    ;21.granny's house
    .byte 21, 0, 118, 122, 149, 155, 104, 111
    ;22.secret cave
    .byte 22, 2, 156, 167,   0,   255, 130, 135
    ;-------------------
entry_points_loc9:
    ;23.exit from grannys house
    .byte 23, 0, 0, 255, 0, 255, 151, 255
    ;--------------------
    ;alien base 2
entry_points_loc10:
    ;24.alien base exit top
    .byte 24, 0, 23, 30, 0, 255, 99, 112
    ;25.alien base exit to pre-alien base
    .byte 25, 0, 0, 255, 0, 255, 222, 255
    ;26. Boss room entrance
    .byte 26, 1, 238, 255, 0, 255, 112, 128
    ;--------------------------
entry_points_loc11:
    ;27.exit from cave location to bjorn's location
    .byte 27, 2, 0, 255, 0,255, 222, 255
    ;28.cave entrance from location 11
    .byte 28, 2, 117, 122, 21, 28, 40, 50
    ;29. entrance to the path to the crashsite
    .byte 29, 0, 0, 255, 0, 255, 0, 22
    ;30. entrance to the segment where Bjorn's house is
    .byte 30, 1, 117, 122, 102, 124, 222, 255
    ;-------------------------------------
entry_points_loc12:
    ;31. Boss room exit
    .byte 31, 0, 0, 4, 0, 255, 112, 127
    ;-------------------------------------
entry_points_loc13:
    ;32. Dark cave exit to light cave
    .byte 32, 0, 0, 5, 0, 255, 32, 76
    ;33. entrance to dark cave second segment
    .byte 33, 2, 189, 240, 0, 255, 222, 255
    ;-------------------------------------
entry_points_loc14:
    ;34. Secret cave exit
    .byte 34, 0, 0, 255, 0, 255, 222, 255
    ;-------------------------------------
entry_points_loc15:
    ;35. Mine room exit
    .byte 35, 0, 0, 255, 0, 255, 160, 255
    ;--------------------------------------
entry_points_loc16:
    ;36. Dark cave2 exit to dark cave 1
    .byte 36, 2, 189, 255, 0, 255, 0, 32
    ;37. alien base lobby entrance
    .byte 37, 0, 105, 118, 0, 255, 185, 203
    ;38. entrance to the lonely cave
    .byte 38, 0, 117, 122, 230, 236, 222, 255
    ;--------------------------------------
    ; Lobby
entry_points_loc17:
    ;39. pre-alien base entrance
    .byte 39, 0, 230, 255, 0, 255, 125, 140
    ;40. exit to dark cave 2
    .byte 40, 0, 32, 40, 0, 255, 119, 130
    ;41. alien-lobby-room
    .byte 41, 0, 120, 136, 0, 255, 40, 50
    ;--------------------------------------
entry_points_loc18:
    ;42. entrance to crashsite location
    .byte 42, 0, 0, 255, 0, 255, 0, 32
    ;43. entrance to location with mine
    .byte 43, 0, 0, 255, 0, 255, 222, 255
    ;----------------------
entry_points_loc19:
    ;44. exit to alien base lobby
    .byte 44, 0, 0, 10, 0, 255, 119, 255
    ;45. entrance to last alien base location
    .byte 45, 0, 0, 255, 0, 255, 0, 32
    ;----------------------
entry_points_loc20:
    ;46. cave-room exit
    .byte 46, 0, 0, 255, 0, 255, 160, 255
entry_points_loc21:
    ;47. lonely cave exit to the dark cave 2
    .byte 47, 0, 0, 255, 0, 255, 0, 40
    ;48. entrance to wood location
    .byte 48, 0, 0, 255, 0, 255, 222, 255
entry_points_loc22:
    ;49. exit to lonely cave
    .byte 49, 0, 52, 60, 0, 255, 72, 88
entry_points_loc23:
    ;50. entrance to the main alien base
    .byte 50, 1, 0, 255, 0, 255, 10, 31
    ;51. exit to alien base puzzle room
    .byte 51, 0, 0, 255, 0, 255, 222, 255
    ;52. entrance to the main alien base
    .byte 50, 0, 0, 255, 0, 255, 10, 31

.segment "ROM0"


;-----------------------------------------------------
;The data of the new location the player has entered 
;---------------------------------------
;PlayerX,
;PlayerY,
;LocationIndex,
;ScreenCount,
;LocationType, e.g. LOCATION_TYPE_OUTDOORS, LOCATION_TYPE_CAVE etc.
;SongName,
;location bank number
;scroll X
;active screen
;ScrollDirection
;PaletteLow
;PaletteHigh
;max generated npc count per screen
;Premade Npcs Low
;Premade NpcsHigh
;currentMapSegment we are entering (only used for animal generation now)

MapSpawnPoint:
    ;Entry to player's house from outside
    .byte 128, 152, 4, 1, LOCATION_TYPE_HOUSE, SONG_INDOORS, 0, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <list_empty, >list_empty, 0
    ;Second location entry point
    .byte 119, 208, 1, OUTDOORS_LOC2_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 208, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0
    ;Third location entry point
    .byte 100, 48, 2, OUTDOORS_LOC3_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 0
    ;granny location
    .byte 77, 42, 8, OUTDOORS_LOC9_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5,  0, 0
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 0
    ;---------------------
    ;Bear's house entrance
    .byte 128, 136, 3, 1, LOCATION_TYPE_VILLAGER, SONG_INDOORS, 3, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <Hut_npcs, >Hut_npcs, 0
    ;Exit point of second location
    .byte 128, 32, 0, OUTDOORS_LOC1_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 3
    ;entrance to mine location(from path)
    .byte 119, 210, 11, OUTDOORS_LOC12_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 160, 2
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 3
    ;entrance to mine location(from Bjorn's house place)
    .byte 119, 210, 11, OUTDOORS_LOC12_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 113, 1
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 1
    ;-----------------
    ;Exit point of third location
    .byte 120, 209, 0, OUTDOORS_LOC1_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 103, 1
    .byte 2, <main_palette, >main_palette, 3, 0, 0, 1
    ;Second villager's house
    .byte 128, 136, 5, 1, LOCATION_TYPE_VILLAGER, SONG_INDOORS, 3, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <villager2_npcs, >villager2_npcs, 0
    ;------------------
    ;Bjorn's house exit
    .byte 120, $80, 1, OUTDOORS_LOC2_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_INDOORS, 0, 88, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0
    ;-----------------
    ;Player's house exit
    .byte 72, 120, 0, OUTDOORS_LOC1_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0
    ;-----------------
    ;Second villager house's exit
    .byte 119, 151, 2, OUTDOORS_LOC3_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 128, 0
    .byte 2, <main_palette, >main_palette, 2, 0, 0, 0
    ;---------------
    ;The abandoned mine
    ;---------------
    ;entrance to place where the plane is
    .byte 120, 210, 7, OUTDOORS_LOC8_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 2, 121, 1
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;exit to mine entrance location
    .byte 119, 63, 11, OUTDOORS_LOC12_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 24, 2
    .byte 1, <main_palette, >main_palette, 2, 0, 0, 2
    ;dark cave entrance
    .byte 15, 50, 13, 2, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <main_palette, >main_palette, 3, <dark_cave_npcs, >dark_cave_npcs, 0
    ;alien base entrance top
    .byte 15, 90, 10, 2, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <alien_palette, >alien_palette, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;Mine room entrance
    .byte 120, 152, 15, 1, LOCATION_TYPE_HOUSE, SONG_INDOORS, 0, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <list_empty, >list_empty, 0
    ;---------------------
    ;crashsite exit to cave
    .byte 120, 34, 6, OUTDOORS_LOC7_SCREEN_COUNT, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 4, 128, 0
    .byte 2, <main_palette, >main_palette, 0, <cave_npcs, >cave_npcs, 0
    ;crashsite exit to path
    .byte 94, 35, 18, 1, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;---------------------
    ;exit from granny's location to main
    .byte 127, 205, 0, OUTDOORS_LOC1_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, OUTDOORS_LOC1_SCREEN_COUNT - 1
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 3
    ;granny's house
    .byte 123, 148, 9, 1, LOCATION_TYPE_VILLAGER, SONG_INDOORS, 3, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <villager3_npcs, >villager3_npcs, 0
    ;secret cave
    .byte 127, 209, 14, 1, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;--------------------
    ;granny's house exit to the location 8
    .byte 119, 126, 8, OUTDOORS_LOC9_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_NIGHT, 5, 154, 0
    .byte 1, <main_palette, >main_palette, 2, 0, 0, 0
    ;------------
    ;alien base exit top
    .byte 200, 50, 6, OUTDOORS_LOC7_SCREEN_COUNT, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 4, 0, 2
    .byte 0, <main_palette, >main_palette, 0, <cave_npcs, >cave_npcs, 0
    ;alien base exit to hallway
    .byte 120, 40, 23, 3, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 1, 0, 1
    .byte 0, <alien_palette, >alien_palette, 3, <abase_hall_npcs, >abase_hall_npcs, 0
    ;boss room entrance
    .byte 20, 120, 12, 1, LOCATION_TYPE_VILLAGER, SONG_BOSS, 3, 0, 0
    .byte 0, <alien_palette, >alien_palette, 0, 0, 0, 0
    ;--------------
    ;A location with the mine entrance
    ;--------------
    ;exit from cave location to bjorn's location (path)
    .byte 135, 38, 1, OUTDOORS_LOC2_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, 1
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 1
    ;cave entrance
    .byte 120, 207, 6, OUTDOORS_LOC7_SCREEN_COUNT, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 4, 222, 0
    .byte 2, <main_palette, >main_palette, 0, <cave_npcs, >cave_npcs, 0
    ;entrance to the path to the crashsite
    .byte 95, 215, 18, 1, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_NIGHT, 5, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;entrance to the segment where Bjorn's house is
    .byte 88, 37, 1, OUTDOORS_LOC2_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0

    ;---------------
    ;boss room exit
    .byte 223, 120, 10, 2, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 4, 0, 1
    .byte 0, <alien_palette, >alien_palette, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;----------------
    ;Dark cave exit to light cave
    .byte 230, 180, 6, OUTDOORS_LOC7_SCREEN_COUNT, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 4, 0, 2
    .byte 0, <main_palette, >main_palette, 0, <cave_npcs, >cave_npcs, 0

    ;entrance to a second dark cave segment
    .byte 200, 60, 16, 3, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 0, 2
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 2
    ;---------------------
    ;secret cave exit to location 8
    .byte 156, 140, 8, OUTDOORS_LOC9_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 0 ,2
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 2
    ;-----------------------
    ;exit of mine room
    .byte 120, 145, 6, OUTDOORS_LOC7_SCREEN_COUNT, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 4, 24, 0
    .byte 0, <main_palette, >main_palette, 0, <cave_npcs, >cave_npcs, 0
    ;-----------------------
    ;exit to first dark cave
    .byte 200, 200, 13, 2, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 0, 1
    .byte 0, <main_palette, >main_palette, 3, <dark_cave_npcs, >dark_cave_npcs, 1
    ;alien base lobby entrance
    .byte 53, 129, 17, 1, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;lonely cave entrance
    .byte 130, 41, 21, 0, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 3, 0, 0
    .byte 0, <main_palette, >main_palette, 0, <lonely_cave_npcs, >lonely_cave_npcs, 0
    ;------------
    ;alien base entrance bottom (pre)
    .byte 15, 170, 19, 3, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 2, 0, 0
    .byte 0, <alien_palette, >alien_palette, 2, 0, 0, 0
    ;exit to dark cave 2
    .byte 96, 196, 16, 3, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0
    ;entrance of the cave-room
    .byte 120, 152, 20, 1, LOCATION_TYPE_HOUSE, SONG_INDOORS, 3, 0, 0
    .byte 0, <house_palette, >house_palette, 0, <list_empty, >list_empty, 0
    ;--------------------
    ;entrance to the crashsite from the path
    .byte 79, 214, 7, OUTDOORS_LOC8_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 2, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;entrance to the mine location
    .byte 105, 33, 11, OUTDOORS_LOC12_SCREEN_COUNT, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 5, 0, 0
    .byte 0, <main_palette, >main_palette, 2, 0, 0, 0
    ;------------------
    ;exit to lobby
    .byte 229, 134, 17, 1, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;entrance to alienbase hallway
    .byte 120, 210, 23, 3, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 1, 184, 0
    .byte 0, <alien_palette, >alien_palette, 3, <abase_hall_npcs, >abase_hall_npcs, 0
    ;------------------
    ;exit to alien lobby
    .byte 126, 60, 17, 1, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 0, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;------------------
    ;exit from lonely cave to the dark cave 2
    .byte 120, 212, 16, 3, LOCATION_TYPE_DARK, SONG_OUTSIDE_NIGHT, 4, 234, 0
    .byte 0, <main_palette, >main_palette, 3, 0, 0, 0
    ;entrance to the wood location
    .byte 56, 112, 22, 2, LOCATION_TYPE_OUTDOORS, SONG_OUTSIDE_DAY, 3, 0, 0
    .byte 0, <main_palette, >main_palette, 0, 0, 0, 0
    ;---------------------
    ;exit to lonely cave from wood location
    .byte 192, 219, 21, 1, LOCATION_TYPE_CAVE, SONG_OUTSIDE_NIGHT, 3, 0, 0
    .byte 0, <main_palette, >main_palette, 0, <lonely_cave_npcs, >lonely_cave_npcs, 0
    ;-----------------------
    ;  alien base hallway
    ;-----------------------
    ;entrance to the main alien base
    .byte 119, 210, 10, 2, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <alien_palette, >alien_palette, 0, <alien_base_npcs, >alien_base_npcs, 0
    ;exit to the puzzle room
    .byte 45, 38, 19, 3, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 2, 0, 0
    .byte 0, <alien_palette, >alien_palette, 2, 0, 0, 0
    ;entrance to the main alien base
    .byte 119, 210, 10, 2, LOCATION_TYPE_ALIEN_BASE, SONG_OUTSIDE_NIGHT, 4, 0, 0
    .byte 0, <alien_palette, >alien_palette, 0, <alien_base_npcs, >alien_base_npcs, 0






;after adding new locations don't forget to change MAX_LOCATIONS

.segment "RODATA"

LocationScreenCountList:
    .byte OUTDOORS_LOC1_SCREEN_COUNT ; 0 Initial location
    .byte OUTDOORS_LOC2_SCREEN_COUNT ; 1 Bjorn's location
    .byte OUTDOORS_LOC3_SCREEN_COUNT ; 2
    .byte 1                          ; 3 Bjorn's house
    .byte 1                          ; 4 Player's house
    .byte 1                          ; 5 Erika's house
    .byte OUTDOORS_LOC7_SCREEN_COUNT ; 6 mine
    .byte OUTDOORS_LOC8_SCREEN_COUNT ; 7 crashsite
    .byte OUTDOORS_LOC9_SCREEN_COUNT ; 8 granny location
    .byte 1                          ; 9 granny's hut
    .byte 2                          ; 10 alien base
    .byte OUTDOORS_LOC12_SCREEN_COUNT; 11 location where the mine entrance is
    .byte 1                          ; 12 boss room
    .byte 3                          ; 13 dark cave
    .byte 1                          ; 14 secret cave
    .byte 1                          ; 15 mine room
    .byte 3                          ; 16 dark cave extension
    .byte 1                          ; 17 alien base lobby
    .byte 1                          ; 18 path to crashsite
    .byte 3                          ; 19 pre alien base location
    .byte 1                          ; 20 house before alien base
    .byte 1                          ; 21 lonely cave
    .byte 2                          ; 22 wood location
    .byte 3                          ; 23 alien base hallway


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
    .byte <entry_points_loc19, >entry_points_loc19
    .byte <entry_points_loc20, >entry_points_loc20
    .byte <entry_points_loc21, >entry_points_loc21
    .byte <entry_points_loc22, >entry_points_loc22
    .byte <entry_points_loc23, >entry_points_loc23

EntryPointCountForLocation:
    .byte 4 ;0
    .byte 4 ;1
    .byte 2 ;2
    .byte 1 ;3
    .byte 1 ;4
    .byte 1 ;5
    .byte 5 ;6
    .byte 2 ;7 ; crashsite
    .byte 3 ;8
    .byte 1 ;9
    .byte 3 ;10 alien base
    .byte 4 ;11 location with the mine
    .byte 1 ;12
    .byte 2 ;13
    .byte 1 ;14
    .byte 1 ;15
    .byte 3 ;16 dark cave 2
    .byte 3 ;17
    .byte 2 ;18
    .byte 2 ;19
    .byte 1 ;20
    .byte 2 ;21
    .byte 1 ;22 wood location
    .byte 3 ;23 alien base hallway


;which location in which bank
LocationBanks:
    .byte 0  ;0
    .byte 0  ;1
    .byte 0  ;2
    .byte 0  ;3
    .byte 0  ;4
    .byte 0  ;5
    .byte 4  ;6
    .byte 2  ;7 crashsite
    .byte 5  ;8
    .byte 0  ;9
    .byte 4  ;10
    .byte 5  ;11
    .byte 3  ;12
    .byte 4  ;13
    .byte 4  ;14
    .byte 3  ;15
    .byte 4  ;16
    .byte 0  ;17
    .byte 5  ;18
    .byte 2  ;19
    .byte 3  ;20
    .byte 3  ;21
    .byte 3  ;22
    .byte 1  ;23


;indexes in Item_Location1_Collection_times

ITEM_IDX_LOC3  = ITEM_COUNT_LOC1 + ITEM_COUNT_LOC2
ITEM_IDX_LOC4  = ITEM_IDX_LOC3   + ITEM_COUNT_LOC3
ITEM_IDX_LOC8  = ITEM_IDX_LOC4   + ITEM_COUNT_LOC7
ITEM_IDX_LOC9  = ITEM_IDX_LOC8   + ITEM_COUNT_LOC8
ITEM_IDX_LOC11 = ITEM_IDX_LOC9   + ITEM_COUNT_LOC9
ITEM_IDX_LOC14 = ITEM_IDX_LOC11  + ITEM_COUNT_LOC12
ITEM_IDX_LOC18 = ITEM_IDX_LOC14  + ITEM_COUNT_LOC15 + ITEM_COUNT_LOC17


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
    .byte ITEM_IDX_LOC11                                                              ;11
    .byte 0                                                                           ;12
    .byte 0                                                                           ;13
    .byte ITEM_IDX_LOC14                                                              ;14
    .byte 0                                                                           ;15
    .byte ITEM_IDX_LOC14 + ITEM_COUNT_LOC15                                           ;16
    .byte 0                                                                           ;17
    .byte ITEM_IDX_LOC18                                                              ;18
    .byte ITEM_IDX_LOC18 + ITEM_COUNT_LOC19                                           ;19
    .byte 0                                                                           ;20
    .byte 0                                                                           ;21
    .byte ITEM_IDX_LOC18 + ITEM_COUNT_LOC19 + ITEM_COUNT_LOC20                        ;22
    .byte 0                                                                           ;23

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
    .byte ITEM_COUNT_LOC19 ; 18 path to crashsite
    .byte ITEM_COUNT_LOC20 ; 19 pre alien base
    .byte 0                ; 20 cave-room
    .byte 0                ; 21 lonely cave
    .byte ITEM_COUNT_LOC23 ; 22 wood location
    .byte 0                ; 23

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
    .byte 1 ; 18 ;path to crashsite
    .byte 1 ; 19
    .byte 0 ; 20
    .byte 0 ; 21
    .byte 1 ; 22
    .byte 0 ; 23

list_empty:
    .byte 0

LocationItems:
    .byte  <Outside1_items,         >Outside1_items              ; 0
    .byte  <Outside2_items,         >Outside2_items              ; 1
    .byte  <Outside3_items,         >Outside3_items              ; 2
    .byte  <list_empty,             >list_empty                  ; 3 Bjorn's house
    .byte  <list_empty,             >list_empty                  ; 4 Player's house
    .byte  <list_empty,             >list_empty                  ; 5 Erika
    .byte  <Cave_items,             >Cave_items                  ; 6 mine
    .byte  <Crashsite_items,        >Crashsite_items             ; 7 crashsite
    .byte  <granny_location_items,  >granny_location_items       ; 8 granny location
    .byte  <list_empty,             >list_empty                  ; 9 granny's hut
    .byte  <list_empty,             >list_empty                  ; 10 alien base
    .byte  <mine_location_items,    >mine_location_items         ; 11 location where cave is
    .byte  <list_empty,             >list_empty                  ; 12 boss room
    .byte  <list_empty,             >list_empty                  ; 13 dark cave
    .byte  <secret_cave_items,      >secret_cave_items           ; 14 secret cave
    .byte  <list_empty,             >list_empty                  ; 15 mine room
    .byte  <dark_cave_2_items,      >dark_cave_2_items           ; 16 dark cave extension
    .byte  <list_empty,             >list_empty                  ; 17 alien base lobby
    .byte  <crashsite_path_items,   >crashsite_path_items        ; 18 path to crashsite
    .byte  <item_list_alien_puzzle, >item_list_alien_puzzle      ; 19 pre alien base location
    .byte  <list_empty,             >list_empty                  ; 20 cave-room
    .byte  <list_empty,             >list_empty                  ; 21 lonely cave
    .byte  <wood_location_items,    >wood_location_items         ; 22 wood location
    .byte  <list_empty,             >list_empty                  ; 23 alien base hallway
