.include "data/intro_bg_mowdens_comp.asm"
.include "data/intro_bg_cockpit_comp.asm"
.include "data/intro_bg_boom_comp.asm"
.include "data/intro_bg_mowdens_base_comp.asm"
.include "data/intro_bg_mowdens_top_comp.asm"

.include "data/outro_bg_sos_comp.asm"
.include "data/outro_bg_that_same_day_comp.asm"
.include "data/outro_bg_chopper_comes_comp.asm"
.include "data/outro_bg_busted_comp.asm"
.include "data/outro_bg_victory_comp.asm"

;ALL cutscenes
cutscenes:
    .byte <cutscene_intro,      >cutscene_intro
    .byte <cutscene_good_outro, >cutscene_good_outro
    .byte <cutscene_bad_outro,  >cutscene_bad_outro

cutscene_len:
    .byte INTRO_SCENE_MAX
    .byte OUTRO_SCENE_MAX
    .byte OUTRO_SCENE_MAX + 1

;---------------------------------
cutscene_intro:
    .byte <intro_scenes,                 >intro_scenes                  ; scenes
    .byte <intro_scenes_delay,           >intro_scenes_delay            ; delay
    .byte <intro_scenes_duration,        >intro_scenes_duration         ; duration
    .byte <intro_sprite_count,           >intro_sprite_count            ; sprite count
    .byte <intro_sprite_pos_y,           >intro_sprite_pos_y            ; sprites Y position
    .byte <intro_sprite_pos_x,           >intro_sprite_pos_x            ; sprites X position
    .byte <intro_sprite_dir_x,           >intro_sprite_dir_x            ; movement direction x
    .byte <intro_sprite_dir_y,           >intro_sprite_dir_y            ; movement direction y
    .byte <intro_scroll_dir_x,           >intro_scroll_dir_x            ; scroll x
    .byte <intro_scroll_dir_y,           >intro_scroll_dir_y            ; scroll y
    .byte <intro_palette_anim_scenes,    >intro_palette_anim_scenes     ; scenes that do palette animation
    .byte <intro_sprites_low,            >intro_sprites_low             ; sprite ptr low
    .byte <intro_sprites_high,           >intro_sprites_high            ; sprite ptr high
    .byte <intro_sprites_2_low,          >intro_sprites_2_low           ; alternate frame sprite ptr low
    .byte <intro_sprites_2_high,         >intro_sprites_2_high          ; alternate frame sprite ptr low
    .byte <intro_meta_sprite_count,      >intro_meta_sprite_count       ; meta-sprite count


cutscene_good_outro:
    .byte <outro_scenes_good,               >outro_scenes_good               ;scenes
    .byte <outro_scenes_good_delay,         >outro_scenes_good_delay         ; delay
    .byte <outro_scenes_good_duration,      >outro_scenes_good_duration      ; duration
    .byte <outro_good_sprite_count,         >outro_good_sprite_count         ; sprite count
    .byte <outro_good_sprite_pos_y,         >outro_good_sprite_pos_y         ; sprites Y position
    .byte <outro_good_sprite_pos_x,         >outro_good_sprite_pos_x         ; sprites X position
    .byte <outro_good_sprite_dir_x,         >outro_good_sprite_dir_x         ; movement direction x
    .byte <outro_good_sprite_dir_y,         >outro_good_sprite_dir_y         ; movement direction x
    .byte <outro_good_scroll_dir_x,         >outro_good_scroll_dir_x         ; scroll x
    .byte <outro_good_scroll_dir_y,         >outro_good_scroll_dir_y         ; scroll y
    .byte <outro_good_palette_anim_scenes,  >outro_good_palette_anim_scenes  ; scenes that do palette animation
    .byte <outro_good_sprites_low,          >outro_good_sprites_low          ; sprite ptr low
    .byte <outro_good_sprites_high,         >outro_good_sprites_high         ; sprite ptr high
    .byte <outro_good_sprites_2_low,        >outro_good_sprites_2_low        ; alternate frame sprite ptr low
    .byte <outro_good_sprites_2_high,       >outro_good_sprites_2_high       ; alternate frame sprite ptr low
    .byte <outro_good_meta_sprite_count,    >outro_good_meta_sprite_count    ; meta-sprite count


cutscene_bad_outro:
    .byte <outro_scenes_bad,              >outro_scenes_bad               ;scenes
    .byte <outro_scenes_bad_delay,        >outro_scenes_bad_delay         ; delay
    .byte <outro_scenes_bad_duration,     >outro_scenes_bad_duration      ; duration
    .byte <outro_bad_sprite_count,        >outro_bad_sprite_count         ; sprite count
    .byte <outro_bad_sprite_pos_y,        >outro_bad_sprite_pos_y         ; sprites Y position
    .byte <outro_bad_sprite_pos_x,        >outro_bad_sprite_pos_x         ; sprites X position
    .byte <outro_bad_sprite_dir_x,        >outro_bad_sprite_dir_x         ; movement direction x
    .byte <outro_bad_sprite_dir_y,        >outro_bad_sprite_dir_y         ; movement direction x
    .byte <outro_bad_scroll_dir_x,        >outro_bad_scroll_dir_x         ; scroll x
    .byte <outro_bad_scroll_dir_y,        >outro_bad_scroll_dir_y         ; scroll y
    .byte <outro_bad_palette_anim_scenes, >outro_bad_palette_anim_scenes  ; scenes that do palette animation
    .byte <outro_bad_sprites_low,         >outro_bad_sprites_low          ; sprite ptr low
    .byte <outro_bad_sprites_high,        >outro_bad_sprites_high         ; sprite ptr high
    .byte <outro_bad_sprites_2_low,       >outro_bad_sprites_2_low        ; alternate frame sprite ptr low
    .byte <outro_bad_sprites_2_high,      >outro_bad_sprites_2_high       ; alternate frame sprite ptr low
    .byte <outro_bad_meta_sprite_count,   >outro_bad_meta_sprite_count    ; meta-sprite count


;---------------------------------
intro_scenes:
    .byte <intro_bg_mowdens_comp,      >intro_bg_mowdens_comp
    .byte <intro_bg_cockpit_comp,      >intro_bg_cockpit_comp
    .byte <intro_bg_mowdens_comp,      >intro_bg_mowdens_comp
    .byte <intro_bg_boom_comp,         >intro_bg_boom_comp
    .byte <intro_bg_mowdens_comp,      >intro_bg_mowdens_comp
    .byte <intro_bg_mowdens_base_comp, >intro_bg_mowdens_base_comp
    .byte <intro_bg_mowdens_top_comp,  >intro_bg_mowdens_top_comp

outro_scenes_good:
    .byte <outro_bg_sos_comp,           >outro_bg_sos_comp
    .byte <outro_bg_that_same_day_comp, >outro_bg_that_same_day_comp
    .byte <outro_bg_chopper_comes_comp, >outro_bg_chopper_comes_comp
    .byte <outro_bg_victory_comp,       >outro_bg_victory_comp


outro_scenes_bad:
    .byte <outro_bg_sos_comp,            >outro_bg_sos_comp
    .byte <outro_bg_that_same_day_comp,  >outro_bg_that_same_day_comp
    .byte <outro_bg_chopper_comes_comp,  >outro_bg_chopper_comes_comp
    .byte <outro_bg_busted_comp,         >outro_bg_busted_comp
    .byte <outro_bg_victory_comp,        >outro_bg_victory_comp

;---------------------------

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

outro_scenes_good_duration:
    .byte 70
    .byte 50
    .byte 39
    .byte 63

outro_scenes_good_delay:
    .byte 5
    .byte 8
    .byte 11
    .byte 5

outro_scenes_bad_duration:
    .byte 70
    .byte 50
    .byte 39
    .byte 50
    .byte 63

outro_scenes_bad_delay:
    .byte 5
    .byte 8
    .byte 11
    .byte 5
    .byte 5

;SPRITE DATA

plane_flies:
    .byte 240,$00,0,228
    .byte 240,$01,0,236
    .byte 240,$02,0,252
    .byte 240,$03,0,  4
    .byte 240,$04,0, 12
    .byte 240,$05,0, 20
    .byte 248,$10,0,228
    .byte 248,$11,0,236
    .byte 248,$12,0,244
    .byte 248,$13,0,252
    .byte 248,$14,0,  4
    .byte 248,$15,0, 12
    .byte 248,$16,0, 20
    .byte   0,$20,0,236
    .byte   0,$21,0,244
    .byte   0,$22,0,252
    .byte   0,$23,0,  4
    .byte   0,$24,0, 12
    .byte   0,$25,0, 20
    .byte   8,$26,0,244
    .byte   8,$27,0,252
    .byte   8,$28,0,  4

dude_climbs_f:
    .byte 236,$8d,0,  8
    .byte 244,$9b,0,248
    .byte 244,$9c,0,  0
    .byte 244,$9d,0,  8
    .byte 252,$99,0,240
    .byte 252,$9a,0,248
    .byte 252,$ae,0,  0
    .byte 252,$af,0,  8
    .byte   4,$ab,0,240
    .byte   4,$ac,0,248
    .byte   4,$ad,0,  0
    .byte  12,$aa,0,  0

dude_climbs:
    .byte 236,$8d,%01000000,240
    .byte 244,$9b,%01000000,  0
    .byte 244,$9c,%01000000,248
    .byte 244,$9d,%01000000,240
    .byte 252,$99,%01000000,  8
    .byte 252,$9a,%01000000,  0
    .byte 252,$ae,%01000000,248
    .byte 252,$af,%01000000,240
    .byte   4,$ab,%01000000,  8
    .byte   4,$ac,%01000000,  0
    .byte   4,$ad,%01000000,248
    .byte  12,$aa,%01000000,248

parachute:
    .byte 220,$2d,0,248
    .byte 220,$2e,0,  0
    .byte 220,$2f,0,  8
    .byte 228,$30,0,232
    .byte 228,$31,0,240
    .byte 228,$32,0,248
    .byte 228,$33,0,  0
    .byte 228,$34,0,  8
    .byte 228,$35,0, 16
    .byte 236,$40,0,232
    .byte 236,$33,0,240
    .byte 236,$41,0,248
    .byte 236,$42,0,  0
    .byte 236,$43,0,  8
    .byte 236,$44,0, 16
    .byte 244,$50,0,232
    .byte 244,$51,0,240
    .byte 244,$52,0,248
    .byte 244,$45,0,  8
    .byte 244,$46,0, 16
    .byte 252,$53,0,232
    .byte 252,$54,0,240
    .byte 252,$55,0,248
    .byte 252,$60,0,  8
    .byte 252,$61,0, 16
    .byte   4,$62,0,240
    .byte   4,$63,0,248
    .byte   4,$64,0,  0
    .byte   4,$65,0,  8
    .byte   4,$66,0, 16
    .byte  12,$70,0,248
    .byte  12,$71,0,  0
    .byte  12,$72,0,  8
    .byte  12,$73,0, 16
    .byte  20,$80,0,248
    .byte  20,$81,0,  0
    .byte  20,$82,0,  8
    .byte  20,$83,0, 16
    .byte  28,$74,0,  0
    .byte  28,$75,0,  8
    .byte  28,$76,0, 16

rocket:
    .byte 248,$06,0,248
    .byte 248,$07,0,  0
    .byte   0,$17,0,248
    .byte   0,$18,0,  0


plane_falling:
    .byte 236,$08,0,232
    .byte 236,$09,0,240
    .byte 244,$19,0,232
    .byte 244,$1a,0,240
    .byte 244,$1b,0,248
    .byte 252,$0a,0,232
    .byte 252,$0b,0,240
    .byte 252,$0c,0,248
    .byte 252,$0d,0,  0
    .byte   4,$1c,0,240
    .byte   4,$1d,0,248
    .byte   4,$1e,0,  0
    .byte   4,$1f,0,  8
    .byte   4,$0e,0, 16
    .byte  12,$29,0,240
    .byte  12,$2a,0,248
    .byte  12,$2b,0,  0
    .byte  12,$2c,0,  8
    .byte  12,$0f,0, 16

yoke:
    .byte 248,$89,%01000010,232
    .byte 248,$88,%01000010,240
    .byte 248,$87,%01000010,248
    .byte 248,$87,%00000010,  0
    .byte 248,$88,%00000010,  8
    .byte 248,$89,%00000010, 16
    .byte   0,$8c,%01000010,232
    .byte   0,$8b,%01000010,240
    .byte   0,$8a,%01000010,248
    .byte   0,$8a,%00000010,  0
    .byte   0,$8b,%00000010,  8
    .byte   0,$8c,%00000010, 16

cloud:
    .byte 248,$84,%00000000,244
    .byte 248,$85,%00000000,252
    .byte 248,$86,%00000000,  4
    .byte   0,$86,%11000000,244
    .byte   0,$85,%10000000,252
    .byte   0,$84,%11000000,  4

chopper:
    .byte 232,$36,0,224
    .byte 232,$37,0,232
    .byte 232,$38,0,240
    .byte 232,$39,0,248
    .byte 232,$3a,0,  0
    .byte 232,$3b,0,  8
    .byte 232,$3c,0, 16
    .byte 240,$47,0,224
    .byte 240,$48,0,232
    .byte 240,$49,0,240
    .byte 240,$4a,0,248
    .byte 240,$4b,0,  0
    .byte 240,$4c,0,  8
    .byte 240,$4d,0, 16
    .byte 240,$4e,0, 24
    .byte 248,$3d,0,224
    .byte 248,$3e,0,232
    .byte 248,$3f,0,240
    .byte 248,$4f,0,248
    .byte 248,$56,0,  0
    .byte 248,$57,0,  8
    .byte 248,$58,0, 24
    .byte 248,$59,0, 32
    .byte   0,$5a,0,224
    .byte   0,$5b,0,232
    .byte   0,$5c,0,240
    .byte   0,$5d,0,248
    .byte   0,$5e,0,  0
    .byte   0,$5f,0,  8
    .byte   0,$67,0, 16
    .byte   0,$68,0, 24
    .byte   0,$69,0, 32
    .byte   8,$6a,0,224
    .byte   8,$6b,0,232
    .byte   8,$6c,0,240
    .byte   8,$6d,0,248
    .byte   8,$6e,0,  0
    .byte   8,$6f,0,  8
    .byte   8,$77,0, 16
    .byte  16,$79,0,224
    .byte  16,$7a,0,232
    .byte  16,$7b,0,240
    .byte  16,$7c,0,248
    .byte  16,$7c,0,  0
    .byte  16,$7d,0,  8

chopper_flipped:
    .byte 232,$36,%01000000, 24
    .byte 232,$37,%01000000, 16
    .byte 232,$38,%01000000,  8
    .byte 232,$39,%01000000,  0
    .byte 232,$3a,%01000000,248
    .byte 232,$3b,%01000000,240
    .byte 232,$3c,%01000000,232
    .byte 240,$47,%01000000, 24
    .byte 240,$48,%01000000, 16
    .byte 240,$49,%01000000,  8
    .byte 240,$4a,%01000000,  0
    .byte 240,$4b,%01000000,248
    .byte 240,$4c,%01000000,240
    .byte 240,$4d,%01000000,232
    .byte 240,$4e,%01000000,224
    .byte 248,$3d,%01000000, 24
    .byte 248,$3e,%01000000, 16
    .byte 248,$3f,%01000000,  8
    .byte 248,$4f,%01000000,  0
    .byte 248,$56,%01000000,248
    .byte 248,$57,%01000000,240
    .byte 248,$58,%01000000,224
    .byte 248,$59,%01000000,216
    .byte   0,$5a,%01000000, 24
    .byte   0,$5b,%01000000, 16
    .byte   0,$5c,%01000000,  8
    .byte   0,$5d,%01000000,  0
    .byte   0,$5e,%01000000,248
    .byte   0,$5f,%01000000,240
    .byte   0,$67,%01000000,232
    .byte   0,$68,%01000000,224
    .byte   0,$69,%01000000,216
    .byte   8,$6a,%01000000, 24
    .byte   8,$6b,%01000000, 16
    .byte   8,$6c,%01000000,  8
    .byte   8,$6d,%01000000,  0
    .byte   8,$6e,%01000000,248
    .byte   8,$6f,%01000000,240
    .byte   8,$77,%01000000,232
    .byte  16,$79,%01000000, 24
    .byte  16,$7a,%01000000, 16
    .byte  16,$7b,%01000000,  8
    .byte  16,$7c,%01000000,  0
    .byte  16,$7c,%01000000,248
    .byte  16,$7d,%01000000,240

raised_hand:
    .byte 240,$90,%00000010,252
    .byte 240,$91,%00000010,  4
    .byte 248,$92,%00000010,252
    .byte 248,$93,%00000010,  4
    .byte   0,$94,%00000010,244
    .byte   0,$95,%00000010,252
    .byte   0,$96,%00000010,  4
    .byte   8,$97,%00000010,252
    .byte   8,$98,%00000010,  4

radio_hand:
    .byte 244,$7e,%00000010,248
    .byte 244,$7f,%00000010,  0
    .byte 252,$8e,%00000010,248
    .byte 252,$8f,%00000010,  0
    .byte   4,$9e,%00000010,248
    .byte   4,$9f,%00000010,  0

busted:
    .byte 236,$a0,0,232
    .byte 236,$a1,0,240
    .byte 236,$a2,0,248
    .byte 236,$a3,0,  0
    .byte 236,$a4,0,  8
    .byte 236,$a5,0, 16
    .byte 244,$b0,0,232
    .byte 244,$b1,0,240
    .byte 244,$b2,0,248
    .byte 244,$b3,0,  0
    .byte 244,$b4,0,  8
    .byte 244,$b5,0, 16
    .byte 244,$b6,0, 24
    .byte 252,$c0,0,224
    .byte 252,$c1,0,232
    .byte 252,$c2,0,240
    .byte 252,$c3,0,248
    .byte 252,$c4,0,  0
    .byte 252,$c5,0,  8
    .byte 252,$c6,0, 16
    .byte 252,$c7,0, 24
    .byte   4,$d0,0,224
    .byte   4,$d1,0,232
    .byte   4,$d2,0,240
    .byte   4,$d3,0,248
    .byte   4,$d4,0,  0
    .byte   4,$d5,0,  8
    .byte   4,$d6,0, 16
    .byte   4,$d7,0, 24
    .byte  12,$e1,0,232
    .byte  12,$e2,0,240
    .byte  12,$e3,0,248
    .byte  12,$e5,0,  8
    .byte  12,$e6,0, 16
    .byte  12,$e7,0, 24



intro_sprite_count:
    .byte 22 * 4
    .byte 0

    .byte 12 * 4
    .byte 6 * 4

    .byte 22 * 4
    .byte 4 * 4

    .byte 0
    .byte 0

    .byte 41 * 4
    .byte 19 * 4

    .byte 12 * 4
    .byte 0

    .byte 12 * 4
    .byte 0

outro_good_sprite_count:
   .byte 6 * 4
   .byte 0

   .byte 0
   .byte 0

   .byte 45 * 4
   .byte 9 * 4

   .byte 45 * 4
   .byte 0

outro_bad_sprite_count:
   .byte 6 * 4
   .byte 0

   .byte 0
   .byte 0

   .byte 45 * 4
   .byte 9 * 4

   .byte 35 * 4
   .byte 0

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


outro_good_sprite_pos_x:
    .byte 112
    .byte 0

    .byte 0
    .byte 0

    .byte 160
    .byte 90

    .byte 65
    .byte 0


outro_good_sprite_pos_y:
    .byte 130
    .byte 0

    .byte 0
    .byte 0

    .byte 30
    .byte 139

    .byte 90
    .byte 0

outro_bad_sprite_pos_x:
    .byte 112
    .byte 0

    .byte 0
    .byte 0

    .byte 160
    .byte 90

    .byte 100
    .byte 0

    .byte 65
    .byte 0


outro_bad_sprite_pos_y:
    .byte 130
    .byte 0

    .byte 0
    .byte 0

    .byte 30
    .byte 139

    .byte 80
    .byte 0

    .byte 90
    .byte 0


outro_good_sprite_dir_y:
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

outro_good_sprite_dir_x:

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

outro_bad_sprite_dir_y:
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
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 255
    .byte 0

outro_bad_sprite_dir_x:

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

    .byte 0
    .byte 0
    .byte 0
    .byte 0

    .byte 2
    .byte 0
    .byte 3
    .byte 0


outro_good_scroll_dir_x:
    .byte 0
    .byte 0

    .byte 0
    .byte 1

outro_good_scroll_dir_y:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

outro_bad_scroll_dir_x:
    .byte 0
    .byte 0

    .byte 0
    .byte 0
    .byte 1

outro_bad_scroll_dir_y:
    .byte 0
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

intro_palette_anim_scenes:
    .byte 0
    .byte 0
    .byte 0
    .byte 1
    .byte 0
    .byte 0
    .byte 0

outro_good_palette_anim_scenes:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0

outro_bad_palette_anim_scenes:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
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

outro_good_sprites_high:
    .byte >radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte >chopper
    .byte >raised_hand

    .byte >chopper_flipped
    .byte 0

outro_bad_sprites_high:
    .byte >radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte >chopper
    .byte >raised_hand

    .byte >busted
    .byte 0

    .byte >chopper_flipped
    .byte 0


outro_good_sprites_low:
    .byte <radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte <chopper
    .byte <raised_hand

    .byte <chopper_flipped
    .byte 0

outro_bad_sprites_low:
    .byte <radio_hand
    .byte 0

    .byte 0
    .byte 0

    .byte <chopper
    .byte <raised_hand

    .byte <busted
    .byte 0

    .byte <chopper_flipped
    .byte 0


outro_good_sprites_2_high:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

outro_bad_sprites_2_high:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0


outro_good_sprites_2_low:
    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

    .byte 0
    .byte 0

outro_bad_sprites_2_low:
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

outro_good_meta_sprite_count:
    .byte 1
    .byte 0
    .byte 2
    .byte 1

outro_bad_meta_sprite_count:
    .byte 1
    .byte 0
    .byte 2
    .byte 1
    .byte 1
