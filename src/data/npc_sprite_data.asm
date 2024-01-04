;Bunny
npc_BUNNY_sprite_data:

npc_BUNNY_frames:
    .byte <npc_BUNNY_frame_LEFT,  >npc_BUNNY_frame_LEFT
    .byte <npc_BUNNY_frame_RIGHT, >npc_BUNNY_frame_RIGHT
    .byte <npc_BUNNY_frame_UP,    >npc_BUNNY_frame_UP
    .byte <npc_BUNNY_frame_DOWN,  >npc_BUNNY_frame_DOWN


npc_BUNNY_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_BUNNY_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_BUNNY_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8


npc_BUNNY_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;=============================================

npc_DOGMAN_frames:
    .byte <npc_DOGMAN_frame_LEFT,  >npc_DOGMAN_frame_LEFT
    .byte <npc_DOGMAN_frame_RIGHT, >npc_DOGMAN_frame_RIGHT
    .byte <npc_DOGMAN_frame_UP,    >npc_DOGMAN_frame_UP
    .byte <npc_DOGMAN_frame_DOWN,  >npc_DOGMAN_frame_DOWN


npc_DOGMAN_sprite_data:

npc_DOGMAN_frame_LEFT:
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
;frame 0
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;frame 1
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;frame 2
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;frame 3
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;attack
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;dead
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8


npc_DOGMAN_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;dead
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8


npc_DOGMAN_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;dead
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8


npc_DOGMAN_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;dead
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8


;===================================================
npc_HOUND_sprite_data:

npc_HOUND_frames:
    .byte <npc_HOUND_frame_LEFT,  >npc_HOUND_frame_LEFT
    .byte <npc_HOUND_frame_RIGHT, >npc_HOUND_frame_RIGHT
    .byte <npc_HOUND_frame_UP,    >npc_HOUND_frame_UP
    .byte <npc_HOUND_frame_DOWN,  >npc_HOUND_frame_DOWN

npc_HOUND_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8


npc_HOUND_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_HOUND_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_HOUND_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 1
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 2
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;frame 3
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;attack
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

;================================================
npc_BJORN_sprite_data:

npc_BJORN_frames:
    .byte <npc_BJORN_frame_LEFT,  >npc_BJORN_frame_LEFT
    .byte <npc_BJORN_frame_RIGHT, >npc_BJORN_frame_RIGHT
    .byte <npc_BJORN_frame_UP,    >npc_BJORN_frame_UP
    .byte <npc_BJORN_frame_DOWN,  >npc_BJORN_frame_DOWN


npc_BJORN_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

npc_BJORN_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

npc_BJORN_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_BJORN_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;================================================
npc_ERIKA_sprite_data:

npc_ERIKA_frames:
    .byte <npc_ERIKA_frame_LEFT,  >npc_ERIKA_frame_LEFT
    .byte <npc_ERIKA_frame_RIGHT, >npc_ERIKA_frame_RIGHT
    .byte <npc_ERIKA_frame_UP,    >npc_ERIKA_frame_UP
    .byte <npc_ERIKA_frame_DOWN,  >npc_ERIKA_frame_DOWN

npc_ERIKA_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

npc_ERIKA_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

npc_ERIKA_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

npc_ERIKA_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
;========================================
npc_GRANNY_sprite_data:

npc_GRANNY_frames:
    .byte <npc_GRANNY_frame_LEFT,  >npc_GRANNY_frame_LEFT
    .byte <npc_GRANNY_frame_RIGHT, >npc_GRANNY_frame_RIGHT
    .byte <npc_GRANNY_frame_UP,    >npc_GRANNY_frame_UP
    .byte <npc_GRANNY_frame_DOWN,  >npc_GRANNY_frame_DOWN

npc_GRANNY_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_GRANNY_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_GRANNY_frame_UP:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8

npc_GRANNY_frame_DOWN:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
;====================================

npc_DEADMAN_sprite_data:

npc_DEADMAN_frames:
    .byte <npc_DEADMAN_frame_LEFT, >npc_DEADMAN_frame_LEFT
    .byte <npc_DEADMAN_frame_RIGHT, >npc_DEADMAN_frame_RIGHT

npc_DEADMAN_frame_LEFT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8
npc_DEADMAN_frame_RIGHT:
;frame 0
    .byte 0, 10, %00000000, 0
    .byte 0, 10, %00000000, 8
    .byte 8, 10, %00000000, 0
    .byte 8, 10, %00000000, 8
    .byte 16, 10, %00000000, 0
    .byte 16, 10, %00000000, 8

