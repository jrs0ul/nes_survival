.include "data/intro_bg_mowdens.asm"
.include "data/intro_bg_cockpit.asm"
.include "data/intro_bg_boom.asm"
.include "data/intro_bg_mowdens_base.asm"
.include "data/intro_bg_mowdens_top.asm"

intro_scenes_low:
    .byte <intro_bg_mowdens
    .byte <intro_bg_cockpit
    .byte <intro_bg_mowdens
    .byte <intro_bg_boom
    .byte <intro_bg_mowdens
    .byte <intro_bg_mowdens_base
    .byte <intro_bg_mowdens_top

intro_scenes_high:
    .byte >intro_bg_mowdens
    .byte >intro_bg_cockpit
    .byte >intro_bg_mowdens
    .byte >intro_bg_boom
    .byte >intro_bg_mowdens
    .byte >intro_bg_mowdens_base
    .byte >intro_bg_mowdens_top

intro_scenes_delay:
    .byte 5
    .byte 37
    .byte 5
    .byte 6
    .byte 15
    .byte 20
    .byte 25

intro_scenes_duration:
    .byte 90
    .byte 10
    .byte 15
    .byte 20
    .byte 20
    .byte 12
    .byte 10


plane_flies:
    .byte 240,$00,0,228
    .byte 240,$01,0,236
    .byte 240,$02,0,244
    .byte 240,$03,0,252
    .byte 240,$04,0,4
    .byte 240,$05,0,12
    .byte 240,$06,0,20
    .byte 248,$10,0,228
    .byte 248,$11,0,236
    .byte 248,$12,0,244
    .byte 248,$13,0,252
    .byte 248,$14,0, 4
    .byte 248,$15,0,12
    .byte 248,$16,0,20
    .byte   0,$22,0,244
    .byte   0,$23,0,252
    .byte   0,$24,0,4
    .byte   0,$26,0,20
    .byte   0,$21,0,236


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
    .byte 220,$43,0,248
    .byte 220,$44,0,0
    .byte 220,$45,0,8
    .byte 228,$51,0,232
    .byte 228,$52,0,240
    .byte 228,$53,0,248
    .byte 228,$54,0,0
    .byte 228,$55,0,8
    .byte 228,$56,0,16
    .byte 236,$61,0,232
    .byte 236,$62,0,240
    .byte 236,$63,0,248
    .byte 236,$64,0,0
    .byte 236,$65,0,8
    .byte 236,$66,0,16
    .byte 244,$71,0,232
    .byte 244,$72,0,240
    .byte 244,$73,0,248
    .byte 244,$75,0,8
    .byte 244,$76,0, 16
    .byte 252,$81,0,232
    .byte 252,$82,0,240
    .byte 252,$83,0,248
    .byte 252,$84,0,  0
    .byte 252,$85,0,  8
    .byte 252,$86,0, 16
    .byte   4,$91,0,232
    .byte   4,$92,0,240
    .byte   4,$93,0,248
    .byte   4,$94,0,  0
    .byte   4,$95,0,  8
    .byte   4,$96,0, 16
    .byte  12,$a3,0,248
    .byte  12,$a4,0,  0
    .byte  12,$a5,0,  8
    .byte  12,$a6,0, 16
    .byte  20,$b3,0,248
    .byte  20,$b4,0,  0
    .byte  20,$b5,0,  8
    .byte  20,$b6,0, 16
    .byte  28,$c4,0,  0
    .byte  28,$c5,0,  8
    .byte  28,$c6,0, 16

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
    .byte 244,$8d,%00000010,0
    .byte 244,$8e,%00000010,8
    .byte 244,$8f,%00000010,16

    .byte 252,$9d,%00000010,0
    .byte 252,$9e,%00000010,8
    .byte 252,$9f,%00000010,16


    .byte 244,$8d,%01000010,248
    .byte 244,$8e,%01000010,240
    .byte 244,$8f,%01000010,232

    .byte 252,$9d,%01000010,248
    .byte 252,$9e,%01000010,240
    .byte 252,$9f,%01000010,232



intro_sprite_count:
    .byte 19 * 4
    .byte 0

    .byte 12 * 4
    .byte 0

    .byte 19 * 4
    .byte 4 * 4

    .byte 0
    .byte 0

    .byte 43 * 4
    .byte 20 * 4

    .byte 14 * 4
    .byte 0

    .byte 14 * 4
    .byte 0

intro_sprite_pos_y:
    .byte 50
    .byte 0

    .byte 130
    .byte 0

    .byte 50
    .byte 100

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
    .byte 0

    .byte 90
    .byte 20

    .byte 0
    .byte 0

    .byte 50
    .byte 160

    .byte 150
    .byte 0

    .byte 150
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
    .byte 0

    .byte 0
    .byte 0
;--
    .byte 1
    .byte 4

    .byte 1
    .byte 4
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
    .byte 253
    .byte 0
    .byte 253

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
    .byte 1
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


intro_sprites_low:
    .byte <plane_flies
    .byte 0

    .byte <yoke
    .byte 0

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
    .byte 0

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
    .byte 1
    .byte 2
    .byte 0
    .byte 2
    .byte 1
    .byte 1
