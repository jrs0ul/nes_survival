LoadAlienGfx:
    ldy #4
    jsr bankswitch_y

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<alien_tiles_chr
    ldy #2
    sta (sp),y
    iny
    lda #>alien_tiles_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$15
    ldy #1
    sta (sp),y
    lda #0
    ldx #11
    jsr UnLZ4toVram

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<alien_sprites_chr
    ldy #2
    sta (sp),y
    iny
    lda #>alien_sprites_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$0A
    ldy #1
    sta (sp),y
    lda #0
    ldx #6
    jsr UnLZ4toVram


    rts
;----------------------------
LoadCaveGfx:

    ldy #4
    jsr bankswitch_y

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<cave_tiles_chr
    ldy #2
    sta (sp),y
    iny
    lda #>cave_tiles_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$15
    ldy #1
    sta (sp),y
    lda #0
    ldx #11
    jsr UnLZ4toVram

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<cave_sprites_chr
    ldy #2
    sta (sp),y
    iny
    lda #>cave_sprites_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$0A
    ldy #1
    sta (sp),y
    lda #0
    ldx #6
    jsr UnLZ4toVram

    rts
;----------------------------
LoadMainTileset:
    ldy #0
    jsr bankswitch_y

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda MustLoadCoreSprites
    beq @loadAnimals

    lda #<main_core_sprites
    ldy #2
    sta (sp), y
    iny
    lda #>main_core_sprites
    sta (sp), y
    lda #0
    tay
    sta (sp), y
    iny
    sta (sp), y
    ldx #$0A
    jsr UnLZ4toVram

    lda #0
    sta MustLoadCoreSprites

@loadAnimals:
    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<main_animal_sprites
    ldy #2
    sta (sp), y
    iny
    lda #>main_animal_sprites
    sta (sp), y
    lda #0
    tay
    sta (sp), y
    iny
    lda #10
    sta (sp), y
    ldx #$06
    lda #0
    jsr UnLZ4toVram

    lda MustReloadFontAndUI
    beq @loadMainBgTiles
@loadFontAndUI:
    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<font
    ldy #2
    sta (sp), y
    iny
    lda #>font
    sta (sp), y
    lda #0
    ldy #0
    sta (sp), y
    iny
    lda #16
    sta (sp), y
    ldx #$03
    lda #0
    jsr UnLZ4toVram

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<UI_tiles
    ldy #2
    sta (sp), y
    iny
    lda #>UI_tiles
    sta (sp), y
    lda #0
    ldy #0
    sta (sp), y
    iny
    lda #19
    sta (sp), y
    ldx #$02
    lda #0
    jsr UnLZ4toVram

    lda #0
    sta MustReloadFontAndUI

@loadMainBgTiles:

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<main_bg_tiles
    ldy #2
    sta (sp), y
    iny
    lda #>main_bg_tiles
    sta (sp), y
    lda #0
    ldy #0
    sta (sp), y
    iny
    lda #21
    sta (sp), y
    ldx #11
    lda #0
    jsr UnLZ4toVram


    rts
;----------------------------


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

    lda LocationType
    cmp #LOCATION_TYPE_CAVE
    beq @load_cave
    cmp #LOCATION_TYPE_DARK
    beq @load_cave
    cmp #LOCATION_TYPE_ALIEN_BASE
    beq @load_alien

    lda LocationIndex
    cmp #LOCATION_CRASHSITE
    beq @load_crashsite
    jmp @main_bank

@load_alien:
    jsr LoadAlienGfx
    jmp @done_copying

@load_cave:
    jsr LoadCaveGfx
    jmp @done_copying

@load_crashsite:

    jsr LoadMainTileset

    ldy #5
    jsr bankswitch_y

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1


    lda #<crashed_plane_tiles_chr
    ldy #2
    sta (sp),y
    iny
    lda #>crashed_plane_tiles_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #25
    ldy #1
    sta (sp),y
    lda #0
    ldx #3
    jsr UnLZ4toVram


    jmp @done_copying

@main_bank:
    jsr LoadMainTileset
    lda #1
    sta MustPlayNewSong

@done_copying:
    lda #0
    sta MustCopyMainChr
    ldy LocationIndex
    lda LocationBanks, y
    tay
    jsr bankswitch_y

@continueLoad:
    ldy CurrentMapSegmentIndex
    sty TempY
    jsr CalcMapAddress

    lda FirstNametableAddr
    sta NametableAddress

    lda #HUD_TILE_COUNT
    sta NametableOffsetInBytes
    jsr LoadNametable
    lda #0
    sta NametableOffsetInBytes

    lda ScreenCount
    cmp #2
    bcc @loadRest ; there is only one screen

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

    lda #HUD_TILE_COUNT
    sta NametableOffsetInBytes
    jsr LoadNametable
    lda #0
    sta NametableOffsetInBytes

    lda ScreenCount
    cmp #3
    bcc @loadRest ; stuff bellow is not needed if there are 2 screens max

    ldy LocationIndex
    lda location_map_pos, y
    sta TempLocationPos

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

    ldy LocationIndex
    lda location_map_pos, y
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

    clc
    adc TempLocationPos

    jsr PrepareDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sta TempZ

    lda BgColumnIdxToUpload
    sta TempPointX

    lda #0
    sta TempPreRowLoopValue

    jsr CopyTilesToScreen
    lda CurrentMapSegmentIndex
    clc
    adc #2
    clc
    adc TempLocationPos
    jsr CopyAttributes

@exit:

    rts
;-----------------------------------
ReloadLowerColumnRange_movingLeft:
    ;copy tiles to screen's columns 0.. BgColumnIdxToUpload(0..15)
    ;from CurrentMapScreen


    lda CurrentMapSegmentIndex ; screen we're copying
    clc
    adc TempLocationPos

    jsr PrepareDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sec
    sbc BgColumnIdxToUpload
    sta TempZ       ;32 - ColumnIndex = 32 .. 17

    lda #16
    sec
    sbc BgColumnIdxToUpload
    sta TempPointX  ;16 - ColumnIndex = 16 .. 1

    lda BgColumnIdxToUpload
    sta TempPreRowLoopValue

    ;x is SCREEN_ROW_COUNT - HUD_TILE_ROW_COUNT (26)

    jsr CopyTilesToScreen
    lda CurrentMapSegmentIndex
    clc
    adc TempLocationPos
    jsr CopyAttributes

@exit:

    rts

;-----------------------------------
ReloadUpperColumnRange_movingLeft:
    ;Upper Range 16 .. BgColumnIdxToUpload(16..32)

    lda CurrentMapSegmentIndex
    beq @exit

    clc
    adc TempLocationPos

    sec
    sbc #1 ; rom screen idx
    jsr PrepareDestAndSource

    lda #SCREEN_COLUMN_COUNT
    sec
    sbc BgColumnIdxToUpload ; 32 - (16..32) = 16 .. 0
    sta TempZ
    sta TempPointX

    lda BgColumnIdxToUpload
    sta TempPreRowLoopValue

    ;x is 26

    jsr CopyTilesToScreen
    lda CurrentMapSegmentIndex
    sec
    sbc #1
    clc
    adc TempLocationPos
    jsr CopyAttributes

@exit:
    rts

;-----------------------------------
ReloadUpperColumnRange_movingRight:
    ;Upper Range 16 .. BgColumnIdxToUpload

    lda CurrentMapSegmentIndex
    clc
    adc #1
    cmp ScreenCount
    bcs @exit

    clc
    adc TempLocationPos

    jsr PrepareDestAndSource

    lda BgColumnIdxToUpload
    sec
    sbc #16
    sta TempPointX

    lda #16
    sta TempZ
    sta TempPreRowLoopValue

    jsr CopyTilesToScreen


    lda CurrentMapSegmentIndex
    clc
    adc #1
    clc
    adc TempLocationPos
    jsr CopyAttributes

@exit:
    rts

;-----------------------------------
;a - screen index
CopyAttributes:

    tay

    lda TempPointX
    lsr
    lsr
    sta Temp
    asl
    asl
    cmp TempPointX
    bcc @increment

    lda Temp
    jmp @saveTempPointX

@increment:
    lda Temp
    clc
    adc #1

@saveTempPointX:
    sta TempPointX ; TempPointX = TempPointX / 4 (rounded)

    lda TempZ
    lsr
    lsr
    sta Temp
    asl
    asl
    cmp TempZ
    bcc @incrementTempZ


    lda Temp
    jmp @saveTempZ

@incrementTempZ:
    lda Temp
    clc
    adc #1

@saveTempZ:
    sta TempZ
    ;TempZ / 4 rounded

    lda TempPreRowLoopValue
    lsr
    lsr
    sta TempPreRowLoopValue


    lda map_list_low, y
    clc
    adc #$40 ; $C0 - $80(four tile rows * 32 bytes)
    sta pointer
    lda map_list_high, y
    adc #$3
    sta pointer + 1

    lda DestScreenAddr
    clc
    adc #$3
    sta Temp
    lda #$C0
    sta TempY

    ldx #8

    jsr CopyTilesToScreen

    rts
;-----------------------------------
CopyTilesToScreen:

@rowLoop:

    lda pointer
    clc
    adc TempPreRowLoopValue
    sta pointer
    bcs @inc_high_Src_Addr
    jmp @screen_addr

@inc_high_Src_Addr:
    inc pointer + 1

@screen_addr:

    lda TempY
    clc
    adc TempPreRowLoopValue
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

@loop:
    lda (pointer), y
    sta $2007
    iny
    cpy TempPointX
    bcc @loop

    ;next row
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
    bne @done
    inc Temp
@done:

    dex
    bne @rowLoop

    rts
;----------------------------------
;a - location * 4 + screen index
PrepareDestAndSource:

    tay
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda DestScreenAddr
    sta Temp ;upper address
    lda #HUD_TILE_COUNT ; skip HUD rows
    sta TempY ;lower address

    ldx #SCREEN_ROW_COUNT - HUD_TILE_ROW_COUNT

    rts
