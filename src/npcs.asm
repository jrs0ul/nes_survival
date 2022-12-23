;pointer points to the NPCs data
LoadNpcs:
    ldy #0
    lda (pointer), y
    sta NpcCount
    sta TempNpcCnt
    beq @exit ; no npcs
    iny
    ldx #0
@npcLoop:

    lda (pointer), y
    sta Npcs, x
    inx
    iny
    lda (pointer), y
    sta Npcs, x
    iny
    inx
    lda (pointer), y
    sta Npcs, x
    iny
    inx
    lda (pointer), y
    sta Npcs, x
    iny
    inx
    lda #1
    sta Npcs, x ; dir
    inx
    inx
    inx
    inx

    dec TempNpcCnt
    lda TempNpcCnt
    bne @npcLoop
@exit:

    rts
;-------------------------------------
;Player's knifer collides with all the npcs
PlayerHitsNpcs:

    lda AttackTimer
    beq @exit

    ldy NpcCount
    beq @exit ; no npcs
    dey
@npcLoop:
    sty TempItemIndex
    jsr CheckSingleNpcAgainstPlayerHit
   
@nextNpc:
    ldy TempItemIndex
    dey
    bpl @npcLoop

@exit:
    lda NPC_COLLISION_DELAY
    sta NpcCollisionDelay
    rts
;-------------------------------------
CheckSingleNpcAgainstPlayerHit:
    tya
    asl
    asl
    asl ; y * 8
    tay

    lda Npcs, y ; index + alive
    lsr
    bcc @exit ; dead already

    sty Temp
    asl
    tay
    iny
    lda npc_data, y ; tile rows
    ldy Temp
    sta Temp ; save row count

    iny
    iny
    iny
    lda Npcs, y ; screen index where npc resides
    jsr CalcItemMapScreenIndexes
    dey
    dey

    lda ItemMapScreenIndex
    beq @skipPrevScreen
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @exit
@skipPrevScreen:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @exit

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen
    
    ;X1
    lda Npcs, y ; x
    sec 
    sbc GlobalScroll
    bcs @exit
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp GlobalScroll
    bcc @exit
    sec
    sbc GlobalScroll
    sta TempPointX

@calcY: ; Y1
    iny
    lda Npcs, y ; y
    sta TempPointY
;-------
    jsr KnifeNpcsCollision
@exit:

    rts

;-------------------------------------
KnifeNpcsCollision:
    lda TempPointX
    cmp KnifeX
    bcs @exit
    lda TempPointX
    clc
    adc #16 ; two tiles
    cmp KnifeX
    bcc @exit

    lda TempPointY
    cmp KnifeY
    bcs @exit

    lda TempPointY
    ldx Temp
@addRowsLoop:
    clc
    adc #8
    dex
    bne @addRowsLoop
    cmp KnifeY
    bcc @exit
    ;---

    dey
    dey
    lda Npcs, y
    and #%11111110;
    sta Npcs, y

    ;drop item
    inc ItemCount
    lda ItemCount

    sec
    sbc #1
    asl
    asl
    tay
    lda #%00000101
    sta Items, y
    iny
    lda TempPointX
    clc
    adc #8
    clc
    adc GlobalScroll
    sta Items, y
    iny
    lda TempPointY
    clc
    adc #8
    sta Items, y
    iny
    lda ItemMapScreenIndex
    sta Items, y



@exit:
    rts
;-------------------------------------
UpdateNpcSpritesInWorld:

    ldy NpcCount
    beq @exit
    dey
@npcLoop:
    sty TempItemIndex ; save npc index
    jsr UpdateSingleNpcSprites

@nextNpc:
    ldy TempItemIndex; restore the index
    dey
    bpl @npcLoop
@exit:
    rts

;------------------------------------
UpdateSingleNpcSprites:
    tya
    asl
    asl
    asl ; a * 8
    tay
    lda Npcs, y ; index + alive

    lsr
    bcc @nextNpc ;npc not active

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
    jsr CalcItemMapScreenIndexes
    dey
    dey

    lda ItemMapScreenIndex
    beq @skipPrevScreen
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @nextNpc
@skipPrevScreen:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @nextNpc

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen

    lda Npcs, y ; x
    sec
    sbc GlobalScroll
    bcs @nextNpc
    sta TempPointX ; save x
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp GlobalScroll
    bcc @nextNpc
    sec
    sbc GlobalScroll
    sta TempPointX
@calcY:
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
    rts
;-------------------------------------
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

    lda TempPointX ; check if the second sprite is still in screen
    clc
    adc #8
    bcs @exit


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

@exit:
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
doNpcAI:

    ldy NpcCount
    dey; npcCount - 1, first index
@npcLoop:
    
    tya
    asl
    asl
    asl ; a * 8
    tax
    lda Npcs, x ;type + active
    lsr
    bcc @nextNpc ; not active

    inx
    inx
    inx
    lda Npcs, x; screen
    dex
    dex
    jsr CalcItemMapScreenIndexes

    lda ItemMapScreenIndex
    beq @skipPrev
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @nextNpc
@skipPrev:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @nextNpc

;final filter (could be removed)
    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen

    lda Npcs, x ; x
    sec
    sbc GlobalScroll
    bcs @nextNpc
    jmp @doAI
@NpcMatchesScreen:
    lda Npcs, x ; x
    cmp GlobalScroll
    bcc @nextNpc
;---------------------

@doAI:
    inx
    inx
    jsr SingleNpcAI

@nextNpc:
    dey
    bpl @npcLoop


    lda #NPC_AI_DELAY
    sta NpcAIUpdateDelay
    rts
;-----------------------------------
SingleNpcAI:

    inx
    lda Npcs, x ; load dir
    dex
    dex
    dex

    cmp #1 ; right?
    bne @goLeft

@goRight:

    lda Npcs, x ;load x
    clc
    adc #1
    bcs @goToNextScreen

    jsr TestCollisionGoingRight
    cmp #1
    beq @changeDir ; collides
    ldx TempIndex
    lda TempX
    sta Npcs, x ;save x
    jmp @nextNpc

@goToNextScreen:
    sta Temp
    inx
    inx
    lda Npcs, x; screen idx
    clc
    adc #1
    cmp ScreenCount
    bcs @changeDir
    sta Npcs, x
    dex
    dex
    lda Temp
    sta Npcs, x; save changed x
    jmp @nextNpc
;----
@goLeft:
    lda Npcs, x
    sta Temp
    sec
    sbc #1
    cmp Temp
    bcs @goToPrevScreen

    jsr TestCollisionGoingLeft
    cmp #1 
    beq @changeDir ;collides
    ldx TempIndex
    lda TempX
    sta Npcs, x
    jmp @nextNpc
@goToPrevScreen:
    sta Temp
    inx
    inx
    lda Npcs, x ; scr
    beq @changeDir
    sec
    sbc #1
    sta Npcs, x
    dex
    dex
    lda Temp
    sta Npcs, x; save changed x
    jmp @nextNpc
;-------------
@changeDir:
    jsr ChangeNpcDirection
@nextNpc:

    rts

;---------------------
ChangeNpcDirection:
    ;x at the npc screen index
    inx
    lda Npcs, x ; direction
    clc
    adc #1
    sta Npcs, x
    cmp #3
    bcs @backToOne
    jmp @exit
@backToOne:
    lda #1
    sta Npcs, x
@exit:

    rts
;----------------------
TestCollisionGoingRight:
    sta TempX ; save modified x
    clc
    adc #14
    sec
    sbc GlobalScroll
    sta TempPointX

    stx TempIndex
    inx
    lda Npcs, x ;y
    clc
    adc #9
    sta TempPointY
    jsr TestPointAgainstCollisionMap
    ldx TempIndex
    inx
    inx ;increment to screen idx
    ;collision result is in A

    rts
;----------------------------------
TestCollisionGoingLeft:
    stx TempIndex ; save x reg
    sta TempX
    sec
    sbc GlobalScroll
    sta TempPointX
    inx
    lda Npcs, x ; y
    clc
    adc #9
    sta TempPointY
    jsr TestPointAgainstCollisionMap
    ldx TempIndex
    inx
    inx
    ;collision result is in A
    rts

