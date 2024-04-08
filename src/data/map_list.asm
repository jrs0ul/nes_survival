;4 screens per location max

location_map_pos: ;index where the pointer to the first screen of each location is
    .byte 0  ;0
    .byte 4  ;1
    .byte 6  ;2
    .byte 8  ;3
    .byte 9  ;4
    .byte 10 ;5
    .byte 11 ;6 cave
    .byte 13 ;7
    .byte 15 ;8
    .byte 18 ;9
    .byte 19 ;10 alien base
    .byte 21 ;11
    .byte 23 ;12 bossroom
    .byte 24 ;13 dark cave
    .byte 26 ;14

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

    .byte <cave0
    .byte <cave1

    .byte <crashsite0
    .byte <crashsite

    .byte <babloc1
    .byte <babloc2
    .byte <babloc3

    .byte <grannys_hut

    .byte <alien_base1
    .byte <alien_base2

    .byte <location_with_cave
    .byte <location_with_cave2

    .byte <alien_bossroom

    .byte <dark_cave0
    .byte <dark_cave1

    .byte <secret_cave0



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

    .byte >cave0
    .byte >cave1

    .byte >crashsite0
    .byte >crashsite

    .byte >babloc1
    .byte >babloc2
    .byte >babloc3

    .byte >grannys_hut

    .byte >alien_base1
    .byte >alien_base2

    .byte >location_with_cave
    .byte >location_with_cave2

    .byte >alien_bossroom

    .byte >dark_cave0
    .byte >dark_cave1

    .byte >secret_cave0
