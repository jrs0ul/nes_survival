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
    .byte   8,$33,0,252
    .byte   8,$34,0,4

pilot:
    .byte 236,$57,0 ,232
    .byte 236,$58,0 ,240
    .byte 236,$59,0 ,248
    .byte 236,$5a,0 ,  0
    .byte 236,$5b,0 ,  8
    .byte 236,$5c,0 , 16
    .byte 244,$67,0 ,232
    .byte 244,$68,0 ,240
    .byte 244,$69,0 ,248
    .byte 244,$6a,0 ,  0
    .byte 244,$6b,0 ,  8
    .byte 244,$6c,0 , 16
    .byte 252,$77,0 ,232
    .byte 252,$78,0 ,240
    .byte 252,$79,0 ,248
    .byte 252,$7a,0 ,  0
    .byte 252,$7b,0 ,  8
    .byte 252,$7c,0 , 16
    .byte   4,$87,0 ,232
    .byte   4,$88,0 ,240
    .byte   4,$89,0 ,248
    .byte   4,$8a,0 ,  0
    .byte   4,$8b,0 ,  8
    .byte   4,$8c,0 , 16
    .byte  12,$97,0 ,232
    .byte  12,$98,0 ,240
    .byte  12,$99,0 ,248
    .byte  12,$9a,0 ,  0
    .byte  12,$9b,0 ,  8
    .byte  12,$9c,0 , 16



dude_climbs:
    .byte 236,$ba,0,248
    .byte 236,$bb,0,0
    .byte 236,$bc,0,8
    .byte 244,$ca,0,248
    .byte 244,$cb,0,0
    .byte 244,$cc,0,8
    .byte 252,$d9,0,240
    .byte 252,$da,0,248
    .byte 252,$db,0,0
    .byte   4,$e9,0,240
    .byte   4,$ea,0,248
    .byte   4,$eb,0,0
    .byte  12,$fa,0,248

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
    .byte 244,$74,0,0
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


intro_sprite_count:
    .byte 20 * 4
    .byte 30 * 4
    .byte 20 * 4
    .byte 44 * 4
    .byte 13 * 4
    .byte 13 * 4

intro_sprite_pos_y:
    .byte 50
    .byte 130
    .byte 50
    .byte 50
    .byte 60
    .byte 150

intro_sprite_pos_x:
    .byte 50
    .byte 60
    .byte 90
    .byte 50
    .byte 150
    .byte 150


intro_sprites_low:
    .byte <plane_flies
    .byte <pilot
    .byte <plane_flies
    .byte <parachute
    .byte <dude_climbs
    .byte <dude_climbs

intro_sprites_high:
    .byte >plane_flies
    .byte >pilot
    .byte >plane_flies
    .byte >parachute
    .byte >dude_climbs
    .byte >dude_climbs
