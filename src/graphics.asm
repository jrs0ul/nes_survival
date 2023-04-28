;----------------------------------
;pointer - data
;Temp - screen High address
;TempX - screen Lower address
;TempPointX - column count
;TempPointY - row count
TransferTiles:
    lda #0  ;turn off ppu
    sta $2001

    ldy #0
    sty TempIndex

@menuRowLoop:

    sty TempY

    lda $2002
    lda Temp
    sta $2006
    lda TempX
    sta $2006

    ldx #0

@menuCellLoop:
    ldy TempIndex 
    lda (pointer), y
    sta $2007
    inx
    inc TempIndex
    cpx TempPointX
    bne @menuCellLoop

    lda TempX
    clc
    adc #$20
    bcs @incrementUpperAddress
    sta TempX
    jmp @incrementRow
@incrementUpperAddress:
    sta TempX
    inc Temp
@incrementRow:
    ldy TempY
    iny
    cpy TempPointY
    bne @menuRowLoop


    rts

;---------------------------------
; Loads palettes
; Temp stores palette size
; pointer points to palette
LoadPalette:
    lda $2002    ; read PPU status to reset the high/low latch
    lda #$3F
    sta $2006    ; write the high byte of $3F00 address
    lda #$00
    sta $2006    ; write the low byte of $3F00 address

    ; Set x to 0 to get ready to load relative addresses from x
    ldy #0
@LoadPalettesLoop:
    lda (pointer), y      ;load palette byte
    sta $2007             ;write to PPU
    iny                   ;set index to next byte
    cpy Temp
    bne @LoadPalettesLoop  


    rts

;----------------------------------------
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

    inc pointer + 1
    inx
    cpx #4
    bne OutsideLoop

    rts
