.segment "ROM1"

;----------------------------------
;pointer - data
;Temp - screen High address
;TempX - screen Lower address
;TempPointX - column count
;TempPointY - row count


;stores 1 in A when the transfer is done
TransferTiles:
    lda #0  ;turn off ppu
    sta $2001

    ;ldy #0
    ;sty TempIndex

    ldy menuTileTransferRowIdx
    sty TempY

    cpy #0
    bne @cont
    ; only if it's the first row

    lda #0
    sta menuTileTransferDataIdx
    lda Temp
    sta menuTileTransferAddressHigh
    lda TempX
    sta menuTileTransferAddressLow

@cont:

    lda $2002
    lda menuTileTransferAddressHigh
    sta $2006
    lda menuTileTransferAddressLow
    sta $2006

    ldx #0

@menuCellLoop:
    ldy menuTileTransferDataIdx
    lda (pointer), y
    sta $2007
    inx
    inc menuTileTransferDataIdx
    cpx TempPointX
    bne @menuCellLoop

    lda menuTileTransferAddressLow
    clc
    adc #$20
    bcs @incrementUpperAddress
    sta menuTileTransferAddressLow
    jmp @incrementRow
@incrementUpperAddress:
    sta menuTileTransferAddressLow
    inc menuTileTransferAddressHigh
@incrementRow:
    ldy TempY
    iny
    cpy TempPointY
    beq @finished

    sty menuTileTransferRowIdx
    lda #0
    jmp @end

@finished: ; transfered last row
    lda #1
@end:
    rts

.segment "CODE"

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
    sta RamPalette, y
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
    sta $2006             ; write the high byte of the name table address
    lda #$00
    sta $2006             ; write the low byte of the name table address

    ldx #$00
    ldy #$00
@OutsideLoop:

@InsideLoop:

    lda (pointer),y       ;
    sta $2007             ; write to PPU
    iny
    cpy #0
    bne @InsideLoop

    inc pointer + 1
    inx
    cpx #4
    bne @OutsideLoop

    rts
