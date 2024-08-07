mod_tiles_by_location:
    .byte <mod_tiles_first,          >mod_tiles_first          ;0
    .byte 0,                         0                         ;1
    .byte 0,                         0                         ;2
    .byte 0,                         0                         ;3
    .byte 0,                         0                         ;4
    .byte 0,                         0                         ;5
    .byte <mod_tiles_mine,           >mod_tiles_mine           ;6 abandoned mine
    .byte 0,                         0                         ;7
    .byte 0,                         0                         ;8
    .byte 0,                         0                         ;9
    .byte <mod_tiles_alien_base,     >mod_tiles_alien_base     ;10 alien base
    .byte 0,                         0                         ;11
    .byte 0,                         0                         ;12
    .byte 0,                         0                         ;13
    .byte <mod_tiles_secret_cave,    >mod_tiles_secret_cave    ;14
    .byte 0,                         0                         ;15
    .byte 0,                         0                         ;16
    .byte 0,                         0                         ;17
    .byte 0,                         0                         ;18
    .byte <mod_tiles_alien_base_pre, >mod_tiles_alien_base_pre ;19 alien base pre

mod_tiles_count_by_location:
    .byte 4 ;0
    .byte 0 ;1
    .byte 0 ;2
    .byte 0 ;3
    .byte 0 ;4
    .byte 0 ;5
    .byte 4 ;6
    .byte 0 ;7
    .byte 0 ;8
    .byte 0 ;9
    .byte 2 ;10
    .byte 0 ;11
    .byte 0 ;12
    .byte 0 ;13
    .byte 4 ;14
    .byte 0 ;15
    .byte 0 ;16
    .byte 0 ;17
    .byte 0 ;18
    .byte 10 ;19
