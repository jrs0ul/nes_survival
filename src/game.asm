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
    .byte $00,$57,$30,$30,$30,$00,$00,$41,$4E,$47,$40,$3E,$4B,$00,$30,$30
    .byte $00,$50,$3A,$4B,$46,$4D,$41,$00,$30,$30,$00,$00,$00,$3D,$30,$30

palette:
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $31,$10,$0f,$01    ;background
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $0f,$0f,$37,$16    ;OAM sprites

house_palette:
    .byte $0f,$16,$27,$37, $0f,$07,$00,$31, $0f,$17,$27,$31, $31,$10,$0f,$01    ;background
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $0f,$0f,$37,$16    ;OAM sprites

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
    FIRE_ANIMATION_DELAY       = $20


    INVENTORY_SPRITE_X         = 48
    INVENTORY_SPRITE_MIN_Y     = 44
    INVENTORY_SPRITE_MAX_Y     = 164

;===================================================================
.segment "ZEROPAGE"

pointer:
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


Inventory:
    .res 10 ;10 items

InventoryPointerPos:
    .res 1

InventoryItemIndex:
    .res 1


WarmthDelay:
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
    lda #0
    sta MustLoadHouseInterior

;---------------------------------

endlessLoop:

    lda MustLoadHouseInterior
    bne continueForever ; don't do logics until the house is not loaded to the PPU
    lda MustLoadOutside
    bne continueForever ; the same is with the map of outside
    lda MustLoadMenu
    bne continueForever

    dec FrameCount
    bne doInput
    jmp doSomeLogics

doInput:
    jsr HandleInput

doSomeLogics:

    lda GameState
    cmp #GAME_STATE
    bne nextIteration

    lda NMIActive
    beq continueForever

    jsr AnimateFire
    
    lda HP
    clc
    adc HP + 1
    adc HP + 2
    cmp #0
    beq killPlayer
    jmp checkWarmth
killPlayer:
    lda #0
    sta PlayerAlive
    jmp doneLogics

checkWarmth:
    dec WarmthDelay
    lda WarmthDelay
    beq resetWarmthDelay
    jmp doneLogics
resetWarmthDelay:
    lda #MAX_WARMTH_DELAY
    sta WarmthDelay
    lda InHouse
    bne increaseWarmth
    jsr DecreaseWarmth
    lda Warmth
    beq checkSecondDigit
    jmp doneLogics
checkSecondDigit:
    lda Warmth + 1
    beq decreaseLife
    jmp doneLogics
decreaseLife:
    jsr DecreaseHP
    jmp doneLogics

increaseWarmth:
    jsr IncreaseWarmth


doneLogics:
    lda #0
    sta NMIActive

continueForever:

    jsr CheckIfEnteredHouse
    jsr CheckIfExitedHouse
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
    jsr UpdateSprites
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

    jsr UpdateInventorySprites

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



;-------------------------------------
UpdateInventorySprites:

    ldx #0
    lda #0
    sta Temp

    lda #32
    sta TempY

@itemLoop:

    lda Inventory, x
    asl ;inventory_index * 2
    tay
    lda inventory_data, y ;grap sprite index
    bne @store_sprite_index
    lda #$FD ;empty sprite index
@store_sprite_index:
    sta TempZ ; save sprite index
    iny
    lda inventory_data, y
    sta TempPointY ; save palette

    stx TempPointX ; save x index
    lda TempY
    clc
    adc #12
    sta TempY

    ldy #0
@twoTileLoop: ;item consists of two tiles

    lda TempY
    ldx Temp
    sta FIRST_SPRITE, x ;set Y coordinate

    inc Temp
    lda TempZ
    sty TempPush
    clc
    adc TempPush
    ldx Temp
    sta FIRST_SPRITE, x

    inc Temp
    ;attributes
    ldx Temp
    lda #0
    clc
    adc TempPointY
    sta FIRST_SPRITE, x
    inc Temp
    ;x coordinate
    lda #INVENTORY_SPRITE_X
    cpy #1
    bne @saveX
    clc
    adc #8
@saveX:
    ldx Temp
    sta FIRST_SPRITE, x
    inc Temp
    iny
    cpy #2
    bcc @twoTileLoop

    ldx TempPointX ;restore x index
@next:
    inx
    cpx #10
    bcc @itemLoop


    ldx Temp
    lda InventoryPointerPos
    sec
    sbc #1
    sta FIRST_SPRITE, x
    inc Temp
    lda #$FC
    ldx Temp
    sta FIRST_SPRITE, x
    inc Temp
    ldx Temp
    lda #%00000011
    sta FIRST_SPRITE, x
    inc Temp
    ldx Temp
    lda #30
    sta FIRST_SPRITE, x



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

    lda #CHARACTER_ZERO
    clc 
    adc HP
    sta $2007
    lda #CHARACTER_ZERO
    clc 
    adc HP + 1
    sta $2007
    lda #CHARACTER_ZERO
    clc 
    adc HP + 2
    sta $2007




    lda $2002
    lda #$20
    sta $2006
    lda #$38
    sta $2006

    lda #CHARACTER_ZERO
    clc
    adc Warmth
    sta $2007

    lda #CHARACTER_ZERO
    clc
    adc Warmth + 1
    sta $2007

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
    lda #$F0
    sta PlayerX
    sta PlayerY
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
    jsr HideSprites
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
    lda #0
    sta HP + 1
    sta HP + 2
    ;lda #9
    sta Warmth
    sta Warmth + 1

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
DecreaseWarmth:

    lda Warmth + 1
    beq @decreaseUperDigit

    dec Warmth + 1
    jmp @exit
@decreaseUperDigit:
    lda Warmth
    beq @exit
    dec Warmth
    lda #9
    sta Warmth + 1

@exit:
    rts
;-------------------------------------
IncreaseWarmth:

    lda Warmth + 1
    cmp #9
    beq @increaseUpperDigit

    inc Warmth + 1
    jmp @exit
@increaseUpperDigit:
    lda Warmth
    cmp #9
    beq @exit
    inc Warmth
    lda #0
    sta Warmth + 1
@exit:
    rts

;-------------------------------------
DecreaseHP:

    lda HP + 2
    beq @decreaseSecondDigit

    dec HP + 2
    jmp @exit
@decreaseSecondDigit:
    lda HP + 1
    beq @decreaseThirdDigit
    dec HP + 1
    lda #9
    sta HP + 2
    jmp @exit
@decreaseThirdDigit:
    lda HP
    beq @exit
    dec HP
    lda #9
    sta HP + 2
    sta HP + 1


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
    lda Buttons
    and #%01000000
    beq @exit
    ldx InventoryItemIndex

    lda Inventory, x
    beq @exit
    lda #0
    sta Inventory, x
    jsr ExitMenuState

@exit:
    lda Buttons
    sta MenuButtons
    lda #0
    sta Buttons

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

    lda #CHARACTER_ZERO
    clc 
    adc HP
    sta $2007

    lda #CHARACTER_ZERO
    clc 
    adc HP + 1
    sta $2007

    lda #CHARACTER_ZERO
    clc 
    adc HP + 2
    sta $2007





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
;--
    inx
    ldy #20
@hideSpritesLoop:
    lda #$FE
    sta FIRST_SPRITE, x
    inx
    inx
    inx
    inx

    dey
    bne @hideSpritesLoop


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

