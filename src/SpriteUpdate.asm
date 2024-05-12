;Sprite update routine during the GAME state

.segment "ROM6"

UpdateSprites:

    lda #0
    sta SpritesUpdated

;--- MAIN CHARACTER:
    ldy PlayerFrame
    bne @vertical

    lda DirectionX
    cmp #2 ;is right ?
    bne @doIt ; frame is 0

@vertical:
    iny ; increment frame

@doIt:
    lda player_frame_indexes, y
    sta TempFrame

    lda PlayerAnimationRowIndex
    asl ;2 lines of anim

    asl
    asl ;x4 to get to the bytes
    sta TempAnimIndex

    lda EquipedClothing
    beq @noClothing
     lda #<player_sprites_coat
    sta character_sprite_data_ptr
    lda #>player_sprites_coat
    sta character_sprite_data_ptr + 1
    jmp @gogo

@noClothing:
    lda #<player_sprites
    sta character_sprite_data_ptr
    lda #>player_sprites
    sta character_sprite_data_ptr + 1

@gogo:
    ldx #0
    ldy #0

@maincharloop:

    sty TempPlayerSpriteIdx ; current row in player sprite data
    tya
    ;add sprite data offset for a frame
    clc
    adc TempFrame

    ; multiply by 4 to get to single sprite data byte
    asl
    asl

    cpx #7
    bcc @skipAnim ; first row of sprites are not animated

    clc
    adc TempAnimIndex

@skipAnim:
    tay
    lda PlayerY
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; y coordinate
    inx
    iny
    lda (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; sprite frame
    inx
    iny
    lda (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x
    inx
    iny
    lda PlayerX
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x
    inx

    ldy TempPlayerSpriteIdx
    iny
    cpy #4
    bcc @maincharloop

    dex
    lda #4
    sta TempSpriteCount

;-------------KNIFE
    lda AttackTimer
    beq @noKnife

    lda EquipedItem
    beq @noKnife
    cmp #ITEM_KNIFE
    bne @noKnife

    jsr PrepareKnifeSprite

@updateKnife: ;update the actual sprite
    inx
    lda TempPointY
    sta FIRST_SPRITE,x
    inx
    lda #240
    clc
    adc PlayerFrame
    sta FIRST_SPRITE,x
    inx
    lda Temp
    sta FIRST_SPRITE,x
    inx
    lda TempPointX
    sta FIRST_SPRITE,x
    inc TempSpriteCount

;------ SPEAR
@noKnife:

    lda SpearData
    lsr
    bcc @projectiles

    lda SpearData + 3 ; screen

    jsr ScreenFilter
    bne @projectiles

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @SpearMatchesScreen

    lda SpearData + 1 ; x
    sec
    sbc ScrollX
    bcs @projectiles
    sta TempPointX ; save x
    jmp @doUpdate
@SpearMatchesScreen:
    lda SpearData + 1; x
    cmp ScrollX
    bcc @projectiles
    sec
    sbc ScrollX
    sta TempPointX


@doUpdate:

    jsr SetTwoSpearSprites

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount
;------------------PROJECTILES
@projectiles:
    jsr UpdateProjectileSprites

;---------------FISHING ROD
@fishingRod:

    lda FishingRodActive
    beq @hammer

    lda PlayerFrame
    beq @horizontal

    cmp #1
    beq @down
    ldy #16
    jmp @update
@down:
    ldy #24
    jmp @update

@horizontal:
    lda DirectionX
    cmp #2
    beq @flipIndex

    ldy #0
    jmp @update

@flipIndex:

    ldy #8
@update:

   jsr UpdateTwoRodSprites
;-----------HAMMER
@hammer:
    lda EquipedItem
    beq @equiped_item
    cmp #ITEM_HAMMER
    beq @ok
    cmp #ITEM_WOOD_HAMMER
    bne @equiped_item
@ok:
    jsr UpdateHammerSprites

;---------------------
@equiped_item:
    inx
    lda EquipedItem
    beq @no_equiped_item

    asl
    asl
    tay
    lda item_data, y
    sta Temp

    lda #15
    sta FIRST_SPRITE, x
    inx
    lda Temp
    sta FIRST_SPRITE, x
    inx
    lda #%00000000
    sta FIRST_SPRITE, x
    inx
    lda #8
    sta FIRST_SPRITE, x
    inx

    inc Temp

    lda #15
    sta FIRST_SPRITE, x
    inx
    lda Temp
    sta FIRST_SPRITE, x
    inx
    lda #%00000000
    sta FIRST_SPRITE, x
    inx
    lda #16
    sta FIRST_SPRITE, x
    inx


    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount


@no_equiped_item:
    lda Stamina
    beq @no_stamina_bar
    cmp #PLAYER_STAMINA_SIZE
    bcs @no_stamina_bar

    lda #15
    sta FIRST_SPRITE, x
    inx
    lda #STAMINA_END_SPRITE
    sta FIRST_SPRITE, x
    inx
    lda #%00000001
    sta FIRST_SPRITE, x
    inx

    lda Stamina ; current max stamina is 128, and it has 4 segments
    lsr
    lsr
    lsr
    lsr
    lsr         ;so let's divide value by segment width 32
    stx StaminaSpritetempx
    tax

    lda stamina_sprite_lookup, x
    sta StaminaSpritePos

    lda Stamina
    sec
    sbc stamina_segment_values, x
    lsr
    lsr
    sta StaminaSpriteOffset

    ldx StaminaSpritetempx

    lda StaminaSpritePos
    clc
    adc StaminaSpriteOffset

    sta FIRST_SPRITE, x
    inx

    inc TempSpriteCount

;--------------------
@no_stamina_bar:

    lda FlickerFrame
    beq @doZtoA
    lda #0
    sta FlickerFrame

    jsr UpdateNpcSpritesInWorldAtoZ
    jsr UpdateItemSpritesInWorldAtoZ
    jmp @updateTextdialog
@doZtoA:
    lda #1
    sta FlickerFrame

    jsr UpdateNpcSpritesInWorldZtoA
    jsr UpdateItemSpritesInWorldZtoA

@updateTextdialog:


;-----------TEXT DIALOG SPRITES

    lda InVillagerHut
    beq @hidesprites

    jsr UpdateVillagerDialogSprites 

;------------------- hide unused sprites
@hidesprites:
    lda TaintedSprites

    cmp TempSpriteCount
    bcc @done
    beq @done
    sec
    sbc TempSpriteCount
    asl
    asl

    tay
    lda #$FE
@hideSpritesLoop:
    sta FIRST_SPRITE, x
    inx

    dey
    bne @hideSpritesLoop
@done:

    lda #1
    sta SpritesUpdated
    lda TempSpriteCount
    sta TaintedSprites

    rts
;==============================================================

UpdateVillagerDialogSprites:


    ldy VillagerIndex
    lda VillagerKilled, y
    bne @exit

    lda SpecialItemsDelivered, y
    bne @exit

    lda MustUpdateTextBaloon
    bne @exit

    stx TempRegX

    lda EnteredBeforeNightfall
    bne @continue

    jsr GetPaletteFadeValueForHour
    cmp #DAYTIME_NIGHT
    bne @continue

    lda VillagerIndex  ;don't show sprites if bear
    beq @restoreXAndExit

@continue:
    ldx TempRegX
    jmp @updateSprites
@restoreXAndExit:
    ldx TempRegX
    jmp @exit

@updateSprites:

    ldy VillagerIndex
    lda ActiveVillagerQuests, y
    cmp #MAX_QUEST - 1
    bcc @continue_update

    lda CompletedSpecialQuests, y
    bne @continue_update
    jmp @exit

@continue_update:


    lda VillagerIndex
    tay
    asl
    asl ; index * 4
    clc
    adc ActiveVillagerQuests, y
    tay

    lda ItemIGave
    bne @checkRewardSpriteCount

    lda QuestSpritesCount, y
    beq @exit ;no sprites
    jmp @storeSpriteCount
@checkRewardSpriteCount:
    lda RewardSpriteCount
    beq @exit ;no sprites

@storeSpriteCount:
    sta TempFrame ;store sprite count

    tya
    asl
    asl
    asl
    asl
    tay

@spriteLoop:

    jsr PickSpriteData
    jsr SingleDialogSpriteUpdate

    inc TempSpriteCount

    dec TempFrame
    bne @spriteLoop

@exit:

    rts
;-----------------------------------
PickSpriteData:
    lda ItemIGave
    bne @reward

    lda #<QuestSprites
    sta pointer
    lda #>QuestSprites
    sta pointer + 1

    jmp @done
@reward:

    lda #<RewardSprites
    sta pointer
    lda #>RewardSprites
    sta pointer + 1

@done:
    rts

;-----------------------------------
;pointer - RewardSprites or QuestSprites
SingleDialogSpriteUpdate:

    lda (pointer), y
    sta FIRST_SPRITE, x
    inx
    iny
    lda (pointer), y
    sta FIRST_SPRITE, x
    inx
    iny
    lda (pointer), y
    sta FIRST_SPRITE, x
    inx
    iny
    lda (pointer), y
    sta FIRST_SPRITE, x
    inx
    iny


    rts
;-----------------------------------

SetTwoSpearSprites:

    lda SpearData
    lsr
    ;(dir - 1) * 8
    sec
    sbc #1
    asl
    asl
    asl
    tay

    lda #2
    sta TempSpearSpriteCnt

@spearLoop:
    inx
    lda SpearData + 4; Y
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda spearSprites, y
    sta FIRST_SPRITE, x
    inx
    iny
    lda TempPointX
    clc
    adc spearSprites, y
    sta FIRST_SPRITE, x

    iny
    dec TempSpearSpriteCnt
    bne @spearLoop

    rts
;---------------------------------
UpdateTwoRodSprites:
    lda FishBiteTimer ; / 8
    lsr
    lsr
    lsr
    sta Temp

    inx
    lda PlayerY
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;y
    iny
    inx
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;x

    inx
    iny
    lda PlayerY
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;y
    inx
    iny
    lda fishingRodSprites, y
    clc
    adc Temp

    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda fishingRodSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc fishingRodSprites, y
    sta FIRST_SPRITE, x ;x

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount


    rts
;----------------------------------
UpdateProjectileSprites:

    ldy ProjectileCount
    beq @exit

    dey
    sty ProjectileIdx

@projectileLoop:

    ldy ProjectileIdx
    lda projectiles_ram_lookup, y
    tay

    lda Projectiles, y
    lsr
    bcc @next ; this projectile is inactive

    iny
    iny
    iny
    lda Projectiles, y ;screen

    jsr ScreenFilter
    bne @next

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @projectileMatchesScreen

    dey
    dey
    lda Projectiles, y ; x
    sec
    sbc ScrollX
    bcs @next
    sta TempPointX
    iny
    iny ; screen
    jmp @continueUpdate
@projectileMatchesScreen:
    dey
    dey
    lda Projectiles, y ; x
    cmp ScrollX
    bcc @next
    sec
    sbc ScrollX
    sta TempPointX
    iny
    iny; screen

@continueUpdate:
    iny ; y
    inx
    lda Projectiles, y ; y
    sta FIRST_SPRITE, x ; y
    inx
    lda #$FB
    sta FIRST_SPRITE, x
    inx
    lda #%00000011
    sta FIRST_SPRITE, x
    inx
    lda TempPointX
    sta FIRST_SPRITE, x


    inc TempSpriteCount
@next:
    dec ProjectileIdx
    bpl @projectileLoop

@exit:

    rts

;----------------------------------
PrepareKnifeSprite:

    lda #%00000000
    sta Temp ; knife is not flipped

    lda #0
    sta TempFrame

    lda DirectionX
    cmp #2
    bne @notFlipped

    lda #%01000000
    sta Temp ; knife is flipped
    lda #1
    sta TempFrame


@notFlipped:

    lda PlayerFrame
    bne @vertical

    clc 
    adc TempFrame
    jmp @horizontal

@vertical:
    clc
    adc #1
@horizontal:
    asl
    tay
    lda knife_pos, y
    sta TempPointX
    iny
    lda knife_pos, y
    sta TempPointY
    lda PlayerY
    clc
    adc TempPointY
    sta TempPointY

    lda PlayerX
    clc
    adc TempPointX
    sta TempPointX

    rts
;----------------------------------
UpdateHammerSprites:

    lda AttackTimer
    bne @cont

    rts

@cont:
    lda PlayerFrame
    beq @horizontal ;

    clc
    adc #1

    jmp @multiply

@horizontal: ; left or right

    lda DirectionX
    cmp #2
    beq @flipped
    lda #0
    jmp @multiply

@flipped:
    lda #1

@multiply:
    asl
    asl
    asl
    tay

@updatesprites:
    inx
    lda PlayerY
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;y
    iny
    inx
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;x

    inx
    iny
    lda PlayerY
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;y
    inx
    iny
    lda hammerSprites, y

    sta FIRST_SPRITE, x ;frame
    inx
    iny
    lda hammerSprites, y
    sta FIRST_SPRITE, x ;attr
    inx
    iny
    lda PlayerX
    clc
    adc hammerSprites, y
    sta FIRST_SPRITE, x ;x

    lda TempSpriteCount
    clc
    adc #2
    sta TempSpriteCount

@exit:
    rts

.segment "CODE"
