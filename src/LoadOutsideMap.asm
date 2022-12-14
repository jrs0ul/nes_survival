LoadOutsideMap:

    lda #$00
    sta $2000
    sta $2001

    ldy CurrentMapSegmentIndex
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda FirstNametableAddr
    sta NametableAddress

    jsr LoadNametable

    ;Load Nametable 2

    lda #$00
    sta $2000
    sta $2001

    ldy CurrentMapSegmentIndex
    iny ; map index + 1
    cpy ScreenCount
    bcs @loadRest


    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda SecondNametableAddr
    sta NametableAddress

    jsr LoadNametable

    lda BgColumnIdxToUpload
    cmp #16
    bcc @lowerRange

;*****UPPER RANGE***********************
    lda ScrollDirection
    cmp #1
    bne @Upper_movedRight
;UPPER MOVE LEFT
    jsr ReloadUpperColumnRange_movingRight
    jsr ReloadUpperColumnRange_movingLeft
    jmp @loadRest

@Upper_movedRight:
    lda CurrentMapSegmentIndex
    beq @justUpperRight
    jsr ReloadUpperColumnRange_movingLeft
@justUpperRight:
    jsr ReloadUpperColumnRange_movingRight
    jmp @loadRest
;*****************************************
@lowerRange:
    lda ScrollDirection
    cmp #1
    bne @Lower_movedRight
;LOWER MOVE LEFT
    jsr ReloadLowerColumnRange_movingRight
@justLowerLeft:
    jsr ReloadLowerColumnRange_movingLeft
    jmp @loadRest

@Lower_movedRight:
    lda CurrentMapSegmentIndex
    beq @justLowerRight
    jsr ReloadLowerColumnRange_movingLeft
@justLowerRight:
    jsr ReloadLowerColumnRange_movingRight
;*******

@loadRest:
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
    sta MustLoadSomething

    lda #5
    sta ScreenCount


    rts
;-----------------------------------
ReloadLowerColumnRange_movingRight:
    ;0.. BgColumnIdxToUpload

    lda CurrentMapSegmentIndex
    clc
    adc #2
    cmp ScreenCount
    bcs @exit
    tay

    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


    lda DestScreenAddr
    sta Temp
    lda #0
    sta TempY
    ldx #30
@lowerRangeRowLoop:
    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldy #0;BgColumnIdxToUpload
@lowerRangeLoop:

    lda (pointer), y
    sta $2007
    iny
    cpy BgColumnIdxToUpload
    bcc @lowerRangeLoop

    lda pointer
    clc
    adc #32
    sta pointer
    cmp #0
    bne @incrementDest
    inc pointer + 1
@incrementDest:
    lda TempY
    clc
    adc #32
    sta TempY
    cmp #0
    bne @nextrow
    inc Temp
@nextrow:
    dex
    bne @lowerRangeRowLoop
@exit:

    rts
;-----------------------------------
ReloadLowerColumnRange_movingLeft:
    ;0.. BgColumnIdxToUpload
    
    ldy CurrentMapSegmentIndex

    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda #32
    sec
    sbc BgColumnIdxToUpload
    sta TempZ

    lda #16
    sec
    sbc BgColumnIdxToUpload
    sta TempPointX


    lda DestScreenAddr
    sta Temp
    lda #0
    sta TempY


    ldx #30
@lowerRangeRowLoop:
    jsr MovingLeft_PreRowLoop

@lowerRangeLoop:

    lda (pointer), y
    sta $2007
    iny
    cpy TempPointX
    bcc @lowerRangeLoop

    lda pointer
    clc
    adc TempZ
    sta pointer
    cmp #0
    bne @incrementDest
    inc pointer + 1
@incrementDest:
    lda TempY
    clc
    adc TempZ
    sta TempY
    cmp #0
    bne @nextrow
    inc Temp
@nextrow:
    dex
    bne @lowerRangeRowLoop

@exit:

    rts

;-----------------------------------
ReloadUpperColumnRange_movingLeft:
    ;Upper Range 16 .. BgColumnIdxToUpload

    lda CurrentMapSegmentIndex
    beq @exit
    sec
    sbc #1
    tay
    
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


    lda DestScreenAddr
    sta Temp ;upper address
    lda #0
    sta TempY ;lower address

    ldx #30 ; rows

    lda #32
    sec
    sbc BgColumnIdxToUpload
    sta TempZ

@UpperRangeRowLoop:
    jsr MovingLeft_PreRowLoop

@UpperRangeLoop:
    lda (pointer), y
    sta $2007
    iny
    cpy TempZ
    bcc @UpperRangeLoop

    lda pointer
    clc
    adc TempZ
    sta pointer
    cmp #0
    bne @incrementDest
    inc pointer + 1

@incrementDest:
    lda TempY
    clc
    adc TempZ
    sta TempY
    cmp #0
    bne @nextrow
    inc Temp
@nextrow:
    dex
    bne @UpperRangeRowLoop

@exit:
    rts

;-----------------------------------
MovingLeft_PreRowLoop:

    lda BgColumnIdxToUpload
    beq @continue ; zero
    lda pointer
    clc
    adc BgColumnIdxToUpload
    sta pointer
    cmp #0

    lda TempY
    clc
    adc BgColumnIdxToUpload
    sta TempY
    cmp #0
    bne @continue
    inc Temp

@continue:
    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldy #0

    rts

;-----------------------------------
ReloadUpperColumnRange_movingRight:
    ;Upper Range 16 .. BgColumnIdxToUpload

    lda CurrentMapSegmentIndex
    clc
    adc #1
    tay
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


    lda DestScreenAddr
    sta Temp ;upper address
    lda #0
    sta TempY ;lower address

    ldx #30 ; rows

    lda BgColumnIdxToUpload
    sec
    sbc #16
    sta TempZ

@UpperRangeRowLoop:

    lda pointer
    clc
    adc #16
    sta pointer
    cmp #0

    lda TempY
    clc
    adc #16
    sta TempY
    cmp #0
    bne @continue
    inc Temp
@continue:
    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldy #0;
@UpperRangeLoop:
    lda (pointer), y
    sta $2007
    iny
    cpy TempZ
    bcc @UpperRangeLoop

    lda pointer
    clc
    adc #16
    sta pointer
    cmp #0
    bne @incrementDest
    inc pointer + 1

@incrementDest:
    lda TempY
    clc
    adc #16
    sta TempY
    cmp #0
    bne @nextrow
    inc Temp
@nextrow:
    dex
    bne @UpperRangeRowLoop


    rts

