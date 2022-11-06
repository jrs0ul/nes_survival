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

.include "field_bg.asm"
.include "field_bg1.asm"
.include "house.asm"
.include "title.asm"
.include "collision_data.asm"

zerosprite:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$41,$49,$00,$30,$30,$00,$41,$4E,$47,$40,$3E,$4B,$00,$30,$30
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

palette:
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $31,$10,$0f,$01    ;background
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $0f,$0f,$37,$16    ;OAM sprites

house_bg_palette:
    .byte $0f,$16,$27,$37, $0f,$07,$00,$31, $0f,$17,$27,$31, $31,$10,$0f,$01    ;background

sprites:
    .byte $0A, $0A, $00000011, $08   ; sprite 0 
    .byte $00, $00, %00000011, $00
    .byte $00, $01, %00000011, $00
    .byte $00, $10, %00000011, $00
    .byte $00, $11, %00000011, $00

;--------------
; CONSTANTS
    DUDE_SPRITE                = $0204

    TITLE_STATE                = 0
    GAME_STATE                 = 1

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

    SCREEN_ROW_COUNT           = 30

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

DirectionX:
    .res 1
DirectionY:
    .res 1


hp0:
    .res 1
hp1:
    .res 1
GameState:
    .res 1
PlayerAlive:
    .res 1
Buttons:
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


loadpalettes:
    lda $2002    ; read PPU status to reset the high/low latch
    lda #$3F
    sta $2006    ; write the high byte of $3F00 address
    lda #$00
    sta $2006    ; write the low byte of $3F00 address

    ; Set x to 0 to get ready to load relative addresses from x
    ldx #$00
LoadPalettesLoop:
    lda palette, x        ;load palette byte
    sta $2007             ;write to PPU
    inx                   ;set index to next byte
    cpx #$20
    bne LoadPalettesLoop  ;if x = $20, 32 bytes copied, all done

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

    dec FrameCount
    bne doInput
    jmp continueForever

doInput:

    lda Buttons
    beq finishInput ; no input

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


finishInput:
    lda #INPUT_DELAY
    sta FrameCount

continueForever:

    jsr CheckIfEnteredHouse
    jsr CheckIfExitedHouse

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

    jsr ReadController
    jsr CheckStartButton

    lda #GAME_STATE
    cmp GameState
    bne endOfNmi    ;if the states is not game, update the sound and finish

    lda MustLoadHouseInterior
    beq checkIfOutsideNeedsToLoad
    jsr LoadTheHouseInterior
checkIfOutsideNeedsToLoad:
    lda MustLoadOutside
    beq continueNmi
    jsr LoadOutsideMap

   
continueNmi:
    jsr CheckGameOver
    jsr UpdateCharacter
    jsr UpdateHpDigits

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


WaitNotSprite0:
    lda $2002
    and #%01000000
    bne WaitNotSprite0   ; wait until sprite 0 not hit

WaitSprite0:
    lda $2002
    and #%01000000
    beq WaitSprite0      ; wait until sprite 0 is hit


    ldx #$03
WaitScanline:
    dex
    bne WaitScanline

    ;uncoment the call for some scrolling
    jsr scrollBackground

    lda #%10010000 
    sta $2000

endOfNmi:

    pla
    tax
    pla
    tay
    pla

    rti        ; return from interrupt

;#############################| Subroutines |#############################################
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
UpdateHpDigits:

    lda $2002
    lda #$20
    sta $2006
    lda #$24
    sta $2006

    lda #$30 ;'0' character
    clc 
    adc hp1
    sta $2007
    lda #$30
    clc 
    adc hp0
    sta $2007

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

    lda #9
    sta hp0
    sta hp1

    lda #0
    sta GlobalScroll
    sta InHouse
    lda #$50
    sta PlayerX
    lda #$90
    sta PlayerY
    lda #$01
    sta PlayerAlive

    rts

;-------------------------------------
CheckStartButton:

    lda Buttons
    and #%00010000
    beq dontStart

    lda GameState
    cmp #$00
    bne dontStart

    lda #GAME_STATE
    sta GameState

    ;Load Nametable 1

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
    jsr ResetEntityVariables

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

dontStart:
    rts

;--------------------------------------
;Loads collision data where CurrentCollisionColumnIndex is the column index
LoadRightCollisionColumn:

    lda RightCollisionColumnIndex
    cmp #COLLISION_MAP_COLUMN_COUNT
    bcs @exit

    ldx #0
@loadColumn:
    txa
    asl
    asl
    clc
    adc RightCollisionColumnIndex
    tay ; x * 4 move to y

    lda bg_collision1, y
    sta ScrollCollisionColumnRight, x
    inx
    cpx #SCREEN_ROW_COUNT
    bcc @loadColumn

@exit:
    rts
;--------------------------------------
;copy-paste hack
LoadLeftCollisionColumn:

    lda LeftCollisionColumnIndex
    cmp #COLLISION_MAP_COLUMN_COUNT
    bcs @exit

    ldx #0
@loadColumn:
    txa
    asl
    asl 
    clc
    adc LeftCollisionColumnIndex
    tay ; x * 4 move to y

    lda bg_collision, y
    sta ScrollCollisionColumnLeft, x
    inx
    cpx #SCREEN_ROW_COUNT
    bcc @loadColumn

@exit:
    rts

;--------------------------------------

scrollBackground:

    lda GlobalScroll
    sta $2005        ; write the horizontal scroll count register

    lda #0           ; no vertical scrolling
    sta $2005
    rts
;---------------------------------
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
    ;cmp #MAX_TILE_SCROLL_LEFT
    ;bne @ScrollGlobalyLeft

    ;jsr PushCollisionMapRight
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
    ;cmp #MAX_TILE_SCROLL_RIGHT
    ;bne @ScrollGlobalyRight

    ;jsr PushCollisionMapLeft

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

    lda PlayerY
    clc
    adc #PLAYER_SPEED
    sta PlayerY
@exit:
    lda #0
    sta Buttons
    rts
;----------------------------------
;Pushing collision map right when moving left
PushCollisionMapRight:
    clc
    ldx #0
    stx TempY
    stx CarrySet

    lda ScrollCollisionColumnLeft
    lsr
    sta ScrollCollisionColumnLeft

    ldx #0
    ldy #COLLISION_MAP_COLUMN_COUNT

@loop:

    lda CarrySet
    bne @RestoreCarry
    jmp @ShiftBits
@RestoreCarry:
    sec

@ShiftBits:
    lda CollisionMap, x
    ror ;shifts right and inserts carry as least significant bit
    sta CollisionMap, x
    dey
    bne @cont ; continue with the next element in the row

    ;push bits in the Right column as well
    stx Temp ; save x
    ldx TempY ; load collision column cell position
    lda ScrollCollisionColumnRight, x
    ror
    sta ScrollCollisionColumnRight, x

    ;new row
    ldy #COLLISION_MAP_COLUMN_COUNT
    inc TempY
    ldx TempY
    cpx #SCREEN_ROW_COUNT
    bcs @restoreX
    lda ScrollCollisionColumnLeft, x
    lsr
    sta ScrollCollisionColumnLeft, x
@restoreX:
    ldx Temp ; restore prev X

@cont:

    ;gotta save carry for ror
    bcs @saveCarry
    lda #0
    jmp @next_element
@saveCarry:
    lda #1
@next_element:
    sta CarrySet
    inx
    cpx #COLLISION_MAP_SIZE
    bcc @loop
    ;--

    lda #0
    sta TilesScroll

    lda TimesShiftedLeft
    bne @revert         ;TimesShiftedLeft > 0

    inc TimesShiftedRight
    lda TimesShiftedRight
    cmp #COLLISION_MAP_COLUMN_SIZE
    beq @update_columns
    jmp @exit

@revert:
    dec TimesShiftedLeft
    lda TimesShiftedLeft
    beq @reloadLeftColumn ;TimesShiftedLeft = 0, reload left column
    jmp @exit

@update_columns: ;update left and right side columns
    dec LeftCollisionColumnIndex
    jsr LoadLeftCollisionColumn
    dec RightCollisionColumnIndex
    jsr LoadRightCollisionColumn

    lda #0
    sta TimesShiftedRight
    jmp @exit
@reloadLeftColumn:
    jsr LoadLeftCollisionColumn
@exit:
    rts
;----------------------------------
;Pushing collision map left when moving right
PushCollisionMapLeft:
    ;starting from the bottom row
    clc
    ldx #SCREEN_ROW_COUNT - 1
    stx TempY; save row index

    lda ScrollCollisionColumnRight, x
    asl
    sta ScrollCollisionColumnRight, x

    ldx #COLLISION_MAP_SIZE - 1
    ldy #COLLISION_MAP_COLUMN_COUNT
@loop:

    lda CollisionMap,x
    rol ;shift collision map and add carry
    sta CollisionMap,x
    dey
    bne @cont

    ;scroll left column

    stx Temp
    ldx TempY
    lda ScrollCollisionColumnLeft, x
    rol
    sta ScrollCollisionColumnLeft, x

    ;new row
    ldy #COLLISION_MAP_COLUMN_COUNT
    dec TempY
    ldx TempY
    cpx #255
    beq @restoreX
    lda ScrollCollisionColumnRight, x
    asl
    sta ScrollCollisionColumnRight, x
@restoreX:
    ldx Temp
@cont:
    dex
    bpl @loop

    lda #0
    sta TilesScroll

    lda TimesShiftedRight
    bne @revert

    inc TimesShiftedLeft
    lda TimesShiftedLeft
    cmp #COLLISION_MAP_COLUMN_SIZE
    beq @update_columns
    jmp @exit

@revert:
    dec TimesShiftedRight
    lda TimesShiftedRight
    beq @reloadRightColumn
    jmp @exit

@update_columns:
    inc RightCollisionColumnIndex
    jsr LoadRightCollisionColumn
    inc LeftCollisionColumnIndex
    jsr LoadLeftCollisionColumn

    lda #0
    sta TimesShiftedLeft
    jmp @exit
@reloadRightColumn:
    jsr LoadRightCollisionColumn

@exit:
    rts
;----------------------------------
;Checks 4 points against the collision map
CanPlayerGo:

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_BOX_X1
    adc TilesScroll
    sta TempPointX

    lda PlayerY
    clc
    adc #8
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_BOX_X2
    adc TilesScroll
    sta TempPointX

    jsr TestPointAgainstCollisionMap
    bne @collides

    lda #0
    jmp @end

@collides:
    lda #1
@end:
    rts
;----------------------------------
;Set TempPointX and TempPointY as point to be tested
;sets A=1 if point collides
TestPointAgainstCollisionMap:

    lda TempPointX

    ; X / 8

    lsr
    lsr
    lsr
    tax

    lda x_collision_pattern, x
    sta Temp        ;save the pattern

    txa

    ; X / 8 one more time
    lsr
    lsr
    lsr
    tax

    ;divide point Y by 8
    lda TempPointY

    lsr
    lsr
    lsr
    tay

    sty TempY

    txa
    clc
    adc TempY ;add y four times, because there are 4 one byte collision segments in one row
    adc TempY
    adc TempY
    adc TempY
    tax

    lda CollisionMap, x
    and Temp
    beq @not_Colliding
    lda #1
    jmp @exit_collision_check

@not_Colliding:
    lda #0

@exit_collision_check:
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
    sta pointer+1
    lda #$20
    sta NametableAddress

    jsr LoadNametable
    jsr LoadStatusBar
    lda #128
    sta PlayerX
    lda #152
    sta PlayerY


    ;--
    lda $2002    ; read PPU status to reset the high/low latch
    lda #$3F
    sta $2006    ; write the high byte of $3F00 address
    lda #$00
    sta $2006    ; write the low byte of $3F00 address

    ldx #$00
@LoadPalettesLoop:
    lda house_bg_palette, x
    sta $2007
    inx
    cpx #$10
    bne @LoadPalettesLoop  
    ;--
    
    lda #0
    sta MustLoadHouseInterior



@nope:
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

    lda #$20
    sta NametableAddress

    jsr LoadNametable
    jsr LoadStatusBar
    lda #72
    sta PlayerX
    lda #120
    sta PlayerY

    lda $2002    ; read PPU status to reset the high/low latch
    lda #$3F
    sta $2006    ; write the high byte of $3F00 address
    lda #$00
    sta $2006    ; write the low byte of $3F00 address

    ldx #$00
@LoadPalettesLoop:
    lda palette, x
    sta $2007
    inx
    cpx #$10
    bne @LoadPalettesLoop

    lda #0
    sta MustLoadOutside

    rts

;-----------------------------------
UpdateCharacter:

    ldx #$00
    lda PlayerY
    sta DUDE_SPRITE, x
    inx
    inx
    inx
    lda PlayerX
    sta DUDE_SPRITE, x
    inx

    lda PlayerY
    sta DUDE_SPRITE, x
    inx
    inx
    inx
    lda PlayerX
    clc
    adc #$08
    sta DUDE_SPRITE, x
    inx

    lda PlayerY
    clc
    adc #$08
    sta DUDE_SPRITE,x
    inx
    inx
    inx
    lda PlayerX
    sta DUDE_SPRITE, x
    inx

    lda PlayerY
    clc
    adc #$08
    sta DUDE_SPRITE,x
    inx
    inx
    inx
    lda PlayerX
    clc
    adc #$08
    sta DUDE_SPRITE, x

    rts

;----------------------------------
loadSprites:
    ldx #$00
spriteLoadLoop:
    lda sprites, x
    sta DUDE_SPRITE - 4, x
    inx
    cpx #$28
    bne spriteLoadLoop

    rts
;---------------------------------
; Feeds stuff that the pointer points to, to PPU
; pointer points to the nametable data
; NametableAddress stores the ppu adress

LoadNametable:
    lda $2002             ; read PPU status to reset the high/low latch
    lda NametableAddress
    sta $2006             ; write the high byte of $2000 address
    lda #$00
    sta $2006             ; write the low byte of $2000 address

    ldx #$00
    ldy #$00
OutsideLoop:

InsideLoop:

    lda (pointer),y       ;
    sta $2007             ; write to PPU
    iny
    cpy #0
    bne InsideLoop

    inc pointer+1
    inx
    cpx #4
    bne OutsideLoop

    rts
