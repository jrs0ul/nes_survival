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
    .byte 31 ;14 secret cave
    .byte 32 ;15 mine room
    .byte 33 ;16 dark cave 2
    .byte 36 ;17 alien base lobby
    .byte 37 ;18 path to crashsite
    .byte 38 ;19 pre alien base location
    .byte 32 ;20 cave room
    .byte 41 ;21 lonely cave
    .byte 42 ;22 wood location
    .byte 44 ;23 alien base hallway
    .byte 47 ;24 alien tunnel

map_list_low:
    .byte <field_bg            ; 0
    .byte <field_bg1
    .byte <field_bg2
    .byte <field_bg4

    .byte <field2_bg           ; 4
    .byte <field2_bg1

    .byte <LOC3_bg0            ; 6
    .byte <LOC3_bg1

    .byte <villager_hut        ; 8

    .byte <house               ; 9

    .byte <villager2_hut       ; 10

    .byte <mine_0              ; 11
    .byte <mine_1
    .byte <mine_2

    .byte <crashsite0          ; 14
    .byte <crashsite1
    .byte <crashsite2

    .byte <babloc1             ; 17
    .byte <babloc2
    .byte <babloc3

    .byte <grannys_hut         ; 20

    .byte <alien_base1         ; 21
    .byte <alien_base2

    .byte <location_with_cave0 ; 23
    .byte <location_with_cave1
    .byte <location_with_cave2
    .byte <location_with_cave3

    .byte <alien_bossroom      ; 27

    .byte <dark_cave0          ; 28
    .byte <dark_cave1
    .byte <dark_cave2

    .byte <secret_cave0        ; 31

    .byte <mine_room           ; 32

    .byte <dark_cave2_0        ; 33
    .byte <dark_cave2_1
    .byte <dark_cave2_2

    .byte <alien_base_lobby    ; 36

    .byte <path_to_crashsite   ; 37

    .byte <pre_alien_base0     ; 38
    .byte <pre_alien_base1
    .byte <pre_alien_base2

    .byte <lonely_cave         ; 41

    .byte <wood_location_0     ; 42
    .byte <wood_location_1

    .byte <abase_hall_0        ;44
    .byte <abase_hall_1
    .byte <abase_hall_2

    .byte <alien_tunnel        ;47



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
    .byte >dark_cave2

    .byte >secret_cave0

    .byte >mine_room

    .byte >dark_cave2_0
    .byte >dark_cave2_1
    .byte >dark_cave2_2

    .byte >alien_base_lobby

    .byte >path_to_crashsite

    .byte >pre_alien_base0
    .byte >pre_alien_base1
    .byte >pre_alien_base2

    .byte >lonely_cave

    .byte >wood_location_0
    .byte >wood_location_1

    .byte >abase_hall_0
    .byte >abase_hall_1
    .byte >abase_hall_2

    .byte >alien_tunnel
