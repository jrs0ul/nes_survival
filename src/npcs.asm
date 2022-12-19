;pointer points to the NPCs data
LoadNpcs:
    ldy #0
    lda (pointer), y
    sta NpcCount
    ldx NpcCount
    beq @exit
    iny
@npcLoop:
    lda (pointer), y
    dey
    sta Npcs, y
    iny
    iny
    lda (pointer), y
    dey
    sta Npcs, y
    iny
    iny
    lda (pointer), y
    dey
    sta Npcs, y
    iny
    iny
    lda (pointer), y
    dey
    sta Npcs, y
    iny
    iny
    dex
    bne @npcLoop
@exit:

    rts

;-------------------------------------
UpdateNpcSpritesInWorld:

    lda CurrentMapSegmentIndex
    bne @exit
    ldy NpcCount
    beq @exit
    dey
@npcLoop:

    sty TempItemIndex ; save npc index
    tya
    asl
    asl
    tay
    lda Npcs, y ; index + alive

    lsr
    bcc @nextNpc

    sty Temp; store Npcs index
    asl
    tay
    lda npc_data, y ; first tile index
    sta TempZ ;save tile
    iny
    lda npc_data, y ; tile rows for the npc
    ldy Temp; restore Npcs index
    sta Temp; store tile rows

    iny
    iny
    iny
    lda Npcs, y ; screen index where npc resides
    sta ItemMapScreenIndex
    dey
    dey

    lda Npcs, y ; x
    cmp GlobalScroll
    bcc @nextNpc
    sec
    sbc GlobalScroll
    sta TempPointX ; save x
    iny
    lda Npcs, y; y
    sta TempPointY ; save y

    lda Temp ; row count
    tay
    lda #0
    sta TempPush ; additionl Y
    sta TempIndex ;additional sprite index
@rowloop:
    jsr UpdateNpcRow
    dey
    bne @rowloop

@nextNpc:
    ldy TempItemIndex; restore the index
    dey
    bpl @npcLoop
@exit:
    rts

;------------------------------------
UpdateNpcRow:
     ;Y
    lda TempPointY
    clc
    adc TempPush
    sta FIRST_SPRITE, x
    inx
    ;index
    lda TempZ
    clc
    adc TempIndex
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda #0
    sta FIRST_SPRITE, x
    inx
    ;X
    lda TempPointX
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inx
    ;Y
    lda TempPointY
    clc
    adc TempPush
    sta FIRST_SPRITE, x
    inx
    ;index
    lda TempZ
    clc
    adc #1
    adc TempIndex
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda #0
    sta FIRST_SPRITE, x
    inx
    ;X
    lda TempPointX
    clc
    adc #8
    sta FIRST_SPRITE, x
    inx

    inc TempSpriteCount
    
    lda TempPush
    clc
    adc #8
    sta TempPush
    lda TempIndex
    clc
    adc #16
    sta TempIndex


    rts


;----------------------------------

