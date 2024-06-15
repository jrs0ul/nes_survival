.include "data/intro_bg_mowdens_comp.asm"
.include "data/intro_bg_cockpit_comp.asm"
.include "data/intro_bg_boom_comp.asm"
.include "data/intro_bg_mowdens_base_comp.asm"
.include "data/intro_bg_mowdens_top_comp.asm"

.include "data/outro_bg_sos_comp.asm"
.include "data/outro_bg_that_same_day_comp.asm"
.include "data/outro_bg_chopper_comes_comp.asm"
.include "data/outro_bg_victory_comp.asm"


intro_scenes_low:
    .byte <intro_bg_mowdens_comp
    .byte <intro_bg_cockpit_comp
    .byte <intro_bg_mowdens_comp
    .byte <intro_bg_boom_comp
    .byte <intro_bg_mowdens_comp
    .byte <intro_bg_mowdens_base_comp
    .byte <intro_bg_mowdens_top_comp

intro_scenes_high:
    .byte >intro_bg_mowdens_comp
    .byte >intro_bg_cockpit_comp
    .byte >intro_bg_mowdens_comp
    .byte >intro_bg_boom_comp
    .byte >intro_bg_mowdens_comp
    .byte >intro_bg_mowdens_base_comp
    .byte >intro_bg_mowdens_top_comp

outro_scenes_low:
    .byte <outro_bg_sos_comp
    .byte <outro_bg_that_same_day_comp
    .byte <outro_bg_chopper_comes_comp
    .byte <outro_bg_victory_comp

outro_scenes_high:
    .byte >outro_bg_sos_comp
    .byte >outro_bg_that_same_day_comp
    .byte >outro_bg_chopper_comes_comp
    .byte >outro_bg_victory_comp

intro_scenes_delay:
    .byte 5
    .byte 37
    .byte 5
    .byte 6
    .byte 15
    .byte 20
    .byte 25

intro_scenes_duration:
    .byte 70
    .byte 10
    .byte 11
    .byte 20
    .byte 20
    .byte 12
    .byte 10

outro_scenes_duration:
    .byte 70
    .byte 50
    .byte 39
    .byte 63

outro_scenes_delay:
    .byte 5
    .byte 8
    .byte 11
    .byte 5


plane_flies:
    .byte 240,$00,0,228
    .byte 240,$01,0,236
    .byte 240,$03,0,252
    .byte 240,$04,0,  4
    .byte 240,$05,0, 12
    .byte 240,$06,0, 20
    .byte 248,$10,0,228
    .byte 248,$11,0,236
    .byte 248,$12,0,244
    .byte 248,$13,0,252
    .byte 248,$14,0,  4
    .byte 248,$15,0, 12
    .byte 248,$16,0, 20
    .byte   0,$21,0,236
    .byte   0,$22,0,244
    .byte   0,$23,0,252
    .byte   0,$24,0,  4
    .byte   0,$25,0, 12
    .byte   0,$26,0, 20
    .byte   8,$32,0,244
    .byte   8,$33,0,252
    .byte   8,$34,0,  4

dude_climbs_f:
    .byte 236,$ba,0,248
    .byte 236,$bb,0,0
    .byte 236,$bc,0,8
    .byte 244,$ca,0,248
    .byte 244,$cb,0,0
    .byte 244,$cc,0,8
    .byte 252,$d9,0,240
    .byte 252,$da,0,248
    .byte 252,$db,0,0
    .byte 252,$dc,0,8
    .byte   4,$e9,0,240
    .byte   4,$ea,0,248
    .byte   4,$eb,0,0
    .byte  12,$fb,0,0

dude_climbs:
    .byte 236,$ba,%01000000,248
    .byte 236,$bb,%01000000,240
    .byte 236,$bc,%01000000,232
    .byte 244,$ca,%01000000,248
    .byte 244,$cb,%01000000,240
    .byte 244,$cc,%01000000,232

    .byte 252,$d9,%01000000,0
    .byte 252,$da,%01000000,248
    .byte 252,$db,%01000000,240
    .byte 252,$dc,%01000000,232
    .byte   4,$e9,%01000000,0
    .byte   4,$ea,%01000000,248
    .byte   4,$eb,%01000000,240
    .byte  12,$fb,%01000000,240


parachute:
    .byte 220,$42,0,248
    .byte 220,$43,0,0
    .byte 220,$44,0,8
    .byte 228,$50,0,232
    .byte 228,$51,0,240
    .byte 228,$52,0,248
    .byte 228,$53,0,0
    .byte 228,$54,0,8
    .byte 228,$55,0,16
    .byte 236,$60,0,232
    .byte 236,$61,0,240
    .byte 236,$62,0,248
    .byte 236,$63,0,0
    .byte 236,$64,0,8
    .byte 236,$65,0,16
    .byte 244,$70,0,232
    .byte 244,$71,0,240
    .byte 244,$72,0,248
    .byte 244,$74,0,8
    .byte 244,$75,0, 16
    .byte 252,$80,0,232
    .byte 252,$81,0,240
    .byte 252,$82,0,248
    .byte 252,$83,0,  0
    .byte 252,$84,0,  8
    .byte 252,$85,0, 16
    .byte   4,$90,0,232
    .byte   4,$91,0,240
    .byte   4,$92,0,248
    .byte   4,$93,0,  0
    .byte   4,$94,0,  8
    .byte   4,$95,0, 16
    .byte  12,$a2,0,248
    .byte  12,$a3,0,  0
    .byte  12,$a4,0,  8
    .byte  12,$a5,0, 16
    .byte  20,$b2,0,248
    .byte  20,$b3,0,  0
    .byte  20,$b4,0,  8
    .byte  20,$b5,0, 16
    .byte  28,$c3,0,  0
    .byte  28,$c4,0,  8
    .byte  28,$c5,0, 16

rocket:
    .byte 248,$07,0,248
    .byte 248,$08,0,  0
    .byte   0,$17,0,248
    .byte   0,$18,0,  0


plane_falling:
    .byte 236,$0a,0,236
    .byte 236,$0b,0,244
    .byte 244,$19,0,228
    .byte 244,$1a,0,236
    .byte 244,$1b,0,244
    .byte 244,$1c,0,252
    .byte 252,$2a,0,236
    .byte 252,$2b,0,244
    .byte 252,$2c,0,252
    .byte 252,$2d,0,  4
    .byte   4,$3b,0,244
    .byte   4,$3c,0,252
    .byte   4,$3d,0,  4
    .byte   4,$3e,0, 12
    .byte   4,$3f,0, 20
    .byte  12,$4b,0,244
    .byte  12,$4c,0,252
    .byte  12,$4d,0,  4
    .byte  12,$4e,0, 12
    .byte  12,$4f,0, 20


yoke:
    .byte 244,$dd,%00000010,0
    .byte 244,$de,%00000010,8
    .byte 244,$df,%00000010,16

    .byte 252,$ed,%00000010,0
    .byte 252,$ee,%00000010,8
    .byte 252,$ef,%00000010,16


    .byte 244,$dd,%01000010,248
    .byte 244,$de,%01000010,240
    .byte 244,$df,%01000010,232

    .byte 252,$ed,%01000010,248
    .byte 252,$ee,%01000010,240
    .byte 252,$ef,%01000010,232

cloud:
    .byte 248,$e1,%00000000,244
    .byte 248,$e2,%00000000,252
    .byte 248,$e3,%00000000,  4
    .byte   0,$f1,%00000000,244
    .byte   0,$f2,%00000000,252
    .byte   0,$f3,%00000000,  4

chopper:
    .byte 232,$56,0,216
    .byte 232,$57,0,224
    .byte 232,$58,0,232
    .byte 232,$59,0,240
    .byte 232,$5a,0,248
    .byte 232,$5b,0,  0
    .byte 232,$5c,0,  8
    .byte 232,$5d,0, 16
    .byte 240,$66,0,216
    .byte 240,$67,0,224
    .byte 240,$68,0,232
    .byte 240,$69,0,240
    .byte 240,$6a,0,248
    .byte 240,$6b,0,  0
    .byte 240,$6c,0,  8
    .byte 240,$6d,0, 16
    .byte 248,$77,0,224
    .byte 248,$78,0,232
    .byte 248,$79,0,240
    .byte 248,$7a,0,248
    .byte 248,$7b,0,  0
    .byte 248,$7c,0,  8
    .byte 248,$7e,0, 24
    .byte 248,$7f,0, 32
    .byte   0,$87,0,224
    .byte   0,$88,0,232
    .byte   0,$89,0,240
    .byte   0,$8a,0,248
    .byte   0,$8b,0,  0
    .byte   0,$8c,0,  8
    .byte   0,$8d,0, 16
    .byte   0,$8e,0, 24
    .byte   8,$97,0,224
    .byte   8,$98,0,232
    .byte   8,$99,0,240
    .byte   8,$9a,0,248
    .byte   8,$9b,0,  0
    .byte   8,$9c,0,  8
    .byte   8,$9d,0, 16
    .byte  16,$a7,0,224
    .byte  16,$a8,0,232
    .byte  16,$a9,0,240
    .byte  16,$aa,0,248
    .byte  16,$ab,0,  0
    .byte  16,$ac,0,  8

chopper_flipped:
    .byte 232,$56,%01000000, 32
    .byte 232,$57,%01000000, 24
    .byte 232,$58,%01000000, 16
    .byte 232,$59,%01000000,  8
    .byte 232,$5a,%01000000,  0
    .byte 232,$5b,%01000000,248
    .byte 232,$5c,%01000000,240
    .byte 232,$5d,%01000000,232
    .byte 240,$66,%01000000, 32
    .byte 240,$67,%01000000, 24
    .byte 240,$68,%01000000, 16
    .byte 240,$69,%01000000,  8
    .byte 240,$6a,%01000000,  0
    .byte 240,$6b,%01000000,248
    .byte 240,$6c,%01000000,240
    .byte 240,$6d,%01000000,232
    .byte 248,$77,%01000000, 24
    .byte 248,$78,%01000000, 16
    .byte 248,$79,%01000000,  8
    .byte 248,$7a,%01000000,  0
    .byte 248,$7b,%01000000,248
    .byte 248,$7c,%01000000,240
    .byte 248,$7e,%01000000,224
    .byte 248,$7f,%01000000,216
    .byte   0,$87,%01000000, 24
    .byte   0,$88,%01000000, 16
    .byte   0,$89,%01000000,  8
    .byte   0,$8a,%01000000,  0
    .byte   0,$8b,%01000000,248
    .byte   0,$8c,%01000000,240
    .byte   0,$8d,%01000000,232
    .byte   0,$8e,%01000000,224
    .byte   8,$97,%01000000, 24
    .byte   8,$98,%01000000, 16
    .byte   8,$99,%01000000,  8
    .byte   8,$9a,%01000000,  0
    .byte   8,$9b,%01000000,248
    .byte   8,$9c,%01000000,240
    .byte   8,$9d,%01000000,232
    .byte  16,$a7,%01000000, 24
    .byte  16,$a8,%01000000, 16
    .byte  16,$a9,%01000000,  8
    .byte  16,$aa,%01000000,  0
    .byte  16,$ab,%01000000,248
    .byte  16,$ac,%01000000,240

raised_hand:
    .byte 240,$c7,%00000010,252
    .byte 240,$c8,%00000010,  4
    .byte 248,$d7,%00000010,252
    .byte 248,$d8,%00000010,  4
    .byte   0,$e6,%00000010,244
    .byte   0,$e7,%00000010,252
    .byte   0,$e8,%00000010,  4
    .byte   8,$f7,%00000010,252
    .byte   8,$f8,%00000010,  4

radio_hand:
    .byte 244,$ae,%00000010,248
    .byte 244,$af,%00000010,  0
    .byte 252,$be,%00000010,248
    .byte 252,$bf,%00000010,  0
    .byte   4,$ce,%00000010,248
    .byte   4,$cf,%00000010,  0


intro_sprite_count:
    .byte 22 * 4
    .byte 0

    .byte 12 * 4
    .byte 6 * 4

    .byte 22 * 4
    .byte 4 * 4

    .byte 0
    .byte 0

    .byte 43 * 4
    .byte 20 * 4

    .byte 14 * 4
    .byte 0

    .byte 14 * 4
    .byte 0

outro_sprite_count:
   .byte 6 * 4
   .byte 0

   .byte 0
   .byte 0

   .byte 45 * 4
   .byte 9 * 4

   .byte 45 * 4
   .byte 0



intro_sprite_pos_y:
    .byte 50
    .byte 0

    .byte 130
    .byte 80

    .byte 50
    .byte 135

    .byte 0
    .byte 0

    .byte 50
    .byte 130

    .byte 130
    .byte 0

    .byte 200
    .byte 0

intro_sprite_pos_x:
    .byte 50
    .byte 0

    .byte 120
    .byte 125

    .byte 90
    .byte 0

    .byte 0
    .byte 0

    .byte 50
    .byte 160

    .byte 150
    .byte 0

    .byte 150
    .byte 0


outro_sprite_pos_x:
    .byte 112
    .byte 0

    .byte 0
    .byte 0

    .byte 160
    .byte 90

    .byte 65
    .byte 0


outro_sprite_pos_y:
    .byte 130
    .byte 0

    .byte 0
    .byte 0

    .byte 30
    .byte 139

    .byte 90
    .byte 0

outro_sprite_dir_y:
    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 1
    .byte 0
    .byte 1
    .byte 0

    .byte 0
    .byte 0
    .byte 255
    .byte 0

outro_sprite_dir_x:

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 1
    .byte 0
    .byte 255

    .byte 2
    .byte 0
    .byte 3
    .byte 0

outro_scroll_dir_x:
    .byte 0
    .byte 0

    .byte 0
    .byte 1

outro_scroll_dir_y:
    .byte 0
    .byte 0

    .byte 0
    .byte 0


;two part movement
intro_sprite_dir_x:
;1st half of the scene
    .byte 2
    .byte 0
;2nd half
    .byte 2
    .byte 0
;-------------scene ends here
    .byte 0
    .byte 250

    .byte 0
    .byte 250
;--
    .byte 1
    .byte 8

    .byte 1
    .byte 8
;--

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 0
    .byte 0

intro_sprite_dir_y:
    .byte 1
    .byte 0
    .byte 255
    .byte 0

    .byte 1
    .byte 0
    .byte 255
    .byte 0

    .byte 0
    .byte 248
    .byte 0
    .byte 248

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 1
    .byte 0
    .byte 1
    .byte 0

    .byte 250
    .byte 0
    .byte 250
    .byte 0

    .byte 250
    .byte 0
    .byte 252
    .byte 0

;backround scrolling directions for the scenes

intro_scroll_dir_x:
    .byte 1
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0

intro_scroll_dir_y:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0

Scenes_that_do_palette_anim:
    .byte 0
    .byte 0
    .byte 0
    .byte 1
    .byte 0
    .byte 0
    .byte 0

intro_palette_changes:
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16
    .byte $38
    .byte $16



;scenes that do some kind of animation with background tiles are 1
Scenes_that_do_tile_anim:
    .byte 0
    .byte 0
    .byte 1
    .byte 0
    .byte 0
    .byte 0
    .byte 0

tile_anim_adresses:

    .byte $20, $C9
    .byte $20, $E8
    .byte $21, $07
    .byte $21, $26
    .byte $21, $45
    .byte $21, $64
    .byte $21, $83
    .byte $21, $A2
    .byte $21, $C1
    .byte $21, $E0
    .byte $22, $00
    .byte $22, $20



intro_sprites_low:
    .byte <plane_flies
    .byte 0

    .byte <yoke
    .byte <cloud

    .byte <plane_flies
    .byte <rocket

    .byte 0
    .byte 0

    .byte <parachute
    .byte <plane_falling

    .byte <dude_climbs
    .byte 0

    .byte <dude_climbs
    .byte 0

intro_sprites_high:
    .byte >plane_flies
    .byte 0

    .byte >yoke
    .byte >cloud

    .byte >plane_flies
    .byte >rocket

    .byte 0
    .byte 0

    .byte >parachute
    .byte >plane_falling

    .byte >dude_climbs
    .byte 0

    .byte >dude_climbs
    .byte 0

outro_sprites_high:
    .byte >radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte >chopper
    .byte >raised_hand

    .byte >chopper_flipped
    .byte 0

outro_sprites_low:
    .byte <radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte <chopper
    .byte <raised_hand

    .byte <chopper_flipped
    .byte 0

outro_sprites_2_high:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

outro_sprites_2_low:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0


;alternative frames for the metasprites

intro_sprites_2_low:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte <dude_climbs_f
    .byte 0

    .byte <dude_climbs_f
    .byte 0

intro_sprites_2_high:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte >dude_climbs_f
    .byte 0

    .byte >dude_climbs_f
    .byte 0

;how many metasprites in a scene ?
intro_meta_sprite_count:
    .byte 1
    .byte 2
    .byte 2
    .byte 0
    .byte 2
    .byte 1
    .byte 1

outro_meta_sprite_count:
    .byte 1
    .byte 0
    .byte 2
    .byte 1
