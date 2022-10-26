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
  .byte %00000000                   ; NROM mapper 0, other mappers have more complicated values here
  .byte $0, $0, $0, $0, $0, $0

.segment "VECTORS"
    .word nmi, reset, 0
;==========================================================
.segment "RODATA" ; data in rom

.include "field_bg.asm"
.include "title.asm"

zerosprite:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$41,$49,$00,$30,$30,$00,$41,$4E,$47,$40,$3E,$4B,$00,$30,$30
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

palette:

    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $31,$10,$0f,$01    ;background
    .byte $0f,$00,$21,$31, $0f,$27,$21,$31, $0f,$17,$21,$31, $0f,$0f,$37,$16    ;OAM sprites

sprites:
    .byte $0A, $0A, $00000011, $08   ; sprite 0 
    .byte $00, $00, %00000011, $00
    .byte $00, $01, %00000011, $00
    .byte $00, $10, %00000011, $00
    .byte $00, $11, %00000011, $00

;===================================================================
.segment "ZEROPAGE"

pointer:
    .res 2
;--------------
.segment "BSS" ; variables in ram

scroll:
    .res 1
PlayerX:
    .res 1
PlayerY:
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

;--------------
                        ; constants
    DUDE_SPRITE      = $0204
    TITLE_STATE      = $00
    GAME_STATE       = $01

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
    stx $2001  ; disable rendering
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

    jsr LoadNametable

    lda #%10010000   ; enable NMI, sprites from Pattern Table 0
    sta $2000
    
    lda #%00011110   ; enable sprites
    sta $2001


    lda #TITLE_STATE
    sta GameState



forever:
    jmp forever

;=========================================================

nmi:

    lda #$00
    sta $2003        ; set the low byte (00) of the RAM address
    lda #$02
    sta $4014        ; set the high byte (02) of the RAM address, start the transfer

    jsr ReadController
    jsr CheckStartButton

    lda #GAME_STATE
    cmp GameState
    bne endOfNmi    ;if the states is not game, update the sound and finish

    jsr go_Left     ; left
    jsr go_Right    ;right
    jsr go_Down
    jsr go_Up

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
    ;jsr scrollBackground

    lda #%10010000 
    sta $2000

endOfNmi:

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
    jsr LoadNametable

noGameOver:
    rts
;-------------------------------------
ResetEntityVariables:

    lda #9
    sta hp0
    sta hp1

    lda #0
    sta scroll
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
    lda #$00
    sta $2000
    sta $2001

    lda #<background
    sta pointer
    lda #>background
    sta pointer+1

    jsr LoadNametable
    jsr LoadStatusBar
    jsr ResetEntityVariables

    
dontStart:
    rts


;--------------------------------------
scrollBackground:

    inc scroll       ; add one to our scroll variable each frame
    lda scroll
    sta $2005        ; write the horizontal scroll count register

    lda #0           ; no vertical scrolling
    sta $2005
    rts
;---------------------------------

go_Left:
    lda Buttons
    and #%00000010
    beq LeftDone
    lda PlayerX
    sec
    sbc #$02
    sta PlayerX
LeftDone:
    rts
;----------------------------------
go_Right:
    lda Buttons
    and #%00000001
    beq RightDone
    lda PlayerX
    clc
    adc #$02
    sta PlayerX
RightDone:
    rts
;----------------------------------
go_Up:
    lda Buttons
    and #%00001000
    beq UpNotPressed
    lda PlayerY
    sec
    sbc #2
    sta PlayerY
UpNotPressed:
    rts
;----------------------------------
go_Down:
    lda Buttons
    and #%00000100
    beq DownNotPressed
    lda PlayerY
    clc
    adc #2
    sta PlayerY
DownNotPressed:
    rts
;----------------------------------
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
LoadNametable:
    lda $2002             ; read PPU status to reset the high/low latch
    lda #$20
    sta $2006             ; write the high byte of $2000 address
    lda #$00
    sta $2006             ; write the low byte of $2000 address

    ldx #$00
    ldx #$00
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
