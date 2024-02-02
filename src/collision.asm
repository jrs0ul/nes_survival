;Checks 2 points against the collision map
CanPlayerGo:

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc ScrollX
    sta TempPointX
    bcs @increment

    lda TempCollisionVar
    jmp @cont
@increment:
    lda TempCollisionVar
    clc
    adc #1

@cont:
    sta TempScreen

    lda PlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides
;------------ 
    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc ScrollX
    sta TempPointX
    bcs @increment2
    lda TempCollisionVar
    jmp @cont2
@increment2:
    lda TempCollisionVar
    clc
    adc #1
@cont2:
    sta TempScreen

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
    adc ScrollX
    sta TempPointX
    bcs @increment

    lda TempCollisionVar
    jmp @cont
@increment:
    lda TempCollisionVar
    clc
    adc #1
@cont:
    sta TempScreen

    lda OldPlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides
;----------- 

    lda PlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc ScrollX
    sta TempPointX
    bcs @increment2

    lda TempCollisionVar
    jmp @cont2
@increment2:

    lda TempCollisionVar
    clc
    adc #1
@cont2:

    sta TempScreen
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
    adc OldScrollX
    sta TempPointX
    bcs @increment
    lda TempCollisionVar
    jmp @cont
@increment:
    lda TempCollisionVar
    clc
    adc #1
@cont:
    sta TempScreen

    lda PlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    bne @collides
;----

    lda OldPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc OldScrollX
    sta TempPointX
    bcs @increment2
    lda TempCollisionVar
    jmp @cont2
@increment2:
    lda TempCollisionVar
    clc
    adc #1
@cont2:
    sta TempScreen

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
;Set TempScreen as screen of your entity
;sets A=1 if point collides
TestPointAgainstCollisionMap:

    ldy LocationIndex
    lda TempScreen
    cmp LocationScreenCountList, y
    bcs @collides
    tay ; let's put screen to Y reg

    lda TempPointY
    clc
    adc #8
    lsr
    lsr
    lsr ; y / 8

    cmp #4
    bcc @collides
    cmp #30
    bcs @collides

    asl  ;row * 2

    clc
    adc row_table_screens, y ; screen is in Y
    tay

    ;load map row address from ram
    lda MapRowAddressTable, y
    sta pointer
    iny
    lda MapRowAddressTable, y
    sta pointer + 1

    lda TempPointX
    lsr
    lsr
    lsr
    tay ;put X/8 to register y

    lda DestroyedTilesCount
    beq @cont

;--- ok, this -is- UGLY------------
    lda #DESTRUCTIBLE_COUNT
    tax
    stx destructibleIdx
@destructiblesLoop:
    ldx destructibleIdx
    dex
    stx destructibleIdx
    bmi @cont

    lda Destructibles, x
    beq @destructiblesLoop

    txa
    asl
    asl
    asl
    tax

    inx
    inx
    inx

    lda TempPointY
    clc
    adc #8
    lsr
    lsr
    lsr
    cmp destructible_tiles_list, x ; compare with y
    bne @destructiblesLoop

    inx ; move to x
    lda TempPointX
    lsr
    lsr
    lsr
    cmp destructible_tiles_list, x
    bne @destructiblesLoop

    inx
    inx ;screen
    lda destructible_tiles_list, x
    cmp TempScreen
    bne @destructiblesLoop

    dex ; tile after destruction
    lda destructible_tiles_list, x
    jmp @compare

;----------------------------
@cont:
    lda (pointer), y
@compare:
    cmp #128
    bcc @not_Colliding
@collides:
    lda #1
    jmp @exit_collision_check

@not_Colliding:
    lda #0

@exit_collision_check:
    rts
;-----------------------------
;Fill ram table with map row addresses
BuildRowTable:

    ldx #0
@screenLoop:

    lda LocationIndex
    asl
    asl ; locationindex * 4
    sta Temp
    txa
    clc
    adc Temp
    tay

    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1


    lda #0
    sta TempRowIndex
@rowLoop: ; Loop through all 30 rows of the map screen

    lda TempRowIndex
    beq @skipcalculation


    lda pointer
    clc
    adc #32
    sta pointer
    bcs @incrementUpper
    jmp @skipcalculation
@incrementUpper:
    inc pointer + 1

@skipcalculation:

    lda TempRowIndex
    asl
    clc
    adc row_table_screens, x
    tay
    lda pointer
    sta MapRowAddressTable, y
    iny
    lda pointer + 1
    sta MapRowAddressTable, y

    inc TempRowIndex
    lda TempRowIndex
    cmp #SCREEN_ROW_COUNT
    bcc @rowLoop

    inx
    cpx #4
    bcc @screenLoop

    rts
