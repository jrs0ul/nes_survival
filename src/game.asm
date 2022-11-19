.segment "CHARS"
    .incbin "tile.chr" 

.segment "HEADER"
 ; this header is to set up a NROM mapper 000 with fixed banks (no bank switching)
  .byte 'N', 'E', 'S', $1A   ; these bytes always start off an ines file
  .byte $02                   ; PRG 32K (1 for 16K)
  .byte $01                   ; CHR 8K

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
  .byte %00000001                   ; NROM mapper 0, other mappers have more complicated values here
  .byte $0, $0, $0, $0, $0, $0

.segment "VECTORS"
    .word nmi, reset, 0
;==========================================================
.segment "RODATA" ; data in rom

.include "data/field_bg.asm"
.include "data/field_bg1.asm"
.include "data/house.asm"
.include "data/title.asm"
.include "data/menu_screen.asm"
.include "data/collision_data.asm"
.include "data/inventory_data.asm"

zerosprite:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$57,$30,$30,$30,$00,$3F,$48,$48,$3D,$00,$30,$30,$30,$00,$50
    .byte $3A,$4B,$46,$4D,$41,$00,$30,$30,$30,$00,$00,$00,$00,$3D,$30,$30

palette:
    .byte $0C,$00,$21,$31, $0C,$27,$21,$31, $0C,$17,$21,$31, $0C,$10,$0f,$01    ;background
    .byte $0C,$0f,$17,$20, $0C,$06,$16,$39, $0C,$17,$21,$31, $0C,$0f,$37,$16    ;OAM sprites

house_palette:
    .byte $0C,$16,$27,$37, $0C,$07,$00,$31, $0C,$17,$27,$31, $0C,$10,$0f,$01    ;background
    .byte $0C,$00,$21,$31, $0C,$27,$21,$31, $0C,$17,$21,$31, $0C,$0f,$37,$16    ;OAM sprites

menu_palette:
    .byte $10,$0F,$00,$10, $0f,$07,$00,$31, $0f,$17,$27,$31, $31,$10,$0f,$01    ;background
    .byte $10,$07,$17,$27, $10,$06,$16,$37, $10,$17,$21,$31, $10,$0f,$17,$16    ;OAM sprites

sprites:
    .byte $0A, $FF, $00000011, $08   ; sprite 0 
    .byte $00, $00, %00000011, $00
    .byte $00, $01, %00000011, $00
    .byte $00, $10, %00000011, $00
    .byte $00, $11, %00000011, $00

;--------------
; CONSTANTS
    FIRST_SPRITE                = $0204

    ;possible game states
    TITLE_STATE                = 0
    GAME_STATE                 = 1
    MENU_STATE                 = 2

    PLAYER_SPEED               = 2
    INPUT_DELAY                = 64
    ITEM_DELAY                 = 64

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

    HOUSE_ENTRY_POINT_X        = 128
    HOUSE_ENTRY_POINT_Y        = 152

    OUTSIDE_ENTRY_FROM_HOUSE_X = 72
    OUTSIDE_ENTRY_FROM_HOUSE_Y = 120

    SCREEN_ROW_COUNT           = 30

    CHARACTER_ZERO             = $30

    MAX_WARMTH_DELAY           = $40
    MAX_FOOD_DELAY             = $60
    MAX_FUEL_DELAY             = $55

    FIRE_ANIMATION_DELAY       = $20


    INVENTORY_SPRITE_X         = 48
    INVENTORY_SPRITE_MIN_Y     = 44
    INVENTORY_SPRITE_MAX_Y     = 164
    INVENTORY_POINTER_X        = 30
    INVENTORY_STEP_PIXELS      = 12

    ITEM_TYPE_FOOD             = 1
    ITEM_TYPE_FUEL             = 2

    INVENTORY_MAX_ITEMS        = 10

;===================================================================
.segment "ZEROPAGE"

pointer:
    .res 2
DigitPtr:
    .res 2
;--------------
.segment "BSS" ; variables in ram


OldGlobalScroll:
    .res 1
GlobalScroll:
    .res 1
TilesScroll:
    .res 1
OldTileScroll:
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

WalkAnimationIndex:
    .res 1
WalkTimer:
    .res 1
PlayerFrame:
    .res 1
PlayerFlip:
    .res 1

DirectionX:
    .res 1
DirectionY:
    .res 1

FireFrame:  ;an animation frame of fire in the fireplace
    .res 1
FireFrameDelay:
    .res 1

HP:
    .res 3
Food:
    .res 3
Warmth:
    .res 3
Fuel:       ;how much fuel you have at home in the fireplace
    .res 3


Inventory:
    .res INVENTORY_MAX_ITEMS 

InventoryPointerPos:
    .res 1

InventoryItemIndex:
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


MustLoadHouseInterior:
    .res 1
MustLoadOutside:
    .res 1
MustLoadMenu:
    .res 1

CarrySet:
    .res 1

FrameCount:
    .res 1
ItemUpdateDelay:
    .res 1


Temp:
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
;----
TempItemIndex:
    .res 1
TempSpriteCount: ; count of active sprites
    .res 1
;--

Items:   ;items that lies in the map
    .res 16 ; max 4 items * 4 bytes(active, x, y, item index)
ItemCount:
    .res 1

Npcs:   ;animals and stuff
    .res 16 ; max 4 npcs * 4 bytes (x, y, starting tile, height in tiles)
NpcCount:
    .res 1
;293 bytes

;====================================================================================
.segment "CODE"


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
   
vblankwait2:      ; Second wait for vblank, PPU is ready after this
    bit $2002
    bpl vblankwait2


    lda #<palette
    sta pointer
    lda #>palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette

    jsr loadSprites

;---
    lda #<title
    sta pointer
    lda #>title
    sta pointer+1

    lda #$20
    sta NametableAddress

    jsr LoadNametable

    lda #%10010000   ; enable NMI, sprites from Pattern Table 0
    sta $2000
    
    lda #%00011110   ; enable sprites
    sta $2001


    lda #TITLE_STATE
    sta GameState

    lda #INPUT_DELAY
    sta FrameCount
    lda #ITEM_DELAY
    sta ItemUpdateDelay
    lda #0
    sta MustLoadHouseInterior

;---------------------------------

endlessLoop:

    lda MustLoadHouseInterior
    bne nextIteration ; don't do logics until the house is not loaded to the PPU
    lda MustLoadOutside
    bne nextIteration ; the same is with the map of outside
    lda MustLoadMenu
    bne nextIteration

    dec FrameCount
    lda FrameCount
    bne checkItems

doInput:
    jsr HandleInput
    lda GameState
    cmp #GAME_STATE
    beq update_game_sprites
    cmp #MENU_STATE
    beq update_menu_sprites
    cmp #TITLE_STATE
    beq hide_sprites

checkItems:
    dec ItemUpdateDelay
    lda ItemUpdateDelay
    beq doItemCheck
    jmp doSomeLogics

doItemCheck:
    jsr ItemCollisionCheck
    jmp doSomeLogics

update_game_sprites:
    jsr UpdateSprites
    jmp doSomeLogics
update_menu_sprites:
    jsr UpdateInventorySprites
    jmp doSomeLogics
hide_sprites:
    jsr HideSprites

doSomeLogics:

    jsr Logics

nextIteration:
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

    lda #$00
    sta $2003        ; set the low byte (00) of the RAM address
    lda #$02
    sta $4014        ; set the high byte (02) of the RAM address, start the transfer

    lda #1
    sta NMIActive

    jsr ReadController
    jsr CheckStartButton


    lda GameState
    cmp #GAME_STATE
    bne endOfNmi

    lda MustLoadMenu
    beq CheckHouseLoad
    jsr LoadMenu
CheckHouseLoad:
    lda MustLoadHouseInterior
    beq checkIfOutsideNeedsToLoad
    jsr LoadTheHouseInterior
checkIfOutsideNeedsToLoad:
    lda MustLoadOutside
    beq checkFire
    jsr LoadOutsideMap

checkFire:
    lda InHouse
    beq continueNmi
    jsr UpdateFireplace

    


continueNmi:
    jsr CheckGameOver
    jsr UpdateStatusDigits

nmicont2:

    ;This is the PPU clean up section, so rendering the next frame starts properly.
    lda #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
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
    cmp #GAME_STATE
    bne endOfNmi

WaitNotSprite0:
    lda $2002
    and #%01000000
    bne WaitNotSprite0   ; wait until sprite 0 not hit

WaitSprite0:
    lda $2002
    and #%01000000
    beq WaitSprite0      ; wait until sprite 0 is hit


    ldx #$F
WaitScanline:
    dex
    bne WaitScanline

    ;uncoment the call for some scrolling
    jsr scrollBackground

endOfNmi:
    lda #%10010000 
    sta $2000


    lda GameState
    cmp #MENU_STATE
    bne endforReal
    jsr MenuInput


endforReal:
    pla
    tax
    pla
    tay
    pla

    rti        ; return from interrupt

;#############################| Subroutines |#############################################

.include "graphics.asm"
.include "collision.asm"


ItemCollisionCheck:
    lda #ITEM_DELAY
    sta ItemUpdateDelay

    ldy #0
@itemLoop:
    tya
    asl
    asl ;y * 4
    tax
    lda Items, x ; active?
    beq @nextItem
    inx
    lda Items, x ;x
    sta TempPointX
    lda PlayerX
    clc
    adc #8
    cmp TempPointX
    bcs @checkX2
    jmp @nextItem
@checkX2:
    lda Items,x
    clc
    adc #16
    sta TempPointX
    lda PlayerX
    clc
    adc #8
    cmp TempPointX
    bcs @nextItem

    inx
    lda Items, x ;y
    sta TempPointY
    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcs @checkY2
    jmp @nextItem
@checkY2:

    lda Items, x
    clc
    adc #16
    sta TempPointY
    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcs @nextItem

    jsr AddAndDeactivateItems

@nextItem:
    iny
    cpy ItemCount
    bcc @itemLoop


    rts


;-----------------------------------
AddAndDeactivateItems:
    sty TempY

    ldy #INVENTORY_MAX_ITEMS - 1
@inventoryLoop:
    lda Inventory, y
    beq @addItem
    dey
    bpl @inventoryLoop
    jmp @exit ; no place in the inventory?

@addItem:
    inx
    lda Items, x
    sta Inventory, y
    ldy TempY

    tya
    asl
    asl
    tax
    lda #0
    sta Items, x
@exit:
    rts
;-----------------------------------
Logics:

    lda GameState
    cmp #GAME_STATE
    bne @exit

    lda NMIActive
    beq @continueForever



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
    dec WarmthDelay
    lda WarmthDelay
    beq @resetWarmthDelay
    jmp @checkFood

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
    jmp @checkFood
@decreaseWarmth:
    jsr DecreaseWarmth
    cmp #0
    beq @decreaseLifeBecauseCold
    jmp @checkFood
@decreaseLifeBecauseCold:
    jsr DecreaseLife

@checkFood:
    jsr FoodLogics

@doneLogics:
    lda #0
    sta NMIActive

@continueForever:

    jsr CheckIfEnteredHouse
    jsr CheckIfExitedHouse
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
    jsr DecreaseDigits
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
    jsr DecreaseDigits
@exit:
    rts

;-------------------------------
DecreaseLife:
    lda #<HP
    sta DigitPtr
    lda #>HP
    sta DigitPtr + 1
    jsr DecreaseDigits
    rts
;-------------------------------
IncreaseWarmth:
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    jsr IncreaseDigits
    rts

;-------------------------------
DecreaseWarmth:
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    jsr DecreaseDigits

    lda Warmth
    clc
    adc Warmth + 1
    adc Warmth + 2
    rts
;-------------------------------------
UpdateInventorySprites:

    ldx #0
    lda #0
    sta TempSpriteIdx
    sta TempSpriteCount

    lda #32
    sta TempTileYPos


@itemLoop:

    lda Inventory, x
    asl
    asl ;inventory_index * 4
    tay
    lda inventory_data, y ;grab sprite index
    bne @store_sprite_index
    lda #$FD ;empty sprite index
@store_sprite_index:
    sta TempTileIndex ; save sprite index
    iny
    lda inventory_data, y
    sta TempPaletteIndex ; save palette

    stx TempInventoryIndex ; save x index
    lda TempTileYPos
    clc
    adc #INVENTORY_STEP_PIXELS
    sta TempTileYPos

    ldy #0
@twoTileLoop: ;item consists of two tiles

    lda TempTileYPos
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x ;set Y coordinate

    inc TempSpriteIdx
    lda TempTileIndex
    sty TempTileIndexOffset
    clc
    adc TempTileIndexOffset
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x

    inc TempSpriteIdx
    ;attributes
    ldx TempSpriteIdx
    lda #0
    clc
    adc TempPaletteIndex
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ;x coordinate
    lda #INVENTORY_SPRITE_X
    cpy #1
    bne @saveX
    clc
    adc #8
@saveX:
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    inc TempSpriteCount
    iny
    cpy #2
    bcc @twoTileLoop

    ldx TempInventoryIndex ;restore x index
@next:
    inx
    cpx #INVENTORY_MAX_ITEMS
    bcc @itemLoop


    ldx TempSpriteIdx
    lda InventoryPointerPos
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #$FC
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #%00000011
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #INVENTORY_POINTER_X
    sta FIRST_SPRITE, x
    inc TempSpriteCount


    inx
    lda #63

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



    rts

;---------------------------------------
AnimateWalk:
    inc WalkTimer
    lda WalkTimer
    cmp #8
    bne @exit
    lda #0
    sta WalkTimer

    lda WalkAnimationIndex
    clc
    adc #16
    cmp #64
    bcs @resetWalk
    jmp @saveWalk
@resetWalk:
    lda #0
@saveWalk:
    sta WalkAnimationIndex
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


;-------------------------------
UpdateFireplace:

    lda GameState
    cmp #GAME_STATE
    bne @exit


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
    lda #$5C
    clc
    adc Temp
    adc #1
    sta $2007
    jmp @exit
@putFireOut:
    lda #0
    sta $2007
    sta $2007

@exit:
    rts



;----------------------------------
HandleInput:

    lda GameState
    cmp #GAME_STATE
    bne inputInOtherStates


    lda Buttons
    beq finishInput ; no input

    
    jsr AnimateWalk

    lda PlayerX
    sta OldPlayerX
    lda PlayerY
    sta OldPlayerY
    lda GlobalScroll
    sta OldGlobalScroll
    lda TilesScroll
    sta OldTileScroll

    jsr ProcessButtons

    jsr CanPlayerGo
    beq contInput; all good, no obstacles

    ;obstacle ahead, restore previous position
    lda OldPlayerX
    sta PlayerX
    lda OldPlayerY
    sta PlayerY
    lda OldGlobalScroll
    sta GlobalScroll
    lda OldTileScroll
    sta TilesScroll

    jmp finishInput

contInput:
    lda TilesScroll
    cmp #MAX_TILE_SCROLL_RIGHT
    bne checkAnother
    lda DirectionX
    cmp #2
    bne checkAnother
    jsr PushCollisionMapLeft
    jmp finishInput
checkAnother:
    lda TilesScroll
    cmp #MAX_TILE_SCROLL_LEFT
    bne finishInput
    lda DirectionX
    cmp #1
    bne finishInput
    jsr PushCollisionMapRight
    jmp finishInput

inputInOtherStates:


finishInput:
    lda #INPUT_DELAY
    sta FrameCount
    rts



;--------------------------
ReadController:
    lda #$01
    sta $4016
    lda #$00
    sta $4016
    ldx #$08
@ReadControllerLoop:
    lda $4016
    lsr
    rol Buttons
    dex
    bne @ReadControllerLoop

    rts
;--------------------------------
UpdateStatusDigits:

    lda GameState
    cmp #GAME_STATE
    bne @exit

    lda $2002
    lda #$20
    sta $2006
    lda #$22
    sta $2006

    ldy #0
@HpLoop:
    lda #CHARACTER_ZERO
    clc 
    adc HP, y
    sta $2007
    iny
    cpy #3
    bcc @HpLoop

    lda $2002
    lda #$20
    sta $2006
    lda #$36
    sta $2006

    ldy #0
@warmthLoop:
    lda #CHARACTER_ZERO
    clc
    adc Warmth, y
    sta $2007

    iny
    cpy #3
    bcc @warmthLoop

    
    lda $2002
    lda #$20
    sta $2006
    lda #$2B
    sta $2006

    ldy #0
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
    ldx #$40 ;64 tiles
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
CheckGameOver:
    lda PlayerAlive
    cmp #$01
    bne gameOver
    jmp noGameOver
gameOver:
    lda #TITLE_STATE
    sta GameState
    lda #$00
    sta $2000
    sta $2001
    sta $2006
    sta $2006
    sta $2005
    sta $2005

    lda #<title
    sta pointer
    lda #>title
    sta pointer+1
    lda #$20
    sta NametableAddress
    jsr LoadNametable

noGameOver:
    rts
;-------------------------------------
ResetEntityVariables:

    lda #1
    sta HP
    sta Warmth
    sta Food
    sta Fuel

    lda #0
    sta HP + 1
    sta HP + 2
    sta Warmth + 1
    sta Warmth + 2
    sta Food + 1
    sta Food + 2
    sta Fuel + 1
    sta Fuel + 2

    lda #3
    sta ItemCount
    lda #1
    sta Items
    lda #50
    sta Items + 1
    lda #180
    sta Items + 2
    lda #ITEM_TYPE_FUEL
    sta Items + 3
    lda #1
    sta Items + 4
    lda #55
    sta Items + 5
    lda #32
    sta Items + 6
    lda #ITEM_TYPE_FOOD
    sta Items + 7
    lda #1
    sta Items + 8
    lda #10
    sta Items + 9
    lda #100
    sta Items + 10
    lda #1
    sta Items + 11

    lda #4
    sta NpcCount
    lda #100
    sta Npcs
    lda #180
    sta Npcs + 1
    lda #14
    sta Npcs + 2
    lda #3
    sta Npcs + 3
    lda #100
    sta Npcs + 4
    lda #32
    sta Npcs + 5
    lda #08
    sta Npcs + 6
    lda #2
    sta Npcs + 7
    lda #132
    sta Npcs + 8
    lda #180
    sta Npcs + 9
    lda #10
    sta Npcs + 10
    lda #3
    sta Npcs + 11
    lda #170
    sta Npcs + 12
    lda #180
    sta Npcs + 13
    lda #10
    sta Npcs + 14 
    lda #3
    sta Npcs + 15


    lda #2
    sta Inventory
    lda #1
    sta Inventory + 1
    lda #1
    sta Inventory + 2
    lda #2
    sta Inventory + 3
    lda #0
    sta Inventory + 4
    lda #2
    sta Inventory + 5
    lda #1
    sta Inventory + 6
    lda #0
    sta Inventory + 7
    lda #2
    sta Inventory + 8
    lda #1
    sta Inventory + 9

    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerPos
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
    sta InHouse
    lda #$50
    sta PlayerX
    lda #$90
    sta PlayerY
    lda #$01
    sta PlayerAlive

    rts
;-------------------------------------
DecreaseDigits:

    ldy #2
    lda (DigitPtr), y
    beq @decreaseSecondDigit

    lda (DigitPtr), y
    sec
    sbc #1
    sta (DigitPtr), y
    jmp @exit
@decreaseSecondDigit:
    ldy #1
    lda (DigitPtr), y
    beq @decreaseThirdDigit

    lda (DigitPtr), y
    sec
    sbc #1
    sta (DigitPtr), y
    lda #9
    ldy #2
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
    ldy #2
    sta (DigitPtr), y
    ldy #1
    sta (DigitPtr), y

@exit:
    rts

;-------------------------------------
;Increase stat number from 000 to 100
IncreaseDigits:

    ldy #0
    lda (DigitPtr), y
    bne @exit           ;the highest digit is not zero anymore, let's stop

    ldy #2
    lda (DigitPtr), y
    cmp #9
    beq @increaseSecondDigit

    lda (DigitPtr), y
    clc
    adc #1
    sta (DigitPtr), y
    jmp @exit
@increaseSecondDigit:
    ldy #1
    lda (DigitPtr), y
    cmp #9
    beq @increaseThirdDigit
    lda (DigitPtr), y
    clc
    adc #1
    sta (DigitPtr), y
    lda #0
    ldy #2
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
    and #%00010000
    bne @checkOld
    jmp @exit
@checkOld:
    lda OldButtons
    and #%00010000
    bne @exit


    lda GameState
    cmp #TITLE_STATE
    bne @someOtherState

    ;On title state------

    lda #GAME_STATE
    sta GameState

    jsr ResetEntityVariables
    lda #1
    sta MustLoadOutside
    

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

    cmp #GAME_STATE
    beq @enterMenuScreen
    ;exit menu screen

    jsr ExitMenuState
    jmp @exit
@enterMenuScreen:

    lda #1
    sta MustLoadMenu


@exit:
    lda Buttons
    sta OldButtons

    rts

;-------------------------------------
ExitMenuState:
    lda #GAME_STATE
    sta GameState

    lda InHouse
    beq @loadOutside ;InHouse = 0
    lda #1
    sta MustLoadHouseInterior
    jmp @exit
@loadOutside:
    lda #1
    sta MustLoadOutside
@exit:

    rts


;-------------------------------------
MenuInput:
    lda Buttons
    cmp MenuButtons
    beq @exit

    lda Buttons
    and #%00000100
    beq @CheckUp

    lda InventoryPointerPos
    cmp #INVENTORY_SPRITE_MAX_Y - 12
    bcs @CheckUp
    clc
    adc #12
    sta InventoryPointerPos
    inc InventoryItemIndex

    jmp @CheckB

@CheckUp:
    lda Buttons
    and #%00001000
    beq @CheckB

    lda InventoryPointerPos
    cmp #INVENTORY_SPRITE_MIN_Y + 12
    bcc @CheckB
    sec
    sbc #12
    sta InventoryPointerPos
    dec InventoryItemIndex

@CheckB:
    jsr Button_B_Pressed

@exit:
    lda Buttons
    sta MenuButtons
    lda #0
    sta Buttons

    rts
;--------------------------------------
Button_B_Pressed:
    lda Buttons
    and #%01000000
    beq @exit
    ldx InventoryItemIndex

    lda Inventory, x
    beq @exit
    asl
    asl
    tay
    iny
    iny
    iny
    lda inventory_data, y ; power
    sta Temp ; save power for later
    dey
    lda inventory_data, y ; type

    cmp #ITEM_TYPE_FUEL
    beq @addFuel

@checkFood:
    cmp #ITEM_TYPE_FOOD
    beq @addFood

    jmp @clearItem

@addFuel:
    lda InHouse
    beq @exit
    lda #MAX_FUEL_DELAY
    sta FuelDelay

    lda Fuel + 1
    clc
    adc Temp
    cmp #10
    bcs @clampFuel
    jmp @saveFuel
@clampFuel:
    lda #0
    sta Fuel + 1
    sta Fuel + 2
    lda #1
    sta Fuel
    jmp @clearItem
@saveFuel:
    sta Fuel + 1
    jmp @clearItem
;--------
@addFood:
    lda #MAX_FOOD_DELAY
    sta FoodDelay

    lda Food + 1
    clc
    adc Temp
    cmp #10
    bcs @clampFood
    jmp @saveFood
@clampFood:
    lda #0
    sta Food + 1
    sta Food + 2
    lda #1
    sta Food
    jmp @clearItem
@saveFood:
    sta Food + 1

@clearItem:
    lda #0
    sta Inventory, x
    jsr ExitMenuState

@exit:
    rts

;--------------------------------------

ProcessButtons:
    lda #0
    sta DirectionX
    sta DirectionY

;Check if LEFT is pressed
    lda Buttons
    and #%00000010
    beq @CheckRight

    lda #1
    sta DirectionX
    lda #0
    sta PlayerFrame
    sta PlayerFlip

    lda PlayerX
    clc
    adc #8
    cmp #128
    bcs @moveLeft


    lda InHouse
    cmp #1
    beq @moveLeft ; no scrolling inside the house :)

    lda GlobalScroll
    beq @moveLeft   ;hack
;--
    lda TilesScroll
    sec
    sbc #PLAYER_SPEED
    sta TilesScroll
;--
@ScrollGlobalyLeft:
    lda GlobalScroll
    cmp #1
    beq @clampLeft

    sec
    sbc #PLAYER_SPEED
    jmp @saveLeft
@clampLeft:
    lda #0
@saveLeft:
    sta GlobalScroll

    jmp @CheckUp

@moveLeft:
    lda PlayerX
    beq @CheckUp ; already x=0
    sec
    sbc #PLAYER_SPEED
    sta PlayerX
    jmp @CheckUp
;-----
;Check if RIGHT is pressed
@CheckRight:
    lda Buttons
    and #%00000001
    beq @CheckUp

    lda #2
    sta DirectionX
    lda #0
    sta PlayerFrame
    lda #1
    sta PlayerFlip


    lda PlayerX
    clc
    adc #8
    cmp #128
    bcc @moveRight  ;not gonna scroll until playerx >= 128
    lda GlobalScroll
    cmp #255        ;hacky constant, it means the map stopped scrolling
    beq @moveRight

    lda InHouse
    cmp #1
    beq @moveRight ; no scrolling

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
    cmp #254
    beq @clamp
    clc
    adc #PLAYER_SPEED
    cmp #255
    bcs @clamp
    jmp @save
@clamp:
    lda #255
@save:
    sta GlobalScroll

    jmp @CheckUp

@moveRight:
    lda PlayerX
    cmp #238 ;254 - 16
    beq @CheckUp
    clc
    adc #PLAYER_SPEED
    sta PlayerX

;--------
;Check if UP is pressed
@CheckUp:
go_Up:
    lda Buttons
    and #%00001000
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
    and #%00000100
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
    lda #0
    sta Buttons
    rts
;----------------------------------
CheckIfEnteredHouse:

    lda InHouse
    cmp #1
    beq @nope

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


    lda #0
    sta ItemCount
    lda #0
    sta NpcCount

    ldx #0
@copyCollisionMapLoop:
    lda hut_collision, x
    sta CollisionMap, x
    inx
    cpx #COLLISION_MAP_SIZE
    bne @copyCollisionMapLoop

    lda #1
    sta MustLoadHouseInterior
    lda #HOUSE_ENTRY_POINT_X
    sta PlayerX
    lda #HOUSE_ENTRY_POINT_Y
    sta PlayerY

@nope:
    rts
;---------------------------

LoadTheHouseInterior:

    lda #$00
    sta $2000
    sta $2001

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

    lda #0
    sta MustLoadHouseInterior



@nope:
    rts
;-----------------------------------
LoadMenu:
    lda #$00
    sta $2000
    sta $2001

    lda #<menu_screen
    sta pointer
    lda #>menu_screen
    sta pointer + 1

    lda #$20    ;$20000
    sta NametableAddress

    jsr LoadNametable

    lda #<menu_palette
    sta pointer
    lda #>menu_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette


    lda $2002
    lda #$20
    sta $2006
    lda #$BB
    sta $2006

    ldy #0
@hpLoop:
    lda #CHARACTER_ZERO
    clc 
    adc HP, y
    sta $2007
    iny
    cpy #3
    bne @hpLoop


    lda $2002
    lda #$20
    sta $2006
    lda #$FB
    sta $2006

    ldy #0
@foodLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Food, y
    sta $2007
    iny
    cpy #3
    bne @foodLoop

    lda $2002
    lda #$21
    sta $2006
    lda #$3B
    sta $2006

    ldy #0
@warmthLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Warmth, y
    sta $2007
    iny
    cpy #3
    bne @warmthLoop


    lda $2002
    lda #$21
    sta $2006
    lda #$DB
    sta $2006

    ldy #0
@fuelLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Fuel, y
    sta $2007
    iny
    cpy #3
    bne @fuelLoop




    lda #0
    sta MustLoadMenu

    lda #MENU_STATE
    sta GameState

    rts



;-----------------------------------
CheckIfExitedHouse:

    lda InHouse
    beq @nope

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
    lda #2
    sta ItemCount
    lda #4
    sta NpcCount

    lda #OUTSIDE_ENTRY_FROM_HOUSE_X
    sta PlayerX
    lda #OUTSIDE_ENTRY_FROM_HOUSE_Y
    sta PlayerY

    lda #1
    sta MustLoadOutside

@nope:
    rts
;-------------------------------
LoadOutsideMap:


    lda #$00
    sta $2000
    sta $2001

    lda #<background
    sta pointer
    lda #>background
    sta pointer+1

    lda #$20    ;$20000
    sta NametableAddress

    jsr LoadNametable

    ;Load Nametable 2

    lda #$00
    sta $2000
    sta $2001

    lda #<field_bg1
    sta pointer
    lda #>field_bg1
    sta pointer+1

    lda #$24    ;$2400
    sta NametableAddress

    jsr LoadNametable
    jsr LoadStatusBar

    lda #<palette
    sta pointer
    lda #>palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette
    
    lda #0
    sta MustLoadOutside


    rts

;-----------------------------------
UpdateSprites:

    ;sprite 1
    ldx #$00
    lda PlayerY
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip1
    lda PlayerFrame
    asl ;frame * 2
    clc
    adc #1
    sta FIRST_SPRITE,x
    inx
    lda FIRST_SPRITE, x
    ora #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX1
@NoFlip1:
    lda PlayerFrame
    asl ;frame * 2
    sta FIRST_SPRITE,x
    inx
    lda FIRST_SPRITE, x
    ora #%00000011
    and #%10111111
    sta FIRST_SPRITE, x
@MoveX1:
    inx
    lda PlayerX
    sta FIRST_SPRITE, x
    inx

    ;sprite 2
    lda PlayerY
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip2
    lda PlayerFrame
    asl
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX2
@NoFlip2:
    lda PlayerFrame
    asl
    clc
    adc #1
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%00000011
    and #%10111111
    sta FIRST_SPRITE, x
@MoveX2:
    inx
    lda PlayerX
    clc
    adc #$08
    sta FIRST_SPRITE, x
    inx
;----
    ;sprite 3
    lda PlayerY
    clc
    adc #$08
    sta FIRST_SPRITE, x
    inx
    lda PlayerFlip
    beq @NoFlip3
    lda PlayerFrame
    asl
    clc
    adc #17
    adc WalkAnimationIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX3
@NoFlip3:
    lda PlayerFrame
    asl
    clc
    adc #16
    adc WalkAnimationIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%00000011
    and #%10111111
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
    lda PlayerFrame
    asl
    clc
    adc #16
    adc WalkAnimationIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%01000011
    sta FIRST_SPRITE, x
    jmp @MoveX4
@NoFlip4:
    lda PlayerFrame
    asl
    clc
    adc #17
    adc WalkAnimationIndex
    sta FIRST_SPRITE, x
    inx
    lda FIRST_SPRITE, x
    ora #%00000011
    and #%10111111
    sta FIRST_SPRITE, x
@MoveX4:
    inx
    lda PlayerX
    clc
    adc #$08
    sta FIRST_SPRITE, x

    lda #4
    sta TempSpriteCount

;--
;items update
    inx
    ldy ItemCount
    dey
@itemLoop:

    sty TempItemIndex
    tya
    asl
    asl ; y * 4
    tay
    lda Items, y ; is active
    beq @nextItem
    iny
    iny
    lda Items, y ; y
    sta FIRST_SPRITE, x
    inx
    ;index
    iny
    lda Items, y
    asl
    asl; a * 4
    sty TempY; store item index
    tay

    lda inventory_data, y ;tile index
    sta TempZ
    sta FIRST_SPRITE, x
    iny
    lda inventory_data, y
    sta TempPointX; store palette index
    ldy TempY ;restore item index

    inx
    ;attributes
    sta FIRST_SPRITE, x
    inx
    dey
    dey
    lda Items, y
    sec
    sbc GlobalScroll
    sta FIRST_SPRITE, x
    ;x
    inx
    iny
    lda Items, y
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    ;y
    inx
    ;idx
    lda TempZ
    clc
    adc #1
    sta FIRST_SPRITE, x
    inx
    ;att
    lda TempPointX
    sta FIRST_SPRITE, x
    inx
    ;x
    dey
    lda Items, y
    clc
    adc #8
    sec
    sbc GlobalScroll
    sta FIRST_SPRITE, x
    inx
    inc TempSpriteCount

@nextItem:
    ldy TempItemIndex
    dey
    bpl @itemLoop
;---
;Npcs
    ldy NpcCount
    beq @hidesprites
    dey
@npcLoop:

    sty TempItemIndex ; save npc index
    tya
    asl
    asl
    tay
    lda Npcs, y ; x
    sec
    sbc GlobalScroll
    sta TempPointX ; save x
    iny
    lda Npcs, y; y
    sta TempPointY ; save y
    iny
    lda Npcs, y    ; first tile
    sta TempZ      ;save tile
    iny
    lda Npcs, y ; row count
    tay
    lda #0
    sta TempPush ; additionl Y
    sta TempIndex ;additional sprite index
@rowloop:
    jsr UpdateNpcRow
    dey
    bne @rowloop

    ldy TempItemIndex; restore the index
    dey
    bpl @npcLoop
;---------
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

    rts
;---------------------------------
UpdateNpcRow:
     ;Y
    lda TempPointY
    clc
    adc TempPush
    sta FIRST_SPRITE, x
    inx
    ;index
    lda TempZ
    clc
    adc TempIndex
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda #0
    sta FIRST_SPRITE, x
    inx
    ;X
    lda TempPointX
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inx
    ;Y
    lda TempPointY
    clc
    adc TempPush
    sta FIRST_SPRITE, x
    inx
    ;index
    lda TempZ
    clc
    adc #1
    adc TempIndex
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda #0
    sta FIRST_SPRITE, x
    inx
    ;X
    lda TempPointX
    clc
    adc #8
    sta FIRST_SPRITE, x
    inx

    inc TempSpriteCount
    
    lda TempPush
    clc
    adc #8
    sta TempPush
    lda TempIndex
    clc
    adc #16
    sta TempIndex


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

    rts

