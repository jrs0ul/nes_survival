.segment "HEADER"
    .byte 'N', 'E', 'S', $1A   ; these bytes always start off an ines file
    .byte 8                    ; 8 Banks x16KB
    .byte $00                  ; CHR RAM

;============================================================================================
; iNES flag 6
; 7654 3210
; |||| ||||
; |||| |||+- Mirroring: 0: horizontal (vertical arrangement) (CIRAM A10 = PPU A11)
; |||| |||              1: vertical (horizontal arrangement) (CIRAM A10 = PPU A10)
; |||| ||+-- 1: Cartridge contains battery-backed PRG RAM ($6000-7FFF) or other persistent memory
; |||| |+--- 1: 512-byte trainer at $7000-$71FF (stored before PRG data)
; |||| 
; ||||+---- 1: Ignore mirroring control or above mirroring bit; instead provide four-screen VRAM
; ++++----- Lower nybble of mapper number
;============================================================================================
    .byte %00100001                   ; NROM mapper 0, other mappers have more complicated values here
    .byte $0, $0, $0, $07, $0, $0

.segment "VECTORS"
    .word nmi, reset, 0
;==========================================================

.segment "ROM0"

main_tiles_chr: .incbin "main.chr"

.include "data/maps/LOC3_bg1.asm"
.include "data/maps/LOC3_bg0.asm"
.include "data/maps/field_bg.asm"
.include "data/maps/field_bg1.asm"
.include "data/maps/field_bg2.asm"
.include "data/maps/field_bg4.asm"


.include "data/collision_data.asm"

;===========================================================
.segment "ROM1"

.include "data/menu_data.asm"
.include "data/recipes.asm"
.include "data/menu_screen.asm"

;============================================================
.segment "ROM2"

title_tiles_chr: .incbin "title.chr"
intro_tiles_chr: .incbin "intro.chr"


;============================================================
.segment "ROM3" ; indoors

house_tiles_chr: .incbin "house.chr"
.include "data/maps/house.asm"
.include "data/maps/villager_hut.asm"
.include "data/maps/villager2_hut.asm"


;============================================================
.segment "ROM4" ; other location

main_tiles_chr2: .incbin "main.chr"

.include "data/maps/field2_bg.asm"
.include "data/maps/field2_bg1.asm"
.include "data/collision_data2.asm"
.include "data/maps/cave1.asm"
.include "data/maps/cave2.asm"
.include "data/maps/crashsite.asm"

;=============================================================
.segment "ROM5" ;title and intro data (?)

title_palette:
    .byte $0F,$07,$11,$20, $0F,$01,$11,$07, $0F,$31,$26,$35, $0F,$07,$11,$35    ;background
    .byte $0F,$0f,$17,$20, $0F,$06,$26,$39, $0F,$17,$21,$31, $0F,$0f,$37,$26    ;OAM sprites

intro_palette:
    .byte $0C,$00,$31,$30, $0C,$01,$31,$30, $0C,$16,$31,$36, $0C,$18,$07,$30 ; background
    .byte $0C,$06,$16,$30, $0C,$0c,$35,$21, $0C,$0c,$16,$36, $0C,$01,$07,$21 ; sprites

.include "data/title.asm"
.include "data/game_over.asm"
.include "data/CutsceneData.asm"

;=============================================================
.segment "ROM6"

.include "data/music.s"
.include "data/sfx.s"

.include "famistudio_ca65.asm"
;=============================================================

.segment "RODATA" ; ROM7

banktable:              ; Write to this table to switch banks.
    .byte $00, $01, $02, $03, $04, $05, $06
    .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E

.include "data/map_list.asm"
.include "data/collision_list.asm"

.include "data/item_data.asm"
.include "data/npc_data.asm"

.include "data/item_list.asm" ;items in maps
.include "data/npc_list.asm"  ;npcs in maps


.include "data/villager_quests.asm"
.include "data/MapEntryPoints.asm"
.include "data/AnimalSpawnPositions.asm"


zerosprite:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72
    .byte $72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72
    .byte $00,$57,$31,$30,$30,$00,$00,$00,$56,$30,$36,$37,$00,$00,$00,$55
    .byte $30,$38,$33,$00,$00,$00,$00,$00,$00,$00,$00,$00,$89,$8A,$8B,$00
    .byte $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
    .byte $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70

x_collision_pattern:
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001
    .byte %10000000
    .byte %01000000
    .byte %00100000
    .byte %00010000
    .byte %00001000
    .byte %00000100
    .byte %00000010
    .byte %00000001

stamina_sprite_lookup:
    .byte 168
    .byte 176
    .byte 184
    .byte 192
    .byte 200
stamina_segment_values:
    .byte 0
    .byte 32
    .byte 64
    .byte 96
    .byte 128

spearSprites:
          ;+Y,frame,attributes,+X
    .byte 248, $E2, %00000000, 252, 0, $E3, %00000000, 252 ;up
    .byte 248, $E3, %10000000, 252, 0, $E2, %10000000, 252 ;down
    .byte 252, $E0, %00000000, 248, 252, $E1, %00000000, 0 ;left
    .byte 252, $E1, %01000000, 248, 252, $E0, %01000000, 0 ;right

fishingRodSprites:
    .byte   8, $E7, %00000000, 0,   8, $E8, %00000000, 248 ;left
    .byte   8, $E7, %01000000, 8,   8, $E8, %01000000, 16 ;right
    .byte   8, $E6, %00000000, 0,  16, $D8, %00000000, 0  ;down
    .byte   0, $E6, %10000000, 0,  248, $D8, %10000000, 0 ;up

hammerSprites:
    .byte   7, $A9, %00000000, 0,   7, $A8, %00000000, 248  ;left
    .byte   7, $A9, %01000000, 8,   7, $A8, %01000000, 16   ;right
    .byte   255, $99, %11000000, 8,  250, $98, %11000000, 8 ;up
    .byte   9, $99, %00000000, 0,  17, $98, %00000000, 0    ;down
    .byte   255, $99, %10000000, 0,  250, $98, %10000000, 0 ;up-flipped
    .byte   9,   $99, %01000000, 8,  17,  $98, %01000000, 8 ;down-flipped


house_palette:
    .byte $0C,$16,$27,$37, $0C,$07,$00,$31, $0C,$17,$27,$31, $0C,$20,$37,$16    ;background
    .byte $0C,$0f,$17,$20, $0C,$0C,$16,$39, $0C,$0f,$16,$39, $0C,$0f,$37,$16    ;OAM sprites

main_palette:
    .byte $0C,$00,$21,$31, $0C,$1B,$21,$31, $0C,$18,$21,$31, $0C,$20,$37,$16    ;background
    .byte $0C,$0f,$17,$20, $0C,$0C,$16,$39, $0C,$0f,$16,$39, $0C,$0f,$37,$16    ;OAM sprites

game_over_palette:
    .byte $0f,$10,$20,$30,$0f,$0c,$35,$21,$0f,$0c,$16,$21,$0f,$01,$07,$21
    .byte $0f,$10,$20,$30,$0f,$0c,$35,$21,$0f,$0c,$16,$21,$0f,$01,$07,$21

snow_palette_frames: ;white and black
    .byte $20, $0F
    .byte $0F, $20
snow_palette_frames_1: ; white and blue
    .byte $20, $11
    .byte $11, $20

sprites:
    .byte $11, $FF, %00000011, $08   ; sprite 0 


;position of knife sprite depending on the player frame
knife_pos_flipped:
    .byte 16,  8 ; left/right
    .byte  0,  0 ; up
    .byte  8, 16 ; down

knife_pos_normal:
    .byte  248,  8 ; left/right (248 = -8)
    .byte  8  ,  0 ; up
    .byte  0  , 16 ; down

knife_collision_pos_flip:
    .byte 22, 9, 22, 15  ; l/r
    .byte 2,  1,  6, 1   ; up
    .byte 10, 22, 14, 22 ;down
knife_collision_pos:
    .byte 250, 9, 250, 15
    .byte 10, 1, 14, 1
    .byte 2, 24, 6, 24

fist_collision_pos_flip:
    .byte 18, 9, 18, 15  ; l/r
    .byte 2,  4,  6, 4   ; up
    .byte 10, 18, 14, 18 ;down
fist_collision_pos:
    .byte 254, 9, 254, 15
    .byte 10, 4, 14, 4
    .byte 2, 18, 6, 18


;data: 
;   location,
;   tile address high, (in video memory)
;   tile address low,
;   tile row
;   tile column
destructable_tiles_list:
    .byte 6, $20, $87, 4, 7, 0, 0, 0
    .byte 6, $20, $88, 4, 8, 0, 0, 0






npc_direction_list:
    .byte 0
    .byte %00000100 ; Up
    .byte %00000001 ; R
    .byte %00001000
    .byte %00000010

PaletteTransitions:
    .byte $00
    .byte $10
    .byte $20
    .byte $30
    .byte $40

palette_fade_for_periods: ; each period is 1h 30 mins
    .byte $40 ;00:00 period start
    .byte $40 ;01:30
    .byte $40 ;03:00
    .byte $40 ;04:30
    .byte $30 ;06:00
    .byte $20 ;07:30
    .byte $10 ;09:00
    .byte $00 ;10:30
    .byte $00 ;12:00
    .byte $00 ;13:30
    .byte $10 ;15:00
    .byte $20 ;16:30
    .byte $30 ;18:00
    .byte $40 ;19:30
    .byte $40 ;21:00
    .byte $40 ;22:30

sun_moon_sprites_for_periods:
    .byte 232, 246, 0, 0 ;$40
    .byte 232, 246, 0, 0 ;$40
    .byte 232, 246, 0, 0 ;$40
    .byte 232, 246, 0, 0 ;$40
    .byte 240, 246, 0, 0 ; 30
    .byte 240, 246, 224, 244 ; 20
    .byte 240, 248, 224, 243 ; 10
    .byte 232, 243, 0, 0 ; 0
    .byte 232, 243, 0, 0 ; 0
    .byte 232, 243, 0, 0 ; 0
    .byte 240, 243, 0, 0 ; 10
    .byte 240, 243, 224, 247 ; 20
    .byte 224, 246, 240,  245; 30
    .byte 232, 246, 0, 0 ;$40
    .byte 232, 246, 0, 0 ;$40
    .byte 232, 246, 0, 0 ;$40

player_anim_row_sequence:
   .byte 0
   .byte 16
   .byte 32
   .byte 16
   .byte 48

npc_anim_row_sequence:
    .byte 0
    .byte 32
    .byte 64
    .byte 32
    .byte 96


player_sprites_not_flip:
    .byte 0, 0,  %00000011, 0 ;1st sprite
    .byte 0, 1,  %00000011, 8 ;2nd
    .byte 8, 16, %00000011, 0 ;3rd
    .byte 8, 17, %00000011, 8 ;4th

player_sprites_flip:
    .byte 0, 1,  %01000011, 0 ;1st
    .byte 0, 0,  %01000011, 8 ;2nd
    .byte 8, 17, %01000011, 0 ;3rd
    .byte 8, 16, %01000011, 8 ;4th


;--------------
; CONSTANTS
    ZERO_SPRITE                 = $0200
    FIRST_SPRITE                = $0204

    ;possible game states
    STATE_TITLE                = 0
    STATE_GAME                 = 1
    STATE_MENU                 = 2
    STATE_GAME_OVER            = 3
    STATE_INTRO                = 4
    STATE_OUTRO                = 5

    BUTTON_RIGHT_MASK           = %00000001
    BUTTON_LEFT_MASK            = %00000010
    BUTTON_DOWN_MASK            = %00000100
    BUTTON_UP_MASK              = %00001000

    BUTTON_START_MASK           = %00010000

    BUTTON_B_MASK               = %01000000
    BUTTON_A_MASK               = %10000000

    NPC_MAX_COUNT              = 16

    PROJECTILE_MAX_COUNT       = 4

    NPC_SPEED                  = 1

    MAX_SPRITE_COUNT           = 64

    MAX_V_SCROLL               = 255

    ANIM_FRAME_BLOODSTAIN      = $B8

    MAX_QUEST                  = 4


    NUM_OF_BUNNIES_BEFORE_DOG  = 3



    INTRO_SCENE_MAX            = 7
    OUTRO_SCENE_MAX            = 4


    HOURS_MAX                  = 240
    MINUTES_MAX                = 60
    SLEEP_TIME                 = 60
    COOKING_TIME               = 5
    CRAFTING_TIME              = 6

    PLAYER_ATTACK_DELAY        = 16

    INPUT_DELAY                = 100
    ITEM_DELAY                 = 66
    NPC_AI_DELAY               = 133
    NPC_COLLISION_DELAY        = 250
    FISHING_DELAY              = 2
    STAMINA_DELAY              = 5
    NPC_ELIMINATION_DELAY      = 200

    COLLISION_MAP_SIZE         = 120 ; 4 columns * 30 rows
    COLLISION_MAP_COLUMN_COUNT = 4
    COLLISION_MAP_COLUMN_SIZE  = 8

    PLAYER_COLLISION_LINE_X1    = 3
    PLAYER_COLLISION_LINE_X2    = 13 ;16 - 3
    PLAYER_COLLISION_LINE_Y1    = 8
    PLAYER_WIDTH                = 16
    PLAYER_STAMINA_SIZE         = 128

    MAX_TILE_SCROLL_LEFT       = 248; -8
    MAX_TILE_SCROLL_RIGHT      = 8


    ENTRY_POINT_COUNT          = 14

    SLEEP_POS_X                = 100
    SLEEP_POS_Y                = 72

    SLEEP_ADD_HP_TIMES_TEN     = 3
    SLEEP_SUB_HP_HUNGER_TT     = 5
    SLEEP_SUB_HP_COLD_TT       = 5

    WARMTH_NIGHT_DECREASE      = 5
    WARMTH_DAY_DECREASE        = 1
    WARMTH_COOKING_INCREASE    = 9
    WARMTH_CRAFTING_INCREASE   = 9

    PALETTE_STATE_FADE_OUT     = 1
    PALETTE_STATE_FADE_IN      = 2
    PALETTE_STEP               = $10
    PALETTE_SIZE_MAX           = 32
    PALETTE_FADE_MAX_ITERATION = 5


    OUTDOORS_LOC1_SCREEN_COUNT = 4
    OUTDOORS_LOC2_SCREEN_COUNT = 2
    OUTDOORS_LOC3_SCREEN_COUNT = 2
    OUTDOORS_LOC7_SCREEN_COUNT = 2
    PLAYER_START_X             = $50
    PLAYER_START_Y             = 200


    SCREEN_ROW_COUNT           = 30

    CHARACTER_ZERO             = $30

    MAX_WARMTH_DELAY           = $40
    MAX_FOOD_DELAY             = $60
    MAX_FUEL_DELAY             = $55

    DECREMENT_FOOD_DEFAULT     = $3

    FIRE_ANIMATION_DELAY       = $20

    COOKING_FUEL_COST          = 5


    INVENTORY_SPRITE_X         = 32
    INVENTORY_SPRITE_MIN_Y     = 68
    INVENTORY_SPRITE_MAX_Y     = 188
    INVENTORY_POINTER_X        = 14
    INVENTORY_STEP_PIXELS      = 12
    BASE_MENU_MIN_Y            = 63  ;pointer position in base action menu
    MENU_ITEM_GRID_ADDRESS     = $03 ; y: 9 * 8
    MENU_TITLE_ADDRESS         = $81
    MENU_ITEM_SPRITE_MIN_Y     = 56
    MENU_SUBMENU_ADDRESS_LOW   = $47
    MENU_SUBMENU_POINTER_X     = 64
    MENU_SUBMENU_POINTER_MIN_Y = 96
    MENU_CRAFT_POINTER_POS     = 58

    ITEM_TYPE_FOOD             = 1
    ITEM_TYPE_FUEL             = 2
    ITEM_TYPE_MEDICINE         = 3
    ITEM_TYPE_MATERIAL         = 4
    ITEM_TYPE_TOOL             = 5
    ITEM_TYPE_CLOTHING         = 6

    ITEM_RAW_MEAT              = 2
    ITEM_COOKED_MEAT           = 3
    ITEM_ROWAN_BERRIES         = 4
    ITEM_JAM                   = 5
    ITEM_SPEAR                 = 7
    ITEM_KNIFE                 = 8
    ITEM_POOP                  = 9
    ITEM_HIDE                  = 10
    ITEM_COAT                  = 11
    ITEM_RAW_JUMBO_MEAT        = 12
    ITEM_COOKED_JUMBO_MEAT     = 13
    ITEM_FISHING_ROD           = 15
    ITEM_RAW_FISH              = 17
    ITEM_COOKED_FISH           = 18
    ITEM_RADIO                 = 19
    ITEM_HAMMER                = 20
    ITEM_WOOD_HAMMER           = 21
    ITEM_SLINGSHOT             = 22

    SPEAR_SPEED                = 3

    ITEM_COUNT_LOC1            = 7
    ITEM_COUNT_LOC2            = 5
    ITEM_COUNT_LOC3            = 3

    ITEM_NEVER_BEEN_PICKED     = 255

    ITEM_RESPAWN_HOURS         = 90

    ITEM_MAX_HP                = 100

    INVENTORY_MAX_ITEMS        = 10
    INVENTORY_MAX_SIZE         = INVENTORY_MAX_ITEMS * 2

    PROJECTILE_DIR_UP          = 1
    PROJECTILE_DIR_DOWN        = 2
    PROJECTILE_DIR_LEFT        = 3
    PROJECTILE_DIR_RIGHT       = 4

    TOOL_WEAR                  = 10

    NPC_STEPS_BEFORE_REDIRECT  = 16

    NPC_DELAY_ATTACK           = 64
    NPC_DELAY_DAMAGED          = 32

    NPC_ATTACK_FRAME           = 128

    NPC_STATE_DAMAGED          = 3
    NPC_STATE_ATTACK           = 2

    NPC_TYPE_TIMID             = 0
    NPC_TYPE_PREDATOR          = 1
    NPC_TYPE_VILLAGER          = 2

    DIALOG_TEXT_LENGTH         = 96

    RECIPES_SIZE               = 33

    ROT_AMOUNT_RAW_MEAT        = 50
    ROT_AMOUNT_COOKED_MEAT     = 25

    FISHING_CATCH_OFFSET_Y     = 18
    FISHING_BITE_TIMER_MAX     = 15

    CLOTHING_DAMAGE_BY_NPC     = 10

    FADE_DELAY_GAME_OVER       = 3
    FADE_DELAY_GENERIC         = 2
    FADE_DELAY_SLEEP           = 10
    MAX_VILLAGERS              = 2

    MAX_LOCATIONS              = 6

    SUBMENU_FOOD               = 1
    SUBMENU_STASH_FOOD         = 2
    SUBMENU_ITEM               = 3
    SUBMENU_STASH_ITEM         = 4
    SUBMENU_MATERIAL           = 5
    SUBMENU_STASH_MATERIAL     = 6
    SUBMENU_TOOL               = 7
    SUBMENU_STASH_TOOL         = 8

;===================================================================
.segment "ZEROPAGE"
current_bank: ;active bank
    .res 1
oldbank:
    .res 1
bankBeforeNMI: ;bank that was active before NMI, so it could be set back
    .res 1
pointer:
    .res 2
TextPtr:
    .res 2
DigitPtr:
    .res 2
MapPtr:
    .res 2
IntroSpritePtr:
    .res 2
IntroSpriteCoordPtr:
    .res 2
pointer2:
    .res 2
PalettePtr:
    .res 2
collisionMapPtr:
    .res 2
AnimalSpawnPointsPtr:
    .res 2

tmpAttribAddress:
    .res 1

InputUpdateDelay:
    .res 1
CutsceneDelay:
ItemUpdateDelay:
    .res 1
NpcAIUpdateDelay:
    .res 1
NpcCollisionDelay:
    .res 1
StaminaDelay:
    .res 1
NpcEliminationDelay:
    .res 1
PaletteUpdateSize:
    .res 1
RamPalette:
    .res 32
TempPalette: ;to store the modified outdoors palette
    .res 32
PaletteAnimDelay:
    .res 1
DigitChangeSize: ;dedicated byte for Decrease/IncreaseDigits, because I can
    .res 1
LastDigit:
    .res 1
TempDigit:
    .res 1


Buttons:
    .res 1
ButtonsP3:
    .res 1
OldButtons:
    .res 1
MenuButtons:
    .res 1
PPUCTRL: ;PPU control settings
    .res 1
GameState:
    .res 1
InputProcessed:
    .res 1
NMIActive:
    .res 1
NMINotFinished: ;to figure if another nmi called during nmi :/
    .res 1
MustUpdatePalette: ;flag that signals the palette update
    .res 1
MustUpdateDestructables:
    .res 1

HP:
    .res 3
HpUpdated:
    .res 1

Food:
    .res 3
FoodUpdated:
    .res 1

Warmth:
    .res 3
WarmthUpdated:
    .res 1
MustLoadSomething:
    .res 1
MustLoadOutside:
    .res 1
MustPlayNewSong:
    .res 1
SongName:
    .res 1
IsLocationRoutine:
    .res 1
ActiveMapEntryIndex:
    .res 1

FlickerFrame: ;variable for alternating sprite update routines to achieve flickerine
    .res 1

ZPBuffer:
    .res 120  ; I want to be aware of the free memory

;--------------
.segment "BSS" ; variables in ram

CurrentPaletteDecrementValue: ;a helper value to prevent doing too much of palette changing
    .res 1

OldGlobalScroll:
    .res 1
GlobalScroll:
    .res 1

GlobalScrollY:
    .res 1

CurrentMapSegmentIndex: ;starting screen
    .res 1
MustIncrementScreenIndex:
    .res 1
MustDecrementScreenIndex:
    .res 1

ScreenCount:
    .res 1

BgColumnIdxToUpload: ; index of a column to be uploaded
    .res 1

AttribColumnIdxToUpdate:
    .res 1


DestScreenAddr: ; higher byte of destination screen to upload columns
    .res 1

FirstNametableAddr: ; will store adresses in ram they will be filpped
    .res 1
SecondNametableAddr:
    .res 1

LeftCollisionMapIdx:
    .res 1
RightCollisonMapIdx:
    .res 1




TilesScroll:
    .res 1
OldTileScroll:
    .res 1
ScrollDirection:
    .res 1
OldScrollDirection:
    .res 1


NametableAddress:
    .res 1

OldPlayerX:
    .res 1
OldPlayerY:
    .res 1

PlayerX:
    .res 1
PlayerY:
    .res 1

SnowDelay:
PlayerSpeed:
    .res 1

PlayerAnimationRowIndex: ;which animation row to use for player sprites at the moment
    .res 1
WalkTimer:
    .res 1
AttackTimer:
    .res 1
NpcsHitByPlayer:
    .res 1
PlayerFrame:
    .res 1
PlayerFlip:
    .res 1

SnowFrame:
Stamina:
    .res 1
FoodToStamina:
    .res 1
StaminaSpritetempx:
    .res 1
StaminaSpritePos:
    .res 1
StaminaSpriteOffset:
    .res 1

DirectionX:
    .res 1
DirectionY:
    .res 1



RandomNumber:
    .res 1

FishingRodActive:
    .res 1
FishBiteTimer:
    .res 1
FishingWaitTimer:
    .res 1
FishingDelay:
    .res 1
FishBiteDuration:   ;for how long a fish will bite
    .res 1

SpearActive:
    .res 1
SpearScreen:
    .res 1
SpearX:
    .res 1
SpearY:
    .res 1
SpearDir:
    .res 1

;attack square
AttackTopLeftX:
    .res 1
AttackTopLeftY:
    .res 1
AttackBottomRightX:
    .res 1
AttackBottomRightY:
    .res 1
;--
FireFrame:  ;an animation frame of fire in the fireplace
    .res 1
FireFrameDelay:
    .res 1



Fuel:       ;how much fuel you have at home in the fireplace
    .res 3

Days:
    .res 3
Minutes:
    .res 1
Hours:
    .res 1

FirstTime: ;entered the house for the firt time
    .res 1

EquipedItem:
    .res 2   ;item index + hp
EquipedClothing:
    .res 2

ItemIGave:
    .res 1  ;item index i gave to villager

Inventory:
    .res INVENTORY_MAX_SIZE

Storage:
    .res INVENTORY_MAX_SIZE

InventoryPointerY:
    .res 1
InventoryPointerX:
    .res 1
OldInventoryPointerY:
    .res 1
FoodMenuIndex: ; COOK OR EAT ?
    .res 1
ItemMenuIndex: ; USE or STORE ?
    .res 1
InventoryItemIndex:
    .res 1

BaseMenuIndex: ; INVENTORY OR SLEEP ?
    .res 1

WarmthDelay:
    .res 1
FoodDelay:
    .res 1
FuelDelay:
    .res 1


PlayerAlive:
    .res 1
PlayerWins:
    .res 1

InHouse:    ;is the player inside his hut?
    .res 1

InCave:
    .res 1

InVillagerHut:
    .res 1

VillagerIndex:
    .res 1

ActiveVillagerQuests:
    .res MAX_VILLAGERS


CollisionMap:
    .res COLLISION_MAP_SIZE

ScrollCollisionColumnRight:  ;column of data from next collision screen
    .res SCREEN_ROW_COUNT
ScrollCollisionColumnLeft:
    .res SCREEN_ROW_COUNT


LeftCollisionColumnIndex:
    .res 1
RightCollisionColumnIndex:
    .res 1

TimesShiftedLeft:
    .res 1
TimesShiftedRight:
    .res 1


MustSleepAfterFadeOut:
    .res 1
MustUpdateTextBaloon:
    .res 1
TextBaloonIndex:
    .res 1
TextLength:
    .res 1


MustCopyMainChr:
    .res 1


MustLoadHouseInterior:
    .res 1

MustLoadMenu:
    .res 1
MustLoadTitle:
    .res 1
MustLoadTitleCHR:
    .res 1
MustLoadGameOver:
    .res 1
MustLoadIntro:
    .res 1
MustLoadIntroChr:
    .res 1
MustLoadOutro:
    .res 1
MustDrawMenuTitle:
    .res 1

MustLoadGameOverAfterFadeOut:
    .res 1

MustShowOutroAfterFadeout:
    .res 1

MustShowTitleAfterFadeout:
    .res 1

MustDrawInventoryGrid:
    .res 1
MustDrawEquipmentGrid:
    .res 1
MustDrawFoodMenu:
    .res 1
MustDrawItemMenu:
    .res 1
MustDrawMaterialMenu:
    .res 1
MustDrawStashItemMenu:
    .res 1
MustDrawStashFoodMenu:
    .res 1
MustDrawStashMaterialMenu:
    .res 1
MustDrawToolMenu:
    .res 1
MustDrawStashToolMenu:
    .res 1
MustClearSubMenu:
    .res 1
MustRestartIndoorsMusic:
    .res 1
;--

PlayerInteractedWithStorage:
    .res 1
PlayerInteractedWithBed:
    .res 1
PlayerInteractedWithFireplace:
    .res 1
PlayerInteractedWithTooltable:
    .res 1

MustExitMenuState: ;if you want to exit the menu state when in bank1
    .res 1


MenuUpperLimit:
    .res 1
MenuLowerLimit:
    .res 1
MenuStep:
    .res 1
MenuMaxItem:
    .res 1


InventoryActivated:
    .res 1
SubMenuIndex:
    .res 1
SubMenuActivated:
    .res 1

StashActivated:
    .res 1
CraftingActivated:
    .res 1
EquipmentActivated:
    .res 1

CraftingIndexes:
    .res 2; item index A + index B
CurrentCraftingComponent:
    .res 1


PaletteFadeAnimationState:
    .res 1; 0 - nothing, 1 - fade-out, 2 - fade-in
PaletteFadeTimer:
    .res 1
FadeIdx:
    .res 1

CutsceneSceneIdx:
    .res 1

CutsceneTimer:
    .res 1

CutsceneSpriteCount:
    .res 1

CutsceneMetaspriteCount:
    .res 1
CutsceneMetaspriteIndex:
    .res 1

CutsceneSprite1X:
    .res 1
CutsceneSprite1Y:
    .res 1
CutsceneSprite2X:
    .res 1
CutsceneSprite2Y:
    .res 1

CutsceneSpriteAnimFrame:
    .res 1

CarrySet:
    .res 1

KilledNpcScreenIdx:
    .res 1

PrevItemMapScreenIndex:
    .res 1
NextItemMapScreenIndex:
    .res 1
ItemMapScreenIndex:
    .res 1

LocationIndex:
    .res 1

DamagedPaletteMask:
    .res 1

Temp:
    .res 1
TempX:
    .res 1
TempY:
    .res 1
TempZ:
    .res 1
TempPush:
    .res 1
TempPointX:
    .res 1
TempPointY:
    .res 1
TempIndex:
    .res 1
TempRegX:
    .res 1

TempAnimIndex:
    .res 1

;inventory temps
TempTileIndex:
    .res 1
TempTileIndexOffset:
    .res 1
TempTileYPos:
    .res 1
TempPaletteIndex:
    .res 1
TempInventoryIndex:
    .res 1
TempSpriteIdx:
    .res 1
TempDir:
    .res 1
TempFrame:
    .res 1
TempNpcIndex:
    .res 1
TempYOffset:
    .res 1
TempNpcType: ;temp value of an npc, if it's a predator or not
    .res 1
TempNpcDataIndex: ;to look it up in npc_data
    .res 1
TempNpcState: ;attacking or idle
    .res 1
TempNpcTimer:
    .res 1
TempNpcRows:
    .res 1
TempFrameOffset:
    .res 1
TempPointX2:
    .res 1
TempPointY2:
    .res 1
TempHp:
    .res 1
TempSpearX:
    .res 1

TempInventoryItemIndex: ; used by "RotFood"
    .res 1
RotAmount:
    .res 1          ;         "RotFood"

TempTextAddress:
    .res 1
TempTextAddressLow:
    .res 1

TempPlayerAttk:
    .res 1
                ;for npc collision
NewNpcX:
    .res 1
NewNpcY:
    .res 1
NewNpcScreen:
    .res 1

NpcXPosition: ;x coordinate position in ram
    .res 1
PlayerCenterY:
    .res 1

DropedItemX: ;x coordinate of item droped by npc
    .res 1


SpritesUpdated:
    .res 1
;----
TempItemIndex:
    .res 1
TempSpriteCount: ; count of active sprites
    .res 1
TempNpcCnt:
    .res 1
TempItemScreen:
    .res 1
;--

TempItemLoadY:
    .res 1
TempItemLoadX:
    .res 1

TempEliminationDest:
    .res 1
TempNpcGenerationIdx:
    .res 1

TempPlayerSpriteIdx:
    .res 1

TempNpcCollisionXReg:
    .res 1

FarOffNpcScreen:
    .res 1
;----------
ParamTimeValue:
    .res 1

MustRedir: ; the current npc must change direction
    .res 1

TempScreenNpcCount:
    .res 1

DogCounter: ; used for canid generation
    .res 1

Items:   ;items that lies in the map
    .res 80 ; max 20 items * 4 bytes
            ;(item index(7 bits) + active(1 bit),
            ; screen_index
            ; x,
            ; y)
ItemCount:
    .res 1

Item_Location1_Collection_times:
    .res ITEM_COUNT_LOC1
Item_Location2_Collection_times:
    .res ITEM_COUNT_LOC2
Item_Location3_Collection_times:
    .res ITEM_COUNT_LOC3

Npcs:   ;animals and stuff
    .res 128 ; max 16 npcs * 8 bytes:
            ;   (npc type(6 bits) + state(2 bit, 0 - dead, 1 - alive, 2 - attacks, 3 - damaged),
            ;   x,
            ;   y,
            ;   screen_index
            ;   direction(0000(unused bits) 00(Vertical) 00(horizonatal))
            ;   frame
            ;   timer
            ;   hp
NpcCount:
    .res 1

Projectiles:
    .res 16 ;  4 bytes * 4 projectiles
            ;  direction(7bit) + state (1bit)
            ;  x
            ;  screen
            ;  y

ProjectileCount:
    .res 1

ProjectileIdx:
    .res 1

Destructables:
    .res 2  ;two destructables so far, 1 means destroyed

AttribHighAddress:
    .res 1
SourceMapIdx:
    .res 1

Buffer:
    .res 403  ;must see how much is still available

;====================================================================================

.macro bankswitch
    sty current_bank      ; save the current bank in RAM so the NMI handler can restore it
    lda banktable, y      ; read a byte from the banktable
    sta banktable, y      ; and write it back, switching banks
.endmacro

.macro calculateItemMapScreenIndexes
    sta ItemMapScreenIndex
    clc
    adc #1
    sta NextItemMapScreenIndex
    sec
    sbc #2
    sta PrevItemMapScreenIndex
.endmacro



.segment "CODE"

bankswitch_y:
    sty current_bank      ; save the current bank in RAM so the NMI handler can restore it
bankswitch_nosave:
    lda banktable, y      ; read a byte from the banktable
    sta banktable, y      ; and write it back, switching banks 
    rts

reset:
    sei
    cld
    ldx #$40
    stx $4017    ; disable APU frame IRQ
    ldx #$FF
    txs          ; Set up stack
    inx          ; now X = 0
    stx $2000    ; disable NMI
    stx $2001    ; disable rendering
    stx $4010    ; disable DMC IRQs

vblankwait1:       ; First wait for vblank to make sure PPU is ready
    bit $2002
    bpl vblankwait1

clrmem:
    lda #$00
    sta $0000, x
    sta $0100, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    lda #$FE
    sta $0200, x
    inx
    bne clrmem

    lda #0
    sta NMINotFinished
    sta FlickerFrame


    ldy #6
    jsr bankswitch_y
    ldx #<sounds
    ldy #>sounds
    jsr famistudio_sfx_init

    ldx #<music_data_untitled
    ldy #>music_data_untitled
    lda #1
    jsr famistudio_init
    lda #2
    jsr famistudio_music_play

vblankwait2:      ; Second wait for vblank, PPU is ready after this
    bit $2002
    bpl vblankwait2

;---
    ldy #2
    bankswitch ;switching to Title/Game Over bank

    lda #<title_tiles_chr
    sta pointer
    lda #>title_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

    ldy #5
    bankswitch

    jsr LoadTitleData ; from bank 5

    lda #%10010000   ; enable NMI, sprites from Pattern Table 0
    sta PPUCTRL
    sta $2000
    
    lda #%00011110   ; enable sprites
    sta $2001


    lda #INPUT_DELAY
    sta InputUpdateDelay
    lda #ITEM_DELAY
    sta ItemUpdateDelay
    lda #NPC_AI_DELAY
    sta NpcAIUpdateDelay
    lda #NPC_COLLISION_DELAY
    sta NpcCollisionDelay
    lda #0
    sta MustLoadHouseInterior
    sta MustLoadSomething

    lda #$20
    sta FirstNametableAddr
    lda #$24
    sta SecondNametableAddr

    lda #1
    sta RightCollisonMapIdx
    lda #0
    sta LeftCollisionMapIdx

    lda #128
    sta RandomNumber

;---------------------------------

endlessLoop:

    lda MustLoadSomething
    bne nextIteration ; don't do logics until *something* is not loaded to the PPU

    dec InputUpdateDelay
    bne checkItems

    lda PaletteFadeAnimationState ; don't do input while fading
    bne skipInput

    jsr HandleInput
skipInput:
    jmp doSomeLogics

checkItems:
    lda GameState
    cmp #STATE_GAME
    bne nextIteration

    dec ItemUpdateDelay
    bne npcElimination

    jsr ItemCollisionCheck

npcElimination:
    dec NpcEliminationDelay
    bne npcAI

    jsr EliminateInactiveNpcs

npcAI:
    dec NpcAIUpdateDelay
    bne npcCollision

    jsr doNpcAI

npcCollision:
    dec NpcCollisionDelay
    bne doSomeLogics

    jsr PlayerHitsNpcs

doSomeLogics:

    jsr Logics

nextIteration:

    lda NMIActive
    beq ne

    jsr DoPaletteFades

    ;famistudio update
    ldy current_bank
    sty oldbank

    ldy #6
    bankswitch ; macro

    lda MustPlayNewSong
    beq doSoundUpdate

    lda SongName
    jsr famistudio_music_play
    lda #0
    sta MustPlayNewSong

doSoundUpdate:
    jsr famistudio_update

    ldy oldbank
    bankswitch

    lda GameState
    cmp #STATE_GAME
    bne checkMenuState
    jsr UpdateSprites
    jmp runrandom
checkMenuState:
    cmp #STATE_MENU
    bne checkIntro ; intro?

    lda MustExitMenuState
    beq updateInventory
exitMenu:
    jsr ExitMenuState
    lda #0
    sta MustExitMenuState
    jmp nextIteration
updateInventory:
    jsr UpdateInventorySprites
    jmp runrandom

checkIntro:
    cmp #STATE_INTRO
    bne checkOutro ; you win ?
    dec CutsceneDelay
    bne runrandom

    jsr doIntro
    jmp runrandom

checkOutro:
    cmp #STATE_OUTRO
    bne checkTitle ; some other state

    dec CutsceneDelay
    bne runrandom

    jsr doOutro
    jmp runrandom

checkTitle:
    cmp #STATE_TITLE
    bne hide_sprites

    jsr doTitle

hide_sprites:
    jsr HideSprites

runrandom:
    jsr UpdateRandomNumber




    lda #0
    sta NMIActive
ne:
    jmp endlessLoop

;=========================================================

nmi:
    ;push registers to stack
    pha
    tya
    pha
    txa
    pha
    ;---
    lda NMINotFinished
    bne transferOAM
    lda current_bank
    sta bankBeforeNMI
    lda #1
    sta NMINotFinished
transferOAM:
    ;copy sprite data
    ;lda SpritesUpdated
    ;beq startNMI
    lda #$00
    sta $2003        ; set the low byte (00) of the RAM address
    lda #$02
    sta $4014        ; set the high byte (02) of the RAM address, start the transfer
    ;---
startNMI:
    lda #1
    sta NMIActive

    ;read controller
    lda #$01
    sta $4016
    lda #$00
    sta $4016
    ldx #8
ReadControllerLoop:
    lda $4016
    lsr
    rol Buttons
    lsr             ;next bit from famicom's expansion port
    rol ButtonsP3
    dex
    bne ReadControllerLoop

    lda Buttons
    eor ButtonsP3 ;combine player3 input with player1
    sta Buttons


    lda #0
    sta InputProcessed

    lda MustLoadSomething
    beq DoneLoadingMaps

    jsr LoadBackgroundsIfNeeded

DoneLoadingMaps:
    lda GameState
    cmp #STATE_GAME
    bne UpdatePalette

    jsr UpdateTextBaloon
    lda MustUpdatePalette
    bne UpdatePalette

    jsr UpdateFireplace
    jsr UploadBgColumns
    jsr UpdateDestructableTiles
    jsr UpdateStatusDigits

UpdatePalette:
    lda MustUpdatePalette
    beq doneUpdatingPalette

    lda #0
    sta $2001
    lda $2002    ; read PPU status to reset the high/low latch
    lda #$3F
    sta $2006    ; write the high byte of $3F00 address
    lda #$00
    sta $2006    ; write the low byte of $3F00 address

    ; Set x to 0 to get ready to load relative addresses from x
    ldy #0
LoadPalettesLoop:
    lda RamPalette, y      ;load palette byte
    sta $2007             ;write to PPU
    iny                   ;set index to next byte
    cpy PaletteUpdateSize
    bne LoadPalettesLoop


    lda #0
    sta MustUpdatePalette


doneUpdatingPalette:

    ;This is the PPU clean up section, so rendering the next frame starts properly.
    lda PPUCTRL
    sta $2000
    lda #%00011110   ; enable sprites, enable background, no clipping on left side
    sta $2001

    lda #$00
    sta $2006        ; clean up PPU address registers
    sta $2006

    lda #$00         ; start with no scroll for status bar
    sta $2005
    sta $2005

    lda GameState
    cmp #STATE_GAME
    beq WaitNotSprite0
    cmp #STATE_INTRO
    beq justScroll
    cmp #STATE_OUTRO
    beq justScroll
    jmp endOfNmi

WaitNotSprite0:
    lda $2002
    and #%01000000
    bne WaitNotSprite0   ; wait until sprite 0 not hit

WaitSprite0:
    lda $2002
    and #%01000000
    beq WaitSprite0      ; wait until sprite 0 is hit

    ldx #219
WaitScanline:
    dex
    bne WaitScanline

justScroll:
    lda GlobalScroll
    sta $2005        ; write the horizontal scroll count register

    lda GlobalScrollY ; vertical scroll
    sta $2005

endOfNmi:
    lda PPUCTRL
    sta $2000

    lda current_bank
    cmp bankBeforeNMI
    beq noBankSwitch

    ldy bankBeforeNMI
    bankswitch

noBankSwitch:
    lda #0
    sta NMINotFinished
    pla
    tax
    pla
    tay
    pla

    rti        ; return from interrupt

;#############################| Subroutines |#############################################
.include "graphics.asm"
.include "collision.asm"
.include "items.asm"
.include "npcs.asm"
.include "LoadOutsideMap.asm"
.include "random.asm"
.include "menu.asm"
.include "IntroCode.asm"
.include "IndoorCode.asm"

;---------------------------------
doIntro:
    ldx CutsceneSceneIdx
    lda intro_scenes_delay, x
    sta CutsceneDelay

    ldy current_bank
    sty oldbank
    ldy #5
    bankswitch

    jsr IntroLogics
    jsr UpdateIntroSprites

    ldy oldbank
    bankswitch
    rts
;---------------------------------
doOutro:

    ldx CutsceneSceneIdx
    lda outro_scenes_delay, x
    sta CutsceneDelay

    ldy current_bank
    sty oldbank
    ldy #5
    bankswitch

    jsr OutroLogics
    jsr UpdateOutroSprites

    ldy oldbank
    bankswitch

    rts
;--------------------------------------
doTitle:

    ldy current_bank
    sty oldbank
    ldy #5
    bankswitch

    jsr TitleLogics

    ldy oldbank
    bankswitch

    rts
;--------------------------------------------
;copy chr tiles from ROM bank to a CHR RAM
;pointer -  sits at zero page, points to the chr data
CopyCHRTiles:

    ldy #0     ; starting index into the first page
    sty $2001  ; turn off rendering just in case
    sty $2006  ; load the destination address into the PPU
    sty $2006
    ldx #32      ; number of 256-byte pages to copy
@loop:
    lda (pointer),y  ; copy one byte
    sta $2007
    iny
    bne @loop  ; repeat until we finish the page
    inc pointer + 1  ; go to the next page
    dex
    bne @loop  ; repeat until we've copied enough pages
    rts

;--------------------------------------------
LoadBackgroundsIfNeeded:

    lda GameState
    cmp #STATE_MENU
    bne @next

    jsr UpdateMenuGfx   ; code from ROM1

@next:

    jsr LoadTitle
    jsr LoadGameOver
    jsr LoadIntro
    jsr LoadOutro
    jsr LoadMenu

    jsr LoadInteriorMap

    lda MustLoadOutside
    beq @exit
    jsr LoadOutsideMap

@exit:
    rts

;---------------------------------
ResetNameTableAdresses:

    lda #$20
    sta FirstNametableAddr
    lda #$24
    sta SecondNametableAddr

    lda PPUCTRL
    and #%11111110

    sta PPUCTRL


    rts


;----------------------------------
UpdateFireplace:

    lda InHouse
    beq @exit

    lda $2002
    lda #$21
    sta $2006
    lda #$0E
    sta $2006

    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    beq @putFireOut
    lda FireFrame
    asl
    sta Temp
    lda #$5C
    clc
    adc Temp
    sta $2007
    adc #1
    sta $2007
    jmp @exit
@putFireOut:
    lda #0
    sta $2007
    sta $2007

@exit:
    rts
;--------------------------------------------
UpdateDestructableTiles:

    ;lda MustUpdateDestructables
    ;bne @exit

    ldy #2
@loop:
    dey
    bmi @exit
    lda Destructables, y
    beq @loop

    tya
    asl
    asl
    asl
    tax
    lda destructable_tiles_list, x
    cmp LocationIndex
    bne @loop
    inx
    lda $2002
    lda destructable_tiles_list, x
    sta $2006
    inx
    lda destructable_tiles_list, x
    sta $2006

    lda #$EF
    sta $2007


    jmp @loop


    ;lda #0
    ;sta MustUpdateDestructables
@exit:
    rts

;--------------------------------------------
;Check and upload background columns from rom map to the PPU
UploadBgColumns:

    lda ScreenCount
    cmp #2
    bcc @exit

    lda LocationIndex
    asl
    asl
    tay

    lda SourceMapIdx
    cmp ScreenCount
    bcs @exit

    tya
    clc
    adc SourceMapIdx
    tay

    ;calculate source address

    lda map_list_low, y
    clc
    adc BgColumnIdxToUpload
    sta pointer
    lda map_list_high, y
    sta pointer + 1

@start:
    ;calculate source address
    lda #128 ; skip four rows
    clc
    adc BgColumnIdxToUpload
    sta pointer2
    lda DestScreenAddr
    sta pointer2 + 1
    

    lda #0
    sta $2001
    lda PPUCTRL
    eor #%00000100 ; add 32 to next ppu address mode
    sta $2000
    lda $2002
    lda pointer2 + 1
    sta $2006
    lda pointer2
    sta $2006

    ldx #SCREEN_ROW_COUNT - 5 ; skip two rows that are invisible anyway and 3 for HUD
    ldy #128  ;  skip four rows
@loop:
    lda (pointer), y
    sta $2007

    tya
    clc
    adc #32 ;increment the data index for the next value in column
    tay

    cpy #0
    bne @cont
    inc pointer + 1

@cont:
    dex
    bne @loop

    lda PPUCTRL ; restore normal ppu addressing
    sta $2000

;update attributes
    jsr UpdateAttributeColumn

@exit:
    rts
;--------------------------------------------
UpdateAttributeColumn:

    lda LocationIndex
    asl
    asl
    clc
    adc SourceMapIdx
    tay

    lda map_list_low, y
    clc
    adc #$C0
    sta pointer
    lda map_list_high, y
    adc #$3
    sta pointer + 1

@start:

    lda pointer
    clc
    adc AttribColumnIdxToUpdate
    sta pointer

    ldx #7 ;
    lda #$C0
    clc
    adc AttribColumnIdxToUpdate
    sta tmpAttribAddress
    lda DestScreenAddr
    clc
    adc #3
    sta AttribHighAddress
    ldy #0
    lda $2002
@attribLoop:
    lda AttribHighAddress
    sta $2006
    lda tmpAttribAddress
    sta $2006

    clc
    adc #8
    sta tmpAttribAddress

    lda (pointer), y
    sta $2007

    tya
    adc #8
    tay

    dex
    bne @attribLoop

    rts
;-----------------------------------
ActivateYouWin:
    lda PaletteFadeAnimationState
    bne @exit
    lda #1
    sta PaletteFadeAnimationState
    sta MustShowOutroAfterFadeout
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay
@exit:
    rts

;-----------------------------------
Logics:

    lda NMIActive
    beq @exit

    lda GameState
    cmp #STATE_GAME
    bne @exit

    lda PlayerAlive
    bne @cont
;----activate fading out for the game over
    lda MustLoadGameOver
    bne @doneLogics
    lda PaletteFadeAnimationState
    bne @cont
    lda #1
    sta PaletteFadeAnimationState
    sta MustLoadGameOverAfterFadeOut
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx
    lda #FADE_DELAY_GAME_OVER
    sta PaletteAnimDelay
;---
@cont:
    lda PlayerWins
    beq @cont2

    jsr ActivateYouWin

@cont2:

    jsr AnimateFire

    lda HP
    clc
    adc HP + 1
    adc HP + 2
    cmp #0
    beq @killPlayer
    jmp @checkFuel
@killPlayer:
    lda #0
    sta PlayerAlive
    jmp @doneLogics

@checkFuel:
    jsr DecreaseFuel
@checkWarmth:
    jsr WarmthLogics
@checkFood:
    jsr FoodLogics

    jsr RunTime

    jsr RestoreStamina


@doneLogics:

    jsr UpdateProjectiles
    jsr UpdateSpear
    jsr UpdateFishingRod

    lda AttackTimer
    beq @noAttack
    dec AttackTimer
    lda AttackTimer
    beq @hideAttackAnim
    jmp @noAttack
@hideAttackAnim:
    lda #1
    sta PlayerAnimationRowIndex
@noAttack:


    jsr CheckEntryPoints

@exit:

    rts
;------------------------------
RestoreStamina:

    lda FoodToStamina
    beq @convertfood ;we need to convert some food to stamina
    jmp @doRefill

@convertfood:

    lda Food
    clc
    adc Food + 1
    adc Food + 2
    cmp #0
    beq @exit ; can't convert food to stamina refill

    lda #<Food
    sta DigitPtr
    lda #>Food
    sta DigitPtr + 1
    lda #1
    sta DigitChangeSize
    jsr DecreaseDigits
    lda #1
    sta FoodUpdated
    lda #PLAYER_STAMINA_SIZE
    sta FoodToStamina


@doRefill:
    lda PlayerSpeed
    cmp #2
    beq @exit
    dec StaminaDelay
    bne @exit

    lda #STAMINA_DELAY
    sta StaminaDelay
    
    lda Stamina
    cmp #PLAYER_STAMINA_SIZE
    bcs @exit
    dec FoodToStamina
    inc Stamina


@exit:
    rts

;------------------------------
CheckEntryPoints:

    ldx #ENTRY_POINT_COUNT - 1
@entryPointLoop:


    txa
    asl
    asl
    asl
    asl
    tay

    lda MapEntryPoints, y ; location index
    cmp LocationIndex
    bne @nextEntry
    iny
    lda MapEntryPoints, y ; CurrentMapSegmentIndex
    cmp CurrentMapSegmentIndex
    bne @nextEntry
    iny             ;minX
    lda PlayerX
    cmp MapEntryPoints, y
    bcc @nextEntry
    iny             ;maxX
    cmp MapEntryPoints, y
    bcs @nextEntry
    lda GlobalScroll
    iny
    cmp MapEntryPoints, y
    bcc @nextEntry
    iny
    cmp MapEntryPoints, y
    bcs @nextEntry
    lda PlayerY
    iny             ;minY
    cmp MapEntryPoints, y
    bcc @nextEntry
    iny
    cmp MapEntryPoints, y
    bcs @nextEntry


    lda PaletteFadeAnimationState
    bne @exit


    ldy #0

    stx ActiveMapEntryIndex

    lda #1
    sta PaletteFadeAnimationState
    sta IsLocationRoutine

    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx

    jmp @exit


@nextEntry:
    dex
    bpl @entryPointLoop


@exit:
    rts


;-------------------------------
UpdateFishingRod:
    lda FishingRodActive
    beq @exit

    lda FishingDelay
    beq @runtimer

    dec FishingDelay
    bne @exit


@runtimer:
    lda #FISHING_DELAY
    sta FishingDelay
    lda FishingWaitTimer
    beq @animateBiting

    dec FishingWaitTimer
    bne @exit

@animateBiting:

    lda FishBiteDuration
    beq @exit

    dec FishBiteDuration
    bne @continueBiting

    lda #0
    sta FishBiteTimer
    jmp @exit

@continueBiting:
    inc FishBiteTimer
    lda FishBiteTimer
    cmp #FISHING_BITE_TIMER_MAX
    bcs @reset
    jmp @exit

@reset:
    lda #0
    sta FishBiteTimer



@exit:
    rts
;-------------------------------
UpdateProjectiles:

    ldy ProjectileCount
    beq @exit

    dey
    sta ProjectileIdx

@projectileLoop:
    lda ProjectileIdx
    asl
    asl
    tax

    lda Projectiles, x
    lsr
    bcc @next

@next:
    dec ProjectileIdx
    bpl @projectileLoop


@exit:
    rts
;-------------------------------
UpdateSpear:

    lda SpearActive
    beq @exit

    lda SpearDir
    cmp #PROJECTILE_DIR_LEFT
    bcc @otherDir

    beq @moveLeft

    lda SpearX
    cmp #255 - SPEAR_SPEED
    bcs @more

    clc
    adc #SPEAR_SPEED
    sta SpearX

    jmp @filter


@more:
    inc SpearScreen
    lda #255
    sec
    sbc SpearX
    sta Temp
    lda #SPEAR_SPEED
    sec
    sbc Temp
    sta SpearX

    jmp @filter

@moveLeft:

    jsr MoveSpearLeft


@filter:
    lda SpearScreen
    jsr CalcItemMapScreenIndexes

    lda ItemMapScreenIndex
    beq @skipPrev
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @disable
@skipPrev:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @disable

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @SpearMatchesScreen

    lda SpearX
    sec
    sbc GlobalScroll
    bcs @disable
    jmp @exit
@SpearMatchesScreen:
    lda SpearX ; x
    cmp GlobalScroll
    bcc @disable

@otherDir:

    jsr MoveSpearVerticaly
    cmp #1
    beq @disable

    jmp @exit

@disable:
    lda #0
    sta EquipedItem
    sta SpearActive


@exit:

    rts
;------------------------------
MoveSpearLeft:
    lda SpearX
    cmp #SPEAR_SPEED
    bcc @less

    sec
    sbc #SPEAR_SPEED
    sta SpearX
    jmp @exit

@less:
    dec SpearScreen
    lda #SPEAR_SPEED
    sec
    sbc SpearX
    sta Temp
    lda #255
    sec
    sbc Temp
    sta SpearX

@exit:

    rts
;------------------------------
MoveSpearVerticaly:
    cmp #PROJECTILE_DIR_DOWN
    bne @checkUp

    lda SpearY
    clc
    adc #SPEAR_SPEED
    sta SpearY
    cmp #252
    bcs @return_disable


@checkUp:
    cmp #PROJECTILE_DIR_UP
    bne @exit

    lda SpearY

    sec
    sbc #SPEAR_SPEED
    sta SpearY

    cmp #SPEAR_SPEED
    bcc @return_disable


    lda #0
    jmp @exit

@return_disable:
    lda #1


@exit:

    rts

;-------------------------------
DoPaletteFades:

    lda PaletteFadeAnimationState
    beq @exit

    inc PaletteFadeTimer
    lda PaletteFadeTimer
    cmp PaletteAnimDelay
    bcc @exit

    lda #0
    sta PaletteFadeTimer

    lda PaletteFadeAnimationState
    cmp #PALETTE_STATE_FADE_IN
    bne @incIndex

    dec FadeIdx
    ldx FadeIdx
    beq @resetFadeIn
    jmp @doFade
@resetFadeIn: ;finished fading in after sleep
    lda #0
    sta PaletteFadeAnimationState
    jmp @doFade

@incIndex:
    inc FadeIdx
    ldx FadeIdx
    cpx #PALETTE_FADE_MAX_ITERATION
    bcs @resetFadeState
    jmp @doFade
@resetFadeState:    ;finished fading out, let's call routines

    jsr RoutinesAfterFadeOut

    jmp @exit
@doFade:

    ldy #0
@paletteLoop:

    lda PaletteFadeAnimationState
    cmp #PALETTE_STATE_FADE_OUT
    beq @OnFadeOut

    lda (PalettePtr), y
    sec
    sbc PaletteTransitions, x
    bcs @saveColor
    lda #$0F
    jmp @saveColor

@OnFadeOut:

    lda RamPalette, y
    sec
    sbc #PALETTE_STEP
    bcs @saveColor
    lda #$0F

@saveColor:
    sta RamPalette, y
    iny
    cpy #PALETTE_SIZE_MAX
    bne @paletteLoop


    lda #PALETTE_SIZE_MAX
    sta PaletteUpdateSize
    lda #1
    sta MustUpdatePalette

@exit:

    rts

;------------------------------
RoutinesAfterFadeOut:

    lda IsLocationRoutine
    bne @locationRoutines

    ;fade in after sleep
    lda MustSleepAfterFadeOut
    beq @next
    ldy current_bank
    sty oldbank
    ldy #3
    jsr bankswitch_y
    jsr DoSleep ; from bank 3
    ldy oldbank
    jsr bankswitch_y
    lda #0
    sta MustSleepAfterFadeOut
    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx
    rts

@next: ;game over
    lda MustLoadGameOverAfterFadeOut
    beq @nextYouWin
    lda #1
    sta MustLoadSomething
    sta MustLoadGameOver
    lda #0
    sta PaletteFadeAnimationState
    sta MustLoadGameOverAfterFadeOut
    rts

@nextYouWin:
    lda MustShowOutroAfterFadeout
    beq @showTitle

    lda #1
    sta MustLoadOutro
    sta MustLoadSomething
    sta MustLoadIntroChr
    lda #0
    sta PaletteFadeAnimationState
    sta MustShowOutroAfterFadeout

    ldy #5
    jsr bankswitch_y
    jsr InitOutro

    rts

@showTitle:

    lda MustShowTitleAfterFadeout
    beq @afterIntro

    lda #1
    sta MustLoadSomething
    sta MustLoadTitle
    sta MustLoadTitleCHR
    lda #%10010000
    sta PPUCTRL
    lda #0
    sta MustShowTitleAfterFadeout
    sta PaletteFadeAnimationState

    rts


@afterIntro:
    jsr StartGame
    rts

    ;---------------------------------------
@locationRoutines: ;location routines start here
    ;--some general location code----
    jsr CommonLocationRoutine
    ;-----------------------------
    ;Entered bear's hut
@next1:
    lda ActiveMapEntryIndex
    cmp #1
    bne @next2

    jsr GetPaletteFadeValueForHour
    cmp #$40
    bne @skip_night

    lda #<Hut_npcs_night
    sta pointer
    lda #>Hut_npcs_night
    sta pointer + 1
    jsr LoadNpcs

@skip_night:

    jsr ResetNameTableAdresses

    lda #0
    sta VillagerIndex
    sta GlobalScroll
    sta TilesScroll
    sta ScrollDirection

    lda #1
    sta MustRestartIndoorsMusic
    sta InVillagerHut
    ;------------------------------------
    ; load the outdoors of bear's hut
@next2:
    lda ActiveMapEntryIndex
    cmp #6
    bne @next3

    lda #0
    sta InVillagerHut

    lda #0
    sta TilesScroll

    lda #0
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta LeftCollisionMapIdx
    lda #3
    sta LeftCollisionColumnIndex
    jsr LoadLeftCollisionColumn
    lda #2
    sta RightCollisonMapIdx
    lda #0
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn


    lda #0
    sta CurrentMapSegmentIndex

    lda #0 ;hack
    sta GlobalScroll

    ;TODO: rework this
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight
    jsr PushCollisionMapRight

    lda #$B8 ;hack
    sta GlobalScroll

    jsr OnExitVillagerHut
    lda #1
    sta MustCopyMainChr

;--------------------------Second location
@next3:

    lda ActiveMapEntryIndex
    cmp #2
    bne @next4

    jsr ResetNameTableAdresses

    lda #0
    sta CurrentMapSegmentIndex

    lda #1
    sta RightCollisonMapIdx
    lda #0      ;load the first column
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex

    lda #0
    sta LeftCollisionMapIdx
    lda #0
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight
    ;--------------------------------------------
    ;Third location
@next4:

    lda ActiveMapEntryIndex
    cmp #3
    bne @next5

    lda #0
    sta CurrentMapSegmentIndex

    lda #1
    sta RightCollisonMapIdx
    lda #0      ;load the first column
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex

    jsr ResetNameTableAdresses

    lda #0
    sta LeftCollisionMapIdx
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight
    ;-----------------------------------------
    ;entered player's house
@next5:

    lda ActiveMapEntryIndex
    cmp #0
    bne @next6

    jsr ResetNameTableAdresses

    lda #1
    sta MustRestartIndoorsMusic
    sta InHouse
    ;---------------------------------------------
    ;Entering first location from second
@next6:

    lda ActiveMapEntryIndex
    cmp #4
    bne @next7

    lda #0
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta TilesScroll

    lda #OUTDOORS_LOC1_SCREEN_COUNT - 1
    sta CurrentMapSegmentIndex

    lda #4
    sta RightCollisonMapIdx
    lda #0
    sta RightCollisionColumnIndex

    lda #2
    sta LeftCollisionMapIdx
    lda #3
    sta LeftCollisionColumnIndex
    jsr LoadLeftCollisionColumn
    ;------------------------------------------------
    ;Outside of player's house
@next7:

    lda ActiveMapEntryIndex
    cmp #7
    bne @next8

    lda #0
    sta InHouse
    sta FirstTime

    lda #1
    sta MustLoadOutside
    sta MustCopyMainChr
    ;-----------------------------------------
@next8: ;third location exit to the 0

    lda ActiveMapEntryIndex
    cmp #5
    bne @next9

    lda #0
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta LeftCollisionMapIdx
    lda #3
    sta LeftCollisionColumnIndex
    jsr LoadLeftCollisionColumn
    lda #2
    sta RightCollisonMapIdx
    lda #0
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn

    lda #3
    sta CurrentMapSegmentIndex

    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft

    lda #7
    sta TilesScroll
    lda #103
    sta GlobalScroll


    lda #28
    sta BgColumnIdxToUpload
    lda #2
    sta ScrollDirection
    lda #1
    sta CurrentMapSegmentIndex
    ;------------------------------------------
    ;second villager
@next9:

    lda ActiveMapEntryIndex
    cmp #8
    bne @next10

    lda #1
    sta MustRestartIndoorsMusic
    sta InVillagerHut
    sta VillagerIndex

    lda #0
    sta CurrentMapSegmentIndex

    jsr ResetNameTableAdresses

    lda #0
    sta GlobalScroll
    sta TilesScroll
    sta ScrollDirection

    ;------------------------------------------
    ;second villager exit
@next10:

    lda ActiveMapEntryIndex
    cmp #9
    bne @next11

    lda #0
    sta InVillagerHut
    sta LeftCollisionMapIdx

    lda #1
    sta RightCollisonMapIdx

    lda #0      ;load the first column
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex


    lda #0 ;hack
    sta TilesScroll
    lda #1
    sta CurrentMapSegmentIndex

    ;TODO: rework this
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft

    lda #0
    sta CurrentMapSegmentIndex

    lda #57
    sta GlobalScroll

    lda #23
    sta BgColumnIdxToUpload
    lda #2
    sta ScrollDirection


    jsr OnExitVillagerHut
    lda #1
    sta TilesScroll
    sta MustCopyMainChr
;-------cave entrance
@next11:
    lda ActiveMapEntryIndex
    cmp #10
    bne @next12

    lda #1
    sta InCave
    lda #0
    sta CurrentMapSegmentIndex

    lda #1
    sta RightCollisonMapIdx
    lda #0
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex


    jsr ResetNameTableAdresses

    lda #0
    sta LeftCollisionMapIdx
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight

;crashsite from cave

@next12:

    lda ActiveMapEntryIndex
    cmp #11
    bne @next13


    lda #0
    sta CurrentMapSegmentIndex
    sta GlobalScroll
    sta TilesScroll

;cave from crashsite
@next13:

    lda ActiveMapEntryIndex
    cmp #12
    bne @next14

    lda #1
    sta InCave
    lda #0
    sta CurrentMapSegmentIndex

    lda #1
    sta RightCollisonMapIdx
    lda #0      ;load the first column
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex


    jsr ResetNameTableAdresses

    lda #0
    sta LeftCollisionMapIdx
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight

;location 2 from cave
@next14:
    lda ActiveMapEntryIndex
    cmp #13
    bne @next15


    lda #255
    sta LeftCollisionMapIdx

    lda #1
    sta RightCollisonMapIdx

    lda #0      ;load the first column
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255
    sta LeftCollisionColumnIndex


    lda #0 ;hack
    sta TilesScroll
    lda #1
    sta CurrentMapSegmentIndex

    ;TODO: rework this
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    jsr PushCollisionMapLeft
    
    lda #0
    sta CurrentMapSegmentIndex

    lda #24
    sta GlobalScroll

    lda #2
    sta ScrollDirection




@next15:

    lda #1
    sta MustLoadSomething ; activate location loading in NMI

    rts
;------------------------------
CommonLocationRoutine:

    lda #NUM_OF_BUNNIES_BEFORE_DOG
    sta DogCounter
    lda #0
    sta InCave
    sta IsLocationRoutine
    sta PaletteFadeAnimationState
    lda ActiveMapEntryIndex
    asl
    asl
    asl
    asl
    tax
    lda MapSpawnPoint, x
    sta PlayerX
    inx
    lda MapSpawnPoint, x
    sta PlayerY
    inx
    lda MapSpawnPoint, x
    sta LocationIndex
    inx
    lda MapSpawnPoint, x
    sta ScreenCount
    inx
    lda MapSpawnPoint, x
    sta pointer
    inx
    lda MapSpawnPoint, x
    sta pointer + 1
    stx TempRegX
    jsr LoadItems
    ldx TempRegX
    inx
    lda MapSpawnPoint, x
    cmp current_bank
    beq @continue
    tay
    bankswitch
@continue:
    inx
    lda MapSpawnPoint, x
    sta pointer
    inx
    lda MapSpawnPoint, x
    sta pointer + 1
    inx
    lda MapSpawnPoint, x
    bne @itsAnIndoorMap
    lda #1
    sta MustLoadOutside
    jmp @loadMapptr
@itsAnIndoorMap:
    lda #1
    sta MustLoadHouseInterior
@loadMapptr:
    inx
    lda MapSpawnPoint, x
    sta MapPtr
    inx
    lda MapSpawnPoint, x
    sta MapPtr + 1

@loadCollision:
    ldy #0
@collisionLoop:
    lda (pointer), y
    sta CollisionMap, y
    iny
    cpy #COLLISION_MAP_SIZE
    bne @collisionLoop

    inx

    lda #0
    sta NpcCount

    stx TempRegX
    lda MapSpawnPoint, x ;generated npc count
    sta TempScreenNpcCount
    beq @skipGeneration
    sta TempNpcCnt
    inx
    inx
    inx
    lda MapSpawnPoint, x
    sta TempIndex ; map segment for generator
    jsr GenerateNpcs
    inc TempIndex
    lda TempIndex
    cmp ScreenCount
    bcs @skipLoadingNpcs
    lda TempScreenNpcCount
    sta TempNpcCnt
    jsr GenerateNpcs
    jmp @skipLoadingNpcs ; we're generating, no need to load
@skipGeneration:
    ldx TempRegX
    inx
    lda MapSpawnPoint, x
    sta pointer
    inx
    lda MapSpawnPoint, x
    sta pointer + 1
    lda pointer
    cmp #0
    beq @checkAnother
    jmp @loadNpcs
@checkAnother:
    cmp pointer + 1
    beq @skipLoadingNpcs
@loadNpcs:
    jsr LoadNpcs
@skipLoadingNpcs:


    rts
;-------------------------------
OnExitVillagerHut:
    lda ItemIGave
    beq @exit
    lda #0
    sta ItemIGave
@incrementQuest:
    ldy VillagerIndex
    lda ActiveVillagerQuests, y
    clc
    adc #1
    cmp #MAX_QUEST
    bcc @saveQuestIndex

    lda #1 ; let's skip the very first quest
@saveQuestIndex:
    sta ActiveVillagerQuests, y
@exit:
    rts

;-------------------------------
;skips a time interval 
;specified by ParamTimeValue
SkipTime:
    lda Hours
    clc
    adc ParamTimeValue
    sta Hours
    bcs @increaseDays
    cmp #HOURS_MAX
    bcs @increaseDays
    jmp @exit

@increaseDays:
    lda Hours
    sec
    sbc #HOURS_MAX
    sta Hours
    jsr IncreaseDays
    jsr ResetTimesWhenItemsWerePicked

    lda #<Inventory
    sta pointer
    lda #>Inventory
    sta pointer + 1
    jsr RotFood

    lda #<Storage
    sta pointer
    lda #>Storage
    sta pointer + 1
    jsr RotFood

@exit:
    rts

;-------------------------------
RunTime:

    inc Minutes
    lda Minutes
    cmp #MINUTES_MAX
    bcc @exit

    
    lda #0
    sta Minutes
    inc Hours
    lda Hours
    cmp #HOURS_MAX
    bcc @adaptPalette
    lda #0
    sta Hours
    jsr ResetTimesWhenItemsWerePicked

    lda #<Inventory
    sta pointer
    lda #>Inventory
    sta pointer + 1
    jsr RotFood

    lda #<Storage
    sta pointer
    lda #>Storage
    sta pointer + 1
    jsr RotFood

    
    jsr IncreaseDays

@adaptPalette:
    lda PaletteFadeAnimationState
    bne @exit
    lda #<RamPalette
    sta PalettePtr
    lda #>RamPalette
    sta PalettePtr + 1
    jsr AdaptBackgroundPaletteByTime

@exit:
    rts
;-------------------------------
;PalettePtr - where to store the modified palette
AdaptBackgroundPaletteByTime:
    lda InHouse
    bne @exit
    lda InVillagerHut
    bne @exit

    ldy #$01 ;keeps the outline for the background objects

    lda InCave
    beq @calc ; if not in cave, we need to use lookup table to get certain fade level

    ldx #0 ; night time index
    lda palette_fade_for_periods, x
    jmp @cont

@calc:
    jsr GetPaletteFadeValueForHour
@cont:
    cmp CurrentPaletteDecrementValue
    beq @exit
    sta CurrentPaletteDecrementValue

@paletteLoop:
    lda main_palette, y ;palette from ROM
    sec
    sbc palette_fade_for_periods, x
    bcs @saveColor
    lda #$0F
@saveColor:
    sta (PalettePtr), y
    iny
    cpy #12 ;skip the last palette that's used for UI
    bne @paletteLoop

    lda #16
    sta PaletteUpdateSize
    lda #1
    sta MustUpdatePalette
@exit:
    rts

;-------------------------------
;loads palette fade value int A
GetPaletteFadeValueForHour:

    lda Hours
    lsr
    lsr
    lsr
    lsr
    tax
    lda palette_fade_for_periods, x

    rts
;-------------------------------
WarmthLogics:
    dec WarmthDelay
    lda WarmthDelay
    beq @resetWarmthDelay
    jmp @exit

@resetWarmthDelay:
    lda #MAX_WARMTH_DELAY
    sta WarmthDelay
    lda InHouse
    bne @increaseWarmth
    lda InVillagerHut
    bne @ignoreFuel
    jmp @decreaseWarmth
@increaseWarmth:
    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    beq @decreaseWarmth
@ignoreFuel: ; for other places than player's hut
    jsr IncreaseWarmth
    jmp @exit
@decreaseWarmth:
    jsr GetPaletteFadeValueForHour
    cmp #$40    ; is it night ?
    beq @nightFreeze
    lda #WARMTH_DAY_DECREASE
    jmp @saveTempDecrease
@nightFreeze:
    lda #WARMTH_NIGHT_DECREASE
@saveTempDecrease:
    sta DigitChangeSize
    lda EquipedClothing
    beq @cont
    lda DigitChangeSize
    cmp #1
    beq @makezero
    sec
    sbc #1
    jmp @cont
@makezero:
    lda #0
    sta DigitChangeSize
@cont:
    jsr DecreaseWarmth
    lda Warmth
    clc
    adc Warmth + 1
    adc Warmth + 2
    cmp #0
    beq @decreaseLifeBecauseCold
    jmp @exit
@decreaseLifeBecauseCold:
    jsr DecreaseLife

@exit:

    rts
;-------------------------------
FoodLogics:
    dec FoodDelay
    lda FoodDelay
    beq @resetFoodDelay
    jmp @exit

@resetFoodDelay:
    lda #MAX_FOOD_DELAY
    sta FoodDelay
    lda #<Food
    sta DigitPtr
    lda #>Food
    sta DigitPtr + 1
    lda #DECREMENT_FOOD_DEFAULT
    sta DigitChangeSize
    jsr DecreaseDigits
    lda #1
    sta FoodUpdated
    lda Food
    clc
    adc Food + 1
    adc Food + 2
    cmp #0
    beq @decreaseLifeBecauseHunger
    jmp @exit

@decreaseLifeBecauseHunger:
    jsr DecreaseLife

@exit:
    rts

;-------------------------------
DecreaseFuel:
    dec FuelDelay
    lda FuelDelay
    beq @resetFuelDelay
    jmp @exit
@resetFuelDelay:
    lda #MAX_FUEL_DELAY
    sta FuelDelay
    lda #<Fuel
    sta DigitPtr
    lda #>Fuel
    sta DigitPtr + 1
    lda #2
    sta DigitChangeSize
    jsr DecreaseDigits
@exit:
    rts

;-------------------------------
DecreaseLife:
    lda #<HP
    sta DigitPtr
    lda #>HP
    sta DigitPtr + 1
    lda #1
    sta DigitChangeSize
    jsr DecreaseDigits
    lda #1
    sta HpUpdated
    rts
;-------------------------------
IncreaseWarmth:
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    lda #3
    sta DigitChangeSize
    jsr IncreaseDigits
    lda #1
    sta WarmthUpdated
    rts
;-------------------------------
IncreaseDays:
    lda #<Days
    sta DigitPtr
    lda #>Days
    sta DigitPtr + 1
    lda #1
    sta DigitChangeSize
    jsr IncreaseDigits
    rts
;-------------------------------
DecreaseWarmth:
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    jsr DecreaseDigits

    lda #1
    sta WarmthUpdated
    rts

;---------------------------------------
AnimateWalk:
    lda AttackTimer
    bne @exit
    inc WalkTimer

    lda PlayerSpeed
    cmp #2
    beq @fastAnimation
    lda WalkTimer
    cmp #8
    bcc @exit
    lda #0
    sta WalkTimer
    jmp @cont
@fastAnimation:
    lda WalkTimer
    cmp #4
    bcc @exit
    lda #0
    sta WalkTimer

@cont:
    lda PlayerAnimationRowIndex
    clc
    adc #1
    cmp #4
    bcs @resetWalk
    jmp @saveWalk
@resetWalk:
    lda #0
@saveWalk:
    sta PlayerAnimationRowIndex
@exit:
    rts
;--------------------------------
AnimateFire:
    dec FireFrameDelay
    lda FireFrameDelay
    bne @exit
    lda #FIRE_ANIMATION_DELAY
    sta FireFrameDelay
    inc FireFrame
    lda FireFrame
    cmp #2
    bne @exit
    lda #0
    sta FireFrame
@exit:
    rts

;----------------------------------
HandleInput:

    jsr CheckStartButton

    lda GameState
    cmp #STATE_MENU
    bne @checkIfGame
    jsr MenuInput
    jmp @finishInput
@checkIfGame:
    cmp #STATE_GAME
    bne @finishInput

    lda Buttons
    beq @finishInput ; no input at all

    lda AttackTimer
    bne @finishInput ; attack pause

    lda InputProcessed
    bne @finishInput

    jsr CheckB

    lda Buttons
    and #%00001111
    beq @finishInput ; dpad is not being used

    lda FishingRodActive
    bne @continueInput ; don't animate walk while fishing

    jsr AnimateWalk

@continueInput:

    ;save the movement before collision check
    jsr BackupMovement
    
    ;gamepad button processing, the player could be moved here
    jsr ProcessButtons

    jsr IsPlayerCollidingWithNpcs
    bne @resetStuff


    ;first general check of newX and newY
    jsr CanPlayerGo
    beq @contInput; all good, no obstacles

    ;there might be some obstacles
    ;let's check with oldY instead
    lda DirectionY
    beq @thirdcheck

    jsr CanPlayerGoWithOldY
    bne @thirdcheck

    ;the obstacles are on the Y axis

    lda DirectionX
    beq @resetJustY

    lda #0
    sta PlayerFrame
@resetJustY:
    lda OldPlayerY
    sta PlayerY

    jmp @contInput

@thirdcheck:
    lda DirectionX
    beq @resetStuff

    ;let's check with oldX now
    jsr CanPlayerGoWithOldX
    bne @resetStuff

    ;the obstacles are on X axis
    jsr ResetPlayerXMovement

    jmp @contInput

@resetStuff:
    ;obstacle ahead, restore previous position
    jsr ResetPlayerXMovement
    lda OldPlayerY
    sta PlayerY

    jmp @finishInput

@contInput:
    jsr SwitchScreenIdxIfNeeded
    jsr PushCollisionMapIfNeeded


@finishInput:
    lda Buttons
    sta OldButtons

    jsr CalcMapColumnToUpdate
    jsr UpdateDestructableTilesCollision

    lda #INPUT_DELAY
    sta InputUpdateDelay
    rts

;Erase collision bits if tiles are destroyed
;--------------------------------
UpdateDestructableTilesCollision:

    lda GlobalScroll ;this will limit destructable tiles to the very first screen
    bne @exit

    ldy #2
@loop:
    dey
    bmi @exit
    lda Destructables, y
    beq @loop

    tya
    asl
    asl
    asl
    tax
    lda destructable_tiles_list, x
    cmp LocationIndex
    bne @loop


    inx
    inx
    inx

    lda destructable_tiles_list, x ; y
    sta TempY


    inx
    lda destructable_tiles_list, x ; x
    tax
    lda x_collision_pattern, x
    eor #%11111111 ; invert byte
    sta Temp
    txa 
    lsr
    lsr
    lsr ; divide x by 8 again
    clc
    adc TempY
    adc TempY
    adc TempY
    adc TempY
    tax
    lda CollisionMap, x
    and Temp
    sta CollisionMap, x

    jmp @loop

@exit:
    rts

;--------------------------------
BackupMovement:

    lda PlayerX
    sta OldPlayerX

    lda PlayerY
    sta OldPlayerY

    lda GlobalScroll
    sta OldGlobalScroll

    lda TilesScroll
    sta OldTileScroll

    lda ScrollDirection
    sta OldScrollDirection

    rts
;--------------------------------
SwitchScreenIdxIfNeeded:
    lda MustIncrementScreenIndex
    beq @checkDecrement
    inc CurrentMapSegmentIndex
    jsr FlipStartingNametable
    lda #0
    sta MustIncrementScreenIndex

    lda TempScreenNpcCount
    sta TempNpcCnt
    lda CurrentMapSegmentIndex
    clc
    adc #1
    cmp ScreenCount
    bcs @exit
    sta TempIndex
    jsr GenerateNpcs

@checkDecrement:
    lda MustDecrementScreenIndex
    beq @exit
    
    dec CurrentMapSegmentIndex
    jsr FlipStartingNametable
    lda #0
    sta MustDecrementScreenIndex


    lda CurrentMapSegmentIndex
    cmp ScreenCount
    bcs @exit
    sta TempIndex
    lda TempScreenNpcCount
    sta TempNpcCnt
    jsr GenerateNpcs

@exit:
    rts
;--------------------------------
ResetPlayerXMovement:

    lda OldPlayerX
    sta PlayerX
    lda OldGlobalScroll
    sta GlobalScroll
    lda OldTileScroll
    sta TilesScroll
    lda OldScrollDirection
    sta ScrollDirection
    lda #0
    sta MustIncrementScreenIndex
    sta MustDecrementScreenIndex

    rts


;--------------------------------
PushCollisionMapIfNeeded:

    lda DirectionX
    cmp #2
    bne @checkAnother

    lda TilesScroll
    cmp #MAX_TILE_SCROLL_RIGHT
    bcc @checkAnother
    cmp #240
    bcs @checkAnother
    jsr PushCollisionMapLeft
    jmp @finishInput
@checkAnother:
    lda DirectionX
    cmp #1
    bne @finishInput

    lda TilesScroll
    cmp #10
    bcc @finishInput
    cmp #MAX_TILE_SCROLL_LEFT + 1
    bcs @finishInput
    jsr PushCollisionMapRight
@finishInput:

    rts
;--------------------------------
CalcMapColumnToUpdate:

    lda GlobalScroll
    lsr
    lsr
    lsr             ;GlobalScroll / 8
    cmp #16
    bcc @WriteToB
;Write to A
    sec
    sbc #16
    sta BgColumnIdxToUpload

;---
    lda ScrollDirection
    cmp #1
    beq @LeftDir
    lda #2
    jmp @SaveDir
@LeftDir:
    lda #0
@SaveDir:
    sta Temp
;---
    lda CurrentMapSegmentIndex
    clc
    adc Temp
    sta SourceMapIdx
    ldx FirstNametableAddr
    jmp @storeIdx
@WriteToB:
    clc
    adc #16
    sta BgColumnIdxToUpload
;---
    lda ScrollDirection
    cmp #1
    beq @LeftDir1
    lda #1
    jmp @SaveDir1
@LeftDir1:
    lda #255 ; -1 ?
@SaveDir1:
    sta Temp

;---
    lda CurrentMapSegmentIndex
    clc
    adc Temp
    sta SourceMapIdx
    ldx SecondNametableAddr

@storeIdx:
    stx DestScreenAddr

    lda BgColumnIdxToUpload
    lsr
    lsr
    sta AttribColumnIdxToUpdate ; attribute id, bg_column / 4

    rts
;--------------------------------
UpdateTextBaloon:

    lda MustUpdateTextBaloon
    beq @exit

    lda #$22
    sta TempTextAddress


    lda #$E0
    clc
    adc TextBaloonIndex
    bcc @continue

    inc TempTextAddress

@continue:
    sta TempTextAddressLow
    lda $2002
    lda TempTextAddress
    sta $2006
    lda TempTextAddressLow
    sta $2006

    ldy TextBaloonIndex

    lda (TextPtr), y
    sta $2007


    inc TextBaloonIndex
    lda TextBaloonIndex
    cmp TextLength
    bcs @done
    jmp @exit

@done:
    lda #0
    sta MustUpdateTextBaloon


@exit:
    rts


;--------------------------------
UpdateStatusDigits:

    lda #0
    sta $2001

    lda $2002
    lda #$20
    sta $2006
    lda #$55
    sta $2006

    lda Stamina
    beq @fail1
    lda #$F1
    sta $2007
    jmp @segment2

@fail1:
    lda #0
    sta $2007

@segment2:

    lda Stamina
    cmp #32
    bcc @fail2
    lda #$F1
    sta $2007
    jmp @segment3

@fail2:
    lda #0
    sta $2007

@segment3:
    lda Stamina
    cmp #64
    bcc @fail3

    lda #$F1
    sta $2007
    jmp @segment4

@fail3:
    lda #0
    sta $2007
@segment4:
    lda Stamina
    cmp #96
    bcc @fail4
    lda #$F1
    sta $2007
    jmp @Hp

@fail4:
    lda #0
    sta $2007

@Hp:
    lda HpUpdated
    beq @warmth

    lda $2002
    lda #$20
    sta $2006
    lda #$42
    sta $2006

    ldy #0
    sty HpUpdated
@HpLoop:
    lda #CHARACTER_ZERO
    clc
    adc HP, y
    sta $2007
    iny
    cpy #3
    bcc @HpLoop

@warmth:
    lda $2002
    lda #$20
    sta $2006
    lda #$50
    sta $2006


    lda WarmthUpdated
    beq @food

    ldy #0
    sty WarmthUpdated
@warmthLoop:
    lda #CHARACTER_ZERO
    clc
    adc Warmth, y
    sta $2007

    iny
    cpy #3
    bcc @warmthLoop

@food:
    lda FoodUpdated
    beq @exit

    lda $2002
    lda #$20
    sta $2006
    lda #$49
    sta $2006

    ldy #0
    sty FoodUpdated
@FoodLoop:
    lda #CHARACTER_ZERO
    clc
    adc Food, y
    sta $2007
    iny
    cpy #3
    bcc @FoodLoop

@exit:
    rts

;-----------------------------------
LoadStatusBar:
    ldy #$00
    ldx #128 ;tiles
    lda $2002
    lda #$20
    sta $2006
    lda #$00
    sta $2006
InitializeStatusBarLoop:     ; copy status bar to first nametable
    lda zerosprite, y
    sta $2007
    iny
    dex
    bne InitializeStatusBarLoop 

    lda #$00
    sta $2006
    sta $2006
    sta $2005
    sta $2005
    lda #1
    sta HpUpdated
    sta FoodUpdated
    sta WarmthUpdated
    rts

;--------------------------------------------

HideSprites:

    ldx #0

    ldy #64
@hideSpritesLoop:
    lda #$FE
    sta ZERO_SPRITE, x
    inx
    ;index
    inx
    ;attr
    inx
    ;x
    inx

    dey
    bne @hideSpritesLoop


    rts
;--------------------------------------------
LoadTitle:

    lda MustLoadTitle
    beq @exit

    lda MustLoadTitleCHR
    beq @loadJustData

    lda #2
    sta SongName
    lda #1
    sta MustPlayNewSong

    ldy #2
    jsr bankswitch_y

    lda #0
    sta $2000
    sta $2001

    lda #<title_tiles_chr
    sta pointer
    lda #>title_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

    lda #0
    sta MustLoadTitleCHR


@loadJustData:
    ldy #5
    jsr bankswitch_y

    lda #$00
    sta $2000
    sta $2001

    lda PPUCTRL
    and #%11111110
    sta PPUCTRL
    jsr LoadTitleData ; from bank 5

    lda #0
    sta MustLoadTitle
    sta MustLoadSomething
    sta MustUpdatePalette
@exit:
    rts
;-------------------------------------
LoadGameOver:
    lda MustLoadGameOver
    beq @exit

    lda #2
    sta SongName
    lda #1
    sta MustPlayNewSong

    ldy #2
    jsr bankswitch_y

    lda #0
    sta $2000
    sta $2001

    lda #%10000000
    sta PPUCTRL

    lda #<title_tiles_chr
    sta pointer
    lda #>title_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles


    lda #STATE_GAME_OVER
    sta GameState

    ldy #5
    bankswitch

    jsr LoadGameOverData ; from bank 5

    lda #0
    sta MustLoadGameOver
    sta MustLoadSomething


@exit:
    rts

;-------------------------------------
ResetEntityVariables:

    lda #1
    sta PlayerSpeed
    sta HP
    sta Warmth
    sta Food
    sta Fuel
    sta HpUpdated
    sta WarmthUpdated
    sta FoodUpdated

    lda #0
    sta ActiveVillagerQuests
    sta ActiveVillagerQuests + 1
    sta HP + 1
    sta HP + 2
    sta Warmth + 1
    sta Warmth + 2
    sta Food + 1
    sta Food + 2
    sta Fuel + 1
    sta Fuel + 2
    lda #PLAYER_STAMINA_SIZE
    sta Stamina

    lda #120
    sta Hours

    lda #0
    sta Minutes
    sta Days
    sta Days + 1
    sta Days + 2

    ldx #INVENTORY_MAX_SIZE
    dex
@clearInventoryLoop:
    sta Inventory, x
    sta Storage, x
    dex
    bpl @clearInventoryLoop

    sta CurrentMapSegmentIndex

    lda #OUTDOORS_LOC1_SCREEN_COUNT ;  screens in the outdoors map
    sta ScreenCount


    lda #BASE_MENU_MIN_Y
    sta InventoryPointerY
    lda #0
    sta InventoryItemIndex

    lda #MAX_WARMTH_DELAY
    sta WarmthDelay
    lda #MAX_FOOD_DELAY
    sta FoodDelay
    lda #MAX_FUEL_DELAY
    sta FuelDelay
    lda #FIRE_ANIMATION_DELAY
    sta FireFrameDelay
    lda #STAMINA_DELAY
    sta StaminaDelay

    lda #0
    sta NpcCount
    sta ProjectileCount
    sta PlayerWins
    sta FoodToStamina
    sta ItemIGave
    sta PaletteFadeAnimationState
    sta FadeIdx
    sta PaletteFadeTimer
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta BaseMenuIndex
    sta InHouse
    sta InCave
    sta InVillagerHut
    sta LocationIndex
    sta SpearActive
    sta FishBiteTimer
    sta FishingRodActive
    sta MustLoadGameOverAfterFadeOut
    sta EquipedClothing
    sta EquipedClothing + 1

    sta Destructables
    sta Destructables + 1

    lda #PLAYER_START_X
    sta PlayerX
    lda #PLAYER_START_Y
    sta PlayerY
    lda #1
    sta PlayerAlive
    sta PlayerFrame
    sta PlayerAnimationRowIndex

    lda #ITEM_KNIFE
    sta EquipedItem
    lda #ITEM_MAX_HP
    sta EquipedItem + 1

    lda #31
    sta BgColumnIdxToUpload

    lda #$20
    sta FirstNametableAddr
    lda #$24
    sta SecondNametableAddr

    lda #1
    sta RightCollisonMapIdx
    lda #0
    sta LeftCollisionMapIdx

    lda #255
    sta CurrentPaletteDecrementValue

    jsr ResetTimesWhenItemsWerePicked

    rts


;-------------------------------------
;Decrement digits from 100 to 000
;DigitChangeSize is the decrement
DecreaseDigits:

    ldy #2
    lda (DigitPtr), y
    cmp DigitChangeSize
    bcc @decreaseSecondDigit ; the last digit was less than Temp

    lda (DigitPtr), y
    sec
    sbc DigitChangeSize
    sta (DigitPtr), y
    jmp @exit
@decreaseSecondDigit:

    sta LastDigit ; store last digit that's less than Temp

    ;check first two digits
    ldy #1
    lda (DigitPtr), y
    sta TempDigit
    ldy #0
    lda (DigitPtr), y
    clc
    adc TempDigit
    cmp #0
    bne @cont

    ldy #2
    lda #0
    sta (DigitPtr), y
    jmp @exit
@cont:
    ldy #2
    lda DigitChangeSize
    sec
    sbc LastDigit
    sta DigitChangeSize
    lda #10
    sec
    sbc DigitChangeSize
    sta (DigitPtr), y

    ldy #1
    lda (DigitPtr), y
    beq @decreaseThirdDigit ; second digit is zero

    lda (DigitPtr), y
    sec
    sbc #1
    sta (DigitPtr), y
    jmp @exit
@decreaseThirdDigit:
    ldy #0
    lda (DigitPtr), y
    beq @exit
    lda (DigitPtr), y
    sec
    sbc #1
    sta (DigitPtr), y
    lda #9
    ldy #1
    sta (DigitPtr), y

@exit:
    rts

;-------------------------------------
;Increase stat number from 000 to 100
;DigitChangeSize is the number to increment
IncreaseDigits:
    ldy #0
    lda (DigitPtr), y
    bne @exit           ;the highest digit is not zero anymore, let's stop

    ldy #2

    lda (DigitPtr), y
    clc
    adc DigitChangeSize
    cmp #10
    bcs @increaseSecondDigit
    sta (DigitPtr), y
    jmp @exit
@increaseSecondDigit:
    sec
    sbc #10
    sta (DigitPtr), y

    ldy #1 ;second digit
    lda (DigitPtr), y
    cmp #9
    beq @increaseThirdDigit
    clc
    adc #1
    sta (DigitPtr), y
    jmp @exit
@increaseThirdDigit:
    lda #1
    ldy #0
    sta (DigitPtr), y
    lda #0
    ldy #1
    sta (DigitPtr), y
    ldy #2
    sta (DigitPtr), y

@exit:
    rts
;------------------------------------
ClearPalette:

    ldy #0
@paletteCopy:
    lda #$0F
    sta RamPalette, y
    iny
    cpy #32
    bne @paletteCopy
    lda #1
    sta MustUpdatePalette
    lda #32
    sta PaletteUpdateSize

    rts

;-------------------------------------
LoadIntro:

    lda MustLoadIntro
    beq @exit

    lda #0
    sta $2000
    sta $2001


    lda MustLoadIntroChr
    beq @loadScene

    ldy #2
    jsr bankswitch_y


    lda #<intro_tiles_chr
    sta pointer
    lda #>intro_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

@loadScene:

    ldy #5
    jsr bankswitch_y

    jsr LoadIntroScene ; from bank 5
@exit:
    rts
;-----------------------------------
LoadOutro:
    lda MustLoadOutro
    beq @exit

    lda #0
    sta $2000
    sta $2001

    lda MustLoadIntroChr
    beq @loadScene

    lda #2
    sta SongName
    lda #1
    sta MustPlayNewSong

    ldy #2
    jsr bankswitch_y


    lda #<intro_tiles_chr
    sta pointer
    lda #>intro_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

@loadScene:
    ldy #5
    jsr bankswitch_y

    jsr LoadOutroScene ; from bank 5

@exit:
    rts


;-------------------------------------
StartGame:
    ldy #0
    jsr bankswitch_y

    jsr ResetEntityVariables


    lda #<Outside1_items
    sta pointer
    lda #>Outside1_items
    sta pointer + 1
    jsr LoadItems

    lda #NUM_OF_BUNNIES_BEFORE_DOG
    sta DogCounter

    lda #3
    sta TempNpcCnt
    sta TempScreenNpcCount
    lda #0
    sta TempIndex
    jsr GenerateNpcs

    lda #1
    sta TempIndex
    lda #3
    sta TempNpcCnt
    jsr GenerateNpcs

    ldx #0
    jsr LoadCollisionMap
    jsr initZeroSprite
    lda #STATE_GAME
    sta GameState
    lda #1
    sta FirstTime
    sta MustLoadOutside
    sta MustLoadSomething
    sta MustCopyMainChr


    rts

;------------------------------
FadeOutToStartGame:
    lda #PALETTE_STATE_FADE_OUT
    sta PaletteFadeAnimationState
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx
    sta IsLocationRoutine
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay
    rts
;--------------------------------
FadeOutToGoToTitle:
    lda #PALETTE_STATE_FADE_OUT
    sta PaletteFadeAnimationState
    lda #1
    sta MustShowTitleAfterFadeout
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx
    sta IsLocationRoutine
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay
    rts



;-------------------------------------
CheckStartButton:

    lda Buttons
    and #BUTTON_START_MASK
    bne @checkOld
    jmp @exit
@checkOld:
    lda OldButtons
    and #BUTTON_START_MASK
    bne @exit


    lda GameState
    cmp #STATE_TITLE
    bne @someOtherState

    ;On title state------

    lda #1
    sta MustLoadSomething
    sta MustLoadIntro
    sta MustLoadIntroChr
    ldy #5
    jsr bankswitch_y

    jsr InitIntro ; from bank 5

    jmp @exit
@someOtherState: ; not title


    cmp #STATE_INTRO
    bne @checkGameOver

    jsr FadeOutToStartGame
    jmp @exit

@checkGameOver:
    cmp #STATE_GAME_OVER
    bne @CheckOutro
@goToTitle:
    lda #1
    sta MustLoadSomething
    sta MustLoadTitle

    lda #%10010000
    sta PPUCTRL

    jmp @exit
@CheckOutro:
    cmp #STATE_OUTRO
    bne @CheckOnGame
    lda #1
    sta MustLoadTitleCHR
    jmp @goToTitle
@CheckOnGame:
    cmp #STATE_GAME
    beq @enterMenuScreen
    ;exit menu screen

    jsr ExitMenuState
    jmp @exit
@enterMenuScreen:

    lda #1
    sta MustLoadMenu
    sta MustLoadSomething
    ldy #1
    jsr bankswitch_y


@exit:
    rts
;--------------------------------------
LoadCollisionMap:
@copyCollisionMapLoop:

    lda LocationIndex
    beq @location0
    lda bg2_collision, x
    jmp @start
@location0:
    lda bg_collision, x
@start:
    sta CollisionMap, x
    inx
    cpx #COLLISION_MAP_SIZE
    bne @copyCollisionMapLoop

    lda #0      ;load the first column
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255;-1
    sta LeftCollisionColumnIndex


    rts


;--------------------------------------

ProcessButtons:
    lda #0
    sta DirectionX
    sta DirectionY

    lda FishingRodActive
    bne @exit

    jsr CheckA ; speed up only active if dpad is used

;Check if LEFT is pressed
    jsr CheckLeft
;-----
;Check if RIGHT is pressed
@CheckRight:
    jsr CheckRight
;--------
;Check if UP is pressed
@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckDown

    lda #1
    sta DirectionY
    lda #1
    sta PlayerFrame

    lda PlayerY
    sec
    sbc PlayerSpeed
    sta PlayerY

@CheckDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @exit

    lda #2
    sta DirectionY
    lda #2
    sta PlayerFrame


    lda PlayerY
    clc
    adc PlayerSpeed
    sta PlayerY
@exit:
    lda #1
    sta InputProcessed

    rts
;----------------------------------
CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda Stamina
    beq @exit ; no stamina

    dec Stamina
    lda #2
    jmp @end

@exit:
    lda #1
@end:
    sta PlayerSpeed
    rts

;----------------------------------
CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    bne @checkOldB
    jmp @exit
@checkOldB:
    lda OldButtons
    and #BUTTON_B_MASK
    bne @exit

    lda InHouse
    beq @useForAttack

    jsr CheckBed
    bne @exit
    jsr CheckFireplace
    bne @exit
    jsr CheckStashBox
    bne @exit
    jsr CheckToolTable
    bne @exit

@useForAttack:

    lda SpearActive
    bne @exit

    lda AttackTimer
    bne @exit

    lda #4
    sta PlayerAnimationRowIndex

    lda EquipedItem
    cmp #ITEM_SPEAR
    bne @checkNext

    jsr LaunchSpear
    jmp @regularAttack
@checkNext:
    cmp #ITEM_SLINGSHOT
    bne @checkIfFishingRod

    jsr ShootSlingshot
    jmp @regularAttack

@checkIfFishingRod:
    cmp #ITEM_FISHING_ROD
    bne @checkhammer

    jsr ActivateFishingRod
    jmp @regularAttack
@checkhammer:
    cmp #ITEM_HAMMER
    beq @use_hammer
    cmp #ITEM_WOOD_HAMMER
    bne @regularAttack
@use_hammer:
    jsr useHammerOnEnvironment

@regularAttack:

    lda #PLAYER_ATTACK_DELAY
    sta AttackTimer
    lda #0
    sta NpcsHitByPlayer

    jsr PlayAttackSfx


@exit:

    rts
;----------------------------------
PlayAttackSfx:
    ldy current_bank
    sty oldbank
    ldy #6
    jsr bankswitch_y

    lda EquipedItem
    cmp #ITEM_HAMMER
    beq @hammer_sfx
    cmp #ITEM_WOOD_HAMMER
    bne @generic_sfx
@hammer_sfx:
    lda #3
    jmp @play_sfx
@generic_sfx:
    lda #1
@play_sfx:
    ldx #FAMISTUDIO_SFX_CH0
    jsr famistudio_sfx_play

    ldy oldbank
    jsr bankswitch_y
    rts
;----------------------------------
WearWeapon:

    lda EquipedItem
    beq @exit

    tay

    lda EquipedItem + 1
    cmp item_wear, y
    bcc @removeWeapon
    beq @removeWeapon
    sec
    sbc item_wear, y
    sta EquipedItem + 1
    jmp @exit

@removeWeapon:
    lda #0
    sta EquipedItem
    sta EquipedItem + 1
@exit:
    rts
;----------------------------------
useHammerOnEnvironment:
    ;TODO: copy paste code begins here

    ;let's check if I can throw there

    lda PlayerFrame
    beq @horizontal ;player is facing left or right

    lda PlayerX
    clc
    adc #4
    jmp @cont

@horizontal:
    lda PlayerFlip
    beq @left
    ;right
    lda PlayerX
    clc
    adc #20 ;two tiles and a half
    jmp @cont
@left:
    lda PlayerX
    sec
    sbc #4


@cont:
    clc
    adc GlobalScroll
    sta TempX
    bcs @mustIncrementScreen


    lda LocationIndex
    asl
    asl
    clc
    adc CurrentMapSegmentIndex
    tay ;store screen index to Y register
    jmp @continueCalc

@mustIncrementScreen:

    lda LocationIndex
    asl
    asl
    clc
    adc CurrentMapSegmentIndex
    clc
    adc #1
    tay; screen index goes to Y register
    sty TempPointY2 ; store screen index

@continueCalc:

    lda TempX ; x / 8
    lsr
    lsr
    lsr
    sta TempX

    lda PlayerFrame
    bne @vertical
    ;horizontal
    lda PlayerY
    clc
    adc #8
    jmp @divide
@vertical:
    cmp #1
    bne @down

    ;up
    lda PlayerY
    sec
    sbc #4
    jmp @divide

@down:

    lda PlayerY
    clc
    adc #20

@divide:
    ; y / 8
    lsr
    lsr
    lsr
    sta TempY


    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


@calcaddress:
    ldy TempY
    beq @skip
@addressLoop:

    lda pointer
    clc
    adc #32
    sta pointer
    bcs @incrementUpper
    jmp @nextRow
@incrementUpper:
    inc pointer + 1
@nextRow:
    dey
    bne @addressLoop
@skip:
    lda TempX
    tay

    lda (pointer), y

;--end of copy paste

    cmp #$F7
    bne @check_other_tiles

    lda EquipedItem
    cmp #ITEM_WOOD_HAMMER
    beq @check_other_tiles

    ldy #2
@destructable_loop:
    dey
    bmi @exit

    tya
    asl
    asl
    asl
    tax
    lda destructable_tiles_list, x
    cmp LocationIndex
    bne @destructable_loop
    inx
    inx
    inx
    lda destructable_tiles_list, x
    cmp TempY
    bne @destructable_loop
    inx
    lda destructable_tiles_list, x
    cmp TempX
    bne @destructable_loop


    lda #1
    sta Destructables, y


    ;TODO: update destructabe tiles
    lda #1
    sta MustUpdateDestructables
    jmp @exit

@check_other_tiles:
;rock
    lda (pointer), y
    cmp #$1C
    beq @spawn_rock
    cmp #$1D
    beq @spawn_rock
    cmp #$0C
    beq @spawn_rock
    cmp #$0D
    beq @spawn_rock
;wood
    jsr IsTree
    bne @spawn_wood
    jmp @exit
@spawn_rock:

    jsr WearWeapon

    jsr UpdateRandomNumber
    and #1
    bne @exit

    lda #%00001101
    sta Temp
    jsr SpawnItem
    jmp @exit
@spawn_wood:
    jsr WearWeapon
    jsr UpdateRandomNumber
    and #1
    bne @exit

    lda #%00000011
    sta Temp
    jsr SpawnItem


@exit:

    rts
;---------------------------------
IsTree:
    cmp #$0A
    beq @yes
    cmp #$0B
    beq @yes
    cmp #$1A
    beq @yes
    cmp #$1B
    beq @yes
    cmp #$2A
    beq @yes
    cmp #$2B
    beq @yes
    cmp #$87
    beq @yes
    cmp #$88
    beq @yes
    bne @nope
@yes:
    lda #1
    jmp @end
@nope:
    lda #0
@end:
    rts

;----------------------------------
;Temp is the item
SpawnItem:

    inc ItemCount
    lda ItemCount
    sec
    sbc #1
    asl
    asl
    tay

    lda Temp ; item id and hp are in Temp
    sta Items, y
    iny
    lda PlayerX
    adc GlobalScroll
    bcs @incrementScreen

    sta TempPointX

    lda CurrentMapSegmentIndex
    sta Items, y
    iny
    lda TempPointX
    sta Items, y
    iny
    lda PlayerY
    clc
    adc #FISHING_CATCH_OFFSET_Y
    sta Items, y

    jmp @exit
@incrementScreen:
    sta TempPointX

    lda CurrentMapSegmentIndex
    clc
    adc #1
    sta Items, y

    lda TempPointX
    sta Items, y
    iny
    lda PlayerY
    clc
    adc #FISHING_CATCH_OFFSET_Y
    sta Items, y

@exit:
    rts


;---------------------------------
ActivateFishingRod:

    lda FishingRodActive
    bne @pullout

    jsr CanCastRodHere
    bne @exit

@throwThere:

    jsr UpdateRandomNumber
    and #%01111111; 128
    clc
    adc #48

    sta FishingWaitTimer
    lda #FISHING_DELAY
    sta FishingDelay

    jsr UpdateRandomNumber
    and #%00001111 ; 16
    clc
    adc #18
    sta FishBiteDuration

    lda #0
    sta FishBiteTimer

    lda #1
    sta FishingRodActive
    jmp @exit

@pullout: ;-----pull the rod out---

    jsr PullOutRod

@exit:
    rts

;----------------------------------
;A -> 0 = can, 1 = can't
CanCastRodHere:
    ;let's check if I can throw there

    lda PlayerFrame
    beq @horizontal ;player is facing left or right

    lda PlayerX
    clc
    adc #4
    jmp @cont

@horizontal:
    lda PlayerFlip
    beq @left
    ;right
    lda PlayerX
    clc
    adc #20 ;two tiles and a half
    jmp @cont
@left:
    lda PlayerX
    sec
    sbc #4


@cont:
    clc
    adc GlobalScroll
    sta TempX
    bcs @mustIncrementScreen


    lda LocationIndex
    asl
    asl
    clc
    adc CurrentMapSegmentIndex
    tay ;store screen index to Y register
    jmp @continueCalc

@mustIncrementScreen:

    lda LocationIndex
    asl
    asl
    clc
    adc CurrentMapSegmentIndex
    clc
    adc #1
    tay; screen index goes to Y register

@continueCalc:

    lda TempX ; x / 8
    lsr
    lsr
    lsr
    sta TempX

    lda PlayerFrame
    bne @vertical
    ;horizontal
    lda PlayerY
    clc
    adc #8
    jmp @divide
@vertical:
    cmp #1
    bne @down

    ;up
    lda PlayerY
    sec
    sbc #4
    jmp @divide

@down:

    lda PlayerY
    clc
    adc #20

@divide:
    ; y / 8
    lsr
    lsr
    lsr
    sta TempY

@activateRod:

    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


@calcaddress:
    ldy TempY
    beq @skip
@addressLoop:

    lda pointer
    clc
    adc #32
    sta pointer
    bcs @incrementUpper
    jmp @nextRow
@incrementUpper:
    inc pointer + 1
@nextRow:
    dey
    bne @addressLoop
@skip:
    lda TempX
    tay

    lda (pointer), y
    cmp #$F0
    beq @throwThere
    cmp #$F1
    bne @exit

@throwThere:

    lda #0
    jmp @end
@exit:
    lda #1

@end:

    rts

;----------------------------------
PullOutRod:

    lda #0
    sta FishingRodActive

    lda FishingWaitTimer
    bne @exit

    lda FishBiteDuration
    bne @cont ; duration is not over, you can still catch the fish

    jsr WearWeapon
    jmp @exit

@cont:
    jsr WearWeapon

    lda #%00100011
    sta Temp
    jsr SpawnItem
@exit:
    rts
;-----------------------------------
ShootSlingshot:

    lda ProjectileCount
    asl
    asl
    tax

    lda ProjectileCount
    clc
    adc #1
    cmp #PROJECTILE_MAX_COUNT + 1
    bcs @exit
    sta ProjectileCount


    lda PlayerFrame
    bne @saveDir
;horizontal direction
    lda PlayerFlip
    clc
    adc #3
@saveDir:
    asl
    and #%11111110
    eor #1
    sta Projectiles, x

    inx ; X

    lda PlayerX
    adc GlobalScroll
    bcs @incrementScreen


    sta Projectiles, x
    lda CurrentMapSegmentIndex
    inx ;screen
    sta Projectiles, x
    jmp @writeY

@incrementScreen:
    sta Projectiles, x

    lda CurrentMapSegmentIndex
    clc
    adc #1
    inx ; screen
    sta Projectiles, x

@writeY:
    inx
    lda PlayerY
    clc
    adc #8
    sta Projectiles, x


@exit:
    rts

;-----------------------------------
LaunchSpear:

    ;throw a spear
    lda #1
    sta SpearActive

    lda PlayerFrame
    beq @horizontalDir
    sta SpearDir
    jmp @setOtherParams

@horizontalDir:
    lda PlayerFlip
    clc
    adc #3
    sta SpearDir
@setOtherParams:

    lda PlayerY
    clc
    adc #8
    sta SpearY

    lda PlayerX
    clc
    adc #8
    adc GlobalScroll
    bcs @incrementScreen


    sta SpearX
    lda CurrentMapSegmentIndex
    sta SpearScreen
    jmp @exit

@incrementScreen:
    sta SpearX

    lda CurrentMapSegmentIndex
    clc
    adc #1
    sta SpearScreen

@exit:

    rts

;-------------------------------
SetupCheckLeft:

    lda #1
    sta DirectionX
    sta ScrollDirection
    lda #0
    sta PlayerFrame
    sta PlayerFlip

    rts


;----------------------------------
CheckLeft:
    lda Buttons
    and #BUTTON_LEFT_MASK
    beq @exit

    jsr SetupCheckLeft

    lda PlayerX
    cmp #120    ;check if player is in the left side of the screen
    bcs @moveLeft

@cont:
    lda CurrentMapSegmentIndex ; CurrentMapSegment < 1 -> do not scroll
    beq @firstScreen


    lda TilesScroll
    sec
    sbc PlayerSpeed
    sta TilesScroll
;--
@ScrollGlobalyLeft:
    lda GlobalScroll
    cmp PlayerSpeed
    bcc @clamp

    sec
    sbc PlayerSpeed
    jmp @save
@clamp:
    lda #1
    sta MustDecrementScreenIndex

    lda GlobalScroll
    sec
    sbc PlayerSpeed
    jmp @save


@firstScreen:

    lda GlobalScroll
    beq @moveLeft


    lda TilesScroll
    sec
    sbc PlayerSpeed
    sta TilesScroll


    lda GlobalScroll
    cmp PlayerSpeed
    bcc @clamp1

    lda GlobalScroll
    sec
    sbc PlayerSpeed
    jmp @save

@clamp1:

    lda #0

@save:
    sta GlobalScroll

    jmp @exit

@moveLeft:
    lda PlayerX
    beq @exit ; already x=0
    sec
    sbc PlayerSpeed
    sta PlayerX

@exit:

    rts

;---------------------------------
SetupCheckRight:
    lda #2
    sta DirectionX
    sta ScrollDirection
    lda #0
    sta PlayerFrame
    lda #1
    sta PlayerFlip

    rts

;----------------------------------
;Right on dpad is pressed
CheckRight:
    lda Buttons
    and #BUTTON_RIGHT_MASK
    beq @exit

    jsr SetupCheckRight

    lda PlayerX
    cmp #120
    bcc @moveRight  ;not gonna scroll until playerx + 8 >= 128

    lda CurrentMapSegmentIndex ; CurrentMapSegment + 1 == ScreenCount -> do not scroll
    clc
    adc #1
    cmp ScreenCount
    beq @moveRight

;--
    lda TilesScroll
    clc
    adc PlayerSpeed
    sta TilesScroll
;--

    lda GlobalScroll
    cmp #MAX_V_SCROLL
    bcs @ScrollGlobalyRight

@ScrollGlobalyRight:

    lda #MAX_V_SCROLL
    sec
    sbc PlayerSpeed
    clc
    adc #1
    cmp GlobalScroll
    bcc @clamp
    beq @clamp

    lda GlobalScroll
    clc
    adc PlayerSpeed
    jmp @save
@clamp:
    lda #1
    sta MustIncrementScreenIndex

    lda CurrentMapSegmentIndex
    clc
    adc #2
    cmp ScreenCount
    beq @preLastScreen

    lda GlobalScroll
    clc
    adc PlayerSpeed
    jmp @save
@preLastScreen:
    lda #0          ;finshed to the last screen, set globalscroll to zero


@save:
    sta GlobalScroll

    jmp @exit

@moveRight:
    lda #0
    sec
    sbc PlayerSpeed
    sec 
    sbc #PLAYER_WIDTH
    cmp PlayerX

    beq @exit
    lda PlayerX
    clc
    adc PlayerSpeed
    sta PlayerX
@exit:

    rts
;----------------------------------
;invert the least significant bit
FlipStartingNametable:
    lda FirstNametableAddr
    ldx SecondNametableAddr
    stx FirstNametableAddr
    sta SecondNametableAddr

    lda PPUCTRL
    eor #1

    sta PPUCTRL

    rts
;----------------------------------
CheckBed:
    lda PlayerX
    cmp #64
    bcc @nope
    cmp #88
    bcs @nope
    lda PlayerY
    cmp #80
    bcc @nope
    cmp #128
    bcs @nope

    lda #0
    sta FirstTime
    sta MustUpdateTextBaloon
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithBed
    ldy #1
    jsr bankswitch_y

    lda #1
    jmp @exit

@nope:
    lda #0
@exit:
    rts
;-----------------------------------
CheckFireplace:

    lda PlayerX
    cmp #104
    bcc @nope
    cmp #128
    bcs @nope
    lda PlayerY
    cmp #80
    bcs @nope

    lda #0
    sta FirstTime
    sta MustUpdateTextBaloon
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithFireplace
    ldy #1
    jsr bankswitch_y


    jmp @exit

@nope:
    lda #0
@exit:
    rts
;-----------------------------------
CheckStashBox:

    lda PlayerX
    cmp #144
    bcc @nope
    cmp #168
    bcs @nope
    lda PlayerY
    cmp #80
    bcs @nope

    lda #0
    sta FirstTime
    sta MustUpdateTextBaloon
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithStorage
    ldy #1
    jsr bankswitch_y


    jmp @exit
@nope:
    lda #0
@exit:
    rts
;-----------------------------------
CheckToolTable:

    lda PlayerX
    cmp #152
    bcc @nope
    cmp #184
    bcs @nope
    lda PlayerY
    cmp #120
    bcs @nope
    cmp #112
    bcc @nope

    lda #0
    sta FirstTime
    sta MustUpdateTextBaloon
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithTooltable
    ldy #1
    jsr bankswitch_y


    jmp @exit
@nope:
    lda #0
@exit:
    rts
;-------------------------------------
LoadInteriorMap:

    lda MustLoadHouseInterior
    beq @nope

    ldy #3
    sty bankBeforeNMI ; hack
    jsr bankswitch_y

    jsr LoadIndoorMapData ; from bank 3

   @nope:
    rts

;-----------------------------------
UpdateSprites:

    lda #0
    sta SpritesUpdated
;--- MAIN CHARACTER:

    lda PlayerFrame
    asl  ; frame * 2
    sta TempFrame

    ldy PlayerAnimationRowIndex
    lda player_anim_row_sequence, y
    sta TempAnimIndex

    ldx #0
    ldy #0

@maincharloop:

    sty TempPlayerSpriteIdx
    tya
    asl
    asl
    ldy PlayerFlip
    beq @notFlipped
    clc
    adc #16 ;16 bytes
@notFlipped:
    tay
    lda PlayerY
    clc
    adc player_sprites_not_flip, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda TempFrame
    clc
    adc player_sprites_not_flip, y
    cpx #8
    bcc @notAnimate
    clc
    adc TempAnimIndex
@notAnimate:
    sta FIRST_SPRITE, x
    inx
    iny
    lda player_sprites_not_flip, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda PlayerX
    clc
    adc player_sprites_not_flip, y
    sta FIRST_SPRITE, x
    inx

    ldy TempPlayerSpriteIdx
    iny
    cpy #4
    bcc @maincharloop

    dex
    lda #4
    sta TempSpriteCount

;-------------KNIFE
    lda AttackTimer
    beq @noKnife

    lda EquipedItem
    beq @noKnife
    cmp #ITEM_KNIFE
    bne @noKnife

    jsr PrepareKnifeSprite

@updateKnife: ;update the actual sprite
    inx
    lda TempPointY
    sta FIRST_SPRITE,x
    inx
    lda #240
    clc
    adc PlayerFrame
    sta FIRST_SPRITE,x
    inx
    lda Temp
    sta FIRST_SPRITE,x
    inx
    lda TempPointX
    sta FIRST_SPRITE,x
    inc TempSpriteCount

;------ SPEAR
@noKnife:

    lda SpearActive
    beq @projectiles

    lda SpearScreen
    jsr CalcItemMapScreenIndexes

    lda ItemMapScreenIndex
    beq @skipPrevScreen
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @projectiles
@skipPrevScreen:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @projectiles

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @SpearMatchesScreen

    lda SpearX ; x
    sec
    sbc GlobalScroll
    bcs @projectiles
    sta TempPointX ; save x
    jmp @doUpdate
@SpearMatchesScreen:
    lda SpearX ; x
    cmp GlobalScroll
    bcc @projectiles
    sec
    sbc GlobalScroll
    sta TempPointX


@doUpdate:

    jsr SetTwoSpearSprites

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount
;------------------PROJECTILES
@projectiles:
    jsr UpdateProjectileSprites

;---------------FISHING ROD
@fishingRod:

    lda FishingRodActive
    beq @hammer

    lda PlayerFrame
    beq @horizontal

    cmp #1
    beq @down
    ldy #16
    jmp @update
@down:
    ldy #24
    jmp @update

@horizontal:
    lda PlayerFlip
    bne @flipIndex

    ldy #0
    jmp @update

@flipIndex:

    ldy #8
@update:

   jsr UpdateTwoRodSprites
;-----------HAMMER
@hammer:
    lda EquipedItem
    beq @sunmoon
    cmp #ITEM_HAMMER
    beq @ok
    cmp #ITEM_WOOD_HAMMER
    bne @sunmoon
@ok:
    jsr UpdateHammerSprites

;------------------------------
;------SUN-MOON INDICATOR
@sunmoon:
    inx; next sprite byte
    lda Hours
    lsr
    lsr
    lsr
    lsr
    asl
    asl
    tay

    lda #15
    sta FIRST_SPRITE, x
    inx
    iny
    lda sun_moon_sprites_for_periods, y
    sta FIRST_SPRITE, x
    inx
    lda #0
    sta FIRST_SPRITE, x
    inx
    dey
    lda sun_moon_sprites_for_periods, y
    sta FIRST_SPRITE, x
    inx
    inc TempSpriteCount
    iny
    iny
    lda sun_moon_sprites_for_periods, y
    sta TempFrame
    beq @no_second_celestial_body
;--
    iny
    lda #15
    sta FIRST_SPRITE, x
    inx
    lda sun_moon_sprites_for_periods, y
    sta FIRST_SPRITE, x
    inx
    lda #0
    sta FIRST_SPRITE, x
    inx
    lda TempFrame
    sta FIRST_SPRITE, x

    inc TempSpriteCount

    inx
;---------------------
@no_second_celestial_body:
    lda Stamina
    beq @no_stamina_bar
    cmp #PLAYER_STAMINA_SIZE
    bcs @no_stamina_bar

    lda #15
    sta FIRST_SPRITE, x
    inx
    lda #$FD
    sta FIRST_SPRITE, x
    inx
    lda #%00000001
    sta FIRST_SPRITE, x
    inx

    lda Stamina ; current max stamina is 128, and it has 4 segments
    lsr
    lsr
    lsr
    lsr
    lsr         ;so let's divide value by segment width 32
    stx StaminaSpritetempx
    tax

    lda stamina_sprite_lookup, x
    sta StaminaSpritePos

    lda Stamina
    sec
    sbc stamina_segment_values, x
    lsr
    lsr
    sta StaminaSpriteOffset

    ldx StaminaSpritetempx

    lda StaminaSpritePos
    clc
    adc StaminaSpriteOffset

    sta FIRST_SPRITE, x
    inx

    inc TempSpriteCount

;--------------------
@no_stamina_bar:

    lda FlickerFrame
    beq @doZtoA
    lda #0
    sta FlickerFrame

    jsr UpdateNpcSpritesInWorldAtoZ
    jsr UpdateItemSpritesInWorldAtoZ
    jmp @updateTextdialog
@doZtoA:
    lda #1
    sta FlickerFrame

    jsr UpdateNpcSpritesInWorldZtoA
    jsr UpdateItemSpritesInWorldZtoA

@updateTextdialog:
;-----------TEXT DIALOG SPRITES

    lda InVillagerHut
    beq @hidesprites

    ldy current_bank
    sty oldbank
    ldy #3
    bankswitch

    jsr UpdateVillagerDialogSprites ;from bank 3

;------------------- hide unused sprites
@hidesprites:
    lda #MAX_SPRITE_COUNT

    cmp TempSpriteCount
    bcc @done
    sec
    sbc TempSpriteCount

    tay
@hideSpritesLoop:
    lda #$FE
    sta FIRST_SPRITE, x
    inx
    inx
    inx
    inx

    dey
    bne @hideSpritesLoop
@done:

    lda #1
    sta SpritesUpdated

    rts
;==============================================================

SetTwoSpearSprites:

    lda SpearDir
    ;(dir - 1) * 8
    sec
    sbc #1
    asl
    asl
    asl
    tay

    inx
    lda SpearY
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda TempPointX
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    ;----
    lda SpearY
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda TempPointX
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x


    rts
;---------------------------------
UpdateTwoRodSprites:
    lda FishBiteTimer ; / 8
    lsr
    lsr
    lsr
    sta Temp

    inx
    lda PlayerY
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;y
    iny
    inx
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;x

    inx
    iny
    lda PlayerY
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;y
    inx
    iny
    lda fishingRodSprites, y
    clc
    adc Temp

    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;x

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount


    rts
;----------------------------------
UpdateProjectileSprites:

    ldy ProjectileCount
    beq @exit

    dey
    sty ProjectileIdx

@projectileLoop:

    lda ProjectileIdx
    asl
    asl
    tay

    lda Projectiles, y
    lsr
    bcc @next ; this projectile is inactive

    iny
    iny
    lda Projectiles, y ;screen

    jsr CalcItemMapScreenIndexes
    lda ItemMapScreenIndex
    beq @skipPrevScreen
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @next
@skipPrevScreen:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @next

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @projectileMatchesScreen

    dey
    lda Projectiles, y ; x
    sec
    sbc GlobalScroll
    bcs @next
    sta TempPointX
    iny ; screen
    jmp @continueUpdate
@projectileMatchesScreen:
    dey
    lda Projectiles, y ; x
    cmp GlobalScroll
    bcc @next
    sec
    sbc GlobalScroll
    sta TempPointX
    iny; screen

@continueUpdate:
    iny ; y
    inx
    lda Projectiles, y ; y
    sta FIRST_SPRITE, x ; y
    inx
    lda #$FB
    sta FIRST_SPRITE, x
    inx
    lda #%00000011
    sta FIRST_SPRITE, x
    inx
    lda TempPointX
    sta FIRST_SPRITE, x


    inc TempSpriteCount
@next:
    dec ProjectileIdx
    bpl @projectileLoop

@exit:

    rts

;----------------------------------
PrepareKnifeSprite:

    lda PlayerFlip
    beq @notFlippedKnife

    lda #%01000000
    sta Temp

    lda PlayerFrame
    asl
    tay
    lda knife_pos_flipped, y
    sta TempPointX
    iny
    lda knife_pos_flipped, y
    sta TempPointY
    lda PlayerY
    clc
    adc TempPointY
    sta TempPointY

    lda PlayerX
    clc
    adc TempPointX
    sta TempPointX

    jmp @exit
@notFlippedKnife:

    lda #%00000000
    sta Temp

    lda PlayerFrame
    asl
    tay
    lda knife_pos_normal, y
    sta TempPointX
    iny
    lda knife_pos_normal, y
    sta TempPointY
    lda PlayerY
    clc
    adc TempPointY
    sta TempPointY
    sta AttackTopLeftY

    lda PlayerX
    clc
    adc TempPointX
    sta TempPointX
    sta AttackTopLeftX

@exit:
    rts
;----------------------------------
UpdateHammerSprites:

    lda AttackTimer
    beq @exit

    lda PlayerFrame
    beq @horizontal ; ( playerframe - 1 ) * 8 + 16
    sec
    sbc #1
    asl
    asl
    asl
    clc
    adc #16
    tay
    lda PlayerFlip
    beq @updatesprites
    tya
    clc
    adc #16
    tay
    jmp @updatesprites
@horizontal:
    lda PlayerFlip ; playerflip * 8 
    asl
    asl
    asl
    tay

@updatesprites:
    inx
    lda PlayerY
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;y
    iny
    inx
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;x

    inx
    iny
    lda PlayerY
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;y
    inx
    iny
    lda hammerSprites, y

    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;x

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount

@exit:
    rts
;----------------------------------
initZeroSprite:
    ldx #$00
spriteLoadLoop:
    lda sprites, x
    sta FIRST_SPRITE - 4, x
    inx
    cpx #4
    bne spriteLoadLoop

    lda #1
    sta SpritesUpdated

    rts

