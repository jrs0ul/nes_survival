;4 screens per location max

location_map_pos: ;index where the pointer to the first screen of each location is
    .byte 0  ;0 first location with house
    .byte 4  ;1
    .byte 6  ;2
    .byte 8  ;3
    .byte 9  ;4
    .byte 10 ;5
    .byte 11 ;6 mine
    .byte 14 ;7 crashsite
    .byte 17 ;8 grannys location
    .byte 20 ;9 granny's house
    .byte 21 ;10 alien base
    .byte 23 ;11 location with mine entrance
    .byte 27 ;12 bossroom
    .byte 28 ;13 dark cave
    .byte 30 ;14 secret cave
    .byte 31 ;15 mine room
    .byte 33 ;16 dark cave 2
    .byte 34 ;17 alien base lobby
    .byte 35 ;18 path to crashsite

map_list_low:
    .byte <field_bg
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg4

    .byte <field2_bg
    .byte <field2_bg1

    .byte <LOC3_bg0
    .byte <LOC3_bg1

    .byte <villager_hut

    .byte <house

    .byte <villager2_hut

    .byte <mine_0
    .byte <mine_1
    .byte <mine_2

    .byte <crashsite0
    .byte <crashsite1
    .byte <crashsite2

    .byte <babloc1
    .byte <babloc2
    .byte <babloc3

    .byte <grannys_hut

    .byte <alien_base1
    .byte <alien_base2

    .byte <location_with_cave0
    .byte <location_with_cave1
    .byte <location_with_cave2
    .byte <location_with_cave3

    .byte <alien_bossroom

    .byte <dark_cave0
    .byte <dark_cave1

    .byte <secret_cave0

    .byte <mine_room

    .byte <dark_cave2_0
    .byte <dark_cave2_1

    .byte <alien_base_lobby

    .byte <path_to_crashsite



map_list_high:
    .byte >field_bg
    .byte >field_bg1
    .byte >field_bg2
    .byte >field_bg4

    .byte >field2_bg
    .byte >field2_bg1

    .byte >LOC3_bg0
    .byte >LOC3_bg1

    .byte >villager_hut

    .byte >house

    .byte >villager2_hut

    .byte >mine_0
    .byte >mine_1
    .byte >mine_2

    .byte >crashsite0
    .byte >crashsite1
    .byte >crashsite2

    .byte >babloc1
    .byte >babloc2
    .byte >babloc3

    .byte >grannys_hut

    .byte >alien_base1
    .byte >alien_base2

    .byte >location_with_cave0
    .byte >location_with_cave1
    .byte >location_with_cave2
    .byte >location_with_cave3

    .byte >alien_bossroom

    .byte >dark_cave0
    .byte >dark_cave1

    .byte >secret_cave0

    .byte >mine_room

    .byte >dark_cave2_0
    .byte >dark_cave2_1

    .byte >alien_base_lobby

    .byte >path_to_crashsite
