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

