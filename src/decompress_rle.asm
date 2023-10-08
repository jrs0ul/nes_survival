
DecompressRLE:

    lda $2002             ; read PPU status to reset the high/low latch
    lda NametableAddress
    sta $2006             ; write the high byte of $2000 address
    lda #$00
    sta $2006             ; write the low byte of $2000 address


    ldy #0


    lda (pointer), y
    sta RLETag

@loop:
    iny
    cpy #0
    bne @cont
    inc pointer + 1

@cont:

    lda (pointer), y
    sta Temp
@checkRLETag:
    iny
    cpy #0
    bne @cont2
    inc pointer + 1

@cont2:

    lda (pointer), y
    cmp RLETag
    bne @unique

    iny
    cpy #0
    bne @cont3
@incHigherByte3:
    inc pointer + 1
@cont3:

    lda (pointer), y ; count
    beq @exit
    tax
    inx
@byteRepeatLoop:
    lda Temp
    sta $2007
    dex
    bne @byteRepeatLoop
    jmp @loop
@unique:
    lda Temp
    sta $2007
    lda (pointer), y
    sta $2007
    sta Temp
    jmp @checkRLETag


@exit:
    rts
