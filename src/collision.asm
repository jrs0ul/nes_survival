;Checks 2 points against the collision map
CanPlayerGo:

    lda NewPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc NewScrollX
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

    lda NewPlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMapHero
    bne @collides
;------------ 
    lda NewPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc NewScrollX
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

    jsr TestPointAgainstCollisionMapHero
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

    lda NewPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X1
    adc NewScrollX
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

    jsr TestPointAgainstCollisionMapHero
    bne @collides
;----------- 

    lda NewPlayerX
    clc
    adc #PLAYER_COLLISION_LINE_X2
    adc NewScrollX
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
    jsr TestPointAgainstCollisionMapHero
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

    lda NewPlayerY
    clc
    adc #PLAYER_COLLISION_LINE_Y1
    sta TempPointY

    jsr TestPointAgainstCollisionMapHero
    bne @collides
;----

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

    jsr TestPointAgainstCollisionMapHero
    bne @collides

    lda #0
    jmp @end

@collides:
    lda #1
@end:
    rts
;---------------------------------
;register A is 1 if collides already
CalculateXYCellsForCollision:
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
    sta PointCellY

    sec
    sbc #4 ; drop the 4 top rows, where the hud is
    bcc @collides

    cmp #26
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
    jmp @notyet

@collides:
    lda #1
    jmp @end
@notyet:
    lda #0
@end:
    rts

;----------------------------------
;Set TempPointX and TempPointY as point to be tested
;Set TempScreen as screen of your entity
;sets A=1 if point collides
TestPointAgainstCollisionMap:

    jsr CalculateXYCellsForCollision
    bne @collides ;already colliding

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
;same as above, but for hero
TestPointAgainstCollisionMapHero:

    jsr CalculateXYCellsForCollision
    bne @collides ;already colliding

    jsr IsCollidingWithAModifiedTile
    cpx #1
    beq @compare

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
IfCollidingWithLockedDoor:

    lda #ITEM_KEY
    sta TempItemIndex
    lda #1
    sty TempHp
    lda #<Inventory
    sta pointer2
    lda #>Inventory
    sta pointer2 + 1
    jsr IsItemXInInventory
    ldy TempHp

    rts


;-----------------------------
;puts 1 into register X if the cell intersects with destructed tile
;tile value is in register A
IsCollidingWithAModifiedTile:

    lda LocationIndex
    tax
    lda mod_tiles_count_by_location, x
    bne @allGood
    ldx #0
    rts
@allGood:
    lda LocationIndex
    asl
    tax
    lda mod_tiles_by_location, x
    sta pointer2
    inx
    lda mod_tiles_by_location, x
    sta pointer2 + 1

    lda #0
    sta destructibleIdx ; save tile index
    sty TempNpcIndex ; store y register
    ldy destructibleIdx

@destructiblesLoop:
    tya ; destructible tile index * 8
    asl
    asl
    asl
    tay
    lda (pointer2), y ; index of Destructibles
    tax
    lda ModifiedTiles, x
    stx TempRegX ; store destructible index

    sta TempDigit ; store is destroyed or not

    iny ; addr high
    iny ; addr low
    iny ; screen
    lda (pointer2), y
    cmp TempScreen
    bne @nextTile

    iny ; y
    lda PointCellY
    cmp (pointer2), y ; compare with y
    bne @nextTile

    iny ; move to x
    lda TempNpcIndex ; x divided by 8, that was in Y register
    cmp (pointer2), y
    bne @nextTile

    lda TempDigit
    cmp #1
    beq @thisTileIsDestroyed

    ;some sort of crutch to unlock the door
    ;tile is not destroyed
    ldx TempRegX
    cpx #DESTRUCTIBLE_DOOR_IDX ; locked door
    beq @colidesWithDoor
    cpx #DESTRUCTIBLE_DOOR_IDX2
    beq @colidesWithDoor
    jmp @nextTile
@colidesWithDoor:
    jsr IfCollidingWithLockedDoor
    cmp #0
    beq @cont ;it's not
    ldx TempRegX
    lda #1
    sta ModifiedTiles, x
    sta MustUpdateDestructibles
    jmp @cont
    ;---------end of crutch


@thisTileIsDestroyed:
    iny ;tile
    lda (pointer2), y

    ldx #1 ;intersects with destructed tile
    jmp @end

@nextTile:
    inc destructibleIdx
    lda destructibleIdx
    ldx LocationIndex
    cmp mod_tiles_count_by_location, x
    bcs @cont
    ldy destructibleIdx
    jmp @destructiblesLoop

@cont:
    ldx #0
@end:
    ldy TempNpcIndex ;restore Y register
    rts
;-----------------------------
;Fill ram table with map row addresses
BuildRowTable:

    ldx #0
@screenLoop:

    ldy LocationIndex
    lda location_map_pos, y
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
