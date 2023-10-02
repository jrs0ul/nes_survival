;Checks 2 points against the collision map
CanPlayerGo:

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc TilesScroll
    sta TempPointX

    lda PlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
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
;Checks 2 points against the collision map
CanPlayerGoWithOldY:

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc TilesScroll
    sta TempPointX

    lda OldPlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
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
;Checks 2 points against the collision map
CanPlayerGoWithOldX:

    lda OldPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc OldTileScroll
    sta TempPointX

    lda PlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides

    lda OldPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc OldTileScroll
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
    lsr
    lsr
    lsr
    sta TempX


    lda TempPointY
    clc
    adc #8
    lsr
    lsr
    lsr
    sta TempY


    lda LocationIndex
    asl
    asl
    clc
    adc CurrentMapSegmentIndex
    tay

    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

@calcaddress:
    ldy TempY
    beq @skip
@addressLoop:

    lda pointer
    clc
    adc #32
    sta pointer
    bcs @incrementUpper
    jmp @nextRow
@incrementUpper:
    inc pointer + 1
@nextRow:
    dey
    bne @addressLoop
@skip:
    lda TempX
    tay


    lda (pointer), y
    cmp #128
    bcc @not_Colliding

    lda #1
    jmp @exit_collision_check

@not_Colliding:
    lda #0

@exit_collision_check:
    rts

