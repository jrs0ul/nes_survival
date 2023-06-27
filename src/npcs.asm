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
    lda #0
    sta Npcs, x ;frame
    inx
    sta Npcs, x ;timer
    inx
    ;hp
    inx

    dec TempNpcCnt
    lda TempNpcCnt
    bne @npcLoop
@exit:

    rts
;-------------------------------------
;Parameters: TempNpcCnt - max npc number used with and instruction

;Generate random npcs
GenerateNpcs:
    jsr UpdateRandomNumber
    and TempNpcCnt ; maximum npcs
    clc
    adc #1         ; you don't want 0 so add at least 1
    sta NpcCount
    sta TempNpcCnt

    jsr GetPaletteFadeValueForHour
    sta TempFrame


    ldx #0
@npcLoop:
    ;npc type
    lda TempFrame
    cmp #$40    ;check if it's night
    beq @makeWolf
    lda TempNpcCnt;if it's a last npc, let's make it hostile
    cmp #1
    beq @makeCanid

    ldy #9
    lda npc_data, y
    sta TempNpcRows
    ldy #12
    lda npc_data, y
    sta TempHp
    lda #%00000101
    jmp @storeType
@makeWolf:
    ldy #1
    lda npc_data, y
    sta TempNpcRows
    ldy #4
    lda npc_data, y
    sta TempHp
    lda #%00000001
    jmp @storeType
@makeCanid:
    ldy #25
    lda npc_data, y
    sta TempNpcRows
    ldy #28
    lda npc_data, y
    sta TempHp
    lda #%00001101
@storeType:
    sta Npcs, x
    inx
    stx TempZ

@generateCoords:
    jsr GenerateNPCCoords

@testCollision:
    jsr TestGeneratedNpcCollision
    bne @generateCoords

    jsr StoreGeneratedNpc


    dec TempNpcCnt
    bne @npcLoop

    rts
;------------------------------------
GenerateNPCCoords:
    ;x
    jsr UpdateRandomNumber
    and #%00011111 ; 32
    sta TempPointX
    ;y
    jsr UpdateRandomNumber
    and #%00001111; 16
    clc
    adc #4
    sta TempPointY

    ;screen idx-------------
    lda LocationIndex
    asl
    tay
    lda LocationPopulatedScreens, y
    sta TempIndex
    jsr UpdateRandomNumber
    and TempIndex
    iny
    clc
    adc LocationPopulatedScreens, y
    sta TempIndex

@exit:

    rts
;------------------------------------
StoreGeneratedNpc:
    ldx TempZ
    ;x
    lda TempPointX
    asl
    asl
    asl ; x8
    sta Npcs, x
    inx
    ;y
    lda TempPointY
    asl
    asl
    asl
    sta Npcs, x
    inx
    ;screen
    lda TempIndex
    sta Npcs, x
    inx
    ;dir
    lda #1
    sta Npcs, x
    inx
    ;frame
    inx
    sta Npcs, x;timer
    inx
    lda TempHp
    sta Npcs, x
    ;hp
    inx

    rts

;------------------------------------
;npc x - TempPointX, npc y - TempPointY, screen - TempIndex
;pointer - collision list low
;pointer2 - collision list high
TestGeneratedNpcCollision:

    lda TempIndex
    cmp ScreenCount
    bcs @collisionDetected

    lda LocationIndex
    asl
    asl
    clc
    adc TempIndex
    tay
    lda collision_list_low, y
    sta pointer ; reuse the pointer :)
    lda collision_list_high, y
    sta pointer + 1


    lda TempPointY
    sta TempY
@RowLoop:

    lda TempPointX
    tax
    lda x_collision_pattern, x
    sta Temp
    txa
    lsr
    lsr
    lsr
    clc
    adc TempY
    adc TempY
    adc TempY
    adc TempY
    tay

    lda (pointer), y
    and Temp
    bne @collisionDetected

    lda TempPointX
    clc
    adc #1
    bcs @collisionDetected

    tax
    lda x_collision_pattern, x
    sta Temp
    txa
    lsr
    lsr
    lsr
    clc
    adc TempY
    adc TempY
    adc TempY
    adc TempY
    tay

    lda (pointer), y
    and Temp
    bne @collisionDetected

    inc TempY
    dec TempNpcRows
    bne @RowLoop

    lda #0
    jmp @exit


@collisionDetected:
    lda #1

@exit:
    rts
;---------------------------------
IsPlayerCollidingWithNpcs:

    ldy NpcCount
    beq @exit

    dey
@npcLoop:
    sty TempItemIndex


    jsr SingleNpcVSPlayerCollision
    bne @collides


    ldy TempItemIndex
    dey
    bpl @npcLoop
    jmp @exit

@collides:
    lda #1
    jmp @end

@exit:
    lda #0
@end:
    rts

;-------------------------------------
SingleNpcVSPlayerCollision:

    tya
    asl
    asl
    asl ; y * 8
    tay

    lda Npcs, y; let's get the state
    and #%00000011
    sta TempNpcState
    cmp #0
    beq @exit ; it's dead

    lda Npcs, y ; let's get DB index
    lsr
    lsr ;eliminate 2 state bits

    sty Temp
    asl
    asl
    asl
    tay
    iny
    lda npc_data, y ; tile rows
    sta TempNpcRows ; save row count
    iny
    iny
    lda npc_data, y ; npc type
    sta TempNpcType
    ldy Temp

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

    lda Npcs, y
    sta DropedItemX ; store this for item droping

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
    jsr PlayerNpcCollision
    bne @collides
    jmp @exit

@collides:
    lda #1
    jmp @end

@exit:
    lda #0
@end:

    rts
;-------------------------------------
PlayerNpcCollision:

    lda TempPointX
    clc
    adc #16
    sta TempPointX2

    stx Temp
    lda TempNpcRows
    sec
    sbc #1
    tax
    lda TempPointY

@addRowsLoop:
    clc
    adc #8
    dex
    bne @addRowsLoop
    ldx Temp
    sta TempPointY2

;--
    lda PlayerX
    cmp TempPointX2
    bcs @exit

    lda PlayerX
    clc
    adc #16
    cmp TempPointX
    bcc @exit
    beq @exit

    lda PlayerY
    cmp TempPointY2
    bcs @exit

    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcc @exit
    beq @exit


@collides:
    lda #1
    jmp @end
@exit:
    lda #0
@end:
    rts

;-------------------------------------
;Player's attack box collides with all the npcs
PlayerHitsNpcs:

    lda SpearActive
    bne @ignoreTimer ;ignore attack timer and hit multiple npcs
    lda AttackTimer
    beq @exit
    lda NpcsHitByPlayer
    bne @exit

@ignoreTimer:
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

    lda Npcs, y; let's get the state
    and #%00000011
    sta TempNpcState
    cmp #0
    beq @exit ; it's dead

    lda Npcs, y ; let's get DB index
    lsr
    lsr ;eliminate 2 state bits

    sty Temp
    asl
    asl
    asl
    tay
    iny
    lda npc_data, y ; tile rows
    sta TempNpcRows ; save row count
    iny
    iny
    lda npc_data, y ; npc type
    sta TempNpcType
    ldy Temp

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

    lda Npcs, y
    sta DropedItemX ; store this for item droping

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
    lda ItemMapScreenIndex
    sta KilledNpcScreenIdx
    jsr AttackBoxNpcsCollision
@exit:

    rts

;-------------------------------------
AttackBoxNpcsCollision:
    lda #0
    sta TempItemScreen

    jsr PreparePlayerAttackSquare
    beq @exit
    
    lda TempPointX
    clc
    adc #16
    sta TempPointX2

    lda TempPointY
    ldx TempNpcRows
@addRowsLoop:
    clc
    adc #8
    dex
    bne @addRowsLoop
    sta TempPointY2



    ;attack box Point1 vs npc point1-poin2
    lda AttackBottomRightX
    cmp TempPointX
    bcc @checkOtherKnifePoint

    cmp TempPointX2
    bcs @checkOtherKnifePoint

    ;check Y1
    lda AttackBottomRightY
    cmp TempPointY
    bcc @checkOtherKnifePoint

    cmp TempPointY2
    bcs @checkOtherKnifePoint
    jmp @collisionDetected

@checkOtherKnifePoint:

    lda AttackTopLeftX
    cmp TempPointX
    bcc @exit

    cmp TempPointX2
    bcs @exit

    lda AttackTopLeftY
    cmp TempPointY
    bcc @exit

    cmp TempPointY2
    bcs @exit

@collisionDetected:

    jsr OnCollisionWithAttackRect
@exit:
    rts
;-----------------------------------
OnCollisionWithAttackRect:

    tya
    clc
    adc #5
    tay

    lda TempNpcType
    cmp #NPC_TYPE_VILLAGER
    beq @doneDoingDmg

    inc NpcsHitByPlayer

    jsr CalcPlayerDmg

    lda Npcs, y ; hp
    cmp TempPlayerAttk
    bcc @instaKill

    sbc TempPlayerAttk ;dmg
    sta Npcs, y
    cmp #0
    bne @doneDoingDmg

@instaKill:

    jsr PlayDamageSfx

    lda #0
    sta Npcs, y
    dey
    lda #32
    sta Npcs, y

    tya
    sec
    sbc #6 ; go to status
    tay

    lda Npcs, y
    and #%11111100; drop two last bits that stand for status
    sta Npcs, y

    jsr DropItemAfterDeath
    jmp @wearWeapon

@doneDoingDmg:

    jsr PlayDamageSfx
   
    tya
    sec
    sbc #7  ;5
    tay
    lda Npcs, y
    and #%11111100
    eor #%00000011 ;set damaged state
    sta Npcs, y
    iny
    iny

@wearWeapon:

    lda EquipedItem
    cmp #ITEM_FISHING_ROD
    beq @exit

    jsr WearWeapon
@exit:

    rts
;------------------------------------
PlayDamageSfx:
    sty TempY
    stx TempRegX

    ldy current_bank
    sty oldbank
    ldy #6
    jsr bankswitch_y

    lda #2
    ldx #FAMISTUDIO_SFX_CH1
    jsr famistudio_sfx_play
    ldy oldbank
    jsr bankswitch_y


    ldy TempY
    ldx TempRegX


    rts

;-------------------------------------
DropItemAfterDeath:
    
    lda TempNpcType
    cmp #NPC_TYPE_PREDATOR
    bne @continueDrop

    lda NpcsHitByPlayer
    cmp #2
    bcs @continueDrop
    jmp @exit ;don't drop anything for the first hostile

@continueDrop:
    ;drop item
    inc ItemCount
    lda ItemCount

    sec
    sbc #1
    asl
    asl
    tay

    lda TempNpcType
    cmp #NPC_TYPE_PREDATOR
    beq @spawnHide


    lda NpcsHitByPlayer
    cmp #2
    bcs @specialRewardItem

    lda #%00000101
    jmp @storeItem
@specialRewardItem:
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @spawnHide
    lda #%00011001
    jmp @storeItem
@spawnHide:
    lda #%00010101
@storeItem:
    sta Items, y
    iny
    iny ; at item x
    lda DropedItemX
    clc
    adc #8
    bcs @IncrementScreenIndex
    jmp @continueSpawningItem
@IncrementScreenIndex:
    lda #1
    sta TempItemScreen
@continueSpawningItem:
    sta Items, y
    dey ;screen index
    lda KilledNpcScreenIdx
    clc
    adc TempItemScreen
    sta Items, y
    iny
    iny
    lda TempPointY
    clc
    adc #8
    sta Items, y

@exit:
    rts
;-------------------------------------
CalcPlayerDmg:
    lda #1
    sta TempPlayerAttk
    lda EquipedItem
    beq @exit
    cmp #ITEM_FISHING_ROD ; fishing rod is not a weapon
    beq @exit

    asl
    asl

    sty TempY
    tay
    iny
    iny
    iny

    lda item_data, y
    sta TempPlayerAttk

    ldy TempY

@exit:
    rts


;--------------------------------------
PreparePlayerAttackSquare:

    sty TempY


    lda EquipedItem
    beq @nothingEquiped

    cmp #ITEM_SPEAR
    beq @spearEquiped

    
    lda PlayerFlip
    beq @notFlipped

    lda PlayerFrame
    asl
    asl
    tay
    lda knife_collision_pos_flip, y
    clc
    adc PlayerX
    sta AttackTopLeftX
    iny
    lda knife_collision_pos_flip, y
    clc
    adc PlayerY
    sta AttackTopLeftY
    iny
    lda knife_collision_pos_flip, y
    clc
    adc PlayerX
    sta AttackBottomRightX
    iny
    lda knife_collision_pos_flip, y
    clc
    adc PlayerY
    sta AttackBottomRightY

    jmp @calcCollision

@notFlipped:
    
    lda PlayerFrame
    asl
    asl
    tay
    lda knife_collision_pos, y
    clc
    adc PlayerX
    sta AttackTopLeftX
    iny
    lda knife_collision_pos, y
    clc
    adc PlayerY
    sta AttackTopLeftY
    iny
    lda knife_collision_pos, y
    clc
    adc PlayerX
    sta AttackBottomRightX
    iny
    lda knife_collision_pos, y
    clc 
    adc PlayerY
    sta AttackBottomRightY

    jmp @calcCollision

@spearEquiped:

    jsr BuildSpearAttackSquare

    beq @fail

    jmp @calcCollision


@nothingEquiped:
    
    lda PlayerFlip
    beq @notFlippedUnarmed

    lda PlayerFrame
    asl
    asl
    tay
    lda fist_collision_pos_flip, y
    clc
    adc PlayerX
    sta AttackTopLeftX
    iny
    lda fist_collision_pos_flip, y
    clc
    adc PlayerY
    sta AttackTopLeftY
    iny
    lda fist_collision_pos_flip, y
    clc
    adc PlayerX
    sta AttackBottomRightX
    iny
    lda fist_collision_pos_flip, y
    clc
    adc PlayerY
    sta AttackBottomRightY

    jmp @calcCollision

@notFlippedUnarmed:
    
    lda PlayerFrame
    asl
    asl
    tay
    lda fist_collision_pos, y
    clc
    adc PlayerX
    sta AttackTopLeftX
    iny
    lda fist_collision_pos, y
    clc
    adc PlayerY
    sta AttackTopLeftY
    iny
    lda fist_collision_pos, y
    clc
    adc PlayerX
    sta AttackBottomRightX
    iny
    lda fist_collision_pos, y
    clc 
    adc PlayerY
    sta AttackBottomRightY

    jmp @calcCollision

@calcCollision:

    ldy TempY
    lda #1
    jmp @end

@fail:

    lda #0
@end:

    rts
;------------------------------------
BuildSpearAttackSquare:

    lda SpearActive
    beq @exit

    lda SpearScreen
    jsr CalcItemMapScreenIndexes

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
    beq @SpearMatchesScreen

    lda SpearX ; x
    sec
    sbc GlobalScroll
    bcs @exit
    sta TempSpearX; save x
    jmp @doUpdate
@SpearMatchesScreen:
    lda SpearX ; x
    cmp GlobalScroll
    bcc @exit
    sec
    sbc GlobalScroll
    sta TempSpearX



@doUpdate:

    lda SpearDir
    sec
    sbc #1
    ;(SpearDir - 1) * 8
    asl
    asl
    asl
    tay

    lda SpearY
    clc
    adc spearSprites, y
    sta AttackTopLeftY
    iny
    iny
    iny
    lda TempSpearX
    clc
    adc spearSprites, y
    sta AttackTopLeftX


    iny

    lda SpearY
    clc
    adc spearSprites, y
    sta AttackBottomRightY

    iny
    iny
    iny

    lda TempSpearX
    clc
    adc spearSprites, y
    sta AttackBottomRightX

    
    lda #1
    jmp @end

@exit:
    lda #0
@end:
    rts

;-------------------------------------
UpdateNpcSpritesInWorldZtoA:

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
;-----------------------------------
UpdateNpcSpritesInWorldAtoZ:

    ldy #0
    cmp NpcCount
    beq @exit
@npcLoop:
    sty TempItemIndex
    jsr UpdateSingleNpcSprites

@nextNpc:
    ldy TempItemIndex
    iny
    cpy NpcCount
    bcc @npcLoop

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

    and #%00000011
    sta TempNpcState

    jsr CollectSingleNpcData

    lda TempNpcState
    bne @skipDeadCheck
    lda TempNpcTimer
    beq @nextNpc ; timer ran out, don't show blood splat

@skipDeadCheck:
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

;-----------------------------------
CollectSingleNpcData:

    cmp #NPC_STATE_DAMAGED
    bne @cont

    lda #1
    sta DamagedPaletteMask
    jmp @cont1
@cont:
    lda #0
    sta DamagedPaletteMask
@cont1:
    lda Npcs, y
    lsr
    lsr

    sty Temp; store Npcs index
    asl
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
    calculateItemMapScreenIndexes ; macro
    iny
    lda Npcs, y ; direction
    sta TempDir
    iny
    lda Npcs, y ; frame

    ;let's calculate animation frame
    lsr
    lsr
    lsr
    lsr
    lsr
    stx TempRegX
    tax
    lda npc_anim_row_sequence, x
    ldx TempRegX

    sta TempFrame ; store frame
    iny
    lda Npcs, y ;timer
    sta TempNpcTimer

    tya
    sec
    sbc #5
    tay

    ;force to use 2 tile rows if dead
    lda TempNpcState
    bne @exit

    lda #2
    sta Temp
    lda #0
    sta TempIndex
    sta TempFrame
    sta TempFrameOffset
    lda #ANIM_FRAME_BLOODSTAIN
    sta TempZ
@exit:
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
    lda TempNpcState
    beq @skipDirFrames ; don't animate direction if dead

    lda TempDir
    lsr
    lsr
    asl ;extract Y dir and multiply by 2
    sta TempFrameOffset

@skipDirFrames:

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
    lda #%00000000
    jmp @saveattr1
@flip1:
    lda #%01000000
@saveattr1:
    eor DamagedPaletteMask
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
    eor DamagedPaletteMask
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
    beq @exit ; no npcs here
    dey; npcCount - 1, first index
@npcLoop:
    
    tya
    asl
    asl
    asl ; a * 8
    tax

    lda Npcs, x ;type + active
    and #%00000011
    sta TempNpcState
    cmp #0
    bne @cont ; not dead

;deadState
    
    txa
    clc
    adc #6 ;timer
    tax

    lda Npcs, x
    beq @nextNpc ;ok it's dead-dead
    sec
    sbc #1
    sta Npcs, x

    jmp @nextNpc

@cont:
    jsr FetchNpcVars
    
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
    sty TempPush
    jsr SingleNpcAI
    ldy TempPush

@nextNpc:
    dey
    bpl @npcLoop


    lda #NPC_AI_DELAY
    sta NpcAIUpdateDelay
@exit:
    rts
;-----------------------------------
FetchNpcVars:
    lda Npcs, x
    lsr
    lsr
    sta TempNpcIndex
    stx TempIndex
    asl
    asl
    asl
    tax
    stx TempNpcDataIndex
    inx
    lda npc_data, x; rows
    sta TempNpcRows
    inx
    lda npc_data, x; y offset for collision
    sta TempYOffset
    inx
    lda npc_data, x; npc type
    sta TempNpcType
    ldx TempIndex

    rts


;-----------------------------------
SingleNpcAI:

    lda TempNpcState
    cmp #NPC_STATE_ATTACK  ;is attack?
    beq @attackState
    cmp #NPC_STATE_DAMAGED ;is damaged?
    beq @damagedState

@idleState:
    lda TempNpcType
    cmp #NPC_TYPE_VILLAGER
    bne @moveNpc
    jsr ChangeNpcDirection
    jmp @nextNpc
@moveNpc:
    jsr NpcMovement
    jmp @nextNpc
@damagedState:
    inx ; dir 
    inx ; frame
    inx ; timer
    lda Npcs, x
    clc
    adc #1
    cmp #NPC_DELAY_DAMAGED
    bcs @resetState
    sta Npcs, x

    jmp @nextNpc

@attackState:
    inx ; dir 
    inx ; frame
    inx ; timer
    lda Npcs, x
    clc
    adc #1
    cmp #NPC_DELAY_ATTACK
    bcs @resetState
    sta Npcs, x
    cmp #15; delay between the npc being agitated and actualy attacking player
    beq @damage
    cmp #32
    bcc @nextNpc
@resetAttackFrame:

    dex
    lda Npcs, x
    cmp #32
    beq @nextNpc

    lda #32
    sta Npcs, x
    jmp @nextNpc

@resetState:
    lda #0
    sta Npcs, x ;reset timer

    ;return x from "timer" back to "state"
    txa
    sec
    sbc #6
    tax

    lda Npcs, x
    and #%11111100 ;clear state
    eor #000000001 ;idle state
    sta Npcs, x

    jmp @nextNpc

@damage:

    jsr CheckNpcAttackBoxWithPlayer

@nextNpc:

    rts
;--------------------------
CheckNpcAttackBoxWithPlayer:

    stx TempRegX
    sty TempY

    dex
    dex
    jsr CalcNPCXYOnScreen
    bne @fail

    lda TempDir
    and #%00000011
    cmp #0
    beq @verticalDir
    ;horizontal direction

    cmp #1
    bne @facesLeft
@facesRight:

    jsr CanNpcFacingRightHitPlayer
    bne @fail

    jmp @doDmg

@facesLeft:

    jsr CanNpcFacingLeftHitPlayer
    bne @fail

    jmp @doDmg

@verticalDir:
    lda TempDir
    lsr
    lsr
    cmp #1
    bne @facesDown
@facesUp:

    jsr CanNpcFacingUpHitPlayer
    bne @fail

    jmp @doDmg

@facesDown:

    jsr CanNpcFacingDownHitPlayer
    bne @fail

    jmp @doDmg

@doDmg:
    ldy TempY
    ldx TempRegX

    jsr DamagePlayer
    jmp @exit

@fail:
    ldy TempY
    ldx TempRegX

@exit:

    rts
;-------------------------
;A = 1 -> FAIL
CalcNPCXYOnScreen:
    lda Npcs, x
    sta TempDir ; fetch npc's direction
    dex
    lda Npcs, x ; screen index where npc resides
    jsr CalcItemMapScreenIndexes
    dex
    dex

    lda ItemMapScreenIndex
    beq @skipPrevScreen
    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @fail
@skipPrevScreen:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @fail

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen
    
    ;X1
    lda Npcs, x ; x
    sec 
    sbc GlobalScroll
    bcs @fail
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, x ; x
    cmp GlobalScroll
    bcc @fail
    sec
    sbc GlobalScroll
    sta TempPointX

@calcY: ; Y1
    inx
    lda Npcs, x ; y
    sta TempPointY


    lda #0
    jmp @exit

@fail:
    lda #1

@exit:
    rts
;---------------------------
;A=1 -> fail
CanNpcFacingRightHitPlayer:

    ;playerX < NpcX + 24 AND playerX + 16 > NpcX
    ;playerY < NpcY + 24 AND playerY + 16 > NpcY

    lda TempPointX
    clc
    adc #24
    cmp PlayerX
    bcc @fail

    lda PlayerX
    clc
    adc #16
    cmp TempPointX
    bcc @fail

    lda TempPointY
    clc
    adc #24
    cmp PlayerY
    bcc @fail

    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcc @fail


    lda #0
    jmp @exit

@fail:
    lda #1

@exit:

    rts
;--------------------------
CanNpcFacingLeftHitPlayer:
    ;playerX + 16 > NpcX - 8 AND playerX < NpcX + 16
    ;playerY < NpcY + 24 AND playerY + 16 > NpcY

    lda TempPointX
    sec
    sbc #8
    sta TempPointX2
    lda PlayerX
    clc
    adc #16
    cmp TempPointX2
    bcc @fail

    lda TempPointX
    clc
    adc #16
    cmp PlayerX
    bcc @fail

    lda TempPointY
    clc
    adc #24
    cmp PlayerY
    bcc @fail

    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcc @fail

    lda #0
    jmp @exit

@fail:
    lda #1

@exit:

    rts
;---------------------------
CanNpcFacingUpHitPlayer:


    ;playerX + 16 > NpcX AND playerX < NpcX + 16
    ;playerY + 16 > NpcY - 8 AND playerY  < NpcY + 24

    lda PlayerX
    clc
    adc #16
    cmp TempPointX
    bcc @fail

    lda TempPointX
    clc
    adc #16
    cmp PlayerX
    bcc @fail

    lda TempPointY
    sec
    sbc #8
    sta TempPointY2
    lda PlayerY
    clc
    adc #16
    cmp TempPointY2
    bcc @fail

    lda TempPointY
    clc
    adc #24
    cmp PlayerY
    bcc @fail



    lda #0
    jmp @exit

@fail:
    lda #1

@exit:

    rts

;---------------------------
CanNpcFacingDownHitPlayer:
    ;playerX + 16 > NpcX AND playerX < NpcX + 16
    ;playerY + 16 > NpcY AND playerY < NpcY + 32

    lda PlayerX
    clc
    adc #16
    cmp TempPointX
    bcc @fail

    lda TempPointX
    clc
    adc #16
    cmp PlayerX
    bcc @fail

    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcc @fail

    lda TempPointY
    clc
    adc #32
    cmp PlayerY
    bcc @fail


    lda #0
    jmp @exit

@fail:
    lda #1

@exit:

    rts

;---------------------------

NpcMovement:
    inx
    lda Npcs, x ; load dir
    sta TempDir
    inx
    lda Npcs, x ; frame, 0..128, step 2
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
    dex ; y
    dex ; x
    stx NpcXPosition ; index at x


    ;Calculate npcs new X and Y using the movement direction
    ;----------
    lda TempDir
    and #%00000011
    cmp #0
    beq @movesVerticaly

    cmp #1
    bne @movingLeft

    ;calculate X going right

    lda Npcs, x ; load x
    clc
    adc #NPC_SPEED
    bcs @IncreaseScreen
    sta NewNpcX

    jmp @movesVerticaly

@IncreaseScreen:
    sta NewNpcX
    ;increase npc screen if needed

    inx
    inx
    lda Npcs, x
    clc
    adc #1
    sta NewNpcScreen

    jmp @movesVerticaly

@movingLeft:
    ;calculate X going left

    lda Npcs, x ; load x
    sta Temp
    sec
    sbc #NPC_SPEED
    cmp Temp
    bcs @DecreaseScreen

    sta NewNpcX
    jmp @movesVerticaly

@DecreaseScreen:

    sta NewNpcX
    ;decrease npc screen if needed
    inx ;y
    inx ;screen
    lda Npcs, x; current screen
    sec
    sbc #1
    sta NewNpcScreen


@movesVerticaly:
    lda TempDir
    lsr
    lsr
    cmp #1
    bne @movesDown

    ;calculate Y going up

    ldx NpcXPosition
    inx ; move to y
    lda Npcs, x

    sec
    sbc #NPC_SPEED

    sta NewNpcY

    jmp @doneCallculation
@movesDown:
    cmp #2
    bne @doneCallculation

    ;calculate Y going down

    ldx NpcXPosition
    inx ; move to y
    lda Npcs, x
    clc
    adc #NPC_SPEED

    sta NewNpcY


@doneCallculation:
    ;--------------

    ldx NpcXPosition
    inx ;y
    inx ;screen

    jsr OnCollisionWithPlayer
    beq @nextNpc

    lda MustRedir
    bne @changeDir

    dex
    dex

    lda TempDir
    and #%00000011
    cmp #0
    beq @YMovement
    
    jsr HorizontalMovement
    lda MustRedir
    bne @changeDir
    ;--
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

;--------------------------
HorizontalMovement:
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
    cmp #1 ; 1 - change direction, mainly if the end of the last screen is reached
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
    cmp #1; ;if 1, change direction, if the x is 0 at the first screen
    beq @changeDir
    jmp @YMovement
@changeDir:
    lda #1
    sta MustRedir
    
@YMovement:
    rts

;--------------------------
SaveX:
    ldx NpcXPosition
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

    lda TempNpcType
    cmp #NPC_TYPE_VILLAGER
    beq @predator

    lda TempNpcTimer
    bne @randomDir

    lda TempNpcType
    cmp #NPC_TYPE_TIMID
    bne @predator

@timid:

    jsr SetDirectionForTimidNpc
    jmp @storeDirection

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
    bcc @goRight
    cmp Temp
    bcc @compareY
    bcs @goLeft
@goRight:
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
    lda PlayerY
    clc
    adc #8
    sta PlayerCenterY

    lda TempPointY
    cmp PlayerCenterY
    bcc @goDown ; bottom of npc should bump to center of player
    cmp Temp
    bcs @goUp
    bcc @storeDirection
@goDown:
    lda TempDir
    ora #%00001000
    sta TempDir
    jmp @storeDirection
@goUp:
    lda TempDir
    ora #%00000100
    sta TempDir

@storeDirection:
    lda TempDir
    sta Npcs, x
@exit:

    rts
;----------------------
SetDirectionForTimidNpc:

    dex ; npc y
    lda Npcs, x; y
    clc
    adc #8
    sta TempPointY

    dex ;npc x
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
    bcc @goLeft
    cmp Temp
    bcc @compareY
    bcs @goRight
@goRight:
    lda #1
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
    bcc @goUp
    cmp Temp
    bcs @goDown
    bcc @goUp
@goDown:
    lda TempDir
    ora #%00001000
    sta TempDir
    jmp @exit
@goUp:
    lda TempDir
    ora #%00000100
    sta TempDir


@exit:

    rts

;----------------------
TestCollisionGoingRight:
    sta TempX ; save modified x
    clc
    adc #16
    sec
    sbc GlobalScroll
    sta TempPointX

    ldx NpcXPosition
    inx
    lda Npcs, x ;y
    clc
    adc TempYOffset
    sta TempPointY
    jsr TestPointAgainstCollisionMap
    ldx NpcXPosition
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
;-----------------------------------------------------
;does an npc collide with the player
OnCollisionWithPlayer:

    dex
    lda Npcs, x; y
    sta TempPointY

;----x position to check
    dex

    lda Npcs, x
    sec
    sbc GlobalScroll
    sta TempPointX
    inx
    inx ; back to screen idx
;-----
;calc player box
    lda PlayerX
    clc
    adc #17
    sta TempX

    lda PlayerY
    clc
    adc #17
    sta TempY
;--collision check
    lda TempPointX
    cmp TempX
    bcs @exit
    lda TempPointX
    clc
    adc #16 ; two tiles
    cmp PlayerX
    bcc @exit

    lda TempPointY
    cmp TempY
    bcs @exit

    stx Temp
    lda TempNpcRows
    sec
    sbc #1
    tax
    lda TempPointY

@addRowsLoop:
    clc
    adc #8
    dex
    bne @addRowsLoop
    ldx Temp
    cmp PlayerY
    bcc @exit


    lda TempNpcType
    beq @collides

    ;---
    ldx NpcXPosition
    dex ;status
    lda Npcs, x
    and #%11111100
    eor #%00000010;set the attack state
    sta Npcs, x

    txa
    clc
    adc #5 ;move from "state" to "frame"
    tax 

    lda #NPC_ATTACK_FRAME
    sta Npcs, x ;attack frame
    inx ; timer
    lda #0
    sta Npcs, x
    dex ;frame
    dex ;direction
    dex ;screen

@collides:
    lda #0
    jmp @done
@exit:
    lda #1
@done:
    rts
;---------------------
DamagePlayer:

    jsr PlayDamageSfx

    lda TempNpcDataIndex
    clc
    adc #5  ;where the attack value is
    tay

    lda npc_data, y
    sta DigitChangeSize


    lda EquipedClothing
    beq @noclothing

    lda DigitChangeSize
    lsr
    sta DigitChangeSize
    lda EquipedClothing + 1
    cmp #CLOTHING_DAMAGE_BY_NPC
    bcc @removeClothing
    beq @removeClothing

    sec
    sbc #CLOTHING_DAMAGE_BY_NPC
    sta EquipedClothing + 1
    jmp @noclothing


@removeClothing:
    lda #0
    sta EquipedClothing


@noclothing:
    lda #<HP
    sta DigitPtr
    lda #>HP
    sta DigitPtr + 1
    jsr DecreaseDigits
    lda #1
    sta HpUpdated
@exit:

    rts





