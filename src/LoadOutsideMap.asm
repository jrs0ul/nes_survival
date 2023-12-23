LoadOutsideMap:

    lda #0
    sta MustUpdateTextBaloon
    ldy LocationIndex
    lda LocationBanks, y
    cmp current_bank
    beq @startLoad

    tay ;transfer bank index to y
    jsr bankswitch_y

@startLoad:
    lda #$00
    sta $2000
    sta $2001

    lda MustCopyMainChr
    beq @continueLoad ;nope we don't need to load CHR

    ldy MapTilesetBankNo;bank where the outdoor tiles are
    jsr bankswitch_y

    lda #<main_tiles_chr
    sta pointer
    lda #>main_tiles_chr
    sta pointer + 1

    jsr CopyCHRTiles

    ldy LocationIndex
    lda LocationBanks, y
    tay
    jsr bankswitch_y

    lda #0
    sta MustCopyMainChr
    sta SongName; let's play song 0
    lda #1
    sta MustPlayNewSong

@continueLoad:
    ldy CurrentMapSegmentIndex
    sty TempY
    jsr CalcMapAddress

    lda FirstNametableAddr
    sta NametableAddress

    jsr LoadNametable

    ;Load Nametable 2

    ldy CurrentMapSegmentIndex
    iny ; map index + 1

    cpy ScreenCount
    bcc @setMapPointer

    ldy CurrentMapSegmentIndex
    dey; map index - 1

@setMapPointer:
    sty TempY
    jsr CalcMapAddress

@loadMap2:
    lda SecondNametableAddr
    sta NametableAddress

    jsr LoadNametable

    lda ScreenCount
    cmp #3
    bcc @loadRest ; stuff bellow is not needed if there are 2 screens max

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
;*****************************************

@loadRest:
    jsr LoadStatusBar

    ;copy outside map palette to ram
    ldy #0
@paletteCopy:
    lda (CurrentMapPalettePtr), y
    sta TempPalette, y
    iny
    cpy #32
    bne @paletteCopy

    lda #255
    sta CurrentPaletteDecrementValue

    lda #<TempPalette
    sta PalettePtr
    lda #>TempPalette
    sta PalettePtr + 1

    jsr AdaptBackgroundPaletteByTime
    lda #32
    sta PaletteUpdateSize

    lda #0
    sta MustLoadOutside
    sta MustLoadSomething

    lda LocationIndex
    tay
    lda LocationScreenCountList, y
    sta ScreenCount

    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx

    rts

;----------------------------------
;TempY - map segment index
CalcMapAddress:

    lda LocationIndex
    asl
    asl
    clc
    adc TempY
    tay
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    rts

;-----------------------------------
ReloadLowerColumnRange_movingRight:
    ;copy tile columns
    ;to screen's 0.. BgColumnIdxToUpload(0..15), row by row
    ;from CurrentMapScreen + 2

    lda CurrentMapSegmentIndex
    clc
    adc #2 ;screen index we're using

    cmp ScreenCount
    bcs @exit

    jsr PrepairDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sta TempZ

@lowerRangeRowLoop:  ;---------loop
    lda $2002
    lda Temp  ;high
    sta $2006
    lda TempY ;low
    sta $2006

    ldy #0

@lowerRangeLoop:
    lda (pointer), y
    sta $2007
    iny
    cpy BgColumnIdxToUpload
    bcc @lowerRangeLoop

    jsr JumpToNextTileRow
    dex
    bne @lowerRangeRowLoop ;----loop
@exit:

    rts
;-----------------------------------
ReloadLowerColumnRange_movingLeft:
    ;copy tiles to screen's columns 0.. BgColumnIdxToUpload(0..15)
    ;from CurrentMapScreen

    lda CurrentMapSegmentIndex ; screen we're copying

    jsr PrepairDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sec
    sbc BgColumnIdxToUpload
    sta TempZ       ;32 - ColumnIndex = 32 .. 17

    lda #16
    sec
    sbc BgColumnIdxToUpload
    sta TempPointX  ;16 - ColumnIndex = 16 .. 1

    ;x is SCREEN_ROW_COUNT (30)

@rowLoop:
    jsr MovingLeft_PreRowLoop
    ;y reg is 0

@loop:

    lda (pointer), y
    sta $2007
    iny
    cpy TempPointX
    bcc @loop  ; if Column is 0, then this will go until y is 16

    ;next row ??
    jsr JumpToNextTileRow
    dex
    bne @rowLoop

@exit:

    rts



;-----------------------------------
ReloadUpperColumnRange_movingLeft:
    ;Upper Range 16 .. BgColumnIdxToUpload(16..32)

    lda CurrentMapSegmentIndex
    beq @exit

    sec
    sbc #1 ; rom screen idx
    jsr PrepairDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sec
    sbc BgColumnIdxToUpload ; 32 - (16..32) = 16 .. 0
    sta TempZ

    ;x is 30

@rowLoop:
    jsr MovingLeft_PreRowLoop

    ;y is 0

@loop:
    lda (pointer), y
    sta $2007
    iny
    cpy TempZ       ; columns (16 .. 0)
    bcc @loop

    ;next row ?
    jsr JumpToNextTileRow
    dex
    bne @rowLoop

@exit:
    rts

;-----------------------------------
ReloadUpperColumnRange_movingRight:
    ;Upper Range 16 .. BgColumnIdxToUpload

    lda CurrentMapSegmentIndex
    clc
    adc #1

    jsr PrepairDestAndSource

    lda BgColumnIdxToUpload
    sec
    sbc #16
    sta TempPointX

    lda #16
    sta TempZ

@rowLoop:

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

@loop:
    lda (pointer), y
    sta $2007
    iny
    cpy TempPointX
    bcc @loop

    ;next row
    jsr JumpToNextTileRow
    dex
    bne @rowLoop

    rts

;-----------------------------------
MovingLeft_PreRowLoop:

    lda pointer
    clc
    adc BgColumnIdxToUpload
    sta pointer
    bcs @inc_high_Src_Addr
    jmp @screen_addr

@inc_high_Src_Addr:
    inc pointer + 1

@screen_addr:

    lda TempY
    clc
    adc BgColumnIdxToUpload
    sta TempY
    bcs @increase
    jmp @continue
@increase:
    inc Temp ; increese screen high adr

@continue:
    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldy #0

    rts
;----------------------------------
;a - screen index
PrepairDestAndSource:

    tay
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda DestScreenAddr
    sta Temp ;upper address
    lda #0
    sta TempY ;lower address

    ldx #SCREEN_ROW_COUNT

    rts

;---------------------------------
JumpToNextTileRow:

    lda pointer
    clc
    adc TempZ
    sta pointer
    bcs @incrementHighPtr
    jmp @incrementDest
@incrementHighPtr:
    inc pointer + 1

@incrementDest:
    lda TempY
    clc
    adc TempZ
    sta TempY
    cmp #0
    bne @exit
    inc Temp
@exit:

    rts
