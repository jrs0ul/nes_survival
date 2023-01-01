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
    iny
    lda Npcs, y ; direction
    sta TempDir
    iny
    lda Npcs, y ; frame
    lsr
    lsr
    lsr
    lsr
    lsr
    asl
    asl
    asl
    asl
    asl
    sta TempFrame
    dey
    dey
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
    jsr CalcNpcY
@rowloop:
    jsr UpdateNpcRow
    dey
    bne @rowloop
@nextNpc:
    rts
;------------------------------------
CalcNpcY:
    iny
    lda Npcs, y; y
    sta TempPointY ; save y

    lda Temp ; row count
    tay
    lda #0
    sta TempPush ; additionl Y
    sta TempIndex ;additional sprite index
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
    lda TempDir
    cmp #1
    beq @spriteIndexFlip1
    cmp #3
    bcc @contFirstSprite
;--
    ;lda TempDir
    ;sec
    ;sbc #2
    ;asl
    lda #0;remove this
    sta TempFrameOffset


    lda TempZ
    clc
    adc TempIndex
    adc TempFrameOffset
    cpy #3 ; don't animate first row if there are 3 in total
    beq @storeSpriteIndex1
    adc TempFrame
    jmp @storeSpriteIndex1
;--
@contFirstSprite:
    lda TempZ
    clc
    adc TempIndex
    cpy #3 ; don't animate first row if there are 3 in total
    beq @storeSpriteIndex1
    adc TempFrame
    jmp @storeSpriteIndex1
@spriteIndexFlip1:
    lda TempZ
    clc
    adc TempIndex
    adc #1
    cpy #3
    beq @storeSpriteIndex1
    adc TempFrame
@storeSpriteIndex1:
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda TempDir
    cmp #1
    beq @flip1
    lda #0
    jmp @saveattr1
@flip1:
    lda #%01000000
@saveattr1:
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
    lda TempDir
    cmp #1
    beq @flipSpriteIndex2
    cmp #3
    bcc @contSprite2

    ;--

    lda TempZ
    clc
    adc #1
    adc TempIndex
    adc TempFrameOffset
    cpy #3
    beq @storeSpriteIndex2
    adc TempFrame
    jmp @storeSpriteIndex2
    ;--

@contSprite2:
    lda TempZ
    clc
    adc #1
    adc TempIndex
    cpy #3
    beq @storeSpriteIndex2
    adc TempFrame
    jmp @storeSpriteIndex2
@flipSpriteIndex2:
    lda TempZ
    clc
    adc TempIndex
    cpy #3
    beq @storeSpriteIndex2
    adc TempFrame
@storeSpriteIndex2:
    sta FIRST_SPRITE, x
    inx
    ;attr
    lda TempDir
    cmp #1
    beq @flip2
    lda #0
    jmp @saveattr2
@flip2:
    lda #%01000000
@saveattr2:
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
    sta TempNpcIndex
    stx TempIndex
    asl
    asl
    tax
    inx
    inx
    lda npc_data, x; y offset for collision
    sta TempYOffset
    inx
    lda npc_data, x; npc type
    sta TempNpcType
    ldx TempIndex

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
;-----------end of filter----------

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
    sta TempDir
    inx
    lda Npcs, x ; frame
    clc
    adc #2
    cmp #128
    bcc @storeFrame
    lda #0
@storeFrame:
    sta Npcs, x
    inx
    lda Npcs, x; timer tics
    clc
    adc #1
    cmp #NPC_STEPS_BEFORE_REDIRECT
    bcc @saveTimer
    lda #1
    sta MustRedir
    lda #0
@saveTimer:
    sta Npcs, x; tics
    sta TempNpcTimer
    dex ; frame
    dex ; direction
    dex ; screen

    lda MustRedir
    bne @changeDir

    dex
    dex

    
    lda TempDir
    and #%00000011
    cmp #1 ; right?
    bne @notRight

@goRight:

    lda Npcs, x ;load x
    clc
    adc #NPC_SPEED
    bcs @goToNextScreen

    jsr TestCollisionGoingRight
    cmp #1
    beq @changeDir ; collides
    jsr SaveX
    jmp @YMovement

@goToNextScreen:
    jsr GoToNextSceen
    cmp #1 ; 1 - change direction
    beq @changeDir
    jmp @YMovement
;----
@notRight:
    cmp #2
    bne @YMovement
@goLeft:
    lda Npcs, x
    sta Temp
    sec
    sbc #NPC_SPEED
    cmp Temp
    bcs @goToPrevScreen

    jsr TestCollisionGoingLeft
    cmp #1 
    beq @changeDir ;collides
    jsr SaveX
    jmp @YMovement
@goToPrevScreen:
    jsr GoToPreviousScreen
    cmp #1; ;if 1, change direction
    beq @changeDir

;---------------------------------------------------
@YMovement:
    lda TempDir
    lsr
    lsr
    cmp #1
    bne @goDown
@goUp:
    jsr TestCollisionGoingUp
    cmp #1
    beq @changeDir
    lda TempZ;stored Y
    dex
    sta Npcs, x ; y

    jmp @nextNpc
@goDown:
    cmp #2
    bne @nextNpc
    jsr TestCollisionGoingDown
    cmp #1
    beq @changeDir
    lda TempZ
    dex
    sta Npcs, x; y
    jmp @nextNpc
;-------------
@changeDir:
    jsr ChangeNpcDirection
@nextNpc:

    rts
;---------------------
SaveX:
    ldx TempIndex
    lda TempX
    sta Npcs, x ;save x

    rts
;---------------------
GoToPreviousScreen:
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
    lda #0
    jmp @exit
@changeDir:
    lda #1
@exit:
    rts
;---------------------
GoToNextSceen:
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
    lda #0
    jmp @exit
@changeDir:
    lda #1
@exit:

    rts
;---------------------
ChangeNpcDirection:
    lda #0
    sta MustRedir
    ;x at the npc screen index
    lda TempNpcTimer
    bne @randomDir
    lda TempNpcType
    bne @predator
@randomDir:
    inx ; increase to direction
    ;just random movement
    jsr UpdateRandomNumber
    and #3
    clc
    adc #1;
    stx TempX
    tax
    lda npc_direction_list, x
    ldx TempX
    sta TempDir
    jmp @storeDirection
@predator:
    dex
    lda Npcs, x; y
    clc
    adc #16
    sta TempPointY
    dex
    lda Npcs, x; x
    clc
    adc #8
    sta TempPointX
    inx ;y
    inx ;screen
    inx ;direction

    lda PlayerX
    clc
    adc #16
    sta Temp

    lda #0
    sta TempDir

    lda TempPointX
    sec
    sbc GlobalScroll
    cmp PlayerX
    bcc @goRight1
    cmp Temp
    bcc @compareY
    bcs @goLeft
@goRight1:
    lda # 1
    sta TempDir
    jmp @compareY
@goLeft:
    lda #2
    sta TempDir

@compareY:
    lda PlayerY
    clc
    adc #16
    sta Temp

    lda TempPointY
    cmp PlayerY
    bcc @goDown
    cmp Temp
    bcs @goUp
    bcc @storeDirection
   ; bcc @attackPlayer
@goDown:
    lda TempDir
    ora #%00001000
    sta TempDir
    jmp @storeDirection
@goUp:
    lda TempDir
    ora #%00000100
    sta TempDir
    jmp @storeDirection
;@attackPlayer:
;    lda #0
;    sta Npcs, x
;    jsr DecreaseLife
;    jmp @exit
@storeDirection:
    lda TempDir
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
    adc TempYOffset
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
    adc TempYOffset
    sta TempPointY
    jsr TestPointAgainstCollisionMap
    ldx TempIndex
    inx
    inx
    ;collision result is in A
    rts
;-------------------------------------
TestCollisionGoingUp:
    inx
    stx TempIndex
    lda Npcs, x ; y
    sec
    sbc #NPC_SPEED
    sta TempZ

    clc
    adc TempYOffset
    sta TempPointY
    dex
    lda Npcs, x ; x
    sec
    sbc GlobalScroll
    clc
    adc #2
    sta TempPointX
    jsr TestPointAgainstCollisionMap
    cmp #1
    beq @exit
    
    lda TempPointX
    clc
    adc #12
    sta TempPointX
    jsr TestPointAgainstCollisionMap
@exit:
    ldx TempIndex
    inx
    rts
;--------------------------------------
TestCollisionGoingDown:
    inx
    stx TempIndex
    lda Npcs, x ; y
    clc
    adc #NPC_SPEED
    sta TempZ

    clc
    adc TempYOffset
    sta TempPointY
    dex
    lda Npcs, x ; x
    sec
    sbc GlobalScroll
    sta TempPointX
    jsr TestPointAgainstCollisionMap
    cmp #1
    beq @exit

    lda TempPointX
    clc
    adc #12
    sta TempPointX
    jsr TestPointAgainstCollisionMap

@exit:
    ldx TempIndex
    inx

    rts
