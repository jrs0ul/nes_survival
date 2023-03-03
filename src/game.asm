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

.include "data/map_list.asm"
.include "data/collision_data.asm"
.include "data/item_list.asm" ;items in maps
.include "data/npc_list.asm"  ;npcs in maps


;===========================================================
.segment "ROM1"

.include "data/menu_data.asm"
.include "data/recipes.asm"
.include "data/menu_screen.asm"

;============================================================
.segment "ROM2"

title_tiles_chr: .incbin "title.chr"

title_palette:

    .byte $0F,$07,$05,$26, $0F,$01,$26,$07, $0F,$26,$26,$35, $0F,$07,$26,$35    ;background
    .byte $0F,$0f,$17,$20, $0F,$06,$26,$39, $0F,$17,$21,$31, $0F,$0f,$37,$26    ;OAM sprites

.include "data/title.asm"
.include "data/game_over.asm"

;============================================================
.segment "ROM3" ; indoors

house_tiles_chr: .incbin "house.chr"
.include "data/house.asm"

house_palette:
    .byte $0C,$16,$27,$37, $0C,$07,$00,$31, $0C,$17,$27,$31, $0C,$20,$37,$16    ;background
    .byte $0C,$0f,$17,$20, $0C,$06,$16,$39, $0C,$17,$21,$31, $0C,$0f,$37,$16    ;OAM sprites



;=============================================================

.segment "RODATA" ; ROM7

banktable:              ; Write to this table to switch banks.
    .byte $00, $01, $02, $03, $04, $05, $06
    .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E

.include "data/music.asm"
.include "data/sfx.s"
.include "data/item_data.asm"
.include "data/npc_data.asm"

zerosprite:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72
    .byte $72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72,$72
    .byte $00,$57,$31,$30,$30,$00,$00,$00,$56,$30,$36,$37,$00,$00,$00,$55
    .byte $30,$38,$33,$00,$00,$00,$00,$00,$00,$00,$00,$00,$89,$8A,$8B,$00
    .byte $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
    .byte $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70


main_palette:
    .byte $0C,$00,$21,$31, $0C,$1B,$21,$31, $0C,$18,$21,$31, $0C,$20,$37,$16    ;background
    .byte $0C,$0f,$17,$20, $0C,$06,$16,$39, $0C,$0f,$16,$39, $0C,$0f,$37,$16    ;OAM sprites

sprites:
    .byte $11, $FF, $00000011, $08   ; sprite 0 
    .byte $00, $00, %00000011, $00
    .byte $00, $01, %00000011, $00
    .byte $00, $10, %00000011, $00
    .byte $00, $11, %00000011, $00

npc_direction_list:
    .byte 0
    .byte %00000100 ; Up
    .byte %00000001 ; R
    .byte %00001000
    .byte %00000010

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



;--------------
; CONSTANTS
    FIRST_SPRITE                = $0204

    ;possible game states
    STATE_TITLE                = 0
    STATE_GAME                 = 1
    STATE_MENU                 = 2
    STATE_GAME_OVER            = 3

    BUTTON_RIGHT_MASK           = %00000001
    BUTTON_LEFT_MASK            = %00000010
    BUTTON_DOWN_MASK            = %00000100
    BUTTON_UP_MASK              = %00001000

    BUTTON_START_MASK           = %00010000

    BUTTON_B_MASK               = %01000000
    BUTTON_A_MASK               = %10000000

    PLAYER_SPEED               = 2
    NPC_SPEED                  = 1

    MAX_V_SCROLL               = 255


    HOURS_MAX                  = 240
    SLEEP_TIME                 = 60

    PLAYER_ATTACK_DELAY        = 16

    INPUT_DELAY                = 130
    ITEM_DELAY                 = 66
    NPC_AI_DELAY               = 128
    NPC_COLLISION_DELAY        = 250

    COLLISION_MAP_SIZE         = 120 ; 4 columns * 30 rows
    COLLISION_MAP_COLUMN_COUNT = 4
    COLLISION_MAP_COLUMN_SIZE  = 8

    PLAYER_COLLISION_BOX_X1    = 3
    PLAYER_COLLISION_BOX_X2    = 13 ;16 - 3

    MAX_TILE_SCROLL_LEFT       = 248; -8
    MAX_TILE_SCROLL_RIGHT      = 8

    HOUSE_DOOR_X1              = 72
    HOUSE_DOOR_Y1              = 112
    HOUSE_DOOR_X2              = 96
    HOUSE_DOOR_Y2              = 120

    HOUSE_EXIT_Y               = 168

    SLEEP_POS_X                = 100
    SLEEP_POS_Y                = 72

    OUTDOORS_MAP_SCREEN_COUNT  = 5
    PLAYER_START_X             = $50
    PLAYER_START_Y             = $90

    HOUSE_ENTRY_POINT_X        = 128
    HOUSE_ENTRY_POINT_Y        = 152

    OUTSIDE_ENTRY_FROM_HOUSE_X = 72
    OUTSIDE_ENTRY_FROM_HOUSE_Y = 120

    SCREEN_ROW_COUNT           = 30

    CHARACTER_ZERO             = $30

    MAX_WARMTH_DELAY           = $40
    MAX_FOOD_DELAY             = $60
    MAX_FUEL_DELAY             = $55

    DECREMENT_FOOD_DEFAULT     = $3

    FIRE_ANIMATION_DELAY       = $20

    COOKING_FUEL_COST          = 5


    INVENTORY_SPRITE_X         = 40
    INVENTORY_SPRITE_MIN_Y     = 44
    INVENTORY_SPRITE_MAX_Y     = 164
    INVENTORY_POINTER_X        = 22
    INVENTORY_STEP_PIXELS      = 12
    BASE_MENU_MIN_Y            = 48 ;pointer position in base action menu

    ITEM_TYPE_FOOD             = 1
    ITEM_TYPE_FUEL             = 2
    ITEM_TYPE_MEDICINE         = 3
    ITEM_TYPE_MATERIAL         = 4

    INVENTORY_MAX_ITEMS        = 10

    NPC_STEPS_BEFORE_REDIRECT  = 16

;===================================================================
.segment "ZEROPAGE"
current_bank: 
    .res 1
pointer:
    .res 2
DigitPtr:
    .res 2
pointer2:
    .res 2
collisionMapPtr:
    .res 2
tmpAttribAddress:
    .res 1

InputUpdateDelay:
    .res 1
ItemUpdateDelay:
    .res 1
NpcAIUpdateDelay:
    .res 1
NpcCollisionDelay:
    .res 1
PaletteUpdateSize:
    .res 1
RamPalette:
    .res 32
DigitChangeSize: ;dedicated byte for Decrease/IncreaseDigits, because I can
    .res 1
LastDigit:
    .res 1
TempDigit:
    .res 1
;--------------
.segment "BSS" ; variables in ram

CurrentPaletteDecrementValue: ;a helper value to prevent doing too much of palette changing
    .res 1

OldGlobalScroll:
    .res 1
GlobalScroll:
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


PPUCTRL: ;PPU control settings
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

PlayerAnimationRowIndex: ;which animation row to use for player sprites at the moment
    .res 1
WalkTimer:
    .res 1
AttackTimer:
    .res 1
PlayerFrame:
    .res 1
PlayerFlip:
    .res 1

DirectionX:
    .res 1
DirectionY:
    .res 1

InputProcessed:
    .res 1

RandomNumber:
    .res 1

KnifeX:
    .res 1
KnifeY:
    .res 1

FireFrame:  ;an animation frame of fire in the fireplace
    .res 1
FireFrameDelay:
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

Fuel:       ;how much fuel you have at home in the fireplace
    .res 3

Days:
    .res 3
DaysUpdated:
    .res 1
Minutes:
    .res 1
Hours:
    .res 1


EquipedItem: ;equiped item type
    .res 1

Inventory:
    .res INVENTORY_MAX_ITEMS

Storage:
    .res INVENTORY_MAX_ITEMS

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

NMIActive:
    .res 1


GameState:
    .res 1
PlayerAlive:
    .res 1
Buttons:
    .res 1
OldButtons:
    .res 1
MenuButtons:
    .res 1

InHouse:    ;is the player inside his hut?
    .res 1

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


MustUpdatePalette: ;flag that signals the palette update
    .res 1

MustCopyMainChr:
    .res 1

MustLoadSomething:
    .res 1
MustLoadHouseInterior:
    .res 1
MustLoadOutside:
    .res 1
MustLoadMenu:
    .res 1
MustLoadTitle:
    .res 1
MustLoadGameOver:
    .res 1
MustDrawMenuTitle:
    .res 1

MustDrawInventoryGrid:
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
MustClearSubMenu:
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
FoodMenuActivated:  ; press b on raw meat in menu
    .res 1
StashFoodMenuActivated:
    .res 1
ItemMenuActivated:
    .res 1
StashItemMenuActivated:
    .res 1
MaterialMenuActivated:
    .res 1
StashMaterialMenuActivated:
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


CarrySet:
    .res 1



PrevItemMapScreenIndex:
    .res 1
NextItemMapScreenIndex:
    .res 1
ItemMapScreenIndex:
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
TempNpcState: ;attacking or idle
    .res 1
TempNpcTimer:
    .res 1
TempNpcRows:
    .res 1
TempFrameOffset:
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

MustRedir: ; the current npc must change direction
    .res 1

Items:   ;items that lies in the map
    .res 80 ; max 20 items * 4 bytes
            ;(item index(7 bits) + active(1 bit),
            ; x,
            ; y,
            ; screen_index)
ItemCount:
    .res 1

Npcs:   ;animals and stuff
    .res 64 ; max 8 npcs * 8 bytes:
            ;   (npc type(6 bits) + state(2 bit, 0 - dead, 1 - alive, 2 - attacks),
            ;   x,
            ;   y,
            ;   screen_index
            ;   direction(0000(unused bits) 00(Vertical) 00(horizonatal))
            ;   frame
            ;   timer
            ;   hp
NpcCount:
    .res 1

AttribHighAddress:
    .res 1
SourceMapIdx:
    .res 1

;====================================================================================
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


    ldx #<sounds
    ldy #>sounds
    jsr famistudio_sfx_init

    ldx #<music_data_untitled
    ldy #>music_data_untitled
    lda #1
    jsr famistudio_init
    lda #0
    jsr famistudio_music_play
   
vblankwait2:      ; Second wait for vblank, PPU is ready after this
    bit $2002
    bpl vblankwait2

    jsr loadSprites

;---
    ldy #2
    jsr bankswitch_y ;switching to Title/Game Over bank

    lda #<title_palette
    sta pointer
    lda #>title_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette


    lda #<title_tiles_chr
    sta pointer
    lda #>title_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

    lda #<title
    sta pointer
    lda #>title
    sta pointer+1

    lda #$20
    sta NametableAddress

    jsr LoadNametable

    lda #%10010000   ; enable NMI, sprites from Pattern Table 0
    sta PPUCTRL
    sta $2000
    
    lda #%00011110   ; enable sprites
    sta $2001

    lda #STATE_TITLE
    sta GameState

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

    jsr HandleInput
    lda GameState
    cmp #STATE_GAME
    beq update_game_sprites
    cmp #STATE_MENU
    beq update_menu_sprites
    jmp hide_sprites

checkItems:
    dec ItemUpdateDelay
    bne npcAI

    jsr ItemCollisionCheck

npcAI:
    dec NpcAIUpdateDelay
    bne npcCollision

    jsr doNpcAI

npcCollision:
    dec NpcCollisionDelay
    bne doSomeLogics

    jsr PlayerHitsNpcs
    jmp doSomeLogics

update_game_sprites:
    jsr UpdateSprites
    jmp doSomeLogics
update_menu_sprites:
    lda MustExitMenuState
    beq updateInventory
exitMenu:
    jsr ExitMenuState
    lda #0
    sta MustExitMenuState
    jmp nextIteration
updateInventory:
    jsr UpdateInventorySprites
    jmp doSomeLogics
hide_sprites:
    jsr HideSprites

doSomeLogics:

    jsr Logics


nextIteration:
    
    lda NMIActive
    beq ne
    jsr famistudio_update
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
    ldx #$08
ReadControllerLoop:
    lda $4016
    lsr
    rol Buttons
    dex
    bne ReadControllerLoop

    lda #0
    sta InputProcessed

    lda MustLoadSomething
    beq DoneLoadingMaps

    jsr UpdateMenuState
    jsr LoadTitle
    jsr LoadGameOver
    jsr LoadMenu
    jsr LoadTheHouseInterior
    lda MustLoadOutside
    beq DoneLoadingMaps
    jsr LoadOutsideMap

DoneLoadingMaps:

    lda MustUpdatePalette
    beq doneUpdatingPalette

    jsr UpdatePalette
    lda #0
    sta MustUpdatePalette


doneUpdatingPalette:
    lda GameState
    cmp #STATE_GAME
    bne nmicont2
    jsr UpdateFireplace
    jsr UploadBgColumns
    jsr UpdateStatusDigits

nmicont2:

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
    bne endOfNmi

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

    lda GlobalScroll
    sta $2005        ; write the horizontal scroll count register

    lda #0           ; no vertical scrolling
    sta $2005

endOfNmi:
    lda PPUCTRL
    sta $2000

    pla
    tax
    pla
    tay
    pla

    rti        ; return from interrupt

;#############################| Subroutines |#############################################
.include "famistudio_ca65.asm"
.include "graphics.asm"
.include "collision.asm"
.include "items.asm"
.include "npcs.asm"
.include "LoadOutsideMap.asm"
.include "random.asm"
.include "menu.asm"

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
UpdateMenuState:
    lda GameState
    cmp #STATE_MENU
    bne @exit

    jsr UpdateMenuGfx   ; code from ROM1

@exit:
    rts


;--------------------------------------------
;Check and upload background columns from rom map to the PPU
UploadBgColumns:


    ldy SourceMapIdx
    cpy ScreenCount
    bcs @exit

    ;calculate source address
    lda map_list_low, y
    clc
    adc BgColumnIdxToUpload
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    ;calculate source address
    lda #128 ; skip four rows
    clc
    adc BgColumnIdxToUpload
    sta pointer2
    lda DestScreenAddr
    sta pointer2 + 1
    

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

    ldy SourceMapIdx

    lda map_list_low, y
    clc
    adc #$C0
    sta pointer
    lda map_list_high, y
    adc #$3
    sta pointer + 1

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
Logics:

    lda GameState
    cmp #STATE_GAME
    bne @exit

    lda NMIActive
    beq @exit

    jsr UpdateRandomNumber

    lda PlayerAlive
    bne @cont
    lda #1
    sta MustLoadSomething
    sta MustLoadGameOver
@cont:
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

@doneLogics:
    
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

    jsr CheckIfEnteredHouse
    jsr CheckIfExitedHouse


@exit:

    rts
;-------------------------------
RunTime:

    inc Minutes
    lda Minutes
    cmp #60
    bcc @exit

    
    lda #0
    sta Minutes
    inc Hours
    lda Hours
    cmp #HOURS_MAX
    bcc @adaptPalette
    lda #0
    sta Hours
    jsr IncreaseDays

@adaptPalette:
    jsr AdaptBackgroundPalette

@exit:
    rts
;-------------------------------
AdaptBackgroundPalette:
    lda InHouse
    bne @exit

    ldy #$01 ;keeps the outline for the background objects
    lda Hours
    lsr
    lsr
    lsr
    lsr
    tax
    lda palette_fade_for_periods, x
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
    sta RamPalette, y
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
    jmp @decreaseWarmth
@increaseWarmth:
    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    beq @decreaseWarmth

    jsr IncreaseWarmth
    jmp @exit
@decreaseWarmth:
    lda Hours
    lsr
    lsr
    lsr
    lsr
    tax
    lda palette_fade_for_periods, x
    cmp #$40
    beq @nightFreeze
    lda #1
    jmp @saveTempDecrease
@nightFreeze:
    lda #5
@saveTempDecrease:
    sta DigitChangeSize
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
    lda #1
    sta DaysUpdated
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
    inc WalkTimer
    lda WalkTimer
    cmp #8
    bne @exit
    lda #0
    sta WalkTimer

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
    beq @finishInput ; no input

   
    lda AttackTimer
    bne @finishInput

    lda InputProcessed
    bne @finishInput

    lda Buttons
    and #%00001111
    beq @continueInput
    jsr AnimateWalk

@continueInput:

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
    
    jsr ProcessButtons

    jsr CanPlayerGo
    beq @contInput; all good, no obstacles

    ;obstacle ahead, restore previous position
    lda OldPlayerX
    sta PlayerX
    lda OldPlayerY
    sta PlayerY
    lda OldGlobalScroll
    sta GlobalScroll
    lda OldTileScroll
    sta TilesScroll
    lda OldScrollDirection
    sta ScrollDirection
    lda #0
    sta MustIncrementScreenIndex
    sta MustDecrementScreenIndex

    
    jmp @finishInput

@contInput:
    jsr SwitchScreenIdxIfNeeded
    jsr PushCollisionMapIfNeeded


@finishInput:
    lda Buttons
    sta OldButtons

    jsr CalcMapColumnToUpdate

    lda #INPUT_DELAY
    sta InputUpdateDelay
    rts
;--------------------------------
SwitchScreenIdxIfNeeded:
    lda MustIncrementScreenIndex
    beq @checkDecrement
    inc CurrentMapSegmentIndex
    jsr FlipStartingNametable
    lda #0
    sta MustIncrementScreenIndex

@checkDecrement:
    lda MustDecrementScreenIndex
    beq @exit
    
    dec CurrentMapSegmentIndex
    jsr FlipStartingNametable
    lda #0
    sta MustDecrementScreenIndex

@exit:
    rts
;--------------------------------
PushCollisionMapIfNeeded:
    lda TilesScroll
    cmp #MAX_TILE_SCROLL_RIGHT
    bne @checkAnother
    lda DirectionX
    cmp #2
    bne @checkAnother
    jsr PushCollisionMapLeft
    jmp @finishInput
@checkAnother:
    lda TilesScroll
    cmp #MAX_TILE_SCROLL_LEFT
    bne @finishInput
    lda DirectionX
    cmp #1
    bne @finishInput
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
    bcc WriteToB
;Write to A
    sec
    sbc #16
    sta BgColumnIdxToUpload

;---
    lda ScrollDirection
    cmp #1
    beq LeftDir
    lda #2
    jmp SaveDir
LeftDir:
    lda #0
SaveDir:
    sta Temp
;---
    lda CurrentMapSegmentIndex
    clc
    adc Temp
    sta SourceMapIdx
    ldx FirstNametableAddr
    jmp storeIdx
WriteToB:
    clc
    adc #16
    sta BgColumnIdxToUpload
;---
    lda ScrollDirection
    cmp #1
    beq LeftDir1
    lda #1
    jmp SaveDir1
LeftDir1:
    lda #255 ; -1 ?
SaveDir1:
    sta Temp

;---
    lda CurrentMapSegmentIndex
    clc
    adc Temp
    sta SourceMapIdx
    ldx SecondNametableAddr

storeIdx:
    stx DestScreenAddr

    lda BgColumnIdxToUpload
    lsr
    lsr
    sta AttribColumnIdxToUpdate ; attribute id, bg_column / 4

    rts
;--------------------------------
UpdateStatusDigits:

    lda GameState
    cmp #STATE_GAME
    bne @exit


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
    beq @days

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

@days:
    lda DaysUpdated
    beq @exit


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
    sta DaysUpdated
    rts

;--------------------------------------------

HideSprites:

    ldx #0

    ldy #64
@hideSpritesLoop:
    lda #$FE
    sta FIRST_SPRITE, x
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


    lda #STATE_TITLE
    sta GameState
    lda #$00
    sta $2000
    sta $2001

    lda #<title
    sta pointer
    lda #>title
    sta pointer+1
    lda PPUCTRL
    and #%11111110
    sta PPUCTRL
    lda #$20
    sta NametableAddress
    jsr LoadNametable
    lda #0
    sta MustLoadTitle
    sta MustLoadSomething
@exit:
    rts
;-------------------------------------
LoadGameOver:
    lda MustLoadGameOver
    beq @exit

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

    lda #<title_palette
    sta pointer
    lda #>title_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette

    lda #STATE_GAME_OVER
    sta GameState

    lda #<game_over
    sta pointer
    lda #>game_over
    sta pointer+1
    lda PPUCTRL
    and #%11111110
    sta PPUCTRL
    lda #$20
    sta NametableAddress
    jsr LoadNametable


    lda $2002
    lda FirstNametableAddr
    clc
    adc #1
    sta $2006
    lda #$D1
    sta $2006

    ldy #0
@daysLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Days, y
    sta $2007
    iny
    cpy #3
    bne @daysLoop



    lda #0
    sta MustLoadGameOver
    sta MustLoadSomething


@exit:
    rts
;-------------------------------------
ResetEntityVariables:

    lda #1
    sta HP
    sta Warmth
    sta Food
    sta Fuel
    sta HpUpdated
    sta WarmthUpdated
    sta FoodUpdated
    sta DaysUpdated

    lda #0
    sta HP + 1
    sta HP + 2
    ;sta Warmth
    sta Warmth + 1
    sta Warmth + 2
    ;sta Food
    sta Food + 1
    sta Food + 2
    sta Fuel + 1
    sta Fuel + 2

    lda #120
    sta Hours
    lda #0
    sta Minutes
    sta Days
    sta Days + 1
    sta Days + 2

    ldx #INVENTORY_MAX_ITEMS
    dex
@clearInventoryLoop:
    sta Inventory, x
    sta Storage, x
    dex
    bpl @clearInventoryLoop

    sta CurrentMapSegmentIndex

    lda #OUTDOORS_MAP_SCREEN_COUNT ;  screens in the outdoors map
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

    lda #0
    sta GlobalScroll
    sta TilesScroll
    sta TimesShiftedLeft
    sta TimesShiftedRight
    sta BaseMenuIndex
    sta InHouse
    lda #PLAYER_START_X
    sta PlayerX
    lda #PLAYER_START_Y
    sta PlayerY
    lda #1
    sta PlayerAlive

    lda #8
    sta EquipedItem

    lda #31
    sta BgColumnIdxToUpload
    lda #24
    sta DestScreenAddr

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

    lda #STATE_GAME
    sta GameState

    ldy #0
    jsr bankswitch_y

    jsr ResetEntityVariables
    lda #1
    sta MustLoadOutside
    sta MustLoadSomething
    sta MustCopyMainChr

    lda #<Outside1_items
    sta pointer
    lda #>Outside1_items
    sta pointer + 1
    jsr LoadItems

    jsr GenerateNpcs
       
@collision:
    ldx #0
@copyCollisionMapLoop:
    lda bg_collision, x
    sta CollisionMap, x
    inx
    cpx #COLLISION_MAP_SIZE
    bne @copyCollisionMapLoop

    lda #0      ;load the first column
    sta RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    lda #255;-1
    sta LeftCollisionColumnIndex


    jmp @exit
@someOtherState:

    cmp #STATE_GAME_OVER
    bne @CheckOnGame
    lda #1
    sta MustLoadSomething
    sta MustLoadTitle
    jmp @exit
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

@exit:
    rts
;--------------------------------------

ProcessButtons:
    lda #0
    sta DirectionX
    sta DirectionY

    jsr CheckB

;Check if LEFT is pressed
    jsr CheckLeft
;-----
;Check if RIGHT is pressed
@CheckRight:
    jsr CheckRight
;--------
;Check if UP is pressed
@CheckUp:
go_Up:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckDown

    lda #1
    sta DirectionY
    lda #1
    sta PlayerFrame


    lda PlayerY
    sec
    sbc #PLAYER_SPEED
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
    adc #PLAYER_SPEED
    sta PlayerY
@exit:
    lda #1
    sta InputProcessed
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

    lda AttackTimer
    bne @exit

    lda #4
    sta PlayerAnimationRowIndex

    lda #PLAYER_ATTACK_DELAY
    sta AttackTimer

    lda #1
    ldx #FAMISTUDIO_SFX_CH0
    jsr famistudio_sfx_play


@exit:

    rts
;----------------------------------
CheckLeft:
    lda Buttons
    and #BUTTON_LEFT_MASK
    beq @exit

    lda #1
    sta DirectionX
    sta ScrollDirection
    lda #0
    sta PlayerFrame
    sta PlayerFlip

    lda PlayerX
    clc
    adc #8
    cmp #128
    bcs @moveLeft

    lda CurrentMapSegmentIndex ; CurrentMapSegment < 1 -> do not scroll
    cmp #1
    bcc @checkScroll
    jmp @skipScroll
;-
@checkScroll:
    lda GlobalScroll
    beq @moveLeft   ;hack
;--
@skipScroll:
    lda TilesScroll
    sec
    sbc #PLAYER_SPEED
    sta TilesScroll
;--
@ScrollGlobalyLeft:
    lda GlobalScroll
    cmp #PLAYER_SPEED
    bcc @clamp

    sec
    sbc #PLAYER_SPEED
    jmp @save
@clamp:
    lda #1
    sta MustDecrementScreenIndex

    lda GlobalScroll
    sec
    sbc #PLAYER_SPEED
    jmp @save
@save:
    sta GlobalScroll

    jmp @exit

@moveLeft:
    lda PlayerX
    beq @exit ; already x=0
    sec
    sbc #PLAYER_SPEED
    sta PlayerX

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
    sta ScrollDirection
    lda #0
    sta PlayerFrame
    lda #1
    sta PlayerFlip


    lda PlayerX
    clc
    adc #8
    cmp #128
    bcc @moveRight  ;not gonna scroll until playerx >= 128

    lda CurrentMapSegmentIndex ; CurrentMapSegment + 1 == ScreenCount -> do not scroll
    clc
    adc #1
    cmp ScreenCount
    beq @moveRight

    lda GlobalScroll
    cmp #255
    bcs @ScrollGlobalyRight
;--
    lda TilesScroll
    clc
    adc #PLAYER_SPEED
    sta TilesScroll
;--
@ScrollGlobalyRight:
    lda GlobalScroll
    cmp #MAX_V_SCROLL - PLAYER_SPEED + 1
    bcs @clamp
    clc
    adc #PLAYER_SPEED
    jmp @save
@clamp:
    lda #1
    sta MustIncrementScreenIndex

    lda GlobalScroll
    clc
    adc #PLAYER_SPEED
@save:
    sta GlobalScroll

    jmp @exit

@moveRight:
    lda PlayerX
    cmp #238 ;254 - 16
    beq @exit
    clc
    adc #PLAYER_SPEED
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
.segment "ROM0"

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

;-----------------------------------
CheckIfEnteredHouse:

    lda InHouse
    bne @nope ; already in

    lda PlayerX
    clc
    adc #8

    cmp #HOUSE_DOOR_X1
    bcc @nope
    cmp #HOUSE_DOOR_X2
    bcs @nope
    lda PlayerY
    clc
    adc #10
    cmp #HOUSE_DOOR_Y1
    bcc @nope
    cmp #HOUSE_DOOR_Y2
    bcs @nope


    lda #<House_items
    sta pointer
    lda #>House_items
    sta pointer + 1
    jsr LoadItems

    lda #<House_npcs
    sta pointer
    lda #>House_npcs
    sta pointer + 1
    jsr LoadNpcs

    ldx #0
@copyCollisionMapLoop:
    lda hut_collision, x
    sta CollisionMap, x
    inx
    cpx #COLLISION_MAP_SIZE
    bne @copyCollisionMapLoop

    lda #1
    sta MustLoadHouseInterior
    sta MustLoadSomething
    lda #HOUSE_ENTRY_POINT_X
    sta PlayerX
    lda #HOUSE_ENTRY_POINT_Y
    sta PlayerY

@nope:
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

    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithBed

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
    

    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithFireplace

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

    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithStorage
    

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

    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    sta PlayerInteractedWithTooltable

    jmp @exit
@nope:
    lda #0
@exit:
    rts

;-----------------------------------
CheckIfExitedHouse:

    lda InHouse
    beq @nope

@checkExit:
    lda PlayerY
    cmp #HOUSE_EXIT_Y
    bcc @nope

    ldx #0
@copyCollisionMapLoop:
    lda bg_collision, x
    sta CollisionMap, x
    inx
    cpx #COLLISION_MAP_SIZE
    bne @copyCollisionMapLoop

    lda #0
    sta InHouse
    
    lda #<Outside1_items
    sta pointer
    lda #>Outside1_items
    sta pointer + 1
    jsr LoadItems

    jsr GenerateNpcs


    lda #OUTSIDE_ENTRY_FROM_HOUSE_X
    sta PlayerX
    lda #OUTSIDE_ENTRY_FROM_HOUSE_Y
    sta PlayerY

    lda #1
    sta MustLoadOutside
    sta MustCopyMainChr
    sta MustLoadSomething

@nope:
    rts

.segment "CODE"
;-------------------------------------
LoadTheHouseInterior:

    lda MustLoadHouseInterior
    beq @nope

    ldy #3
    jsr bankswitch_y

    lda #$00
    sta $2000
    sta $2001

    lda #<house_tiles_chr
    sta pointer
    lda #>house_tiles_chr
    sta pointer + 1
    jsr CopyCHRTiles

    lda #1
    sta InHouse

    lda #<house
    sta pointer
    lda #>house
    sta pointer + 1
    lda #$20    ; $20000
    sta NametableAddress

    jsr LoadNametable
    jsr LoadStatusBar
    

    lda #<house_palette
    sta pointer
    lda #>house_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette

    ldy #0
    jsr bankswitch_y

    lda #0
    sta MustLoadHouseInterior
    sta MustLoadSomething
    lda #1
    sta ScreenCount



@nope:
    rts

;-----------------------------------
UpdateSprites:
    
    lda #0
    sta SpritesUpdated

    lda PlayerFrame
    asl  ; frame * 2
    sta TempFrame

    ;sprite 1
    ldx #$00
    lda PlayerY
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip1

    lda TempFrame
    clc
    adc #1
    sta FIRST_SPRITE,x
    inx
    lda FIRST_SPRITE, x
    lda #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX1
@NoFlip1:

    lda TempFrame
    sta FIRST_SPRITE,x
    inx
    lda FIRST_SPRITE, x
    lda #%00000011
    sta FIRST_SPRITE, x
@MoveX1:
    inx
    lda PlayerX
    sta FIRST_SPRITE, x
    inx
;---
    ;sprite 2
    lda PlayerY
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip2
    lda TempFrame
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX2
@NoFlip2:
    lda TempFrame
    clc
    adc #1
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%00000011
    sta FIRST_SPRITE, x
@MoveX2:
    inx
    lda PlayerX
    clc
    adc #$08
    sta FIRST_SPRITE, x
    inx
;----

    ldy PlayerAnimationRowIndex
    lda player_anim_row_sequence, y
    sta TempAnimIndex

    ;sprite 3
    lda PlayerY
    clc
    adc #$08
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip3
    lda TempFrame
    clc
    adc #17
    adc TempAnimIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX3
@NoFlip3:
    lda TempFrame
    clc
    adc #16
    adc TempAnimIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%00000011
    sta FIRST_SPRITE, x
@MoveX3:
    inx
    lda PlayerX
    sta FIRST_SPRITE, x
    inx

    ;sprite 4
    lda PlayerY
    clc
    adc #$08
    sta FIRST_SPRITE,x
    inx
    lda PlayerFlip
    beq @NoFlip4
    lda TempFrame
    clc
    adc #16
    adc TempAnimIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX4
@NoFlip4:
    lda TempFrame
    clc
    adc #17
    adc TempAnimIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    lda #%00000011
    sta FIRST_SPRITE, x
@MoveX4:
    inx
    lda PlayerX
    clc
    adc #$08
    sta FIRST_SPRITE, x

    lda #4
    sta TempSpriteCount

;-----knife
    lda AttackTimer
    beq @noKnife
    jsr SetKnifeSprite
@noKnife:
;---
    inx; next sprite byte
;------sun-moon indicator

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
;--------------------
@no_second_celestial_body:
    jsr UpdateNpcSpritesInWorld
    jsr UpdateItemSpritesInWorld

@hidesprites:
    lda #64

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
;----------------------------------
SetKnifeSprite:

    lda PlayerFlip
    beq @nF

    lda #%01000000
    sta Temp


    lda PlayerFrame
    beq @horizF
    cmp #2
    beq @gDown

    lda PlayerY
    sta TempPointY

    lda PlayerX
    sta TempPointX

    jmp @updateKnife
@gDown:
    lda PlayerY
    clc
    adc #16
    sta TempPointY

    lda PlayerX
    clc
    adc #8
    sta TempPointX


    jmp @updateKnife
@horizF:
    lda PlayerY
    clc
    adc #8
    sta TempPointY

    lda PlayerX
    clc
    adc #16
    sta TempPointX

    jmp @updateKnife
@nF:

    lda #%00000000
    sta Temp

    lda PlayerFrame
    beq @horizNF
    cmp #2
    beq @gDownNF


    lda PlayerY
    sta TempPointY

    lda PlayerX
    clc
    adc #8
    sta TempPointX

    jmp @updateKnife
@gDownNF:
    lda PlayerY
    clc
    adc #16
    sta TempPointY

    lda PlayerX
    sta TempPointX


    jmp @updateKnife
@horizNF:
    lda PlayerY
    clc
    adc #8
    sta TempPointY

    lda PlayerX
    sec
    sbc #8
    sta TempPointX
@updateKnife:
;----------------------

    inx
    lda TempPointY;KnifeY
    sta FIRST_SPRITE,x
    clc
    adc #4
    sta KnifeY
    inx
    lda #240
    clc
    adc PlayerFrame
    sta FIRST_SPRITE,x
    inx
    lda Temp
    sta FIRST_SPRITE,x
    inx
    lda TempPointX;KnifeX
    sta FIRST_SPRITE,x
    clc
    adc #4
    sta KnifeX
    inc TempSpriteCount

@exit:
    rts

;----------------------------------
loadSprites:
    ldx #$00
spriteLoadLoop:
    lda sprites, x
    sta FIRST_SPRITE - 4, x
    inx
    cpx #$32
    bne spriteLoadLoop

    lda #1
    sta SpritesUpdated

    rts

