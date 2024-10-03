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

main_core_sprites   : .incbin "chr/main_core_sprites.lz4"
main_animal_sprites : .incbin "chr/main_animal_sprites.lz4"
font                : .incbin "chr/font.lz4"
UI_tiles            : .incbin "chr/UI.lz4"
main_bg_tiles       : .incbin "chr/main_bg_tiles.lz4"

.include "data/maps/cropped/field_bg_crop.asm"
.include "data/maps/cropped/field_bg1_crop.asm"
.include "data/maps/cropped/field_bg2_crop.asm"
.include "data/maps/cropped/field_bg4_crop.asm"
.include "data/maps/cropped/LOC3_bg1_crop.asm"
.include "data/maps/cropped/LOC3_bg0_crop.asm"
.include "data/maps/cropped/alien_base_lobby_crop.asm"
.include "data/maps/cropped/field2_bg_crop.asm"
.include "data/maps/cropped/field2_bg1_crop.asm"
.include "data/item_list_Outside1.asm"
.include "data/item_list_Outside3.asm"
.include "data/mod_tiles_first.asm"
.include "data/mod_tiles_alien_lobby.asm"
.include "data/item_list_outside2.asm"


;===========================================================
.segment "ROM1"

.include "data/menu_screen_comp.asm"
.include "data/menu_data.asm"
.include "data/recipes.asm"

.include "data/maps/cropped/abase_hall_0_crop.asm"
.include "data/maps/cropped/abase_hall_1_crop.asm"
.include "data/maps/cropped/abase_hall_2_crop.asm"
.include "data/npc_list_abase_hall.asm"

;============================================================
.segment "ROM2"

title_tiles_chr   :  .incbin "chr/title_tiles.lz4"
gameover_tiles_chr:  .incbin "chr/gameover_tiles.lz4"
intro_tiles_chr   :  .incbin "chr/intro.lz4"
.include "data/maps/cropped/crashsite0_crop.asm"
.include "data/maps/cropped/crashsite1_crop.asm"
.include "data/maps/cropped/crashsite2_crop.asm"
.include "data/maps/cropped/pre_alien_base0_crop.asm"
.include "data/maps/cropped/pre_alien_base1_crop.asm"
.include "data/maps/cropped/pre_alien_base2_crop.asm"
.include "data/mod_tiles_alien_base_pre.asm"
.include "data/item_list_crashsite.asm"
.include "data/item_list_alien_puzzle.asm"

;============================================================
.segment "ROM3" ; indoors

house_tiles_chr:   .incbin "chr/house_bg_tiles.lz4"
house_sprites_chr: .incbin "chr/house_sprites.lz4"
boss_sprites_chr:  .incbin "chr/boss_sprites.lz4"
.include "data/maps/cropped/house_crop.asm"
.include "data/maps/cropped/villager_hut_crop.asm"
.include "data/maps/cropped/villager2_hut_crop.asm"
.include "data/maps/cropped/grannys_hut_crop.asm"
.include "data/maps/cropped/alien_bossroom_crop.asm"
.include "data/maps/cropped/mine_room_crop.asm"
.include "data/npc_list_alien_bossroom.asm"
.include "data/npc_list_bjorn_house.asm"
.include "data/npc_list_erikas_house.asm"
.include "data/npc_list_grannys_house.asm"
.include "data/maps/cropped/lonely_cave_crop.asm"
.include "data/maps/cropped/wood_location_0_crop.asm"
.include "data/maps/cropped/wood_location_1_crop.asm"
.include "data/item_list_wood_location.asm"
.include "data/AnimalSpawnPositions.asm"


;============================================================
.segment "ROM4" ; other location

cave_tiles_chr   : .incbin "chr/cave_bg_tiles.lz4"
alien_tiles_chr  : .incbin "chr/alien_bg_tiles.lz4"
cave_sprites_chr : .incbin "chr/cave_sprites.lz4"
alien_sprites_chr: .incbin "chr/alien_sprites.lz4"

.include "data/maps/cropped/alien_base1_crop.asm"
.include "data/maps/cropped/alien_base2_crop.asm"
.include "data/maps/cropped/mine_0_crop.asm"
.include "data/maps/cropped/mine_1_crop.asm"
.include "data/maps/cropped/mine_2_crop.asm"
.include "data/maps/cropped/dark_cave0_crop.asm"
.include "data/maps/cropped/dark_cave1_crop.asm"
.include "data/maps/cropped/dark_cave2_0_crop.asm"
.include "data/maps/cropped/dark_cave2_1_crop.asm"
.include "data/maps/cropped/dark_cave2_2_crop.asm"
.include "data/maps/cropped/secret_cave0_crop.asm"
.include "data/mod_tiles_secret_cave.asm"
.include "data/mod_tiles_mine.asm"
.include "data/mod_tiles_alien_base.asm"
.include "data/item_list_dark_cave2.asm"
.include "data/item_list_secret_cave.asm"
.include "data/item_list_mine.asm"
.include "data/npc_list_mine.asm"
.include "data/npc_list_alien_base.asm"
.include "data/npc_list_dark_cave.asm"



;=============================================================
.segment "ROM5" ;title and intro data (?)

.include "data/game_over_comp.asm"
.include "data/title_comp.asm"
crashed_plane_tiles_chr: .incbin "chr/crashed_plane_tiles.lz4"

title_palette:
    .byte $0F,$00,$11,$20, $0F,$01,$11,$07, $0F,$30,$11,$38, $0F,$07,$11,$35    ;background
    .byte $0F,$0f,$17,$20, $0F,$06,$26,$39, $0F,$17,$21,$31, $0F,$0f,$37,$26    ;OAM sprites

intro_palette:
    .byte $0C,$00,$31,$30, $0C,$01,$31,$30, $0C,$16,$31,$36, $0C,$18,$07,$30 ; background
    .byte $0C,$06,$16,$30, $0C,$0c,$1B,$36, $0C,$0c,$16,$36, $0C,$01,$07,$21 ; sprites

push_start:
    .byte $1a,$1f,$1d,$12,$00,$1d,$1e,$0b,$1c,$1e


game_over_sprites:
    .byte 152, $11, 0, 88   ; G
    .byte 152, $0b, 0, 96   ; A
    .byte 152, $17, 0, 104  ; M
    .byte 152, $0f, 0, 112  ; E

    .byte 152, $19, 0, 136  ; O
    .byte 152, $20, 0, 144  ; V
    .byte 152, $0f, 0, 152  ; E
    .byte 152, $1c, 0, 160  ; R

    .byte 184, $1d, 1, 96   ; S
    .byte 184, $1f, 1, 104  ; U
    .byte 184, $1c, 1, 112  ; R
    .byte 184, $20, 1, 120  ; V
    .byte 184, $13, 1, 128  ; I
    .byte 184, $20, 1, 136  ; V
    .byte 184, $0f, 1, 144  ; E
    .byte 184, $0e, 1, 152  ; D

    .byte 200, $0e, 1, 128  ; D
    .byte 200, $0b, 1, 136  ; A
    .byte 200, $23, 1, 144  ; Y
    .byte 200, $1d, 1, 152  ; S

.include "data/CutsceneData.asm"
;--------- maps
.include "data/maps/cropped/babloc1_crop.asm"
.include "data/maps/cropped/babloc2_crop.asm"
.include "data/maps/cropped/babloc3_crop.asm"
.include "data/maps/cropped/location_with_cave0_crop.asm"
.include "data/maps/cropped/location_with_cave1_crop.asm"
.include "data/maps/cropped/location_with_cave2_crop.asm"
.include "data/maps/cropped/location_with_cave3_crop.asm"
.include "data/maps/cropped/path_to_crashsite_crop.asm"

.include "data/item_list_mine_location.asm"
.include "data/item_list_granny_location.asm"

;=============================================================
.segment "ROM6"
FAMISTUDIO_DPCM_OFF = $FBBA
FAMISTUDIO_CFG_C_BINDINGS = 0
.include "data/music.s"
.include "data/sfx.s"
.include "famistudio_ca65.s"

.include "data/StatusBar.asm"

.include "data/player_sprite_data.asm"
.include "data/npc_sprite_data.asm"
;=============================================================

.segment "RODATA" ; ROM7

banktable:              ; Write to this table to switch banks.
    .byte $00, $01, $02, $03, $04, $05, $06
    .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E

.include "data/map_list.asm"

.include "data/item_data.asm"
.include "data/npc_data.asm"

.include "data/villager_quests.asm" ;ROM3, ROM6, etc.
.include "data/MapEntryPoints.asm" ; ROM1, RODATA

;collision lookup table positions
row_table_screens:
    .byte 0
    .byte 60
    .byte 120
    .byte 180


stamina_sprite_lookup:
    .byte 176
    .byte 184
    .byte 192
    .byte 200
    .byte 208

stamina_segment_values:
    .byte 0
    .byte 32
    .byte 64
    .byte 96
    .byte 128

knockBackValuesInteger:
    .byte 2
    .byte 1
    .byte 0
    .byte 0
    .byte 0

knockBackValuesFractions:
    .byte 200
    .byte 250
    .byte 180
    .byte 10
    .byte 10


.include "data/house_palette.asm"
.include "data/main_palette.asm"
.include "data/alien_palette.asm"
.include "data/dark_cave_palette.asm"
.include "data/destructible_tiles.asm"

game_over_palette:
    .byte $0f,$0c,$11,$16,$0f,$0c,$35,$31,$0f,$0c,$16,$31,$0f,$0c,$11,$31
    .byte $0f,$30,$30,$30,$0f,$10,$10,$10,$0f,$30,$30,$30,$0f,$30,$30,$30


zero_sprite:
    .byte $16, $00, %00000011, $FA  ; sprite 0 

knife_sprite_data:
    .byte 8,  $29, %00000000, 248 ; left (248 = -8)
    .byte 8,  $29, %01000000, 16 ; right
    .byte 0,  $2A, %00000000, 8  ; up
    .byte 16, $2A, %10000000, 0 ; down

knife_collision_pos:
    .byte 250, 9, 250, 15 ; left
    .byte 22, 9, 22, 15   ; right
    .byte 10, 1, 14, 1    ; up
    .byte 2, 24, 6, 24    ; down

fist_collision_pos:
    .byte 254, 9, 254, 15  ;left
    .byte 18, 9, 18, 15    ;right
    .byte 10, 4, 14, 4     ;up
    .byte 2, 18, 6, 18     ;down


spearSprites:
          ;+Y,frame,attributes,+X
    .byte 248, $2B, %00000000, 252, 0  , $2C, %00000000, 252 ;up
    .byte 248, $2C, %10000000, 252, 0  , $2B, %10000000, 252 ;down
    .byte 252, $3E, %00000000, 248, 252, $3F, %00000000, 0 ;left
    .byte 252, $3F, %01000000, 248, 252, $3E, %01000000, 0 ;right


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
    .byte DAYTIME_NIGHT ;00:00 period start
    .byte DAYTIME_NIGHT ;01:30
    .byte DAYTIME_NIGHT ;03:00
    .byte DAYTIME_NIGHT ;04:30
    .byte $30           ;06:00
    .byte $20           ;07:30
    .byte $10           ;09:00
    .byte $00           ;10:30
    .byte $00           ;12:00
    .byte $00           ;13:30
    .byte $10           ;15:00
    .byte $20           ;16:30
    .byte $30           ;18:00
    .byte DAYTIME_NIGHT ;19:30
    .byte DAYTIME_NIGHT ;21:00
    .byte DAYTIME_NIGHT ;22:30

sun_moon_tiles_for_periods:
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $00, $32, $33 ;$30
    .byte $31, $00, $32, $33 ;$20
    .byte $30, $31, $00, $32 ;$10
    .byte $00, $30, $31, $00 ;$00
    .byte $00, $30, $31, $00 ;$00
    .byte $00, $30, $31, $00 ;$00
    .byte $00, $00, $30, $31 ;$10
    .byte $33, $00, $30, $31 ;$20
    .byte $32, $33, $00, $30 ;$30
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $32, $33, $00 ;$40
    .byte $00, $32, $33, $00 ;$40

npcs_ram_lookup: ;npc position in ram by index, max 16 npcs
    .byte 0
    .byte 11
    .byte 22
    .byte 33
    .byte 44
    .byte 55
    .byte 66
    .byte 77
    .byte 88
    .byte 99
    .byte 110
    .byte 121
    .byte 132
    .byte 143
    .byte 154
    .byte 165

projectiles_ram_lookup: ; max 10 projectiles
    .byte 0
    .byte 6
    .byte 12
    .byte 18
    .byte 24
    .byte 30
    .byte 36
    .byte 42
    .byte 48
    .byte 54

.include "constants.asm"

;===================================================================
.segment "ZEROPAGE"
current_bank: ;active bank
    .res 1
oldbank:
    .res 1
bankBeforeStatusBarLoad:
    .res 1
bankBeforeNMI: ;bank that was active before NMI, so it could be set back
    .res 1
pointer:
    .res 2
TextPtr:
    .res 2
DigitPtr:
    .res 2
CutsceneDataPtr = DigitPtr

IntroSpritePtr:
    .res 2
ItemListPtr = IntroSpritePtr

IntroSpriteCoordPtr:
    .res 2
pointer2:
    .res 2
PalettePtr:
    .res 2
CurrentMapPalettePtr:
    .res 2
AnimalSpawnPointsPtr:
    .res 2
ProjectilePtr:
    .res 2

tmpAttribAddress:
    .res 1

InputUpdateDelay:
    .res 1
ItemUpdateDelay:
    .res 1

CutsceneDelay = ItemUpdateDelay

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
MustUpdateDestructibles:
    .res 1

HP:
    .res 3
HpUpdated:
    .res 1

Food:
    .res 3
FoodUpdated:
    .res 1

PlayerDamagedCounter:
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
MustPlaySfx:
    .res 1



SongName:
    .res 1
SfxName:
    .res 1
IsLocationRoutine:
    .res 1
ActiveMapEntryIndex:
    .res 1

FlickerFrame: ;variable for alternating sprite update routines to achieve flickerine
    .res 1

LocationBankNo:
    .res 1

TempScreen:
    .res 1

menuTileTransferRowIdx: ; current row of tile graphics to be copied to menu screen
    .res 1

menuTileTransferAddressHigh:
    .res 1
menuTileTransferAddressLow:
    .res 1
menuTileTransferDataIdx:
    .res 1

TransferingSecondMenuPart:
    .res 1

character_sprite_data_ptr:
    .res 2

weapon_collision_ptr:
    .res 2

ptr_list:
    .res 2
MustUpdateMapColumn:
    .res 1
MustUpdateMapAttributeColumn:
    .res 1
OldBgColumnIdxToUpload:
    .res 1
OldAttribColumnIdxToUpdate:
    .res 1
OldSourceMapIdx:
    .res 1
MustUpdateSunMoon:
    .res 1

Stamina:
    .res 1
OldStamina:
    .res 1
PlayerMovesDiagonaly:
    .res 1

MapColumnData:
    .res SCREEN_ROW_COUNT - 4 ; 26
MapColumnAttributes:
    .res 8

CheckpointSaved:
    .res 1

hadKnockBack:
    .res 1
KnockBackDirectionX:
    .res 1
KnockBackDirectionY:
    .res 1
KnockBackIndex:
    .res 1
KnockBackDelay:
    .res 1
OldDirectionX:
    .res 1

chr_dest_high:
    .res 1
chr_dest_low:
    .res 1
chr_pages_to_copy:
    .res 1

TempMapColumnY:
    .res 1
TempDestructibleTileIdx:
    .res 1

NewPlayerX:
    .res 2
NewPlayerY:
    .res 2

PlayerX:
    .res 2
PlayerY:
    .res 2

PlayerSpeed:
    .res 2

NewScrollX:
    .res 2
ScrollX:
    .res 2

LocationIndex:
    .res 1

SourceMapIdx:
    .res 1

bankBeforeItemReset:
    .res 1

CurrentMapSegmentIndex: ;starting screen
    .res 1
NewCurrentMapSegmentIndex:
    .res 1

CurrentScreenChange: ; 0 - not changed, 1 - incremented, 255 - decremented
    .res 1
PossibleCurrentScreenChange:
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

LocationType:
    .res 1

ScreenCount:
    .res 1


BgColumnIdxToUpload: ; index of a column to be uploaded
    .res 1

AttribColumnIdxToUpdate:
    .res 1

RandomNumber:
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
PointCellY: ; for collision
    .res 1

sp:
    .res 2
sreg:
    .res 2
VillagerIndex:
    .res 1

MustCopyMainChr:
    .res 1

PlayerFrame:
    .res 1

ZP_Free:
    .res 1

;--------------
.segment "BSS" ; variables in ram

DialogTextContainer:
    .res 96
;--menu vars
MustDrawInventoryGrid   = DialogTextContainer
MustDrawEquipmentGrid   = DialogTextContainer + 1
MustDrawMenu            = DialogTextContainer + 2
MustDrawSleepMessage    = DialogTextContainer + 3
MustDrawDocument        = DialogTextContainer + 4
MustClearSubMenu        = DialogTextContainer + 5
;--Cutscene vars
CutsceneSceneIdx        = DialogTextContainer
CutsceneTimer           = DialogTextContainer + 1
CutsceneSpriteCount     = DialogTextContainer + 2
CutsceneMetaspriteCount = DialogTextContainer + 3
CutsceneMetaspriteIndex = DialogTextContainer + 4
CutsceneSprite1X        = DialogTextContainer + 5
CutsceneSprite1Y        = DialogTextContainer + 6
CutsceneSprite2X        = DialogTextContainer + 7
CutsceneSprite2Y        = DialogTextContainer + 8
CutsceneSpriteAnimFrame = DialogTextContainer + 9
SnowDelay               = DialogTextContainer + 10
DemoModeOn              = DialogTextContainer + 11 ; demo mode enabled, basically shows intro cutscene
TitleScreenTimer        = DialogTextContainer + 12


CurrentPaletteDecrementValue: ;a helper value to prevent doing too much of palette changing
    .res 1


ScrollY:
    .res 1

DestScreenAddr: ; higher byte of destination screen to upload columns
    .res 1

FirstNametableAddr: ; will store adresses in ram they will be filpped
    .res 1
SecondNametableAddr:
    .res 1


ScrollDirection:
    .res 1
NewScrollDirection:
    .res 1


NametableAddress:
    .res 1

PlayerAnimationRowIndex: ;which animation row to use for player sprites at the moment
    .res 1
WalkTimer:
    .res 1
AttackTimer:
    .res 1
NpcsKilledByPlayer: ; kills by a single strike
    .res 1
TempNpcFrame:
    .res 1

SnowFrame:
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

SpearData: ; Direction(7bit) + Active(1bit), X(2 bytes), Screen, Y(2bytes)
    .res 6

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
SpecialItemsDelivered:
    .res MAX_VILLAGERS

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


ActiveVillagerQuests:
    .res MAX_VILLAGERS
TakenQuestItems:
    .res MAX_VILLAGERS
CompletedSpecialQuests: ; 1 if items is taken from sender, delivered and reward is taken from sender
    .res MAX_VILLAGERS


MustSleepAfterFadeOut:
    .res 1
MustUpdateTextBaloon:
    .res 1
TextBaloonIndex:
    .res 1
TextLength:
    .res 1


MustLoadHouseInterior:
    .res 1

MustLoadMenu:
    .res 1
MustResetMenu: ; must update stats and draw main menu on top
    .res 1
MustLoadTitle:
    .res 1
MustLoadTitleCHR:
    .res 1
MustLoadGameOver:
    .res 1
MustLoadCutscene:
    .res 1
MustLoadIntroChr:
    .res 1
MustDrawMenuTitle:
    .res 1

MustLoadGameOverAfterFadeOut:
    .res 1

MustShowOutroAfterFadeout:
    .res 1

MustShowTitleAfterFadeout:
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
SleepMessageActivated:
    .res 1
DocumentActivated:
    .res 1
ActiveDocument:
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


KilledNpcScreenIdx:
    .res 1

PrevItemMapScreenIndex:
    .res 1
NextItemMapScreenIndex:
    .res 1
ItemMapScreenIndex:
    .res 1


DamagedPaletteMask:
    .res 1


TempAnimIndex:
    .res 1

TempPlayerY2: ;used for npc direction change callculation
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
TempNpcSpeed:
    .res 2
TempFrameOffset:
    .res 1
TempPointX2:
    .res 1
TempPointY2:
    .res 1
TempNpcCenterY:
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

;timid npc agitation range
TempPlayerRangeX1:
    .res 1
TempPlayerRangeX2:
    .res 1
TempPlayerRangeY1:
    .res 1
TempPlayerRangeY2:
    .res 1

ProjectileWidth:
    .res 1
ProjectileX:
    .res 1
ProjectileY:
    .res 1

                ;for npc collision
NewNpcX:
    .res 2
NewNpcY:
    .res 2
NewNpcScreen:
    .res 1

NpcXPosition: ;x coordinate position in ram
    .res 1
PlayerCenterY:
    .res 1

DropedItemX: ;x coordinate of item droped by npc
    .res 1

ShotWithProjectile:
    .res 1

SpritesUpdated:
    .res 1
TaintedSprites:
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

TempSpearSpriteCnt:
    .res 1

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

TempItemStorageIdx: ; for finding reusable item slot, to spawn item in map
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
    .res 4 * ITEM_COUNT_MAX ; ITEM_COUNT_MAX * 4 bytes
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
Item_Location7_Collection_times:
    .res ITEM_COUNT_LOC7
Item_Location8_Collection_times:
    .res ITEM_COUNT_LOC8
Item_Location9_Collection_times:
    .res ITEM_COUNT_LOC9
Item_Location12_Collection_times:
    .res ITEM_COUNT_LOC12
Item_Location15_Collection_times:
    .res ITEM_COUNT_LOC15
Item_Location17_Collection_times:
    .res ITEM_COUNT_LOC17
Item_Location20_Collection_times:
    .res ITEM_COUNT_LOC20
Item_Location23_Collection_times:
    .res ITEM_COUNT_LOC23


Npcs:   ;animals and stuff
    .res 176 ; max 16 npcs * 11 bytes:
            ;   (npc type(4 bits) + agitatded?(1bit) + damaged?(1bit) + state(2 bit,
            ;                                                           0 - dead,
            ;                                                           1 - alive/idle,
            ;                                                           2 - attacks,
            ;                                                           3 - warning
            ;       ),
            ;   x (2 bytes),
            ;   y (2 bytes),
            ;   screen_index
            ;   direction(0000(unused bits) 00(Vertical) 00(horizonatal))
            ;   frame
            ;   timer
            ;   hp
            ;   dammage timer (for how long a npc should stay red)
NpcCount:
    .res 1

Projectiles:
    .res 6 * PROJECTILE_MAX_COUNT ;  6 bytes:
                                  ;---------------------------------
                                  ;  direction(7bit) + state (1bit)
                                  ;  x (2 bytes)
                                  ;  screen
                                  ;  y (2 bytes)

ProjectileCount:
    .res 1

ProjectileIdx:
    .res 1

ModifiedTiles:
    .res MODIFYABLE_OBJECTS_COUNT  ;1 means destroyed

AttribHighAddress:
    .res 1

MapRowAddressTable:
    .res ROW_TABLE_SIZE

TempRowIndex:
    .res 1

TempCollisionVar:
    .res 1


destructibleIdx:
    .res 1


RedCounter:
    .res 1

EnteredBeforeNightfall:
    .res 1

InitiateCompleteItemRespawn:
    .res 1

DontIncrementQuestNumber:
    .res 1

TempPreRowLoopValue: ; used in LoadOutsidemap
    .res 1

SelectedItemPower:
    .res 1

TempNpcDataIdxForCollision:
    .res 1

DocumentJustClosed:
    .res 1

PreviouslyEquipedItemIdx:
    .res 1
EquipNextResetCount:
    .res 1

VillagerKilled:
    .res MAX_VILLAGERS

BossAgitated:
    .res 1

TempNpcTilesInARow:
    .res 1
TempNpcWidth:
    .res 1

CurrentSpritesInRow:
    .res 1

TempScreenPos:
    .res 1

TempNpcPosInRam:
    .res 1

TempNpcMovesDiagonaly:
    .res 1

TempLocationPos:
    .res 1

TempNpcDamaged:
    .res 1
TempNpcAgitated:
    .res 1


SaveData: ; inventory       |      storage       | HP | Food | Fuel | Warmth | Time | Equipment
    .res INVENTORY_MAX_SIZE + INVENTORY_MAX_SIZE + 3  +   3 +   3   +   3    +   5  +    4

FullInventoryScrollX:
    .res 1
FullInventoryPlayerX:
    .res 1
FullInventoryPlayerY:
    .res 1

RepeatSameRowInTransfer: ; use same data row in tile transfer
    .res 1

NpcsHitByPlayer: ;npc hits in one strike
    .res 1

NametableOffsetInBytes: ; how many bytes to fill with zeroes at the beginning of a nametable
    .res 1
SkipLastTileRowsInIndoorMaps:
    .res 1
MustLoadCoreSprites:
    .res 1
MustReloadFontAndUI:
    .res 1
skipZeroSpriteCheck:
    .res 1
ImportantItemTimer:
    .res 1
ImportantItemTile:
    .res 1
ImportantItemPaletteIdx:
    .res 1

ModifiedTilesToDraw:
    .res 1
ModifiedTileHalfFull:
    .res 1

ModifiedTilesBuffer: ; 5 * 4(Address low, Address high, value1, value2)
    .res 20

TempIndex:
    .res 1
TempRegX:
    .res 1

CutsceneIdx: ; what cutscene to display
    .res 1

MustStopMusic:
    .res 1
MusicIsPlaying:
    .res 1

BSS_Free_Bytes:
    .res 3

;====================================================================================

;.macro bankswitch
;    sty current_bank      ; save the current bank in RAM so the NMI handler can restore it
;    lda banktable, y      ; read a byte from the banktable
;    sta banktable, y      ; and write it back, switching banks
;.endmacro

.segment "CODE"
;---------------------------
bankswitch_y:
;    cpy #8
;    bcs basta

    sty current_bank      ; save the current bank in RAM so the NMI handler can restore it
bankswitch_nosave:
    lda banktable, y      ; read a byte from the banktable
    sta banktable, y      ; and write it back, switching banks
;    jmp end
;basta:
;    lda #1
;end:
    rts
;----------------------------
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

    jsr LoadTitleGfx

    ldy #5
    jsr bankswitch_y

    jsr LoadTitleData ; from bank 5

    lda #%10010000   ; enable NMI, sprites from Pattern Table 0
    sta PPUCTRL
    sta $2000
    
    lda #%00011110   ; enable sprites
    sta $2001

    lda #3
    sta CutsceneIdx

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

    jsr famistudioupdate

    lda GameState
    cmp #STATE_GAME
    bne checkMenuState


    jsr RunSpriteUpdate

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
    cmp #STATE_CUTSCENE
    bne checkTitle
    dec CutsceneDelay
    bne runrandom

    jsr doCutscene
    jmp runrandom

checkTitle:
    cmp #STATE_TITLE
    bne checkGameOver

    jsr doTitle
    jmp runrandom

checkGameOver:
    cmp #STATE_GAME_OVER
    bne hide_sprites

    jsr doGameOver
    jmp runrandom

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
    bne skipSpriteZero
    lda current_bank
    sta bankBeforeNMI
    lda #1
    sta NMINotFinished
    lda #0
    sta skipZeroSpriteCheck
    jmp transferOAM
skipSpriteZero:
    lda #1
    sta skipZeroSpriteCheck
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
    bne otherState

    jsr UpdateTextBaloon
    lda MustUpdatePalette
    bne UpdatePalette

    jsr UpdateFireplace
    jsr UploadBgColumns
    jsr UploadModifiedTiles
    jsr UpdateStatusDigits
    jmp UpdatePalette
otherState:
    cmp #STATE_CUTSCENE
    bne checkTitleState

    jsr CutsceneNametableAnimations
    jmp UpdatePalette
checkTitleState:
    cmp #STATE_TITLE
    bne checkMenuStateUpdate

    jsr AnimateTitleTiles
checkMenuStateUpdate:
    cmp #STATE_MENU
    bne UpdatePalette


    lda MustUpdateSunMoon
    beq UpdatePalette
    lda $2002
    lda FirstNametableAddr
    clc
    adc #$02
    sta $2006
    lda #$9A
    sta $2006

    jsr UpdateSunMoonTiles


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

    lda skipZeroSpriteCheck
    bne justScroll
    lda GameState
    cmp #STATE_GAME
    beq WaitNotSprite0
    cmp #STATE_CUTSCENE
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

justScroll:
    lda ScrollX
    sta $2005        ; write the horizontal scroll count register

    lda ScrollY ; vertical scroll
    sta $2005

endOfNmi:
    lda PPUCTRL
    sta $2000


    lda current_bank
    cmp bankBeforeNMI
    beq noBankSwitch

    ldy bankBeforeNMI
    ;bankswitch
    jsr bankswitch_y

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
.include "lz4vram.s"
.include "decompress_rle.asm"
.include "graphics.asm"
.include "collision.asm"
.include "items.asm"
.include "npcs.asm"
.include "LoadOutsideMap.asm"
.include "random.asm"
.include "menu.asm"
.include "IntroCode.asm"
.include "IndoorCode.asm"
.include "SpriteUpdate.asm"
.include "AlienBasePreSwitchesLogic.asm"
;-----------------------------------
AnimateTitleTiles:

    lda current_bank
    cmp #5
    beq @doAnim

    ldy #5
    jsr bankswitch_y

@doAnim:
    jsr TitleTilesAnim

    rts
;-----------------------------------
famistudioupdate:

    ;famistudio update
    ldy current_bank
    sty oldbank

    ldy #6
    jsr bankswitch_y

    lda MustStopMusic
    beq @continue

    jsr famistudio_music_stop
    lda #0
    sta MustStopMusic
    sta MusicIsPlaying
    jmp @doSoundUpdate

@continue:
    lda MustPlaySfx
    beq @checkNewSong

    lda SfxName
    ldx #FAMISTUDIO_SFX_CH1
    jsr famistudio_sfx_play
    lda #0
    sta MustPlaySfx

    jmp @doSoundUpdate

@checkNewSong:
    lda MustPlayNewSong
    beq @doSoundUpdate

    sta MusicIsPlaying
    lda SongName
    jsr famistudio_music_play
    lda #0
    sta MustPlayNewSong

@doSoundUpdate:
    jsr famistudio_update

    ldy oldbank
    jsr bankswitch_y

@exit:
    rts


;---------------------------------
RunSpriteUpdate:
    ldy current_bank
    sty oldbank
    ldy #6
    jsr bankswitch_y


    jsr UpdateSprites ; bank 6


    ldy oldbank
    jsr bankswitch_y

    rts

;--------------------------------
doGameOver:

    ldy current_bank
    sty oldbank
    ldy #5
    ;bankswitch
    jsr bankswitch_y

    jsr UpdateGameOverSprites ; bank 5

    ldy oldbank
    ;bankswitch
    jsr bankswitch_y


    rts

;---------------------------------
doCutscene:

    ldy #CUTSCENE_SCENE_DELAY_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y
    sta CutsceneDelay

    ldy current_bank
    sty oldbank
    ldy #5
    ;bankswitch
    jsr bankswitch_y

    jsr CutsceneLogics
    beq @SpriteUpdate

    lda CutsceneIdx
    bne @SpriteUpdate ; don't start the game if idx is 1 or 2

    lda DemoModeOn
    beq @startGame

    lda #0
    sta DemoModeOn
    sta TitleScreenTimer

    lda #1
    sta MustLoadTitleCHR
    lda #1
    sta MustLoadSomething
    sta MustLoadTitle

    lda #%10010000
    sta PPUCTRL
    jmp @exit

@startGame:
    jsr FadeOutToStartGame
@SpriteUpdate:
    jsr UpdateCutsceneSprites

    ldy oldbank
    ;bankswitch
    jsr bankswitch_y
@exit:
    rts
;---------------------------------
doTitle:

    ldy current_bank
    sty oldbank
    ldy #5
    ;bankswitch
    jsr bankswitch_y

    jsr TitleLogics

    ldy oldbank
    ;bankswitch
    jsr bankswitch_y

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
    jsr LoadCutscene
    jsr LoadMenu

    jsr LoadInteriorMap

    lda MustLoadOutside
    beq @exit
    jsr LoadOutsideMap

@exit:
    rts

;---------------------------------
ResetNameTableAddresses:

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

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit

    ldy #3
    jsr bankswitch_y
    jsr FireplaceUpdate

@exit:
    rts
;--------------------------------------------
UploadModifiedTiles:

    lda ModifiedTilesToDraw
    beq @done

    tay
@tileLoop:
    dey
    bmi @done

    tya
    asl
    asl
    tax
    lda $2002
    lda ModifiedTilesBuffer, x
    sta $2006
    inx
    lda ModifiedTilesBuffer, x
    sta $2006
    inx
    lda ModifiedTilesBuffer, x
    sta $2007
    inx
    lda ModifiedTilesBuffer, x
    cmp #255
    beq @tileLoop
    sta $2007

    jmp @tileLoop

@done:
    lda #0
    sta ModifiedTilesToDraw

    rts

;--------------------------------------------
UpdateModifiedTiles:

    lda MustUpdateDestructibles
    bne @proceed
    rts

@proceed:
    ldy LocationIndex
    lda mod_tiles_count_by_location, y
    bne @hasTiles
    rts

@hasTiles:
    lda LocationIndex
    asl
    tay
    lda mod_tiles_by_location, y
    sta pointer2
    iny
    lda mod_tiles_by_location, y
    sta pointer2 + 1

    ldy #0
    sty TempNpcCnt ;will use this as a tile index

@tileLoop:
    lda TempNpcCnt ; idx * 8
    asl
    asl
    asl
    tay

    lda (pointer2), y
    tax
    lda ModifiedTiles, x
    sta TempNpcState ;store if the tile is modified

    lda ModifiedTilesToDraw
    cmp #5
    bcc @stillHaveSpace

    rts

@stillHaveSpace:
    iny ; tile status idx
    iny ; skip adress high
    iny ; skip address low
    lda (pointer2), y
    cmp CurrentMapSegmentIndex
    beq @continue ;tile matches screen
    bcc @nextTile
    ;current screen idx is less than what is desired
    sec
    sbc #1
    cmp CurrentMapSegmentIndex
    beq @checkScroll
    bcs @nextTile ; current idx is less than targetScreen - 1
@checkScroll:

    ;TODO: remove this scroll checking
    lda DirectionX
    cmp #1
    bne @pass

    jsr CheckModTileScroll
    bcc @nextTile
    ldy TempNpcSpeed
    jmp @pass


@continue: ;tile matches the current screen
    iny ;y
    iny ;x

    lda (pointer2), y
    asl
    asl
    asl
    clc
    adc #8
    cmp ScrollX
    bcc @nextTile

    dey ; y
    dey ; screen
@pass:
    dey ; address low
    dey ; address high

@newTile:
    lda ModifiedTilesToDraw
    asl
    asl
    tax

    lda ModifiedTileHalfFull
    bne @tryToCompleteTile
    
    jsr StoreModTileToDraw

    jmp @nextTile

@tryToCompleteTile:
    lda (pointer2), y
    cmp ModifiedTilesBuffer, x
    beq @continueCompletion

@jumptoNew:
    inc ModifiedTilesToDraw
    lda #0
    sta ModifiedTileHalfFull
    jmp @newTile

@continueCompletion:
    iny
    inx
    lda (pointer2), y
    sec
    sbc #1
    cmp ModifiedTilesBuffer, x
    beq @completeIt

    dey
    jmp @jumptoNew

@completeIt:
    iny ;screen
    iny ;x
    iny ;y
    iny ;value
    lda TempNpcState
    bne @moded
    iny
@moded:

    inx ; skip previous tile value
    inx ; at value 2
    lda #0
    sta ModifiedTileHalfFull
    lda (pointer2), y
    sta ModifiedTilesBuffer, x
    inc ModifiedTilesToDraw

@nextTile:
    inc TempNpcCnt
    lda TempNpcCnt
    ldx LocationIndex
    cmp mod_tiles_count_by_location, x
    bcs @exit

    jmp @tileLoop

@exit:
    lda ModifiedTileHalfFull
    beq @ok
    inc ModifiedTilesToDraw
    lda #0
    sta ModifiedTileHalfFull
@ok:
    lda #0
    sta MustUpdateDestructibles

    rts
;-------------------------------------------
CheckModTileScroll:
    sty TempNpcSpeed
    ldy LocationIndex
    lda mod_tiles_count_by_location, y
    asl
    asl
    asl
    clc
    adc LocationIndex
    tay

    lda ScrollX
    cmp (pointer2), y
    
    rts

;--------------------------------------------
StoreModTileToDraw:
    lda (pointer2), y
    sta ModifiedTilesBuffer, x
    iny ;address lo
    inx
    lda (pointer2), y
    sta ModifiedTilesBuffer, x
    iny ;screen
    iny ; y
    iny ; x
    iny ; tile value
    lda TempNpcState ; is tile modified or not
    bne @cont
    iny ; second tile value
@cont:
    inx
    lda (pointer2), y
    sta ModifiedTilesBuffer, x
    inx
    lda #255
    sta ModifiedTilesBuffer, x

    lda #1
    sta ModifiedTileHalfFull

    rts

;--------------------------------------------
;BgColumnIdxToUpload - column to be updated from ROM
;Check and upload background columns from rom map to the PPU
UploadBgColumns:

    lda ScreenCount
    cmp #MIN_SCREEN_COUNT_TO_UPDATE
    bcs @bigmap

    rts

@bigmap:

    lda MustUpdateMapColumn
    beq @updateAttributes


    lda SourceMapIdx
    cmp ScreenCount
    bcc @doUpdates

    rts

@doUpdates:

    lda #1
    sta MustUpdateDestructibles

    ; somewhat of a crutch, activates NMI if it was delayed before
    ; prevents the CHR ram corruption in some cases
    lda PPUCTRL
    sta $2000

    ;calculate destination address
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

    ldx #0
@loop:
    lda MapColumnData, x
    sta $2007

@cont:
    inx
    cpx #SCREEN_ROW_COUNT - 4
    bcc @loop

    lda PPUCTRL ; restore normal ppu addressing
    sta $2000

    lda BgColumnIdxToUpload
    sta OldBgColumnIdxToUpload
    lda SourceMapIdx
    sta OldSourceMapIdx
    lda #0
    sta MustUpdateMapColumn

@updateAttributes:
    lda MustUpdateMapAttributeColumn
    beq @exit

    lda #0
    sta $2001

    ldx #0 ;
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

    lda MapColumnAttributes, x
    sta $2007


    inx
    cpx #8
    bcc @attribLoop
@done:

    lda SourceMapIdx
    sta OldSourceMapIdx
    lda AttribColumnIdxToUpdate
    sta OldAttribColumnIdxToUpdate
    lda #0
    sta MustUpdateMapAttributeColumn


@exit:
    rts

;-----------------------------------
Logics:

    lda NMIActive
    bne @begin

    rts

@begin:
    lda GameState
    cmp #STATE_GAME
    beq @gameOn

    rts

@gameOn:
    ;-----------
    lda current_bank
    sta oldbank
    ldy #1
    jsr bankswitch_y
    ;----- switching to bank 1

    jsr FadingOutForGameOver
    bne @doneLogics
    jsr ActivateYouWin   ; bank 1
    jsr UpdateIndoorFire ; bank 1

    jsr PlayerHPCheck ; bank 1
    bne @doneLogics ; player was killed

    jsr DecreaseFuel ;bank 1
    jsr WarmthLogics ;bank 1
    jsr FoodLogics   ;bank 1

    jsr RunTime        ; bank 1
    jsr RestoreStamina ; bank 1

@doneLogics:
    jsr UpdateFishingRod ; bank 1
    jsr UpdateAttackTimer; bank 1
    jsr UpdateImportantItemTimer; bank 1
    jsr CheckEntryPoints ; bank 1

    ;-----------------
    ldy oldbank
    jsr bankswitch_y
    ;------------------

    jsr UpdateModifiedTiles
    jsr UpdateProjectiles
    jsr UpdateSpear

@exit:
    rts
;------------------------------
.segment "ROM1"
;if a has 1 at the end must abort logics
FadingOutForGameOver:
    lda PlayerAlive
    bne @exit
;----activate fading out for the game over
    lda MustLoadGameOver
    bne @abort
    lda PaletteFadeAnimationState
    bne @exit
    lda #1
    sta PaletteFadeAnimationState

    lda CheckpointSaved
    beq @gameOver
    jmp @cont
@gameOver:
    lda #1
    sta MustLoadGameOverAfterFadeOut
@cont:
    lda #0
    sta PaletteFadeTimer
    sta FadeIdx
    lda #FADE_DELAY_GAME_OVER
    sta PaletteAnimDelay

@abort:
    lda #1
    jmp @done
@exit:
    lda #0
@done:
    rts
;------------------------------
UpdateAttackTimer:
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
    rts
;------------------------------
ActivateYouWin:
    lda PlayerWins
    beq @exit
    lda PaletteFadeAnimationState
    bne @exit
    lda #1
    sta PaletteFadeAnimationState
    sta MustShowOutroAfterFadeout
    lda #0
    sta CheckpointSaved
    sta PaletteFadeTimer
    sta FadeIdx
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay
@exit:
    rts
;---------------------------------
UpdateIndoorFire:
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
;if a register is 1, logics needs to be aborted
PlayerHPCheck:
    lda HP
    clc
    adc HP + 1
    adc HP + 2
    cmp #0
    bne @exit

;Kill player
    lda #0
    sta PlayerAlive
    lda #1
    jmp @done

@exit:
    lda #0
@done:
    rts

;-----------------------------------
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


    lda LocationIndex
    tax
    lda EntryPointCountForLocation, x
    sta TempNpcCnt ; save entry point count

    lda LocationIndex
    asl
    tax
    lda LocationEntryPointPtrs, x
    sta pointer2
    inx
    lda LocationEntryPointPtrs, x
    sta pointer2 + 1
    ldy #0
    ldx #0
@entryPointLoop:
    txa
    asl
    asl
    asl
    tay

    lda (pointer2), y ; entry index
    sta ActiveMapEntryIndex
    iny
    lda (pointer2), y ; CurrentMapSegmentIndex
    cmp CurrentMapSegmentIndex
    bne @nextEntry
    iny             ;minX
    lda PlayerX
    cmp (pointer2), y
    bcc @nextEntry
    iny             ;maxX
    cmp (pointer2), y
    bcs @nextEntry
    lda ScrollX
    iny
    cmp (pointer2), y
    bcc @nextEntry
    iny
    cmp (pointer2), y
    bcs @nextEntry
    lda PlayerY
    iny             ;minY
    cmp (pointer2), y
    bcc @nextEntry
    iny
    cmp (pointer2), y
    bcs @nextEntry


    lda PaletteFadeAnimationState
    bne @exit


    ldy #0
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
    inx
    cpx TempNpcCnt ; count for that location
    bcc @entryPointLoop

@exit:
    rts
;--------------------------------
UpdateImportantItemTimer:

    lda ImportantItemTimer
    beq @exit

    sec
    sbc #1
    sta ImportantItemTimer
    beq @done
    jmp @exit
@done:
    lda #1
    sta PlayerAnimationRowIndex
@exit:
    rts
;--------------------------------
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

.segment "CODE"
;-------------------------------
UpdateProjectiles:

    ldy ProjectileCount
    bne @continue

    rts

@continue:
    dey
    sty ProjectileIdx

@projectileLoop:
    ldy ProjectileIdx
    lda projectiles_ram_lookup, y
    tay

    jsr UpdateSingleProjectile

@next:
    dec ProjectileIdx
    bpl @projectileLoop


@exit:
    rts
;-------------------------------
UpdateSingleProjectile:

    lda #<Projectiles
    sta ProjectilePtr
    lda #>Projectiles
    sta ProjectilePtr + 1


    lda Projectiles, y
    lsr
    bcs @continue   ;the projectile is active

    rts

@continue:

    cmp #PROJECTILE_DIR_LEFT
    bcc @otherDir
    beq @moveLeft

    lda #8
    sta ProjectileWidth
    jsr MoveProjectileRight
    bne @disable
    jmp @filter

@moveLeft:
    jsr MoveProjectileLeft
    bne @disable

@filter:

    jmp @exit

@otherDir:

    iny ; x
    iny ; x2
    iny ; screen
    iny ; y
    jsr MoveProjectileVerticaly
    cmp #1
    beq @disable

    jmp @exit


@disable:

    jsr DisableProjectiles

@exit:

    rts
;-----------------------------
DisableProjectiles:

    ldy ProjectileIdx
    lda projectiles_ram_lookup, y
    tay
    sty TempYOffset

    iny
    lda Projectiles, y
    sta TempPointX
    iny
    iny
    lda Projectiles, y
    sta TempScreen
    iny
    lda Projectiles, y
    sta TempPointY

    lda #%00001101 ; 7 + active bit
    sta TempItemIndex
    jsr ItemSpawnPrep
    lda TempScreen
    sta Items, y
    iny
    lda TempPointX
    sta Items, y
    iny
    lda TempPointY
    sta Items, y


    ldy TempYOffset
    lda #0
    sta Projectiles, y


    rts
;-----------------------------
;stores A as ItemMapScreenIndex
;calculates screen indexes and filters out screens
ScreenFilter:

    sta ItemMapScreenIndex
    clc
    adc #1
    sta NextItemMapScreenIndex
    sec
    sbc #2
    sta PrevItemMapScreenIndex


    lda ItemMapScreenIndex
    beq @skipPrev
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @disable
@skipPrev:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcc @exit

@disable:
    lda #1
    jmp @end
@exit:
    lda #0
@end:
    rts


;setup the ProjectileWidth
;-------------------------------
MoveProjectileRight:

    iny
    sty TempYOffset
    iny
    lda (ProjectilePtr), y ; y fraction
    clc
    adc #PROJECTILE_SPEED_FRAC
    sta (ProjectilePtr), y
    dey
    lda (ProjectilePtr), y ; x
    adc ProjectileWidth
    bcs @more
    clc
    adc #PROJECTILE_SPEED_INT
    bcs @more
    ;---
    sta TempPointX
    iny
    iny
    lda (ProjectilePtr), y ; screen
    sta TempScreen
    iny
    lda (ProjectilePtr), y ; y
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @return_disable ;it does

    ;---

    ldy TempYOffset ; restore where x coordinate was
    lda TempPointX
    sec
    sbc ProjectileWidth
    sta (ProjectilePtr), y

    jmp @filter


@more:
    lda #255
    sec
    sbc (ProjectilePtr), y
    sec
    sbc ProjectileWidth
    sta Temp
    lda #PROJECTILE_SPEED_INT
    sec
    sbc Temp

    sta TempPointX

    iny
    iny
    lda (ProjectilePtr), y ;screen
    clc
    adc #1

    sta TempScreen
    iny
    lda (ProjectilePtr), y; y
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @return_disable

    ldy TempYOffset ; restore index of x coordinates location
    lda TempPointX
    sec
    sbc ProjectileWidth
    sta (ProjectilePtr), y
    cmp TempPointX
    bcc @cont
    dec TempScreen
@cont:
    iny
    iny
    lda TempScreen
    sta (ProjectilePtr), y


@filter:
    lda #0
    jmp @exit

@return_disable:
    lda #1


@exit:


    rts
;-------------------------------
UpdateSpear:

    lda #<SpearData
    sta ProjectilePtr
    lda #>SpearData
    sta ProjectilePtr + 1
    ldy #0


    lda SpearData ; Dir + Active
    lsr
    bcc @exit

    cmp #PROJECTILE_DIR_LEFT
    bcc @otherDir
    beq @moveLeft

    lda #16
    sta ProjectileWidth
    jsr MoveProjectileRight
    bne @disable
    jmp @filter

@moveLeft:

   jsr MoveProjectileLeft
   bne @disable

@filter:
    ldy #2
    jmp @exit

@otherDir:

    ldy #4 ; set to Y

    jsr MoveProjectileVerticaly
    cmp #1
    beq @disable

    jmp @exit

@disable:
    jsr DisableSpear


@exit:

    rts
;-------------------------------
MoveProjectileLeft:

    iny
    sty TempYOffset ; store x coord position

    iny; x fraction
    lda (ProjectilePtr), y
    sec
    sbc #PROJECTILE_SPEED_FRAC
    sta (ProjectilePtr), y
    dey ;x integer part
    lda (ProjectilePtr), y
    sbc #PROJECTILE_SPEED_INT
    sta TempPointX
    bcc @less

    iny
    iny
    lda (ProjectilePtr), y ; screen
    sta TempScreen
    iny
    lda (ProjectilePtr), y; y
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @return_disable ;it does

    ldy TempYOffset ; restore x coord pos
    lda TempPointX

    sta (ProjectilePtr), y
    jmp @filter

@less:

    ;decrease screen idx
    iny
    iny
    lda (ProjectilePtr), y
    sec
    sbc #1
    sta TempScreen
    iny
    lda (ProjectilePtr), y ; y
    sta TempPointY


    jsr TestPointAgainstCollisionMap
    bne @return_disable


    ldy TempYOffset ; restore x coord pos
    lda TempPointX
    sta (ProjectilePtr), y
    iny
    iny
    lda TempScreen
    sta (ProjectilePtr), y

@filter:
    lda #0
    jmp @exit

@return_disable:
    lda #1

@exit:
    rts


;-------------------------------
DisableSpear:

    lda EquipedItem + 1
    cmp #ITEM_MAX_HP
    bne @simplyRemove

    lda #%00001111 ; 7 + active bit
    sta TempItemIndex
    jsr ItemSpawnPrep
    lda SpearData + 3 ; screen
    sta Items, y
    iny
    lda SpearData + 1 ; x
    sta Items, y
    iny
    lda SpearData + 4 ; y
    sta Items, y

@simplyRemove:
    lda #0
    sta EquipedItem
    sta SpearData

    rts


;------------------------------
MoveProjectileVerticaly:
    cmp #PROJECTILE_DIR_DOWN
    bne @checkUp

    iny
    lda (ProjectilePtr), y ; y fraction
    clc
    adc #PROJECTILE_SPEED_FRAC
    dey
    lda (ProjectilePtr), y ; Y
    adc #PROJECTILE_SPEED_INT

    sta TempPointY
    sty TempYOffset
    dey
    lda(ProjectilePtr), y ;screen
    sta TempScreen
    dey
    dey
    lda (ProjectilePtr), y; x
    sta TempPointX


    jsr TestPointAgainstCollisionMap
    bne @return_disable ;it does

    ldy TempYOffset
    lda TempPointY
    sta (ProjectilePtr), y ; Y
    cmp #252
    bcs @return_disable


@checkUp:
    cmp #PROJECTILE_DIR_UP
    bne @exit

    iny
    lda (ProjectilePtr), y ; y fraction
    sec
    sbc #PROJECTILE_SPEED_FRAC
    dey
    lda (ProjectilePtr), y ; y
    sbc #PROJECTILE_SPEED_INT

    sta TempPointY
    sty TempYOffset
    dey
    lda(ProjectilePtr), y ;screen
    sta TempScreen
    dey
    dey
    lda (ProjectilePtr), y; x
    sta TempPointX

    jsr TestPointAgainstCollisionMap
    bne @return_disable

    lda TempPointY
    ldy TempYOffset

    sta (ProjectilePtr), y ; Y
    cmp #PROJECTILE_SPEED_INT
    bcc @return_disable

    lda #0
    jmp @exit

@return_disable:
    lda #1


@exit:

    rts

;-------------------------------
DoPaletteFades:

    lda GameState
    cmp #STATE_GAME
    bne @continue

    lda PaletteFadeAnimationState
    bne @continue

    lda PlayerDamagedCounter
    beq @checkRed
    sec
    sbc #1
    sta PlayerDamagedCounter
    bne @checkRed

    ldy #29
    lda #$0F
    sta RamPalette, y
    lda #32
    sta PaletteUpdateSize
    lda #1
    sta MustUpdatePalette


@checkRed:
    lda RedCounter
    beq @continue
    sec
    sbc #1
    sta RedCounter
    beq @resetRed

    rts
@resetRed:
    ldy #0
    lda (CurrentMapPalettePtr), y
    sta RamPalette
    lda #1
    sta MustUpdatePalette
    sta PaletteUpdateSize
    jmp @exit

@continue:
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
FadeAfterSleep:
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
;-----------------------------
OnYouWin:
    lda #1
    sta MustLoadCutscene
    sta MustLoadSomething
    sta MustLoadIntroChr
    lda #0
    sta PaletteFadeAnimationState
    sta MustShowOutroAfterFadeout


    lda VillagerKilled
    clc
    adc VillagerKilled + 1
    adc VillagerKilled + 2
    cmp #0
    bne @evilEnding

    lda #SONG_ENDING_GOOD
    sta SongName
    lda #1
    sta CutsceneIdx
    jmp @activateNewSong
@evilEnding:
    lda #2
    sta CutsceneIdx
    lda #SONG_ENDING_EVIL
    sta SongName

@activateNewSong:
    lda #1
    sta MustPlayNewSong


    ldy #5
    jsr bankswitch_y
    jsr InitCutscene
    rts

;------------------------------
RoutinesAfterFadeOut:

    lda IsLocationRoutine
    bne @locationRoutines

    ;fade in after sleep
    lda MustSleepAfterFadeOut
    beq @next
    jsr FadeAfterSleep
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

    jsr OnYouWin

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

    lda CheckpointSaved
    beq @newGame

    jsr LoadCheckPoint
    rts

@newGame:
    jsr StartGame
    rts

    ;---------------------------------------
@locationRoutines: ;location routines start here
    ;--some general location code----
    jsr CommonLocationRoutine
    ;-----------------------------
    ;4.Bjorn's house entrance
@next1:
    lda ActiveMapEntryIndex
    cmp #4
    bne @next2

    lda #0
    sta VillagerIndex

    ldy #0
    lda VillagerKilled, y
    beq @cont_bjorn

    lda #0
    sta NpcCount
    jmp @next2

@cont_bjorn:
    jsr GetPaletteFadeValueForHour
    cmp #DAYTIME_NIGHT
    bne @skip_night

    lda #0
    sta EnteredBeforeNightfall

    lda #<Hut_npcs_night
    sta pointer
    lda #>Hut_npcs_night
    sta pointer + 1
    lda #0
    sta NpcCount
    jsr LoadNpcs
    jmp @next2

@skip_night:

    lda #1
    sta EnteredBeforeNightfall
    ;------------------------------------
    ;9.Bjorn's house exit
@next2:
    lda ActiveMapEntryIndex
    cmp #9
    bne @next4

    jsr OnExitVillagerHut
    ;--------------------------
    ;5. second location exit
@next4:
    lda ActiveMapEntryIndex
    cmp #5
    bne @next7

    jsr FlipStartingNametable ; for the breakable rock
    ;---------------------------------------------
    ;10.Player's house exit
@next7:

    lda ActiveMapEntryIndex
    cmp #10
    bne @next8

    lda #0
    sta FirstTime

    lda #1
    sta MustCopyMainChr
    ;-----------------------------------------
    ;7.Exit point of third location
@next8:

    lda ActiveMapEntryIndex
    cmp #7
    bne @next9

    lda #2
    sta ScrollDirection
    jsr FlipStartingNametable ;for the rock
    ;------------------------------------------
    ;8.Erika's house entrance
@next9:

    lda ActiveMapEntryIndex
    cmp #8
    bne @next10

    lda #1
    sta VillagerIndex

    tay
    lda VillagerKilled, y
    beq @cont_erika
    lda #0
    sta NpcCount
    jmp @next10
@cont_erika:
    jsr SpawnQuestItems
    jsr SpawnSpecialItemOwnerReward

    ;------------------------------------------
    ;11.Second villager house's exit
@next10:

    lda ActiveMapEntryIndex
    cmp #11
    bne @next11

    lda #2
    sta ScrollDirection

    jsr OnExitVillagerHut
    ;----------------------------
    ;27.cave entrance from location 11
@next11:
    lda ActiveMapEntryIndex
    cmp #27
    bne @next12

    lda #2
    sta ScrollDirection

    lda #0
    sta FirstTime
    ;---------------------
    ;12. crashsite entrance from cave
@next12:

    lda ActiveMapEntryIndex
    cmp #12
    bne @next13

    lda #1
    sta MustCopyMainChr
    ;------------------------------
    ;17.crashsite exit to cave
@next13:

    lda ActiveMapEntryIndex
    cmp #17
    bne @next14

    lda #2
    sta ScrollDirection

    lda #1
    sta MustCopyMainChr

    ;-------------------------
    ;13.cave exit to cave location
@next14:
    lda ActiveMapEntryIndex
    cmp #13
    bne @next16

    lda #2
    sta ScrollDirection

    lda #1
    sta MustCopyMainChr
    lda #0
    sta CheckpointSaved
    ;-------------------------
    ;19. exit from the grannys location
@next16:
    lda ActiveMapEntryIndex
    cmp #19
    bne @next17

    jsr FlipStartingNametable ; for the breakable rock
    ;----------------------------
    ;20.granny's house
@next17:
    lda ActiveMapEntryIndex
    cmp #20
    bne @next18

    lda #2
    sta VillagerIndex

    tay
    lda VillagerKilled, y
    beq @cont_granny

    lda #0
    sta NpcCount
    jmp @next18

@cont_granny:
    jsr SpawnQuestItems
    jsr SpawnSpecialItemOwnerReward

    ;-------------------------------
    ;22.exit from grannys house
@next18:
    lda ActiveMapEntryIndex
    cmp #22
    bne @next24

    lda #2
    sta ScrollDirection

    jsr OnExitVillagerHut
    ;------------------------
    ;25. Boss room entrance
@next24:

    lda ActiveMapEntryIndex
    cmp #25
    bne @next25

    lda #<alien_palette
    sta PalettePtr
    lda #>alien_palette
    sta PalettePtr + 1


    ldy #3
    lda VillagerKilled, y
    bne @next25
    lda #<boss_npcs
    sta pointer
    lda #>boss_npcs
    sta pointer + 1
    lda #0
    sta NpcCount
    jsr LoadNpcs


    lda #3
    sta VillagerIndex
    ;-------------------------
    ;29 Boss room exit
@next25:

    lda ActiveMapEntryIndex
    cmp #29
    bne @next27

    jsr FlipStartingNametable ; for the locked door, so the second screen would always be in adress $24**

    lda #0
    sta BossAgitated
    ;-----------------------
    ;14 dark cave entrance
@next27:
    lda ActiveMapEntryIndex
    cmp #14
    bne @next28

    lda #ITEM_LAMP
    sta TempItemIndex
    lda #<Inventory
    sta pointer2
    lda #>Inventory
    sta pointer2 + 1
    jsr IsItemXInInventory
    bne @saveTheGame ; it is

    lda #<dark_cave_palette
    sta CurrentMapPalettePtr
    lda #>dark_cave_palette
    sta CurrentMapPalettePtr + 1
    jmp @next28
@saveTheGame:
    ldy #3
    lda VillagerKilled, y
    bne @next28
    lda CheckpointSaved
    bne @next28

    lda current_bank
    sta oldbank
    ldy #0
    jsr bankswitch_y ; switch to bank 0
    jsr SaveGame     ; call from bank 0
    lda #1
    sta CheckpointSaved
    ldy oldbank
    jsr bankswitch_y
    ;---------------------
    ;21 secret cave entrance
@next28:
    lda ActiveMapEntryIndex
    cmp #21
    bne @next35

    lda #1
    sta MustCopyMainChr

    jsr TurnDarkPaletteOn
    ;------------------------
    ;31 dark cave 2
@next35:

    lda ActiveMapEntryIndex
    cmp #31
    bne @next36

    jsr TurnDarkPaletteOn
    ;---------------------------
    ;34 from dark cave 2 to dark cave 1
@next36:
    lda ActiveMapEntryIndex
    cmp #34
    bne @next37

    jsr TurnDarkPaletteOn
    ;-------------------
    ;38 exit from alien lobby to dark cave 2
@next37:
    lda ActiveMapEntryIndex
    cmp #38
    bne @next40

    lda #1
    sta MustCopyMainChr
    jsr TurnDarkPaletteOn

    ;---------------------
@next40:
    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @itsAnIndoorMap
    cmp #LOCATION_TYPE_HOUSE
    beq @itsAnIndoorMap
    lda #1
    sta MustLoadOutside
    sta MustUpdateDestructibles

    lda ActiveMapEntryIndex
    lda #1
    jmp @saveCopyFlag
@notcopy:
    lda #0
@saveCopyFlag:
    sta MustCopyMainChr

    jmp @finish
@itsAnIndoorMap:
    lda #1
    sta MustLoadHouseInterior

    lda ActiveMapEntryIndex
    lda #1
    jmp @saveCHRloading
@saveCHRloading:
    sta MustCopyMainChr

@finish:
    lda #1
    sta MustLoadSomething ; activate location loading in NMI
    sta MustUpdateSunMoon
    lda #255
    sta OldBgColumnIdxToUpload
    sta OldSourceMapIdx
    sta OldAttribColumnIdxToUpdate
    sta TaintedSprites
    jsr CalcMapColumnToUpdate


    rts
;------------------------------
TurnDarkPaletteOn:

    lda #ITEM_LAMP
    sta TempItemIndex
    lda #<Inventory
    sta pointer2
    lda #>Inventory
    sta pointer2 + 1
    jsr IsItemXInInventory
    bne @exit ; it is

    lda #<dark_cave_palette
    sta CurrentMapPalettePtr
    lda #>dark_cave_palette
    sta CurrentMapPalettePtr + 1
@exit:

    rts
;------------------------------
CommonLocationRoutine:

    ldy #0 ;switch to bank where the MapSpawnPoint is
    jsr bankswitch_y

    lda #NUM_OF_BUNNIES_BEFORE_DOG
    sta DogCounter
    lda #0
    sta IsLocationRoutine
    sta PaletteFadeAnimationState
    sta ModifiedTilesToDraw
    sta ModifiedTileHalfFull

    lda #<MapSpawnPoint
    sta pointer2
    lda #>MapSpawnPoint
    sta pointer2 + 1


    lda ActiveMapEntryIndex
    beq @letsgo

    tax
    lda pointer2
@addressLoop:
    clc
    adc #16
    sta pointer2
    bcs @increaseUpper
    jmp @contAddressCalc

@increaseUpper:
    inc pointer2 + 1
@contAddressCalc:

    dex
    bne @addressLoop

@letsgo:
    ldy #0

    lda (pointer2), y
    sta PlayerX
    iny
    lda (pointer2), y
    sta PlayerY
    iny
    lda (pointer2), y
    sta LocationIndex
    iny
    lda (pointer2), y
    sta ScreenCount
    iny
    lda (pointer2), y ; Location type
    cmp LocationType
    beq @sameLocationType
    sta LocationType
    lda #1
    sta MustStopMusic
@sameLocationType:
    iny
    lda (pointer2), y ; upper address to item data
    sta SongName

    sty TempY
    lda LocationIndex
    asl
    tay
    lda LocationItems, y
    sta ItemListPtr
    iny
    lda LocationItems, y
    sta ItemListPtr + 1

    ldy TempY

    iny
    lda (pointer2), y ;rom bank for the location
    sta LocationBankNo

    iny
    lda (pointer2), y ; scroll X
    sta ScrollX
    iny
    lda (pointer2), y ; active screen
    sta CurrentMapSegmentIndex
    iny
    lda (pointer2), y ; is the location indoors or outdoors
    ;sta DetectedMapType

    iny
    lda (pointer2), y ;indoor map address (lower byte)
    sta CurrentMapPalettePtr
    iny
    lda (pointer2), y ;indoor map address (higher byte)
    sta CurrentMapPalettePtr + 1
;---
    iny

    lda #0
    sta NpcCount

    sty TempY
    lda (pointer2), y ;generated npc count
    sta TempScreenNpcCount
    beq @skipGeneration ; 0 generated
    sta TempNpcCnt
    iny
    iny
    iny
    lda (pointer2), y
    sta TempIndex ; map segment for generator

    jsr GenerateNpcs
    inc TempIndex
    lda TempIndex
    cmp ScreenCount
    bcs @skipLoadingNpcs
    lda TempScreenNpcCount
    sta TempNpcCnt

    jsr GenerateNpcs
@skipGeneration:
    ldy TempY
    iny
    lda (pointer2), y
    sta pointer
    iny
    lda (pointer2), y
    sta pointer + 1
    lda pointer
    cmp #0
    beq @checkAnother

    jmp @loadNpcs
@checkAnother:
    cmp pointer + 1
    beq @skipLoadingNpcs
@loadNpcs:
    ldy LocationBankNo
    jsr bankswitch_y

    jsr LoadNpcs
@skipLoadingNpcs:

    ldy LocationBankNo
    jsr bankswitch_y

    jsr LoadItems

    lda #0
    sta ScrollDirection

    jsr BuildRowTable
    jsr ResetNameTableAddresses


    rts
;-------------------------------
;put item id in TempItemIndex
;pointer2 - points to a container (inventory or storage)
IsItemXInInventory:

    ldx #INVENTORY_MAX_ITEMS - 1
@loop:
    txa
    asl
    tay
    lda (pointer2), y
    cmp TempItemIndex
    beq @found
    dex
    bpl @loop

    lda #0
    jmp @end

@found:
    lda #1

@end:
    rts


;-------------------------------
OnExitVillagerHut:
    lda ItemIGave
    bne @cont ; increment quest only if the regular item was given

    lda #0
    sta DontIncrementQuestNumber

    ldy VillagerIndex
    lda ActiveVillagerQuests, y
    sta Temp ; store villager quest number


    ;what if this npc is his own receiver?
    lda VillagerIndex
    asl
    tay
    lda special_quests, y
    cmp VillagerIndex
    bne @checkIfDifferentReceiver
    iny
    lda special_quests, y ; quest number
    cmp Temp
    bne @checkIfDifferentReceiver

    lda VillagerIndex
    asl
    tax
    inx
    lda #1
    sta DontIncrementQuestNumber
    ldy VillagerIndex
    lda SpecialItemsDelivered, y
    bne @special


@checkIfDifferentReceiver:
    ;check if an item was delivered to a receiver of this npc
    ldy VillagerIndex
    lda special_receivers, y
    tay
    lda SpecialItemsDelivered, y
    beq @exit ; nope, the quest was not completed

   
    ldy #0

    ;does the active quest number match the number from the list ?
@villagerloop:
    tya
    asl
    tax
    lda special_quests, x
    cmp VillagerIndex
    bne @next
    inx
    lda special_quests, x
    cmp Temp ; compare with active villager quest
    beq @special

@next:
    iny
    cpy #MAX_VILLAGERS
    bcc @villagerloop
    bcs @exit

@special:

    ldy VillagerIndex
    lda #0
    sta TakenQuestItems, y
    dex
    txa
    lsr
    tax
    lda #0
    sta SpecialItemsDelivered, x

    lda DontIncrementQuestNumber
    bne @exit


@cont:
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

;------------------------------
DoFoodSpoilage:

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

    rts
;---------------------------------
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
    lda #0
    sta TempPointX2
    jsr ResetTimesWhenItemsWerePicked
    jsr DoFoodSpoilage

@exit:
    rts
;--------------------------------
;gets the item id that is spawned for the quest
;input: Y - villager index
;output: A - item id
GetItemIdForTheQuest:

    lda ActiveVillagerQuests, y
    sta Temp
    tya
    asl
    asl
    clc
    adc Temp
    tay
    lda quest_items, y


    rts
;---------------------------------
;spawn items needed for the villager quest
SpawnQuestItems:

    ldy VillagerIndex
    
    lda ActiveVillagerQuests, y
    cmp #MAX_QUEST - 1
    bcc @cont

    lda CompletedSpecialQuests, y
    bne @cont

    jmp @exit

@cont:

    lda TakenQuestItems, y
    bne @exit

    jsr GetItemIdForTheQuest
    beq @exit

    asl
    ora #%00000001
    sta Items
    lda #0
    sta Items + 1
    lda #120
    sta Items + 2
    lda #108
    sta Items + 3

    lda #1
    sta ItemCount

@exit:
    rts
;---------------------------------
SpawnSpecialItemOwnerReward:



    ldy VillagerIndex
    lda special_receivers, y
    tay
    lda SpecialItemsDelivered, y
    beq @exit

    ldy VillagerIndex
    lda TakenQuestItems, y
    beq @exit
    tya
    asl
    asl
    clc
    adc ActiveVillagerQuests, y
    tay


    lda reward_items_list, y
    beq @exit
    asl
    ora #%00000001
    sta Items
    lda #0
    sta Items + 1
    lda #120
    sta Items + 2
    lda #108
    sta Items + 3

    lda #1
    sta ItemCount

    ldy VillagerIndex
    lda special_receivers, y
    tay
    lda #1
    sta CompletedSpecialQuests, y

@exit:
    rts


;---------------------------------
;pointer - storage or inventory
RotFood:

    ldy #0
@loop:
    sty TempInventoryItemIndex
    tya
    asl ; y * 2
    tay

    lda (pointer), y
    beq @nextItem       ;if empty

    cmp #ITEM_RAW_MEAT
    beq @setRaw
    cmp #ITEM_RAW_JUMBO_MEAT
    beq @setRaw
    cmp #ITEM_RAW_FISH
    beq @setRaw
    cmp #ITEM_MUSHROOM
    beq @setRaw
    jmp @checkCooked

@setRaw:
    lda #ROT_AMOUNT_RAW_MEAT
    sta RotAmount
    jmp @rot

@checkCooked:
    cmp #ITEM_COOKED_MEAT
    beq @setCooked
    cmp #ITEM_COOKED_JUMBO_MEAT
    beq @setCooked
    cmp #ITEM_COOKED_FISH
    beq @setCooked
    cmp #ITEM_COOKED_MUSHROOM
    beq @setCooked

    jmp @nextItem

@setCooked:
    lda #ROT_AMOUNT_COOKED_MEAT
    sta RotAmount
@rot:
    iny
    lda (pointer), y
    cmp RotAmount
    bcc @turnToPoop
    beq @turnToPoop

    sec
    sbc RotAmount
    sta (pointer), y
    jmp @nextItem


@turnToPoop:
    dey
    lda #ITEM_POOP
    sta (pointer), y

    
@nextItem:
    ldy TempInventoryItemIndex ; stored item index
    iny
    cpy #INVENTORY_MAX_ITEMS
    bcc @loop

    rts


;-------------------------------
;PalettePtr - where to store the modified palette
AdaptBackgroundPaletteByTime:
    lda #1
    sta MustUpdateSunMoon
    lda LocationType
    cmp #LOCATION_TYPE_CAVE
    beq @continuewith
    cmp #LOCATION_TYPE_DARK
    beq @continuewith
    cmp #LOCATION_TYPE_OUTDOORS
    beq @continuewith
    rts

@continuewith:

    ldy #$01 ;keeps the outline for the background objects

    lda LocationType
    cmp #LOCATION_TYPE_DARK
    beq @check_lamp

    jmp @regular_cave_check

@check_lamp:
    lda #ITEM_LAMP
    sta TempItemIndex
    lda #<Inventory
    sta pointer2
    lda #>Inventory
    sta pointer2 + 1
    jsr IsItemXInInventory
    beq @dark_cave

@regular_cave_check:
    lda LocationType
    cmp #LOCATION_TYPE_OUTDOORS
    beq @calc ; if not in cave, we need to use lookup table to get certain fade level

    ldx #5 ; evening time index
    lda palette_fade_for_periods, x
    jmp @cont

@dark_cave:

    ldx #0 ; evening time index
    lda palette_fade_for_periods, x
    jmp @cont

@calc:
    jsr GetPaletteFadeValueForHour
    sta TempY ;backup the Fadevalue from register A
    cmp #DAYTIME_NIGHT
    bne @not_night
    lda SongName
    cmp #SONG_OUTSIDE_NIGHT
    beq @restoreFadeValue
    lda #1
    sta MustPlayNewSong
    lda #SONG_OUTSIDE_NIGHT
    sta SongName
    jmp @restoreFadeValue
@not_night:
    lda SongName
    cmp #SONG_OUTSIDE_DAY
    beq @restoreFadeValue
    lda #1
    sta MustPlayNewSong
    lda #SONG_OUTSIDE_DAY
    sta SongName

@restoreFadeValue:
    lda TempY; restore register A value

@cont:
    cmp CurrentPaletteDecrementValue
    beq @exit
    sta CurrentPaletteDecrementValue

    ldy #1
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
.segment "ROM1"

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
    sta TempPointX2
    jsr ResetTimesWhenItemsWerePicked
    jsr DoFoodSpoilage
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

WarmthLogics:
    dec WarmthDelay
    lda WarmthDelay
    beq @resetWarmthDelay
    jmp @exit

@resetWarmthDelay:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @increaseWarmth
    cmp #LOCATION_TYPE_VILLAGER
    beq @ignoreFuel
    cmp #LOCATION_TYPE_ALIEN_BASE
    beq @exit
    jmp @decreaseWarmth
@increaseWarmth:
    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    beq @decreaseWarmth
@ignoreFuel: ; for other places than player's hut
    lda #MAX_WARMTH_DELAY_INDOORS
    sta WarmthDelay
    jsr IncreaseWarmth
    jmp @exit
@decreaseWarmth:
    lda #MAX_WARMTH_DELAY_OUTSIDE
    sta WarmthDelay
    jsr GetPaletteFadeValueForHour
    cmp #DAYTIME_NIGHT    ; is it night ?
    beq @nightFreeze
@dayFreeze:
    lda #WARMTH_DAY_DECREASE
    jmp @saveTempDecrease
@nightFreeze:
    lda LocationType
    cmp #LOCATION_TYPE_CAVE
    beq @dayFreeze
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


.segment "CODE"
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
    sta MustUpdatePalette
    lda #COLOR_RED
    ldy #0
    sta RamPalette, y
    lda #1
    sta PaletteUpdateSize
    lda #DAMAGE_RED_BLINK_DURATION
    sta RedCounter
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
    cmp #PLAYER_SPEED_RUN_BASE
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

    lda ImportantItemTimer
    bne @finishInput

    lda Buttons
    bne @checkAttackTimer ; something is pressed
    ;NO INPUT
    lda #PLAYER_SPEED_WALK_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_WALK_FRACTION
    sta PlayerSpeed + 1

@checkAttackTimer:
    lda AttackTimer
    bne @finishInput ; attack pause


    lda InputProcessed
    bne @finishInput

    jsr CheckB

    lda hadKnockBack
    bne @continueInput

    lda Buttons
    and #%00001111
    beq @finishInput ; dpad is not being used

    lda FishingRodActive
    bne @continueInput ; don't animate walk while fishing

    jsr AnimateWalk

@continueInput:

    ;save the movement before collision check
    jsr CreateNewPlayerMovementVars

    ;gamepad button processing, the player could be moved here
    jsr ProcessButtons

    jsr addKnockBack

    jsr IsPlayerCollidingWithNpcs
    bne @finishInput

    ;calc screen for collision
    lda NewCurrentMapSegmentIndex
    sta TempCollisionVar

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
    beq @storeXMovement

    lda #0
    sta PlayerFrame
@resetJustY:
    jmp @storeXMovement ; store just X

@thirdcheck:
    lda DirectionX
    beq @finishInput

    ;let's check with oldX now
    jsr CanPlayerGoWithOldX
    bne @finishInput ; don't store neither X nor Y

    ;the obstacles are on X axis
    jsr StoreYMovement ; store just Y
    jmp @generate


@contInput:

    jsr StoreYMovement
@storeXMovement:
    jsr StoreXMovement
@generate:
    jsr GenerateNpcsIfNeeded

@finishInput:
    lda Buttons
    sta OldButtons

    jsr CalcMapColumnToUpdate

    lda #INPUT_DELAY
    sta InputUpdateDelay
    rts

;--------------------------------
CreateNewPlayerMovementVars:

    lda PlayerX
    sta NewPlayerX
    lda PlayerX + 1
    sta NewPlayerX + 1

    lda PlayerY
    sta NewPlayerY
    lda PlayerY + 1
    sta NewPlayerY + 1

    lda ScrollX
    sta NewScrollX
    lda ScrollX + 1
    sta NewScrollX + 1

    lda ScrollDirection
    sta NewScrollDirection

    lda CurrentMapSegmentIndex
    sta NewCurrentMapSegmentIndex

    lda #0
    sta PossibleCurrentScreenChange

    rts

;-------------------------------
StoreXMovement:
    lda NewPlayerX + 1
    sta PlayerX + 1
    lda NewPlayerX
    sta PlayerX

    lda NewScrollX + 1
    sta ScrollX + 1
    lda NewScrollX
    sta ScrollX

    lda NewScrollDirection
    sta ScrollDirection

    lda NewCurrentMapSegmentIndex
    sta CurrentMapSegmentIndex

    lda PossibleCurrentScreenChange
    sta CurrentScreenChange

    rts
;-------------------------------
StoreYMovement:

    lda NewPlayerY + 1
    sta PlayerY + 1
    lda NewPlayerY
    sta PlayerY

    rts

;--------------------------------
GenerateNpcsIfNeeded:


    lda CurrentScreenChange
    cmp #CURRENT_SCREEN_INCREMENTED
    bne @checkdecrement

    jsr FlipStartingNametable
    lda #0
    sta CurrentScreenChange

    lda CurrentMapSegmentIndex
    clc
    adc #1
    cmp ScreenCount
    bcs @exit
    jmp @generate

@checkdecrement:

    cmp #CURRENT_SCREEN_DECREMENTED
    bne @exit

    jsr FlipStartingNametable
    lda #0
    sta CurrentScreenChange

    lda CurrentMapSegmentIndex
    cmp ScreenCount
    bcs @exit


@generate:
    sta TempIndex ; save Screen Index for new npcs
    lda TempScreenNpcCount
    sta TempNpcCnt
    jsr GenerateNpcs


@exit:
    rts
;-----------------------------
;Calculates depending on ScrollX and ScrollDirection:

;  BgColumnIdxToUpload;     - tile column to update
;  AttribColumnIdxToUpdate; - attribute column to update
;  DestScreenAddr;          - which nametable to use (20 or 24)
;  SourceMapIdx;            - map screen ID from ROM
;--------------------------------
CalcMapColumnToUpdate:

    lda ScreenCount
    cmp #MIN_SCREEN_COUNT_TO_UPDATE
    bcs @start

    rts

@start:
    lda #0
    sta MustUpdateMapColumn
    sta MustUpdateMapAttributeColumn

    lda ScrollX
    lsr
    lsr
    lsr             ;ScrollX / 8
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

    lda SourceMapIdx
    cmp OldSourceMapIdx
    bne @mustUpdate
    lda BgColumnIdxToUpload
    cmp OldBgColumnIdxToUpload
    beq @attr
@mustUpdate:

    ;collect column data
    ldy LocationIndex
    lda location_map_pos, y
    clc
    adc SourceMapIdx
    tay
    lda map_list_low, y
    clc
    adc BgColumnIdxToUpload
    sta pointer
    lda map_list_high, y
    adc #0
    sta pointer + 1

    ldx #0
    ldy #0
@loop:
    lda (pointer), y
    sta MapColumnData, x
    tya
    clc
    adc #32 ;increment the data index for the next value in column
    tay

    cpy #0
    bne @cont
    inc pointer + 1

@cont:

    inx
    cpx #SCREEN_ROW_COUNT - 4
    bcc @loop
    ;------------------


    lda #1
    sta MustUpdateMapColumn
    sta MustUpdateDestructibles

@attr:
    lda BgColumnIdxToUpload
    lsr
    lsr
    sta AttribColumnIdxToUpdate ; attribute id, bg_column / 4

    lda SourceMapIdx
    cmp OldSourceMapIdx
    bne @updateAttributes
    lda AttribColumnIdxToUpdate
    cmp OldAttribColumnIdxToUpdate
    beq @exit
@updateAttributes:

    ;------------
    ldy LocationIndex
    lda location_map_pos, y
    clc
    adc SourceMapIdx
    tay

    lda map_list_low, y
    clc
    adc #$40 ; C0 - 80(4 lines at the top)
    sta pointer
    lda map_list_high, y
    adc #$3
    sta pointer + 1


    lda pointer
    clc
    adc AttribColumnIdxToUpdate
    sta pointer

    ldx #0 ;
    lda #$40
    clc
    adc AttribColumnIdxToUpdate
    sta tmpAttribAddress
    lda DestScreenAddr
    clc
    adc #3
    sta AttribHighAddress
    ldy #0
@attribLoop:


    lda (pointer), y
    sta MapColumnAttributes, x

    tya
    adc #8
    tay

    inx
    cpx #8
    bcc @attribLoop
    ;------------
    lda #1
    sta MustUpdateMapAttributeColumn
@exit:
    rts

;--------------------------------
CutsceneNametableAnimations:

    ldy #5
    jsr bankswitch_y

    jsr CutsceneNameTableUpdate

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

    lda DialogTextContainer, y
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

    lda Stamina
    cmp OldStamina
    beq @Hp

    lda $2002
    lda #$20
    sta $2006
    lda #STAMINA_SEGMENT_START
    sta $2006

    lda Stamina
    beq @fail1
    lda #STAMINA_TILE
    sta $2007
    jmp @segment2

@fail1:
    lda #0
    sta $2007

@segment2:

    lda Stamina
    cmp #32
    bcc @fail2
    lda #STAMINA_TILE
    sta $2007
    jmp @segment3

@fail2:
    lda #0
    sta $2007

@segment3:
    lda Stamina
    cmp #64
    bcc @fail3

    lda #STAMINA_TILE
    sta $2007
    jmp @segment4

@fail3:
    lda #0
    sta $2007
@segment4:
    lda Stamina
    cmp #96
    bcc @fail4
    lda #STAMINA_TILE
    sta $2007
    jmp @Hp

@fail4:
    lda #0
    sta $2007

@Hp:
    lda Stamina
    sta OldStamina

    lda HpUpdated
    beq @warmth

    lda $2002
    lda #$20
    sta $2006
    lda #$45
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
    lda #$51
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
    beq @sunmoon

    lda $2002
    lda #$20
    sta $2006
    lda #$4B
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

@sunmoon:

    lda MustUpdateSunMoon
    beq @exit

    lda $2002
    lda #$20
    sta $2006
    lda #$5B
    sta $2006

    jsr UpdateSunMoonTiles
@exit:
    rts

;-----------------------------------
;Must put the address of the time indicator into $2006
UpdateSunMoonTiles:
    lda Hours
    lsr
    lsr
    lsr
    lsr
    asl
    asl
    tay
    lda sun_moon_tiles_for_periods, y
    sta $2007
    iny
    lda sun_moon_tiles_for_periods, y
    sta $2007
    iny
    lda sun_moon_tiles_for_periods, y
    sta $2007
    iny
    lda sun_moon_tiles_for_periods, y
    sta $2007

    lda #0
    sta MustUpdateSunMoon


    rts

;-----------------------------------
LoadStatusBar:
    lda current_bank
    sta bankBeforeStatusBarLoad
    ldy #6 ; bank 6 where the status bar data is
    jsr bankswitch_y
    ldy #$00
    ldx #128 ;tiles
    lda $2002
    lda #$20
    sta $2006
    lda #$00
    sta $2006
InitializeStatusBarLoop:     ; copy status bar to first nametable
    lda StatusBar, y
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
    ldy bankBeforeStatusBarLoad
    jsr bankswitch_y
    rts

;--------------------------------------------

HideSprites:

    ldx #0

    ldy #MAX_SPRITE_COUNT 
    lda #$FE
@hideSpritesLoop:
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
LoadTitleGfx:
    ldy #0
    jsr bankswitch_y ;switching to Title/Game Over bank

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<font
    ldy #2
    sta (sp), y
    iny
    lda #>font
    sta (sp), y
    lda #0
    ldy #0
    sta (sp), y
    iny
    lda #16
    sta (sp), y
    ldx #$03
    lda #0
    jsr UnLZ4toVram

    ldy #2
    jsr bankswitch_y ;switching to Title/Game Over bank

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1


    lda #<title_tiles_chr
    ldy #$02
    sta (sp),y
    iny
    lda #>title_tiles_chr
    sta (sp),y
    lda #$00
    tay
    sta (sp),y
    iny
    lda #19
    sta (sp),y
    ldx #13
    lda #0
    jsr UnLZ4toVram


    rts

;--------------------------------------------
LoadTitle:

    lda MustLoadTitle
    beq @exit


    lda #SONG_TITLE
    sta SongName
    lda #1
    sta MustPlayNewSong


    lda MustLoadTitleCHR
    beq @loadJustData


    lda #0
    sta $2000
    sta $2001

    jsr LoadTitleGfx

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
    sta CutsceneIdx

@exit:
    rts
;-------------------------------------
LoadGameOver:
    lda MustLoadGameOver
    bne @cont

    rts

@cont:
    lda #1
    sta MustPlayNewSong
    lda #SONG_GAME_OVER
    sta SongName

    lda #0
    sta $2000
    sta $2001

    lda #%10000000
    sta PPUCTRL

    ldy #0
    jsr bankswitch_y ;switching to Title/Game Over bank

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<font
    ldy #2
    sta (sp), y
    iny
    lda #>font
    sta (sp), y
    lda #0
    ldy #0
    sta (sp), y
    iny
    lda #0
    sta (sp), y
    ldx #$03
    jsr UnLZ4toVram

    ldy #2
    jsr bankswitch_y ;switching to Title/Game Over bank

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<gameover_tiles_chr
    ldy #$02
    sta (sp),y
    iny
    lda #>gameover_tiles_chr
    sta (sp),y
    lda #$00
    tay
    sta (sp),y
    iny
    lda #03
    sta (sp),y
    ldx #13
    lda #0
    jsr UnLZ4toVram

    jsr LoadTitleGfx


    lda #STATE_GAME_OVER
    sta GameState

    ldy #5
    jsr bankswitch_y

    jsr LoadGameOverData ; from bank 5

    lda #0
    sta MustLoadGameOver
    sta MustLoadSomething
    lda #255
    sta TaintedSprites


@exit:
    rts

.segment "ROM0"
;-------------------------------------
SaveGame:

    ldy #0
    ldx #0
@InventoryLoop:
    lda Inventory, x
    sta SaveData, y

    iny
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @InventoryLoop

    ldx #0
@storageLoop:
    lda Storage, x
    sta SaveData, y

    iny
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @storageLoop

    ldx #0
@HPLoop:
    lda HP, x
    sta SaveData, y
    iny
    inx
    cpx #3
    bcc @HPLoop

    ldx #0
@FoodLoop:
    lda Food, x
    sta SaveData, y
    iny
    inx
    cpx #3
    bcc @FoodLoop

    ldx #0
@FuelLoop:
    lda Fuel, x
    sta SaveData, y
    iny
    inx
    cpx #3
    bcc @FuelLoop

    ldx #0
@WarmthLoop:
    lda Warmth, x
    sta SaveData, y
    iny
    inx
    cpx #3
    bcc @WarmthLoop
;Time
    ldx #0
@DaysLoop:
    lda Days, x
    sta SaveData, y
    iny
    inx
    cpx #3
    bcc @DaysLoop

    lda Hours
    sta SaveData, y
    iny
    lda Minutes
    sta SaveData, y
    iny
;Equipment
    lda EquipedItem
    sta SaveData, y
    iny
    lda EquipedItem + 1
    sta SaveData, y
    iny
    lda EquipedClothing
    sta SaveData, y
    iny
    lda EquipedClothing + 1
    sta SaveData, y

    rts
;-------------------------------
LoadGame:

    ldy #0
    ldx #0
@InventoryLoop:
    lda SaveData, y
    sta Inventory, x

    iny
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @InventoryLoop

    ldx #0
@storageLoop:
    lda SaveData, y
    sta Storage, x

    iny
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @storageLoop

    ldx #0
@HPLoop:
    lda SaveData, y
    sta HP, x
    iny
    inx
    cpx #3
    bcc @HPLoop

    ldx #0
@FoodLoop:
    lda SaveData, y
    sta Food, x
    iny
    inx
    cpx #3
    bcc @FoodLoop

    ldx #0
@FuelLoop:
    lda SaveData, y
    sta Fuel, x
    iny
    inx
    cpx #3
    bcc @FuelLoop

    ldx #0
@WarmthLoop:
    lda SaveData, y
    sta Warmth, x
    iny
    inx
    cpx #3
    bcc @WarmthLoop
;Time
    ldx #0
@DaysLoop:
    lda SaveData, y
    sta Days, x
    iny
    inx
    cpx #3
    bcc @DaysLoop

    lda SaveData, y
    sta Hours
    iny
    lda SaveData, y
    sta Minutes
    iny
;Equipment
    lda SaveData, y
    sta EquipedItem
    iny
    lda SaveData, y
    sta EquipedItem + 1
    iny
    lda SaveData, y
    sta EquipedClothing
    iny
    lda SaveData, y
    sta EquipedClothing + 1

    rts



;-------------------------------------
ResetVariables:
    lda #MAX_SPRITE_COUNT
    sta TaintedSprites

    lda #PLAYER_SPEED_WALK_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_WALK_FRACTION
    sta PlayerSpeed + 1

    lda #1
    sta HP
    sta Warmth
    sta Food
    sta Fuel
    sta HpUpdated
    sta WarmthUpdated
    sta FoodUpdated

    lda #254
    sta PreviouslyEquipedItemIdx

    lda #120
    sta Hours

    lda #PLAYER_STAMINA_SIZE
    sta Stamina

    lda #0
    sta HP + 1
    sta HP + 2
    sta Warmth + 1
    sta Warmth + 2
    sta Food + 1
    sta Food + 2
    sta Fuel + 1
    sta Fuel + 2
    
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

    ldx #0
    lda #ITEM_WOOD_HAMMER
    sta Storage, x
    lda #ITEM_MAX_HP
    ldx #1
    sta Storage,x
    ldx #2
    lda #ITEM_STICK
    sta Storage, x
    ldx #4
    sta Storage, x
    ldx #6
    sta Storage, x
    ldx #8
    lda #ITEM_SLINGSHOT
    sta Storage, x
    ldx #9
    lda #ITEM_MAX_HP
    sta Storage, x
    inx
    lda #25
    sta Storage, x
    inx
    lda #ITEM_MAX_HP
    sta Storage, x

    lda #OUTDOORS_LOC1_SCREEN_COUNT ;  screens in the outdoors map
    sta ScreenCount

    lda #BASE_MENU_MIN_Y
    sta InventoryPointerY

    lda #MAX_WARMTH_DELAY_OUTSIDE
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
    sta SkipLastTileRowsInIndoorMaps
    sta NametableOffsetInBytes
    sta BossAgitated
    sta hadKnockBack
    sta CheckpointSaved
    sta menuTileTransferRowIdx
    sta MustPlaySfx
    sta InventoryItemIndex
    sta CurrentMapSegmentIndex
    sta ScrollDirection
    sta NpcCount
    sta ProjectileCount
    sta PlayerWins
    sta FoodToStamina
    sta ItemIGave

    ldx #MAX_VILLAGERS - 1
@villagerLoop:
    sta SpecialItemsDelivered, x
    sta CompletedSpecialQuests, x
    sta ActiveVillagerQuests, x
    sta TakenQuestItems, x
    sta VillagerKilled, x
    dex
    bpl @villagerLoop

    sta PaletteFadeAnimationState
    sta FadeIdx
    sta PaletteFadeTimer
    sta ScrollX
    sta BaseMenuIndex
    sta LocationType
    sta LocationIndex
    sta SpearData
    sta FishBiteTimer
    sta FishingRodActive
    sta MustLoadGameOverAfterFadeOut
    sta EquipedClothing
    sta EquipedClothing + 1

    ldy #MODIFYABLE_OBJECTS_COUNT

@destructibleLoop:
    sta ModifiedTiles, y
    dey
    bne @destructibleLoop

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
    sta DestScreenAddr

    lda #255
    sta CurrentPaletteDecrementValue

    sta TempPointX2
    jsr ResetTimesWhenItemsWerePicked

    rts

.segment "CODE"
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

;-----------------------------------
LoadCutscene:
    lda MustLoadCutscene
    beq @exit

    lda #0
    sta $2000
    sta $2001

    lda MustLoadIntroChr
    beq @loadScene


    ldy #2
    jsr bankswitch_y

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<intro_tiles_chr
    ldy #$02
    sta (sp),y
    iny
    lda #>intro_tiles_chr
    sta (sp),y
    lda #$00
    tay
    sta (sp),y
    iny
    sta (sp),y
    ldx #$20
    jsr UnLZ4toVram

@loadScene:
    ldy #5
    jsr bankswitch_y

    jsr LoadCutScene ; from bank 5

@exit:
    rts
;-------------------------------------
LoadCheckPoint:

    ldy #0
    jsr bankswitch_y ; switch to bank 0
    jsr LoadGame     ; call from bank 0

    ldx #0
    jsr initZeroSprite
    lda #STATE_GAME
    sta GameState

    lda #1
    sta PlayerAlive

    jsr ResetNameTableAddresses
    
    lda #6
    sta LocationIndex
    lda #3
    sta ScreenCount
    lda #2
    sta CurrentMapSegmentIndex
    lda #4
    sta LocationBankNo
    lda #0
    sta hadKnockBack
    sta NpcCount
    sta ModifiedTilesToDraw
    sta ProjectileCount ; reset projectiles
    sta SpearData       ; reset spear
    sta ScrollX
    lda #$77
    sta PlayerX
    lda #$70
    sta PlayerY

    ldy LocationBankNo
    jsr bankswitch_y

    lda #<Cave_items
    sta ItemListPtr
    lda #>Cave_items
    sta ItemListPtr + 1
    jsr LoadItems

    lda #<alien_palette
    sta CurrentMapPalettePtr
    sta PalettePtr
    lda #>alien_palette
    sta CurrentMapPalettePtr + 1
    sta PalettePtr + 1

    lda #0
    sta BossAgitated
    lda #SONG_OUTSIDE_NIGHT
    sta SongName
    lda #1
    sta MustPlayNewSong


    lda #<cave_npcs
    sta pointer
    lda #>cave_npcs
    sta pointer + 1

    jsr LoadNpcs
    jsr BuildRowTable

    lda #LOCATION_TYPE_CAVE
    sta LocationType
    lda #1
    sta MustLoadOutside
    sta MustUpdateDestructibles
    sta MustLoadSomething
    sta MustCopyMainChr

    rts

;-------------------------------------
StartGame:
    ldy #0
    jsr bankswitch_y

    lda #1
    sta InitiateCompleteItemRespawn

    jsr ResetVariables


    lda #<Outside1_items
    sta ItemListPtr
    lda #>Outside1_items
    sta ItemListPtr + 1
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
    jsr initZeroSprite
    lda #STATE_GAME
    sta GameState

    lda #<main_palette
    sta CurrentMapPalettePtr
    lda #>main_palette
    sta CurrentMapPalettePtr + 1

    lda #1
    sta FirstTime
    sta MustLoadOutside
    sta MustUpdateDestructibles
    sta MustLoadSomething
    sta MustCopyMainChr
    sta MustLoadCoreSprites
    sta MustReloadFontAndUI

    jsr BuildRowTable

    lda #SONG_OUTSIDE_DAY
    sta SongName
    sta InitiateCompleteItemRespawn
    lda #1
    sta MustStopMusic

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
    jmp @checkSelect
@checkOld:
    lda OldButtons
    and #BUTTON_START_MASK
    bne @checkSelect


    lda GameState
    cmp #STATE_TITLE
    bne @someOtherState

    ;On title state------

    lda #1
    sta MustLoadSomething
    sta MustLoadCutscene
    sta MustLoadIntroChr
    ldy #5
    jsr bankswitch_y

    jsr InitCutscene ; from bank 5

    jmp @exit
@someOtherState: ; not title

    cmp #STATE_CUTSCENE
    bne @checkGameOver

    lda CutsceneIdx
    beq @onIntro ; intro
    jmp @onOutro
@onIntro:
    
    lda DemoModeOn
    beq @startGame

    lda #0
    sta DemoModeOn
    sta TitleScreenTimer
    jmp @onOutro

@startGame:
    jsr FadeOutToStartGame
    jmp @exit
@onOutro:
    lda #1
    sta MustLoadTitleCHR
    jmp @goToTitle

@checkGameOver:
    cmp #STATE_GAME_OVER
    bne @CheckOnGame
@goToTitle:
    lda #1
    sta MustLoadSomething
    sta MustLoadTitle

    lda #%10010000
    sta PPUCTRL

    jmp @exit

@CheckOnGame:
    cmp #STATE_GAME
    beq @enterMenuScreen
    ;exit menu screen

    jsr ExitMenuState
    jmp @exit
@enterMenuScreen:

    ldy #1
    jsr bankswitch_y ; switch bank first
    lda #1
    sta MustLoadMenu
    sta MustLoadSomething
    jsr ResetOverlayedMenuVars
    lda #STATE_MENU
    sta GameState
    jmp @exit

@checkSelect:
    lda Buttons
    and #BUTTON_SELECT_MASK
    bne @checkOldSelect
    jmp @exit
@checkOldSelect:
    lda OldButtons
    and #BUTTON_SELECT_MASK
    bne @exit

    lda GameState
    cmp #STATE_GAME
    beq @equipNext
    cmp #STATE_MENU
    beq @equipNext
    jmp @exit

@equipNext:

    lda FishingRodActive
    bne @exit

    jsr EquipNext

@exit:
    rts

;--------------------------------------
EquipNext:

    lda current_bank
    sta oldbank
    ldy #1
    jsr bankswitch_y

    lda #0
    sta EquipNextResetCount

    ldx PreviouslyEquipedItemIdx
@loop:
    inx
    inx
    cpx #INVENTORY_MAX_SIZE
    bcs @reset
    lda Inventory,x
    beq @loop
    asl
    asl
    tay
    iny
    iny
    lda item_data,y
    cmp #ITEM_TYPE_TOOL
    bne @loop
    jmp @cont ; done

@reset:
    lda EquipNextResetCount
    cmp #1
    bcs @exit
    inc EquipNextResetCount
    ldx #254
    jmp @loop

@cont:
    stx TempItemIndex

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr UnequipItem

    lda EquipedItem
    bne @exit ; failed

    ldx TempItemIndex
    jsr EquipItem
    beq @exit

    stx PreviouslyEquipedItemIdx
    lda #0
    sta Inventory, x
    inx
    sta Inventory, x


@exit:
    ldy oldbank
    jsr bankswitch_y

    rts
;--------------------------------------
CheckDiagonal:
    lda #0
    sta PlayerMovesDiagonaly

    lda Buttons
    and #BUTTON_RIGHT_DOWN_MASK
    cmp #BUTTON_RIGHT_DOWN_MASK
    beq @found
    lda Buttons
    and #BUTTON_RIGHT_UP_MASK
    cmp #BUTTON_RIGHT_UP_MASK
    beq @found
    lda Buttons
    and #BUTTON_LEFT_DOWN_MASK
    cmp #BUTTON_LEFT_DOWN_MASK
    beq @found
    lda Buttons
    and #BUTTON_LEFT_UP_MAK
    cmp #BUTTON_LEFT_UP_MAK
    bne @exit

@found:
    lda #1
    sta PlayerMovesDiagonaly

@exit:
    rts
;-------------------------------------
;TODO: too similar to CheckLeft, should be merged
KnockedBackLeft:

    lda #1
    sta NewScrollDirection

    lda OldDirectionX
    sta DirectionX

    lda NewPlayerX
    cmp #SCREEN_MIDDLE
    bcs @moveLeft

    lda NewCurrentMapSegmentIndex ; is first screen
    bne @scrollLeft                  ; nope
    lda NewScrollX
    beq @moveLeft
@scrollLeft:

    ldy KnockBackIndex

    lda NewScrollX + 1
    sec
    sbc knockBackValuesFractions, y
    sta NewScrollX + 1

    lda NewScrollX
    sbc knockBackValuesInteger, y
    sta NewScrollX

    bcs @end

    lda NewCurrentMapSegmentIndex
    beq @firstScreen
    dec NewCurrentMapSegmentIndex
    lda #255
    sta PossibleCurrentScreenChange
    jmp @end
@firstScreen:
    lda #0
    sta NewScrollX

    jmp @end


@moveLeft:

    ldy KnockBackIndex
    lda NewPlayerX + 1
    sec
    sbc knockBackValuesFractions, y
    sta NewPlayerX + 1

    lda NewPlayerX
    beq @end
    sbc knockBackValuesInteger, y
    sta NewPlayerX
@end:
    rts
;--------------------------------------
;TODO: same here as above
KnockedBackRight:

    lda #2
    sta NewScrollDirection

    lda OldDirectionX
    sta DirectionX


    lda NewPlayerX
    cmp #SCREEN_MIDDLE
    bcc @moveRight

    lda NewCurrentMapSegmentIndex ; CurrentMapSegment + 1 == ScreenCount -> do not scroll
    clc
    adc #1
    cmp ScreenCount
    beq @moveRight

    ldy KnockBackIndex

    lda NewScrollX + 1
    clc
    adc knockBackValuesFractions, y
    sta NewScrollX + 1

    lda NewScrollX
    adc knockBackValuesInteger, y
    sta NewScrollX

    bcc @end

    inc NewCurrentMapSegmentIndex
    lda #1
    sta PossibleCurrentScreenChange

    lda NewCurrentMapSegmentIndex
    clc
    adc #1
    cmp ScreenCount
    beq @preLastScreen

    jmp @end

@preLastScreen:
    lda #0          ;finshed to the last screen, set scroll to zero
    sta NewScrollX

    jmp @end



@moveRight:
    ldy KnockBackIndex
    lda NewPlayerX + 1
    clc
    adc knockBackValuesFractions, y
    sta NewPlayerX + 1

    lda NewPlayerX
    adc knockBackValuesInteger, y
    sta NewPlayerX
    adc #PLAYER_WIDTH
    bcc @end

    lda #$FF
    sec
    sbc #PLAYER_WIDTH
    sta NewPlayerX


@end:

    rts

;--------------------------------------
addKnockBack:

    lda hadKnockBack
    bne @continue

    rts

@continue:
    lda FishingRodActive
    beq @cont

    rts

@cont:

    lda KnockBackDirectionY
    cmp #1
    bne @knockBackDown
    ;knockBackUp

    ldy KnockBackIndex

    lda NewPlayerY + 1
    sec
    sbc knockBackValuesFractions, y
    sta NewPlayerY + 1

    lda NewPlayerY
    sbc knockBackValuesInteger, y
    sta NewPlayerY
    jmp @end

@knockBackDown:
    cmp #2
    bne @horizontal
    ldy KnockBackIndex

    lda NewPlayerY + 1
    clc
    adc knockBackValuesFractions, y
    sta NewPlayerY + 1

    lda NewPlayerY
    adc knockBackValuesInteger, y
    sta NewPlayerY
    jmp @end
;------
@horizontal:
    lda KnockBackDirectionX
    beq @end ; no direction
    cmp #1 ; left
    bne @knockedRight

    jsr KnockedBackLeft

    jmp @end

@knockedRight:

   jsr KnockedBackRight

@end:
    inc KnockBackDelay
    lda KnockBackDelay
    cmp #2
    bcc @exit

    lda #0
    sta KnockBackDelay
    inc KnockBackIndex
    lda KnockBackIndex
    cmp #5
    bcs @reset

    jmp @exit

@reset:
    lda #0
    sta hadKnockBack


@exit:
    rts


;--------------------------------------
ProcessButtons:

    lda FishingRodActive
    bne @exit
    lda hadKnockBack
    bne @exit

    lda DirectionX
    sta OldDirectionX
    lda #0
    sta DirectionX
    sta DirectionY

    jsr CheckDiagonal

    lda PlayerMovesDiagonaly
    beq @normalSpeed

    lda #PLAYER_SPEED_DIAG_WALK_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_DIAG_WALK_FRACTION
    sta PlayerSpeed + 1
    jmp @checkA

@normalSpeed:
    lda #PLAYER_SPEED_WALK_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_WALK_FRACTION
    sta PlayerSpeed + 1

@checkA:
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


    lda NewPlayerY + 1 ; fraction
    sec
    sbc PlayerSpeed + 1
    sta NewPlayerY + 1

    lda NewPlayerY
    sbc PlayerSpeed
    sta NewPlayerY

@CheckDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @exit

    lda #2
    sta DirectionY
    lda #2
    sta PlayerFrame


    lda NewPlayerY + 1 ; fraction
    clc
    adc PlayerSpeed + 1
    sta NewPlayerY + 1

    lda NewPlayerY
    adc PlayerSpeed
    sta NewPlayerY
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
    lda PlayerMovesDiagonaly
    beq @notdiagonal

    lda #PLAYER_SPEED_DIAG_RUN_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_DIAG_RUN_FRACTION
    sta PlayerSpeed + 1
    jmp @exit


@notdiagonal:
    lda #PLAYER_SPEED_RUN_BASE
    sta PlayerSpeed
    lda #PLAYER_SPEED_RUN_FRACTION
    sta PlayerSpeed + 1

@exit:
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

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @useForAttack

    jsr CheckBed
    bne @exit
    jsr CheckFireplace
    bne @exit
    jsr CheckStashBox
    bne @exit
    jsr CheckToolTable
    bne @exit

@useForAttack:

    lda SpearData
    lsr
    bcs @exit

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

    jsr ActivateSwitch

    lda #PLAYER_ATTACK_DELAY
    sta AttackTimer
    lda #0
    sta NpcsKilledByPlayer
    sta NpcsHitByPlayer

    jsr PlayAttackSfx


@exit:

    rts
;----------------------------------
;Activate a switch by punching it
ActivateSwitch:
    jsr CalcTileAddressInFrontOfPlayer

    lda LocationIndex
    ;TODO: compare with a list of trigger locations perhaps
    cmp #LOCATION_ALIEN_BASE_PRE
    bne @exit

    ldy current_bank
    sty oldbank
    ldy #2
    jsr bankswitch_y

    jsr SwitchesLogic ; bank 2

    ldy oldbank
    jsr bankswitch_y


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
;stores 1 in register A if you can destroy
CanTileBeDestroyed:

    cmp #$9C
    beq @can
    cmp #$9D
    beq @can
    cmp #$AC
    beq @can
    cmp #$AD
    beq @can

    cmp #$F9
    beq @can
    cmp #$F5
    beq @can
    cmp #$F6
    beq @can
    cmp #$F8
    beq @can

    jmp @cannot
@can:
    lda #1
    jmp @exit
@cannot:
    lda #0

@exit:
    rts
;----------------------------------
useHammerOnEnvironment:

    lda LocationType
    cmp #LOCATION_TYPE_OUTDOORS
    beq @cont
    cmp #LOCATION_TYPE_CAVE
    beq @cont
    cmp #LOCATION_TYPE_DARK
    beq @cont
    jmp @abort

@abort:
    rts

@cont:
    jsr CalcTileAddressInFrontOfPlayer

    lda TempY
    clc
    adc #4
    sta TempY

    lda (pointer), y

    jsr CanTileBeDestroyed
    beq @check_other_tiles

    lda EquipedItem
    cmp #ITEM_WOOD_HAMMER
    beq @check_other_tiles

    ldx LocationIndex
    lda mod_tiles_count_by_location, x
    sta TempNpcCnt
    bne @hasDestructibles
    rts

@hasDestructibles:
    lda LocationIndex
    asl
    tax
    lda mod_tiles_by_location, x
    sta pointer2
    inx
    lda mod_tiles_by_location, x
    sta pointer2 + 1

    ldx TempNpcCnt
@destructable_loop:
    dex
    bmi @exit

    txa
    asl
    asl
    asl
    tay
    lda (pointer2), y
    iny ;hi
    iny ;lo
    iny ;scr
    iny ;y

    lda (pointer2), y
    cmp TempY
    bne @destructable_loop
    iny ; x
    lda (pointer2), y
    cmp TempX
    bne @destructable_loop
    dey ; y
    dey ; scr
    dey ; lo
    dey ; hi
    dey ; status idx

    lda (pointer2), y
    tay
    lda #1
    sta ModifiedTiles, y

    lda #1
    sta MustUpdateDestructibles
    jmp @exit

@check_other_tiles:
;rock
    lda (pointer), y
    cmp #ROCK_TILE_1
    beq @spawn_rock
    cmp #ROCK_TILE_2
    beq @spawn_rock
    cmp #ROCK_TILE_3
    beq @spawn_rock
    cmp #ROCK_TILE_4
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
    sta TempItemIndex
    jsr SpawnItem
    jmp @exit
@spawn_wood:
    jsr WearWeapon
    jsr UpdateRandomNumber
    and #1
    bne @exit

    lda #%00000011
    sta TempItemIndex
    jsr SpawnItem


@exit:

    rts
;---------------------------------
IsTree:
    cmp #$87
    beq @yes
    cmp #$88
    beq @yes
    cmp #$DC
    beq @yes
    cmp #$DD
    beq @yes
    cmp #$CE
    beq @yes
    cmp #$CF
    beq @yes
    cmp #$CC
    beq @yes
    cmp #$CD
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
ItemSpawnPrep:

    lda ItemCount
    clc
    adc #1
    cmp #ITEM_COUNT_MAX
    bcc @save_and_continue

    ldy LocationIndex
    lda LocationItemCounts, y ;we should start from here to look for reusable item slot

@testIfFits:
    sta TempItemStorageIdx
    sec
    sbc #1
    asl
    asl
    tay
    lda Items, y
    lsr
    bcc @found

    lda TempItemStorageIdx
    clc
    adc #1
    cmp #ITEM_COUNT_MAX
    bcc @testIfFits

@found:
    lda TempItemStorageIdx
    jmp @continue

@save_and_continue:
    sta ItemCount
@continue:
    sec
    sbc #1
    asl
    asl
    tay

    lda TempItemIndex ; item id and hp are here
    sta Items, y
    iny

    rts

;----------------------------------
;TempItemIndex is the item
SpawnItem:

    jsr ItemSpawnPrep

    lda #0
    sta TempItemScreen

    lda PlayerX
    clc
    adc ScrollX
    sta TempPointX
    bcs @incrementScreen
    jmp @continue
@incrementScreen:
    lda #1
    sta TempItemScreen
@continue:


    lda CurrentMapSegmentIndex
    clc
    adc TempItemScreen
    sta Items, y
    iny
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

;---------------------------------
;Set the map [pointer] and calculate the offset and put it in [y] register
CalcTileAddressInFrontOfPlayer:

    lda PlayerFrame
    beq @horizontal ;player is facing left or right

    cmp #1
    bne @downwards
    lda PlayerX
    clc
    adc #12
    jmp @cont
@downwards:
    lda PlayerX
    clc
    adc #4
    jmp @cont

@horizontal:
    lda DirectionX
    cmp #2
    bne @left
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
    adc ScrollX
    sta TempX
    bcs @mustIncrementScreen

    lda CurrentMapSegmentIndex
    tay ;store screen index to Y register
    jmp @continueCalc

@mustIncrementScreen:

    lda CurrentMapSegmentIndex
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

    sec
    sbc #4 ; remove supposed HUD rows

    sta TempY

    asl
    clc
    adc row_table_screens, y
    tay

    ;load map row address from ram
    lda MapRowAddressTable, y 
    sta pointer
    iny
    lda MapRowAddressTable, y
    sta pointer + 1

    lda TempX
    tay ;put X/8 to register y


    rts
;----------------------------------
;A -> 0 = can, 1 = can't
CanCastRodHere:
    ;let's check if I can throw there

    lda LocationType
    cmp #LOCATION_TYPE_OUTDOORS
    bne @exit

    jsr CalcTileAddressInFrontOfPlayer

    lda (pointer), y
    cmp #ICE_TILE_B
    beq @throwThere
    cmp #ICE_TILE_A
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
    sta TempItemIndex
    jsr SpawnItem
@exit:
    rts
;-----------------------------------
ShootSlingshot:

    ldy #INVENTORY_MAX_SIZE
    dey
    dey
@itemLoop:

    lda Inventory, y
    cmp #ITEM_ROCK
    beq @found

    dey
    dey
    bpl @itemLoop

    jmp @exit

@found:

    lda #0
    sta Inventory, y


    lda ProjectileCount
    beq @isEmpty

    ldy ProjectileCount
    dey
@checkLoop:

    lda projectiles_ram_lookup, y
    tax
    lda Projectiles, x
    lsr
    bcc @reuseProjectile
    
    dey
    bpl @checkLoop

@isEmpty:
    ldx ProjectileCount
    lda projectiles_ram_lookup, x
    tax

    lda ProjectileCount
    clc
    adc #1
    cmp #PROJECTILE_MAX_COUNT + 1
    bcs @exit
    sta ProjectileCount


@reuseProjectile:

    lda PlayerFrame
    bne @saveDir
;horizontal direction
    lda DirectionX
    sec
    sbc #1
    clc
    adc #3
@saveDir:
    asl
    and #%11111110
    eor #1
    sta Projectiles, x

    inx ; X

    lda PlayerX
    clc
    adc #4
    clc
    adc ScrollX

    bcs @incrementScreen


    sta Projectiles, x
    lda CurrentMapSegmentIndex
    inx ;x2
    inx ;screen
    sta Projectiles, x
    jmp @writeY

@incrementScreen:
    sta Projectiles, x

    lda CurrentMapSegmentIndex
    clc
    adc #1
    inx
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

    lda PlayerFrame
    bne @saveDir

    lda DirectionX
    sec
    sbc #1
    clc
    adc #3

@saveDir:
    asl
    and #%11111110
    eor #1
    sta SpearData

@setOtherParams:

    lda PlayerY
    clc
    adc #8
    sta SpearData + 4

    lda PlayerX
    clc
    adc #8
    adc ScrollX
    bcs @incrementScreen

    sta SpearData + 1
    lda CurrentMapSegmentIndex
    sta SpearData + 3 ; screen
    jmp @exit

@incrementScreen:
    sta SpearData + 1

    lda CurrentMapSegmentIndex
    clc
    adc #1
    sta SpearData + 3 ; screen

@exit:

    rts



;----------------------------------
CheckLeft:
    lda Buttons
    and #BUTTON_LEFT_MASK
    beq @exit

    lda #1
    sta DirectionX
    sta NewScrollDirection
    lda #0
    sta PlayerFrame

    lda PlayerX
    cmp #SCREEN_MIDDLE    ;check if player is in the left side of the screen
    bcs @moveLeft

    lda CurrentMapSegmentIndex ; is first screen
    bne @cont                  ; nope
    lda ScrollX
    beq @moveLeft
@cont:

    lda ScrollX + 1
    sec
    sbc PlayerSpeed + 1
    sta NewScrollX + 1

    lda NewScrollX
    sbc PlayerSpeed

    sta NewScrollX
    bcs @exit


    lda CurrentMapSegmentIndex
    beq @firstScreen
    sec
    sbc #1
    sta NewCurrentMapSegmentIndex
    lda #255
    sta PossibleCurrentScreenChange
    jmp @exit
@firstScreen:
    lda #0
    sta NewScrollX

    jmp @exit

@moveLeft:

    lda PlayerX + 1 ; fraction
    sec
    sbc PlayerSpeed + 1
    sta NewPlayerX + 1

    lda PlayerX
    beq @exit ; already x=0

    sbc PlayerSpeed
    sta NewPlayerX

@exit:

    rts
;----------------------------------
;Right on dpad is pressed
CheckRight:
    lda Buttons
    and #BUTTON_RIGHT_MASK
    beq @exit

    lda #2
    sta DirectionX
    sta NewScrollDirection
    lda #0
    sta PlayerFrame

    lda NewPlayerX
    cmp #SCREEN_MIDDLE
    bcc @moveRight  ;not gonna scroll until playerx + 8 >= 128

    lda NewCurrentMapSegmentIndex ; CurrentMapSegment + 1 == ScreenCount -> do not scroll
    clc
    adc #1
    cmp ScreenCount
    beq @moveRight

    lda NewScrollX + 1
    clc
    adc PlayerSpeed + 1
    sta NewScrollX + 1

    lda NewScrollX
    adc PlayerSpeed
    sta NewScrollX

    bcc @exit ; no overflow

    lda NewCurrentMapSegmentIndex
    clc
    adc #1
    sta NewCurrentMapSegmentIndex
    lda #1
    sta PossibleCurrentScreenChange

    lda NewCurrentMapSegmentIndex
    clc
    adc #1
    cmp ScreenCount
    beq @preLastScreen

    jmp @exit

@preLastScreen:
    lda #0          ;finshed to the last screen, set scroll to zero
    sta NewScrollX

    jmp @exit

@moveRight:

    lda NewPlayerX + 1
    clc
    adc PlayerSpeed + 1
    sta NewPlayerX + 1

    lda NewPlayerX
    adc PlayerSpeed
    sta NewPlayerX

    adc #PLAYER_WIDTH
    bcc @exit ; not greater than 255? Then fine

    lda #$FF
    sec
    sbc #PLAYER_WIDTH
    sta NewPlayerX

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
    jsr ResetOverlayedMenuVars
    lda #STATE_MENU
    sta GameState

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
    jsr ResetOverlayedMenuVars
    lda #STATE_MENU
    sta GameState


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
    jsr ResetOverlayedMenuVars
    lda #STATE_MENU
    sta GameState


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
    jsr ResetOverlayedMenuVars
    lda #STATE_MENU
    sta GameState


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

;----------------------------------
initZeroSprite:
    ldx #$00
spriteLoadLoop:
    lda zero_sprite, x
    sta FIRST_SPRITE - 4, x
    inx
    cpx #4
    bne spriteLoadLoop

    lda #1
    sta SpritesUpdated

    rts
;--------------------------
.segment "DPCM"
dpcm: .incbin "data/music.dmc"
