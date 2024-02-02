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
    lda (pointer), y
    sta Npcs, x ; hp
    inx
    iny

    dec TempNpcCnt
    lda TempNpcCnt
    bne @npcLoop
@exit:

    rts
;-------------------------------------
;Parameters: TempNpcCnt - npc number
;            TempIndex  - location screen index
;Generate random npcs
GenerateNpcs:

    lda InCave
    bne @exit

    jsr UpdateRandomNumber
    and TempNpcCnt
    beq @exit
    sta TempNpcCnt

    ;let's calculate index for the screen coordinates
    lda TempIndex
    asl
    asl
    asl
    sta TempNpcIndex


    ldx LocationIndex
    lda location_spawns_low, x
    sta AnimalSpawnPointsPtr
    lda location_spawns_high, x
    sta AnimalSpawnPointsPtr + 1


    jsr GetPaletteFadeValueForHour
    sta TempFrame

    ldx #0
    stx TempNpcGenerationIdx

@npcLoop:

    lda TempNpcGenerationIdx
    asl
    asl
    asl
    tax ; npc slot * 8

    lda TempNpcGenerationIdx
    cmp NpcCount
    bcc @checkOldNpc

    lda NpcCount
    clc
    adc #1
    cmp #NPC_MAX_COUNT
    bcs @exit
    sta NpcCount
    jmp @generate

@checkOldNpc:
    lda Npcs, x
    and #%00000111
    cmp #0
    bne @next

@generate:
    jsr GenerateSingleNpc


    inc TempNpcGenerationIdx
    dec TempNpcCnt
    bne @npcLoop
    jmp @exit

@next:
    inc TempNpcGenerationIdx
    jmp @npcLoop

@exit:
    rts
;---------------------------------
GenerateSingleNpc:
    ;npc type
    lda TempFrame
    cmp #DAYTIME_NIGHT    ;check if it's night
    beq @makeWolf

    dec DogCounter
    beq @decideWhatToMake

@makeBunny:
    ldy #9
    lda npc_data, y
    sta TempNpcRows
    ldy #12
    lda npc_data, y
    sta TempHp
    lda #%00001001
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

@decideWhatToMake:
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @makeCanid
@makeBoar:
    lda #NUM_OF_BUNNIES_BEFORE_DOG
    sta DogCounter
    ldy #57
    lda npc_data, y
    sta TempNpcRows
    ldy #60
    lda npc_data, y
    sta TempHp
    lda #%00111001
    jmp @storeType

@makeCanid:
    lda #NUM_OF_BUNNIES_BEFORE_DOG
    sta DogCounter
    ldy #25
    lda npc_data, y
    sta TempNpcRows
    ldy #28
    lda npc_data, y
    sta TempHp
    lda #%00011001
@storeType:
    sta Npcs, x
    inx

    ;x
    ldy TempNpcIndex
    lda (AnimalSpawnPointsPtr), y
    sta Npcs, x
    inx

    ;y
    iny
    lda (AnimalSpawnPointsPtr), y
    sta Npcs, x
    inx

    ;screen
    lda TempIndex
    sta Npcs, x
    inx
    ;dir
    inx
    ;frame
    inx
    inx
    lda TempHp
    sta Npcs, x
    ;hp
    inx

    lda TempNpcIndex
    clc
    adc #2
    sta TempNpcIndex



    rts
;---------------------------------
EliminateInactiveNpcs:

    lda #NPC_ELIMINATION_DELAY
    sta NpcEliminationDelay

    lda InCave
    bne @exit
    lda LocationIndex
    cmp #10 ; alien base
    beq @exit

    ldy NpcCount
    beq @exit ; no npcs

    lda CurrentMapSegmentIndex
    clc
    adc #2
    sta FarOffNpcScreen

    dey

@npcLoop:
    tya
    asl
    asl
    asl
    tax
    stx TempEliminationDest

    lda Npcs, x 
    and #%00000111
    cmp #0
    beq @next
    inx
    inx
    inx
    lda Npcs, x
    cmp CurrentMapSegmentIndex
    bcc @eliminate
    cmp FarOffNpcScreen
    bcs @eliminate
    jmp @next


@eliminate:

   ldx TempEliminationDest
   lda #0
   sta Npcs, x

@next:
    dey
    bpl @npcLoop
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
    and #%00000011 ; let's ignore agitation bit
    sta TempNpcState
    cmp #0
    beq @exit ; it's dead

    lda Npcs, y ; let's get DB index
    lsr
    lsr
    lsr ;eliminate 3 state bits


    sty TempNpcDataIdxForCollision
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
    ldy TempNpcDataIdxForCollision

    iny
    iny
    iny
    lda Npcs, y ; screen index where npc resides
    dey
    dey

    jsr ScreenFilter
    bne @exit

    lda Npcs, y
    sta DropedItemX ; store this for item droping

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen

    ;X1
    lda Npcs, y ; x
    sec
    sbc ScrollX
    bcs @exit
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX
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
;Does player collides with an npc?
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
    and #%00000011 ; ignoring the agitation bit
    sta TempNpcState
    cmp #0
    beq @exit ; it's dead

    lda Npcs, y ; let's get DB index
    lsr
    lsr
    lsr ;eliminate 3 state bits

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
    dey
    dey

    jsr ScreenFilter
    bne @exit

    lda Npcs, y
    sta DropedItemX ; store this for item droping

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen
    
    ;X1
    lda Npcs, y ; x
    sec
    sbc ScrollX
    bcs @exit
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX
    sta TempPointX

@calcY: ; Y1
    iny
    lda Npcs, y ; y
    sta TempPointY
;-------
    lda ItemMapScreenIndex
    sta KilledNpcScreenIdx

    jsr CollisionWithProjectiles

    lda SpearData
    lsr
    bcs @ignoreTimer
    lda AttackTimer
    beq @exit
    lda NpcsHitByPlayer
    bne @exit
@ignoreTimer:
    jsr AttackBoxNpcsCollision

@exit:

    rts
;-------------------------------------
CollisionWithProjectiles:

    lda #0
    sta ShotWithProjectile

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


    sty TempY ;save Y register

    ldy ProjectileCount
    beq @exit
    dey

    sty ProjectileIdx
@loop:

    jsr SingleProjectileCollision

@next:
    dec ProjectileIdx
    bpl @loop

@exit:
    ldy TempY
    rts

;---------------------------------
SingleProjectileCollision:


    lda ProjectileIdx
    asl
    asl
    tay

    lda Projectiles, y ; dir + status
    lsr
    bcs @proceed
    
    rts

@proceed:
    iny
    iny

    lda Projectiles, y ; screen
    jsr ScreenFilter
    beq @gogo

    rts

@gogo:

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @ProjectileMatchesScreen
    ;don't match

    dey
    lda Projectiles, y ; x
    sec
    sbc ScrollX
    bcs @exit

    jmp @cont
@ProjectileMatchesScreen:

    dey
    lda Projectiles, y ; x
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX

@cont:
    sta ProjectileX
    iny
    iny
    lda Projectiles, y ; y
    sta ProjectileY

    lda ProjectileX
    clc
    adc #8
    cmp TempPointX
    bcc @checkOtherPoint

    cmp TempPointX
    bcs @checkOtherPoint

    lda ProjectileY
    clc
    adc #8
    cmp TempPointY
    bcc @checkOtherPoint

    cmp TempPointY2
    bcs @checkOtherPoint

    jmp @collisionDetected

@checkOtherPoint:

    lda ProjectileX
    cmp TempPointX
    bcc @exit

    cmp TempPointX2
    bcs @exit

    lda ProjectileY
    cmp TempPointY
    bcc @exit

    cmp TempPointY2
    bcs @exit


@collisionDetected:

    lda ProjectileIdx
    asl
    asl
    tay
    lda #0
    sta Projectiles, y

    lda #1
    sta ShotWithProjectile

    ldy TempY
    jsr OnCollisionWithAttackRect

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
    cmp #NPC_TYPE_PASSIVE
    beq @exit

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
    sta Npcs, y ;hp
    dey
    lda #32
    sta Npcs, y ;timer
    dey
    lda #5*32
    sta Npcs, y ;frame

    tya
    sec
    sbc #5 ; go to status
    tay

    lda Npcs, y
    and #%11111000; drop three last bits that stand for status
    sta Npcs, y

    lda TempNpcIndex
    cmp #NPC_IDX_BOSS
    bne @dropStuff
    lda #1
    sta BossDefeated
    sta Destructables + 2
    sta Destructables + 3
    lda DestroyedTilesCount
    clc
    adc #2

@dropStuff:
    jsr DropItemAfterDeath
    jmp @wearWeapon

@doneDoingDmg:

    jsr PlayDamageSfx
   
    tya
    sec
    sbc #7  ;5
    tay
    lda Npcs, y
    and #%11111000
    eor #%00000111 ; setting agitation bit + damaged state
    
    sta Npcs, y
    iny
    iny

@wearWeapon:

    lda EquipedItem
    cmp #ITEM_FISHING_ROD
    beq @exit
    cmp #ITEM_SLINGSHOT
    bne @wear
    lda ShotWithProjectile
    beq @exit
@wear:
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

    lda TempNpcIndex
    beq @exit

@continueDrop:
    ;drop item


    lda TempNpcType
    cmp #NPC_TYPE_PREDATOR
    beq @spawnHide
    cmp #NPC_TYPE_AGRESSIVE
    beq @specialRewardItem


    lda NpcsHitByPlayer
    cmp #2
    bcs @specialRewardItem

    lda #ITEM_RAW_MEAT
    asl
    ora #1

    jmp @storeItem
@specialRewardItem:
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @spawnHide
    lda #ITEM_RAW_JUMBO_MEAT
    asl
    ora #1
    jmp @storeItem
@spawnHide:
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcc @exit
    lda #ITEM_HIDE
    asl
    ora #1
@storeItem:

    sta TempItemIndex


    jsr ItemSpawnPrep


    lda DropedItemX
    clc
    adc #8
    bcs @IncrementScreenIndex
    jmp @continueSpawningItem
@IncrementScreenIndex:
    lda #1
    sta TempItemScreen
@continueSpawningItem:
    iny ; at item x
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
    lda ShotWithProjectile
    beq @cont

    sty TempY

    ldy #91 ;slingshot's power
    lda item_data, y
    sta TempPlayerAttk

    ldy TempY
    jmp @exit

@cont:
    lda #1
    sta TempPlayerAttk
    lda EquipedItem
    beq @exit
    cmp #ITEM_FISHING_ROD ; fishing rod is not a weapon
    beq @exit
    cmp #ITEM_SLINGSHOT
    beq @exit

    asl
    asl

    sty TempY
    tay
    iny ;palette
    iny ;type
    iny ;power

    lda item_data, y ;get power value
    sta TempPlayerAttk

    ldy TempY

@exit:
    rts

;-------------------------------------
MakeGenericAttackSquare:

    lda PlayerFrame
    bne @vertical

    lda DirectionX
    cmp #2
    beq @facingRight

    lda #0
    jmp @multiply

@facingRight:
    lda #1 ; right
    jmp @multiply

@vertical:
    clc
    adc #1

@multiply:
    asl
    asl
    tay
    lda (weapon_collision_ptr), y
    clc
    adc PlayerX
    sta AttackTopLeftX
    iny
    lda (weapon_collision_ptr), y
    clc
    adc PlayerY
    sta AttackTopLeftY
    iny
    lda (weapon_collision_ptr), y
    clc
    adc PlayerX
    sta AttackBottomRightX
    iny
    lda (weapon_collision_ptr), y
    clc
    adc PlayerY
    sta AttackBottomRightY

    rts

;--------------------------------------
PreparePlayerAttackSquare:

    sty TempY

    lda EquipedItem
    beq @nothingEquiped

    cmp #ITEM_SPEAR
    beq @spearEquiped

    ;knife
    lda #<knife_collision_pos
    sta weapon_collision_ptr
    lda #>knife_collision_pos
    sta weapon_collision_ptr + 1
    jsr MakeGenericAttackSquare

    jmp @calcCollision

@spearEquiped:

    jsr BuildSpearAttackSquare

    beq @fail

    jmp @calcCollision

@nothingEquiped:
    lda #<fist_collision_pos
    sta weapon_collision_ptr
    lda #>fist_collision_pos
    sta weapon_collision_ptr + 1
    jsr MakeGenericAttackSquare

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

    lda SpearData
    lsr
    bcc @exit

    lda SpearData + 2 ; screen

    jsr ScreenFilter
    bne @exit

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @SpearMatchesScreen

    lda SpearData + 1 ; x
    sec
    sbc ScrollX
    bcs @exit
    sta TempSpearX; save x
    jmp @doUpdate
@SpearMatchesScreen:
    lda SpearData + 1 ; x
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX
    sta TempSpearX

@doUpdate:

    lda SpearData ; Dir + Active
    lsr
    sec
    sbc #1
    ;(SpearDir - 1) * 8
    asl
    asl
    asl
    tay

    lda SpearData + 3 ; Y
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

    lda SpearData + 3 ; Y
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
.SEGMENT "ROM1"
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

    lda Npcs, y ; index + agitation + state
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
    sbc ScrollX
    bcs @nextNpc
    sta TempPointX ; save x
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp ScrollX
    bcc @nextNpc
    sec
    sbc ScrollX
    sta TempPointX
@calcY:
    iny
    lda Npcs, y; y
    sta TempPointY ; save y

    jsr GetSpriteDataPointer

    lda Temp ; row count
    sta TempRowIndex


    ;add to y reg particular ammount of rows to get the right frame
    ;npc_height_in_rows * frame_index
    lda Temp
    asl
    tay
    lda npc_anim_rows, y
    sta ptr_list
    iny
    lda npc_anim_rows, y
    sta ptr_list + 1


    ldy TempNpcFrame
    lda (ptr_list), y

    asl ; let's assume that a row is 2 sprites portrayed by 8 bytes
    asl
    asl
    tay ; index for our sprite data

@rowloop:
    jsr UpdateNpcRow
    dec TempRowIndex
    bne @rowloop
@nextNpc:
    rts
;----------------------------------
GetSpriteDataPointer:
    ;let's get the pointer to the sprite data
    ldy TempNpcIndex
    lda frame_list_index_lookup, y
    tay
    lda npc_data, y
    sta ptr_list
    iny
    lda npc_data, y
    sta ptr_list + 1
    ;we got the pointer

    lda TempDir
    cmp #1 ;right
    beq @right
    cmp #3
    bcc @left

    lsr
    lsr
    clc
    adc #1 ; (1 or 2) + 1 = 2 or 3 (up or down)
    jmp @found

@left:
    lda #0 ;left
    jmp @found
@right:
    lda #1
@found:
    asl
    tay
    lda (ptr_list), y
    sta character_sprite_data_ptr
    iny
    lda (ptr_list), y
    sta character_sprite_data_ptr + 1

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
    lsr

    sty Temp; store Npcs index
    sta TempNpcIndex ; what kind of npc is this ?
    asl
    asl
    asl
    tay
    iny
    lda npc_data, y ; tile rows for the npc
    ldy Temp; restore Npcs index

    sta Temp; store tile rows

    iny
    iny
    iny
    lda Npcs, y ; screen index where npc resides
    sta ItemMapScreenIndex
    clc
    adc #1
    sta NextItemMapScreenIndex
    sec
    sbc #2
    sta PrevItemMapScreenIndex
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
    lsr ;frame / 32
    sta TempNpcFrame ; let's store the frame for later

    iny
    lda Npcs, y ;timer
    sta TempNpcTimer

    tya
    sec
    sbc #5
    tay

@exit:
    rts

;-------------------------------------
;Update two npc sprites
UpdateNpcRow:

    ;Sprite 1

    lda TempPointY
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; y coordinate
    inx
    iny

    lda (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; tile index
    inx
    iny

    lda (character_sprite_data_ptr), y
    eor DamagedPaletteMask
    sta FIRST_SPRITE, x; sprite attributes
    inx
    iny
    ;X coord------------------
    lda TempPointX
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; x coordinate
    inc TempSpriteCount
    inx
    iny

    ;SECOND SPRITE -----------------------------------

    lda TempPointX ; check if the second sprite is still in screen
    clc
    adc #8
    bcs @skipThatSprite
    ;----

    lda TempPointY
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; y coordinate
    inx
    iny

    lda (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; tile index
    inx
    iny

    lda (character_sprite_data_ptr), y
    eor DamagedPaletteMask
    sta FIRST_SPRITE, x ; sprite attributes
    inx
    iny
    ;X coord------------------
    lda TempPointX
    clc
    adc (character_sprite_data_ptr), y
    sta FIRST_SPRITE, x ; x coordinate
    inc TempSpriteCount
    inx
    iny

    jmp @exit
@skipThatSprite:

    iny
    iny
    iny
    iny

@exit:

    rts

.SEGMENT "CODE"
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

    jsr ScreenFilter
    bne @nextNpc

;final filter (could be removed)
    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen

    lda Npcs, x ; x
    sec
    sbc ScrollX
    bcs @nextNpc
    jmp @doAI
@NpcMatchesScreen:
    lda Npcs, x ; x
    cmp ScrollX
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
    beq @changeDir
    cmp #NPC_TYPE_PASSIVE
    beq @nextNpc
    jmp @moveNpc

@changeDir:
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
    dex
    dex


    jsr ScreenFilter
    bne @fail

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen
    
    ;X1
    lda Npcs, x ; x
    sec
    sbc ScrollX
    bcs @fail
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, x ; x
    cmp ScrollX
    bcc @fail
    sec
    sbc ScrollX
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

    lda #NPC_SPEED
    sta TempNpcSpeed


    lda TempNpcType
    cmp #NPC_TYPE_TIMID
    bne @continue_move
    jsr CheckAgitationByPlayer

    dex; state (was at x coord)
    lda Npcs, x ; index and stuff
    and #%00000100 ; check agitated bit
    beq @done_timid ; not agitated
    lda #NPC_SPEED_AGITATED ; if agitated, go realy fast
    sta TempNpcSpeed
@done_timid:
    inx
@continue_move:
    ;Calculate npcs new X and Y using the movement direction
    ;----------
    ;store the new coordinates, because there might not be any direction
    ;but we need the collision detection working
    lda Npcs, x
    sta NewNpcX
    inx
    lda Npcs, x
    sta NewNpcY
    inx
    lda Npcs, x
    sta NewNpcScreen
    ;now let's see if the npc is moving any of the directions
    ldx NpcXPosition
    lda TempDir
    and #%00000011
    cmp #0
    beq @movesVerticaly

    cmp #1
    bne @movingLeft

    ;calculate X going right

    lda Npcs, x ; load x
    clc
    adc TempNpcSpeed
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
    sbc TempNpcSpeed
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
    sbc TempNpcSpeed

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
    adc TempNpcSpeed

    sta NewNpcY


@doneCallculation:
    ;--------------
    ;let's check collision with the player
    ldx NpcXPosition
    inx ;y
    inx ;screen

    jsr OnCollisionWithPlayer
    beq @nextNpc ; if hostile and collides

    lda MustRedir   ;if not hostile and collides, probably will have mustRedir set to 1
    bne @changeDir

    ldx NpcXPosition ;return the x regster to X coordinate position

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
    jsr TestCollisionGoingVerticaly
    cmp #1
    beq @changeDir
    lda TempZ;stored Y
    dex
    sta Npcs, x ; y

    jmp @nextNpc
@goDown:
    cmp #2
    bne @nextNpc
    jsr TestCollisionGoingVerticaly
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

;-------------------------

CheckAgitationByPlayer:
    ; x reg at x coord

    stx TempRegX

    lda PlayerY
    cmp #48
    bcc @clampY1
    sec
    sbc #48
    jmp @saveY1
@clampY1:
    lda #0
@saveY1:
    sta TempPlayerRangeY1

    lda PlayerY
    clc
    adc #64
    bcs @clampY2
    jmp @saveY2
@clampY2:
    lda #255
@saveY2:
    sta TempPlayerRangeY2


    lda PlayerX
    clc
    adc #64
    sta TempPlayerRangeX2

    lda PlayerX
    sec
    sbc #48
    sta TempPlayerRangeX1

    lda Npcs, x
    sec
    sbc ScrollX
    cmp TempPlayerRangeX2
    bcs @exit
    lda Npcs, x
    clc
    adc #16
    sec
    sbc ScrollX
    cmp TempPlayerRangeX1
    bcc @exit

    inx ; y
    lda Npcs, x
    cmp TempPlayerRangeY2
    bcs @exit

    lda Npcs, x
    clc
    adc #16
    cmp TempPlayerRangeY1
    bcc @exit
;--
    ldx TempRegX ; at x
    dex ;state
    ;set agitated
    lda Npcs, x
    and #%11111011
    eor #%00000100
    sta Npcs, x

@exit:
    ldx TempRegX ; must return x to x coord

    rts


;--------------------------
HorizontalMovement:
    cmp #1 ; right?
    bne @notRight

@goRight:
    lda NewNpcX
    ;let's test the newly callculated x coordinate
    jsr TestCollisionGoingRight
    cmp #1
    beq @changeDir ; collides
    jsr SaveX

    lda NewNpcScreen
    cmp ScreenCount
    bcs @changeDir

    inx ;y
    inx ;screen
    sta Npcs, x
    dex
    dex

    jmp @YMovement

@notRight:
    cmp #2
    bne @YMovement
@goLeft:

    lda NewNpcX
    jsr TestCollisionGoingLeft
    cmp #1 
    beq @changeDir ;collides
    jsr SaveX

    lda NewNpcScreen
    cmp ScreenCount
    bcs @changeDir

    inx ;y
    inx ;screen
    sta Npcs, x
    dex
    dex

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
    cmp #NPC_TYPE_PREDATOR
    beq @predator
    cmp #NPC_TYPE_AGRESSIVE
    beq @agressiveWhenDamaged

@timid:

    jsr SetDirectionForTimidNpc
    beq @storeDirection ; else do random

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
@agressiveWhenDamaged:

    jsr SetDirectionForBoar
    beq @storeDirection
    jmp @randomDir

@predator:
    jsr SetDirectionsForPredatorNpc
@storeDirection:
    lda TempDir
    sta Npcs, x
@exit:

    rts
;------------------------------
SetDirectionForBoar:
    

    dex
    dex
    dex
    lda Npcs, x
    and #%00000100
    beq @doRandom


@done:
    inx ; x
    inx ; y
    inx ; screen
    jsr SetDirectionsForPredatorNpc
    lda #0
    jmp @end

@doRandom:
    inx
    inx
    inx
    lda #1
@end:


    rts


;------------------------------
;preparation for direction change for predator npc
;x reg value is at the x coordinate index of that npc
PredatorDirectionChangePrep:

    lda Npcs, x; x
    clc
    adc #8
    sta TempPointX
    inx
    lda Npcs, x; y
    clc
    adc #16
    sta TempPointY

    inx ;screen
    inx ;direction

    lda PlayerX
    clc
    adc #16
    sta Temp

    lda #0
    sta TempDir

    lda PlayerY
    clc
    adc #16
    sta TempPlayerY2

    lda PlayerY
    clc
    adc #8
    sta PlayerCenterY

    rts

;-------------------------------
SetDirectionsForPredatorNpc:

    dex
    dex ; x

    jsr PredatorDirectionChangePrep

    lda TempPointX
    sec
    sbc ScrollX
    cmp PlayerX
    bcc @goRight
    cmp Temp
    bcc @compareY
    bcs @goLeft
@goRight:
    lda #1
    sta TempDir
    jmp @compareY
@goLeft:
    lda #2
    sta TempDir

@compareY:
    lda TempPointY
    cmp PlayerCenterY
    bcc @goDown ; bottom of npc should bump to center of player
    cmp TempPlayerY2
    bcs @goUp
    bcc @end
@goDown:
    lda TempDir
    ora #%00001000
    sta TempDir
    jmp @end
@goUp:
    lda TempDir
    ora #%00000100
    sta TempDir
@end:

    rts



;if A is 0 then direction is set
;----------------------
SetDirectionForTimidNpc:

    dex
    dex
    dex ; index + status
    lda Npcs, x
    and #%00000100 ; check the agitation bit
    beq @doRandom

    inx ; x
    inx ; y

    lda Npcs, x; y
    clc
    adc #8
    sta TempNpcCenterY

;---
;Calc npc X points
    dex ;npc x
    lda Npcs, x; x
    clc
    adc #8
    sta TempZ

    inx ;y
    inx ;screen
    inx ;direction

    lda PlayerX
    clc
    adc #16
    sta Temp

    lda #0
    sta TempDir

    lda TempZ ; npc center
    sec
    sbc ScrollX
    cmp PlayerX
    bcc @goLeft
    cmp Temp
    bcc @compareY

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


    lda TempNpcCenterY
    cmp PlayerY
    bcc @goUp
    cmp Temp
    bcs @goDown
    bcc @goUp
@goDown:
    lda TempDir
    ora #%00001000
    sta TempDir
    jmp @done
@goUp:
    lda TempDir
    ora #%00000100
    sta TempDir


@done:
    lda #0
    jmp @end
@doRandom:
    inx ;x
    inx ;y
    inx ; screen
    lda #1
@end:

    rts

;----------------------
TestCollisionGoingRight:
    sta TempX ; save modified x
    clc
    adc #16 ; npc width
    sta TempPointX
    bcs @incrementScreen ; it's more than 256

    lda NewNpcScreen
    sta TempScreen ; screen idx for collision test

    jmp @cont
@incrementScreen:
    lda NewNpcScreen
    clc
    adc #1
    sta TempScreen ; screen idx for collision test
@cont:
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
    sta TempPointX
    inx
    lda Npcs, x ; y
    clc
    adc TempYOffset
    sta TempPointY
    lda NewNpcScreen
    sta TempScreen
    jsr TestPointAgainstCollisionMap
    ldx TempIndex
    inx
    inx
    ;collision result is in A
    rts
;--------------------------------------
TestCollisionGoingVerticaly:

    lda NewNpcY ; y
    sta TempZ

    clc
    adc TempYOffset
    sta TempPointY

    lda NewNpcX
    clc
    adc #2
    sta TempPointX
    lda NewNpcScreen
    sta TempScreen
    jsr TestPointAgainstCollisionMap
    cmp #1
    beq @exit

    lda TempPointX
    clc
    adc #12
    sta TempPointX
    lda NewNpcScreen
    sta TempScreen
    jsr TestPointAgainstCollisionMap

@exit:
    ldx NpcXPosition
    inx
    inx ; screen

    rts
;-----------------------------------------------------
;does an npc collide with the player
OnCollisionWithPlayer:

    ;calc player box
    lda PlayerX
    clc
    adc #16
    sta TempX

    lda PlayerY
    clc
    adc #16
    sta TempY
    ;---------------

    dex
    lda NewNpcY
    sta TempPointY

;----x position to check
    dex

    lda NewNpcX
    sec
    sbc ScrollX
    sta TempPointX
    inx
    inx ; back to screen idx
;-----
    stx TempNpcCollisionXReg
    lda TempNpcRows
    sec
    sbc #1
    tax ;npc sprite rows - 1

    lda TempPointY
@addRowsLoop:
    clc
    adc #8
    dex
    bne @addRowsLoop
    ldx TempNpcCollisionXReg
    sta TempPointY2

;--collision check
    lda TempPointX ;npc min x
    cmp TempX      ;player max x
    bcs @exit

    lda TempPointX
    clc
    adc #16 ; two tiles
    cmp PlayerX
    bcc @exit
    beq @exit

    lda TempPointY ;npc min y
    cmp TempY
    bcs @exit

    lda TempPointY2
    cmp PlayerY
    bcc @exit

    lda TempNpcType
    beq @timid

    ;---
    jsr SetTheAttackDirection

    ldx NpcXPosition
    dex ;status
    lda Npcs, x

    and #%00000011
    cmp #NPC_STATE_DAMAGED
    beq @collides ; don't attack if in damaged state

    lda Npcs, x     ;  reload the status
    and #%11111100  ;  remove previous status
    eor #%00000010  ;  set the attack state
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
@timid:
    lda #1
    sta MustRedir
@exit:
    lda #1
@done:
    rts
;---------------------
;clear the diagonal direction and set it one of four directions for attack anim
SetTheAttackDirection:

    ldx NpcXPosition

    jsr PredatorDirectionChangePrep


    lda TempPointY
    cmp PlayerCenterY
    bcc @goDown ; bottom of npc should bump to center of player
    cmp TempPlayerY2
    bcs @goUp
    bcc @compareX
@goDown:
    lda #%00001000
    sta TempDir
    jmp @compareX
@goUp:
    lda #%00000100
    sta TempDir

@compareX:
    lda TempPointX
    sec
    sbc ScrollX
    cmp PlayerX
    bcc @goRight
    cmp Temp
    bcc @done
    bcs @goLeft
@goRight:
    lda # 1
    sta TempDir
    jmp @done
@goLeft:
    lda #2
    sta TempDir


@done:

    lda TempDir
    sta Npcs, x

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
    sta MustUpdatePalette
    ldy #29
    lda #07
    sta RamPalette, y
    sta PlayerDamagedCounter
    lda #32
    sta PaletteUpdateSize


@exit:

    rts





