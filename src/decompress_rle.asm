RLETag = TempDestructibleTileIdx

;pointer  - points to the compressed screen
;NametableAddress - nametable where we will put the screen
DecompressRLE:

    lda $2002             ; read PPU status to reset the high/low latch
    lda NametableAddress
    sta $2006             ; write the high byte of $2000 address
    lda #$00
    sta $2006             ; write the low byte of $2000 address


    ldy #0


    lda (pointer), y     ; let's read the rle tag that's going to be used here
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
    bne @unique ; no count, it's a single unique tile

    iny
    cpy #0
    bne @cont3
    inc pointer + 1
@cont3:

    lda (pointer), y ; repeating tiles count
    beq @exit ; count can't be 0, that means we're done
    tax
    inx

@byteRepeatLoop:
    lda Temp
    sta $2007
    dex
    bne @byteRepeatLoop ; let's output all the repeating tiles

    jmp @loop

@unique:
    lda Temp
    sta $2007
    lda (pointer), y
    sta Temp

    jmp @checkRLETag ; let's see if this unique tile has count or not


@exit:
    lda Temp
    sta $2007 ; let's output the last remaining byte
    rts
