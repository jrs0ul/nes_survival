;pointer points to the NPCs data
LoadNpcs:
    ldy #0
    lda (pointer), y
    sta TempNpcCnt
    beq @exit ; no npcs
    iny
    ldx NpcCount
    lda npcs_ram_lookup, x
    tax
@npcLoop:

    lda (pointer), y
    sta Npcs, x
    inx
    iny
    lda (pointer), y
    sta Npcs, x ;x
    iny
    inx
    inx
    lda (pointer), y
    sta Npcs, x ; y
    iny
    inx
    inx
    lda (pointer), y
    sta Npcs, x ; screen
    iny
    inx
    lda #1
    sta Npcs, x ; dir
    inx
    lda #32
    sta Npcs, x ;frame
    inx
    lda #0
    sta Npcs, x ;timer
    inx
    ;hp
    lda (pointer), y
    sta Npcs, x ; hp
    inx
    iny
    lda #0
    sta Npcs, x ; clear the dmg timer
    inx

    inc NpcCount
    dec TempNpcCnt
    lda TempNpcCnt
    bne @npcLoop
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



;-----------------
; Calls the routine from the BANK 3
GenerateNpcs:

    ldy current_bank
    sty oldbank
    ldy #3
    jsr bankswitch_y

    jsr GenNpcs

    ldy oldbank
    jsr bankswitch_y

    rts

.SEGMENT "ROM3"
;-------------------------------------
;Parameters: TempNpcCnt - npc number
;            TempIndex  - location screen index
;Generate random npcs
GenNpcs:

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

    ldx TempNpcGenerationIdx ; npc slot
    lda npcs_ram_lookup, x
    tax

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
;---------------------------
MakeBunny:
    ldy #9
    lda npc_data, y
    sta TempNpcRows
    ldy #12
    lda npc_data, y
    sta TempHp
    lda #%00010001
    rts
;---------------------------------
GenerateSingleNpc:

    lda LocationType
    cmp #LOCATION_TYPE_CAVE
    beq @cave
    cmp #LOCATION_TYPE_DARK
    beq @cave
    cmp #LOCATION_TYPE_ALIEN_BASE
    beq @alien
    jmp @notInCave
@cave:
    jsr UpdateRandomNumber
    and #3
    cmp #0
    beq @makeWolf
    cmp #2
    beq @makeSpider
    jmp @makeBunny

@alien:
    jsr UpdateRandomNumber
    and #3
    cmp #0
    beq @makeSlimer
    cmp #1
    beq @makeBaraka
    jmp @makeWolf

@notInCave:
    lda TempFrame ; fade value for time of the day
    cmp #DAYTIME_NIGHT    ;check if it's night
    beq @makeWolf

    dec DogCounter
    beq @decideWhatToMake

@makeBunny:
    jsr MakeBunny
    jmp @storeType
@makeSpider:
    ldy #72
    lda npc_data, y
    sta TempNpcRows
    ldy #76
    lda npc_data, y
    sta TempHp
    lda #%10010001
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
    lda #%01110001
    jmp @storeType

@makeBaraka:
    ldy #81
    lda npc_data, y
    sta TempNpcRows
    ldy #84
    lda npc_data, y
    sta TempHp
    lda #%10110001
    jmp @storeType

@makeSlimer:
    ldy #73
    lda npc_data, y
    sta TempNpcRows
    ldy #76
    lda npc_data, y
    sta TempHp
    lda #%10100001
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
    lda #%00110001
@storeType:
    sta Npcs, x
    inx

    ;x
    ldy TempNpcIndex
    lda (AnimalSpawnPointsPtr), y
    sta Npcs, x
    inx
    inx

    ;y
    iny
    lda (AnimalSpawnPointsPtr), y
    sta Npcs, x
    inx
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

.SEGMENT "CODE"
;---------------------------------
EliminateInactiveNpcs:

    lda #NPC_ELIMINATION_DELAY
    sta NpcEliminationDelay

    lda LocationIndex
    cmp #LOCATION_ALIEN_BASE
    beq @exit
    cmp #LOCATION_MINE
    beq @exit

    ldy NpcCount
    beq @exit ; no npcs

    lda CurrentMapSegmentIndex
    clc
    adc #2
    sta FarOffNpcScreen

    dey

@npcLoop:
    ldx npcs_ram_lookup, y
    stx TempEliminationDest

    lda Npcs, x ; status
    and #%00000111
    cmp #0
    beq @next

    txa
    clc
    adc #5
    tax

    lda Npcs, x ;screen
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

    lda npcs_ram_lookup, y
    tay

    lda Npcs, y; let's get the state
    and #%00000011 ; let's ignore agitation and damage bits
    sta TempNpcState
    cmp #0
    beq @exit ; it's dead

    lda Npcs, y ; let's get DB index
    lsr
    lsr
    lsr
    lsr;eliminate 4 state bits


    sty TempNpcDataIdxForCollision
    asl
    asl
    asl
    tay
    lda npc_data, y ; tiles in a row
    asl
    asl
    asl ; multiply by 8
    sta TempNpcWidth
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
    iny
    iny
    lda Npcs, y ; screen index where npc resides
    dey ;y2
    dey ;y
    dey ;x2
    dey ;x

    jsr ScreenFilter
    bne @exit

    lda Npcs, y
    sta DropedItemX ; store this for item droping

    lda NewCurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @NpcMatchesScreen

    ;X1
    lda Npcs, y ; x
    sec
    sbc NewScrollX
    bcs @exit
    sta TempPointX
    jmp @calcY
@NpcMatchesScreen:
    lda Npcs, y ; x
    cmp NewScrollX
    bcc @exit
    sec
    sbc NewScrollX
    sta TempPointX

@calcY: ; Y1
    iny ;x2
    iny ;y
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
;oposite subroutine is OnCollisionWithPlayer
PlayerNpcCollision:

    lda TempPointX
    clc
    adc TempNpcWidth
    sta TempPointX2

    lda TempNpcRows
    sec
    sbc #1
    asl
    asl
    asl ; (rows - 1) * 8
    clc
    adc TempPointY

    sta TempPointY2

;--
    lda NewPlayerX
    clc
    adc #3
    cmp TempPointX2 ; Little bit more than just PlayerX
    bcs @exit

    lda NewPlayerX
    clc
    adc #PLAYER_WIDTH - 3 ; and less than a full player width
    cmp TempPointX
    bcc @exit
    beq @exit

    lda NewPlayerY
    cmp TempPointY2 
    bcs @exit

    lda NewPlayerY
    clc
    adc #PLAYER_HEIGHT
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
PlayerHitsNpcs:

    lda current_bank
    sta bankBeforeStatusBarLoad
    ldy #6
    jsr bankswitch_y

    jsr PlayerNpcsHitDectect

    ldy bankBeforeStatusBarLoad
    jsr bankswitch_y

    rts
;------------------------------------
OnBossDefeat:
    lda BossDefeated
    beq @exit ; it's not defeated
    ldy #3
    lda #1
    sta VillagerKilled, y
    sta ModifiedTiles + 2
    sta ModifiedTiles + 3
@exit:
    rts

;-------------------------------------
.segment "ROM6"
;Player's attack box collides with all the npcs
PlayerNpcsHitDectect:

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
;Check if the player is hitting one of the npcs
CheckSingleNpcAgainstPlayerHit:
    lda npcs_ram_lookup, y
    tay

    lda Npcs, y; let's get the state
    and #%00000011 ; ignoring the agitation and damage bits
    sta TempNpcState
    cmp #0
    bne  @cont

    rts ; it's dead
@cont:
    lda Npcs, y ; let's get DB index
    lsr
    lsr
    lsr
    lsr ;eliminate 3 state bits

    sta TempNpcIndex ; state the npc kind for item dropping
    sty TempNpcPosInRam
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
    ldy TempNpcPosInRam

    tya
    clc
    adc #5
    tay
    lda Npcs, y ; screen index where npc resides
    ldy TempNpcPosInRam
    iny

    jsr ScreenFilter
    bne @exit

    lda Npcs, y ; x coord
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
    bne @exit ; only one hit per attack
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
    adc TempNpcWidth
    clc
    adc #4
    sta TempPointX2

    lda TempNpcRows
    asl
    asl
    asl
    clc
    adc TempPointY ; TempPointY2 = rows * 8 + y
    clc
    adc #4
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


    ldy ProjectileIdx
    lda projectiles_ram_lookup, y
    tay

    lda Projectiles, y ; dir + status
    lsr
    bcs @proceed

    rts ; projectile is not active, exit

@proceed:
    iny;x
    iny;x2
    iny;screen

    lda Projectiles, y ; screen
    jsr ScreenFilter
    beq @gogo

    rts ; projectile is not in the same screen, exit

@gogo:

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @ProjectileMatchesScreen
    ;don't match

    dey ;x2
    dey ;x
    lda Projectiles, y ; x
    sec
    sbc ScrollX
    bcs @exit

    jmp @cont
@ProjectileMatchesScreen:

    dey
    dey
    lda Projectiles, y ; x
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX

@cont:
    clc
    adc #4
    sta ProjectileX
    iny ;x2
    iny ;screen
    iny ;y
    lda Projectiles, y ; y
    clc
    adc #4
    sta ProjectileY
    ;--------

    lda TempPointX
    sec
    sbc #4
    cmp TempPointX2
    bcs @checkSecondPoint ; X1 is negative, thus larger than X2

    cmp ProjectileX
    bcs @exit

@checkSecondPoint:
    lda TempPointX2
    cmp TempPointX
    bcc @testX1Again ; X2 is less than X1
    cmp ProjectileX
    bcc @exit
    jmp @testY
@testX1Again:
    lda TempPointX
    sec
    sbc #4
    cmp ProjectileX
    bcs @exit

@testY:
    lda TempPointY
    sec
    sbc #4
    cmp ProjectileY
    bcs @exit

    lda TempPointY2
    cmp ProjectileY
    bcc @exit

    ldy ProjectileIdx
    lda projectiles_ram_lookup, y
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
    adc TempNpcWidth
    sta TempPointX2

    lda TempNpcRows
    asl
    asl
    asl
    clc
    adc TempPointY
    sta TempPointY2 ; TempPointY2 = y + 8 * rows

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
    adc #6 ; go to hp
    tay

@continue:

    inc NpcsHitByPlayer

    jsr CalcPlayerDmg

    lda Npcs, y ; hp
    cmp TempPlayerAttk
    bcc @instaKill

    sbc TempPlayerAttk ;dmg
    sta Npcs, y
    cmp #0
    beq @instaKill

    lda EquipedItem
    cmp #ITEM_SPEAR
    bne @doneDoingDmg

    ;if spear is equiped and you didn't kill the npc
    lda #0
    sta EquipedItem
    sta EquipedItem + 1
    sta SpearData

    jmp @doneDoingDmg



@instaKill:

    lda TempNpcType
    cmp #NPC_TYPE_VILLAGER
    bne @playsfx

    sty TempY
    ldy VillagerIndex
    lda #1
    sta VillagerKilled, y
    ldy TempY

    jsr ClearTextBaloon

@playsfx:
    jsr PlayDamageSfx

    lda #0
    sta Npcs, y ;hp
    dey
    lda #32
    sta Npcs, y ;timer
    dey
    lda #NPC_DEATH_FRAME
    sta Npcs, y ;frame

    tya
    sec
    sbc #7 ; go to status from fame
    tay

    lda Npcs, y
    and #%11110000; drop 4 last bits that stand for status
    sta Npcs, y

    inc NpcsKilledByPlayer


    lda TempNpcIndex
    cmp #NPC_IDX_BOSS
    bne @dropStuff
    lda #1
    sta BossDefeated
    jmp @wearWeapon ; boss not dropping anything

@dropStuff:
    jsr DropItemAfterDeath
    jmp @wearWeapon

@doneDoingDmg:

    jsr PlayDamageSfx

    tya
    sec
    sbc #9 ; going back to status from hp
    tay
    lda Npcs, y
    and #%11110011 ; just clear the bits, preserve the state
    eor #%00001100 ; setting agitation bit + damaged bit

    sta Npcs, y

    lda TempNpcAgitated
    bne @dontAgitateBoss

    lda TempNpcIndex
    cmp #NPC_IDX_BOSS
    bne @dontAgitateBoss

    lda #1
    sta BossAgitated
    jsr ClearTextBaloon

@dontAgitateBoss:
    tya
    clc
    adc #10; go to damage timer
    tay
    lda #0
    sta Npcs, y  ;reset it

    tya
    sec
    sbc #8
    tay

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
;---------------------------------
ClearTextBaloon:

    ldx #95
@loop:
    lda #0
    sta DialogTextContainer, x
    dex
    bne @loop

    lda #1
    sta MustUpdateTextBaloon
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    lda #0
    sta TextBaloonIndex

    rts



;-------------------------------------
DropItemAfterDeath:

    lda NpcsKilledByPlayer
    cmp #2
    bcs @specialRewardItem


    lda TempNpcIndex
    cmp #NPC_IDX_HOUND
    bne @test_Boar
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @hide

    rts

@test_Boar:
    cmp #NPC_IDX_BOAR
    beq @jumbo
    cmp #NPC_IDX_DOGMAN
    bne @nextKind
    rts
@nextKind:
    cmp #NPC_IDX_BJORN
    beq @lamp
    cmp #NPC_IDX_GRANNY
    beq @grannysHead
    cmp #NPC_IDX_ERIKA
    beq @superHammer
    cmp #NPC_IDX_DEADMAN
    beq @key

    ;everything else
    lda #ITEM_RAW_MEAT
    jmp @storeItem
@lamp:
    lda #ITEM_LAMP
    jmp @storeItem
@key:
    lda #ITEM_KEY
    sta TempItemIndex
    lda #<Inventory
    sta pointer2
    lda #>Inventory
    sta pointer2 + 1
    jsr IsItemXInInventory
    bne @exit
    lda #<Storage
    sta pointer2
    lda #>Storage
    sta pointer2 + 1
    jsr IsItemXInInventory
    bne @exit ; I already have the key
    lda #ITEM_KEY
    jmp @storeItem
@grannysHead:
    lda #ITEM_GRANNYS_HEAD
    jmp @storeItem
@superHammer:
    lda #ITEM_HAMMER
    jmp @storeItem

@specialRewardItem:
    ;the dogmen should drop berries/rocks
    lda TempNpcIndex
    cmp #NPC_IDX_DOGMAN
    bne @continueSpecial

    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @berries
    jmp @rock

@continueSpecial:
    jsr UpdateRandomNumber
    and #3
    cmp #2
    bcs @hide
@jumbo:
    lda #ITEM_RAW_JUMBO_MEAT
    jmp @storeItem
@berries:
    lda #ITEM_ROWAN_BERRIES
    jmp @storeItem
@rock:
    lda #ITEM_ROCK
    jmp @storeItem
@hide:
    lda #ITEM_HIDE
@storeItem:

    asl
    ora #1
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

    lda SpearData + 3 ; screen

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

    lda SpearData + 4 ; Y
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

    lda SpearData + 4 ; Y
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
.SEGMENT "ROM6"
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

    lda npcs_ram_lookup, y ; y is npc index
    tay

    lda Npcs, y ; index + agitation + damaged + state
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
    iny
    lda Npcs, y; y
    sta TempPointY ; save y

    ;----
    jsr GetSpriteDataPointer

    lda Temp ; row count
    sta TempRowIndex

    ldy #0

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
    sta pointer
    iny
    lda (ptr_list), y
    sta pointer + 1

    lda TempNpcFrame
    asl
    tay
    lda (pointer), y
    sta character_sprite_data_ptr
    iny
    lda (pointer), y
    sta character_sprite_data_ptr + 1

    rts


;-----------------------------------
CollectSingleNpcData:

    lda Npcs, y
    and #%00000100
    cmp #4 ; damaged ?
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
    lsr ; push out 3bit status and agitation bit

    sty Temp; store Npcs index
    sta TempNpcIndex ; what kind of npc is this ?
    asl
    asl
    asl ; index * 8
    tay
    lda npc_data, y ; tiles per row
    sta TempNpcTilesInARow
    iny
    lda npc_data, y ; tile rows for the npc
    ldy Temp; restore Npcs index

    sta Temp; store tile rows

    tya
    clc
    adc #5
    tay

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
    sbc #7 ; back to npcs's x coord
    tay

@exit:
    rts

;-------------------------------------
;Update two npc sprites
UpdateNpcRow:

    lda TempNpcTilesInARow
    sta CurrentSpritesInRow

@nextSprite:
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

    dec CurrentSpritesInRow
    beq @exit


    lda CurrentSpritesInRow
    asl
    asl
    asl
    clc
    adc TempPointX
    bcs @skipThatSprite

    jmp @nextSprite

@skipThatSprite:

    iny
    iny
    iny
    iny
    dec CurrentSpritesInRow
    bne @nextSprite

@exit:

    rts
;---------------
.SEGMENT "CODE"
doNpcAI:

    ldy NpcCount
    beq @exit ; no npcs here
    dey; npcCount - 1, first index
@npcLoop:

    lda npcs_ram_lookup, y ;npc start
    tax

    lda Npcs, x ;type + active
    and #%00000011
    sta TempNpcState
    cmp #0
    bne @cont ; not dead

;deadState

    txa
    clc
    adc #8 ;go to timer
    tax

    lda Npcs, x
    beq @nextNpc ;ok it's dead-dead
    sec
    sbc #1
    sta Npcs, x

    jmp @nextNpc

@cont:
    jsr FetchNpcVars

    txa
    clc
    adc #5 ; go to screen value
    tax

    lda Npcs, x; screen
    dex
    dex
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
    inx ;x2
    inx ;y
    inx ;y2
    inx ;screen
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
    and #NPC_DAMAGED_BIT
    sta TempNpcDamaged
    lda Npcs, x
    and #NPC_AGITATION_BIT
    sta TempNpcAgitated

    lda Npcs, x ;type & status
    lsr
    lsr
    lsr
    lsr ;strip last 4 bits
    sta TempNpcIndex ;extracted type index
    stx TempIndex
    asl
    asl
    asl
    tax
    stx TempNpcDataIndex
    lda npc_data, x
    asl
    asl
    asl
    sta TempNpcWidth
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

    ;x is at screen index

    lda TempNpcDamaged
    beq @continue

    txa
    clc
    adc #5 ;move to damage timer
    tax
    lda Npcs, x
    clc
    adc #1
    cmp #NPC_DELAY_DAMAGED
    bcs @resetDmgBit
    sta Npcs, x

    txa
    sec
    sbc #5 ; move to screen index
    tax

    jmp @continue

@resetDmgBit:
    txa
    sec
    sbc #10 ; move to index
    tax
    lda Npcs, x
    and #%11111011
    sta Npcs, x
    txa
    clc
    adc #5
    tax

@continue:
    lda TempNpcState
    cmp #NPC_STATE_WARNING  ;npc shows it is about to attack
    beq @warningState
    cmp #NPC_STATE_ATTACK   ;npc is attacking
    beq @attackState

@idleState:
    lda TempNpcType
    cmp #NPC_TYPE_VILLAGER
    beq @changeDir
    cmp #NPC_TYPE_PASSIVE
    beq @rip
    lda TempNpcIndex
    cmp #NPC_IDX_BOSS
    beq @onBoss

    jmp @moveNpc
@rip:
    rts
@onBoss:
    lda TempNpcAgitated
    beq @changeDir  ;  Face the player if not agitated
    jmp @moveNpc

@changeDir:
    jsr ChangeNpcDirection
    jmp @nextNpc
@moveNpc:
    jsr NpcMovement
    jmp @nextNpc

@warningState:
    inx ; dir 
    inx ; frame
    inx ; timer

    lda TempNpcIndex
    cmp #NPC_IDX_BOSS

    beq @bossWarning

    lda Npcs, x
    clc
    adc #1
    sta Npcs, x

    cmp #NPC_DURATION_WARNING
    bcc @nextNpc
    jmp @enterAttackState

@bossWarning:

    lda Npcs, x
    clc
    adc #1
    sta Npcs, x

    cmp #NPC_BOSS_DURATION_WARNING
    bcc @nextNpc
@enterAttackState:
    jsr npcGoToAttackStateFromWarning
    jmp @nextNpc
    ;end of attack warning code
@attackState:
    inx ; dir
    inx ;frame
    inx ;timer
    lda Npcs, x
    clc
    adc #1
    cmp #NPC_DURATION_ATTACK
    bcs @resetState
    sta Npcs, x
    cmp #15; delay between the npc being agitated and actualy attacking player
    beq @damage
    cmp #32
    bcc @nextNpc
@resetAttackFrame:

    dex ;hop back to 'frame'
    lda Npcs, x
    cmp #NPC_IDLE_FRAME
    beq @nextNpc

    lda #NPC_IDLE_FRAME
    sta Npcs, x
    jmp @nextNpc

@resetState: ; exit to IDLE state from whatever state we were in
    jsr ResetNpcState
    jmp @nextNpc

@damage:

    jsr CheckNpcAttackBoxWithPlayer

@nextNpc:

    rts

;---------------------------
npcGoToAttackStateFromWarning:
    txa
    sec
    sbc #8 ; move to state
    tax
    lda Npcs, x
    and #%11111000
    eor #%00000010 ; attack state
    sta Npcs, x
    txa
    clc
    adc #7 ; move to frame
    tax
    lda #NPC_ATTACK_FRAME    ; boss attack frame
    sta Npcs, x
    inx
    lda #0
    sta Npcs, x ; reset the timer

    rts

;--------------------------
;x is at npc timer
ResetNpcState:
    lda #0
    sta Npcs, x ;reset timer

    ;return x from "timer" back to "state"
    txa
    sec
    sbc #8
    tax

    lda Npcs, x
    and #%11111000 ;clear state
    eor #000000001 ;idle state
    sta Npcs, x

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

    lda #1
    sta hadKnockBack
    lda #2
    sta KnockBackDirectionX
    lda #0
    sta KnockBackIndex
    sta KnockBackDirectionY
    sta KnockBackDelay

    jmp @doDmg

@facesLeft:

    jsr CanNpcFacingLeftHitPlayer
    bne @fail

    lda #1
    sta hadKnockBack
    sta KnockBackDirectionX

    lda #0
    sta KnockBackIndex
    sta KnockBackDirectionY
    sta KnockBackDelay

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

    lda #1
    sta hadKnockBack
    sta KnockBackDirectionY
    lda #0
    sta KnockBackDirectionX
    sta KnockBackIndex
    sta KnockBackDelay

    jmp @doDmg

@facesDown:

    jsr CanNpcFacingDownHitPlayer
    bne @fail

    lda #1
    sta hadKnockBack
    lda #0
    sta KnockBackDirectionX
    sta KnockBackIndex
    sta KnockBackDelay
    lda #2
    sta KnockBackDirectionY

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

    ;playerX < NpcX + width + 8 AND playerX + 16 > NpcX
    ;playerY < NpcY + width + 8 AND playerY + 16 > NpcY

    lda TempPointX
    clc
    adc TempNpcWidth
    clc
    adc #8
    cmp PlayerX
    bcc @fail

    lda PlayerX
    clc
    adc #PLAYER_WIDTH
    cmp TempPointX
    bcc @fail

    lda TempPointY
    clc
    adc TempNpcWidth
    clc
    adc #8
    cmp PlayerY
    bcc @fail

    lda PlayerY
    clc
    adc #PLAYER_WIDTH
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
    adc #PLAYER_WIDTH
    cmp TempPointX2
    bcc @fail

    lda TempPointX
    clc
    adc TempNpcWidth
    cmp PlayerX
    bcc @fail


    lda TempNpcRows
    asl
    asl
    asl
    clc
    adc TempPointY

    cmp PlayerY
    bcc @fail

    lda PlayerY
    clc
    adc #PLAYER_HEIGHT
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
    adc #PLAYER_WIDTH
    cmp TempPointX
    bcc @fail

    lda TempPointX
    clc
    adc TempNpcWidth
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
    adc #PLAYER_WIDTH
    cmp TempPointX
    bcc @fail

    lda TempPointX
    clc
    adc TempNpcWidth
    cmp PlayerX
    bcc @fail

    lda PlayerY
    clc
    adc #PLAYER_HEIGHT
    cmp TempPointY
    bcc @fail


    lda TempNpcRows
    clc
    adc #1
    asl
    asl
    asl
    clc
    adc TempPointY ; y + (rows + 1) * 8

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
    lda #0
    sta TempNpcMovesDiagonaly
    inx
    lda Npcs, x ; load dir
    sta TempDir
    ;let's detect if the npc moves diagonaly
    cmp #4
    bcc @notDiagonalDir
    and #%00000011
    beq @notDiagonalDir
    lda #1
    sta TempNpcMovesDiagonaly
@notDiagonalDir:
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

    txa
    sec
    sbc #7 ;move from 'timer' to 'x coord'
    tax
    stx NpcXPosition ; index at x

    lda TempNpcMovesDiagonaly
    beq @movesNormaly
    lda #NPC_SPEED_DIAG
    sta TempNpcSpeed
    lda #NPC_SPEED_DIAG_FRACTION
    sta TempNpcSpeed + 1
@movesNormaly:
    lda #NPC_SPEED
    sta TempNpcSpeed
    lda #NPC_SPEED_FRACTION
    sta TempNpcSpeed + 1


    lda TempNpcType
    cmp #NPC_TYPE_TIMID
    bne @continue_move
    lda TempNpcIndex
    cmp #NPC_IDX_BUNNY
    bne @continue_move
    jsr CheckAgitationByPlayer

    dex; state (was at x coord)
    lda Npcs, x ; index and stuff
    and #NPC_AGITATION_BIT ; check the agitation bit
    beq @done_timid ; not agitated

    lda TempNpcMovesDiagonaly
    beq @movesnormalyagitated
    lda #NPC_SPEED_AGITATED_DIAG ; if agitated, go realy fast
    sta TempNpcSpeed
    lda #NPC_SPEED_AGITATED_DIAG_FRACTION
    sta TempNpcSpeed + 1
@movesnormalyagitated:
    lda #NPC_SPEED_AGITATED ; if agitated, go realy fast
    sta TempNpcSpeed
    lda #NPC_SPEED_AGITATED_FRACTION
    sta TempNpcSpeed + 1
@done_timid:
    inx
@continue_move:
    ;Calculate npcs new X and Y using the movement direction
    ;----------
    ;store the new coordinates, because there might not be any direction
    ;but we still need the collision detection working

    lda Npcs, x ; x integer part
    sta NewNpcX
    inx
    lda Npcs, x ; fraction
    sta NewNpcX + 1
    inx
    lda Npcs, x ; y integer part
    sta NewNpcY
    inx
    lda Npcs, x ; y fraction
    sta NewNpcY + 1
    inx
    lda Npcs, x ; screen
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

    inx
    lda Npcs, x ; load x fraction
    clc
    adc TempNpcSpeed + 1
    sta NewNpcX + 1
    dex
    lda Npcs, x ; load x
    adc TempNpcSpeed
    bcs @IncreaseScreen
    sta NewNpcX

    jmp @movesVerticaly

@IncreaseScreen:
    sta NewNpcX
    ;increase npc screen if needed

    inx ;x2
    inx ;y
    inx ;y2
    inx ;screen
    lda Npcs, x
    clc
    adc #1
    sta NewNpcScreen

    jmp @movesVerticaly

@movingLeft:
    ;calculate X going left

    inx
    lda Npcs, x ; load x fraction
    sec
    sbc TempNpcSpeed + 1
    sta NewNpcX + 1
    dex
    lda Npcs, x ; load x
    sbc TempNpcSpeed
    bcc @DecreaseScreen

    sta NewNpcX
    jmp @movesVerticaly

@DecreaseScreen:

    sta NewNpcX
    ;decrease npc screen if needed
    inx ;x2
    inx ;y
    inx ;y2
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
    inx
    inx ; move to y
    inx ; fraction
    lda Npcs, x ; y coord fraction

    sec
    sbc TempNpcSpeed + 1
    sta NewNpcY + 1
    dex ;main y
    lda Npcs, x; y
    sbc TempNpcSpeed
    sta NewNpcY

    jmp @doneCallculation
@movesDown:
    cmp #2
    bne @doneCallculation

    ;calculate Y going down

    ldx NpcXPosition
    inx
    inx ; move to y
    inx ; fraction
    lda Npcs, x ; y coord
    clc
    adc TempNpcSpeed + 1
    sta NewNpcY + 1
    dex
    lda Npcs, x
    adc TempNpcSpeed
    sta NewNpcY


@doneCallculation:
    ;--------------
    ;let's check collision with the player
    ldx NpcXPosition
    inx ;x2
    inx ;y
    inx ;y2
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
    lda NewNpcY + 1
    dex
    sta Npcs, x ; y fraction
    dex ;y
    lda NewNpcY
    sta Npcs, x ; integer y

    jmp @nextNpc
@goDown:
    cmp #2
    bne @nextNpc
    jsr TestCollisionGoingVerticaly
    cmp #1
    beq @changeDir
    dex ;y2
    lda NewNpcY + 1
    sta Npcs, x ; y fraction
    dex ;y
    lda NewNpcY
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

    inx ; y2
    inx ; y
    lda Npcs, x ; y coord
    cmp TempPlayerRangeY2
    bcs @exit

    lda Npcs, x ; y coord
    clc
    adc #16
    cmp TempPlayerRangeY1
    bcc @exit
;--
    ldx TempRegX ; at x
    dex ;state
    ;set agitated
    lda Npcs, x
    and #%11110111
    eor #NPC_AGITATION_BIT
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

    inx
    inx ;y
    inx ;
    inx ;screen
    sta Npcs, x ;save screen
    ldx NpcXPosition

    jmp @YMovement

@notRight:
    cmp #2
    bne @YMovement
@goLeft:

    lda NewNpcX
    jsr TestCollisionGoingLeft
    cmp #1 
    beq @changeDir ;collides
    jsr SaveX ; sets x to x coord

    lda NewNpcScreen
    cmp ScreenCount
    bcs @changeDir

    inx ;x2
    inx ;y
    inx ;y2
    inx ;screen
    sta Npcs, x ;save the screen
    ldx NpcXPosition

    jmp @YMovement

@changeDir:
    lda #1
    sta MustRedir

@YMovement:
    rts

;--------------------------
SaveX:
    ldx NpcXPosition
    lda NewNpcX
    sta Npcs, x ;save x
    inx
    lda NewNpcX + 1
    sta Npcs, x
    ldx NpcXPosition

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
    beq @storeDirection ; if 0 in register A

    ;else do random
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

    stx TempScreenPos

    txa
    sec
    sbc #5 ;from screen to npc status
    tax

    lda Npcs, x
    and #NPC_AGITATION_BIT ; check the agitation bit
    beq @doRandom  ; if not set move randomly


@done:
    ldx TempScreenPos
    jsr SetDirectionsForPredatorNpc
    lda #0
    jmp @end

@doRandom:

    ldx TempScreenPos
    lda #1
@end:


    rts


;------------------------------
;preparation for direction change for predator npc
;x reg value is at the x coordinate index of that npc
PredatorDirectionChangePrep:

    lda TempNpcWidth
    lsr ; middle of width
    clc
    adc Npcs, x; x coord

    sta TempPointX
    inx
    inx

    lda TempNpcRows
    cmp #3
    bcs @minusOne ; if more than 2 rows subtract 1
    jmp @cont
@minusOne:
    sec
    sbc #1
@cont: ;rows * 8
    asl
    asl
    asl
    clc
    adc Npcs, x; y
    sta TempPointY

    inx ;y2
    inx ;screen
    inx ;direction

    lda PlayerX
    clc
    adc #PLAYER_WIDTH
    sta Temp

    lda #0
    sta TempDir

    lda PlayerY
    clc
    adc #PLAYER_HEIGHT
    sta TempPlayerY2

    lda PlayerY
    clc
    adc #8
    sta PlayerCenterY

    rts

;-------------------------------
SetDirectionsForPredatorNpc:

    dex ; y2
    dex ; y
    dex ; x2
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
    ;x is at screen
    txa
    sec
    sbc #5 ; go back to status
    tax
    lda Npcs, x
    and #NPC_AGITATION_BIT ; is npc agitated ?
    beq @doRandom  ; no ? then move randomly

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
    inx ;x2
    inx ;y
    inx ;y2
    inx ;screen
    inx ;direction

    lda PlayerX
    clc
    adc #PLAYER_WIDTH
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
    adc #PLAYER_HEIGHT
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
    txa
    clc
    adc #5 ; move to 'screen' from 'status'
    tax
    lda #1
@end:

    rts

;----------------------
TestCollisionGoingRight:
    sta TempX ; save modified x
    clc
    adc TempNpcWidth ; npc width
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
    inx
    lda Npcs, x ;y
    clc
    adc TempYOffset
    sta TempPointY

    jsr TestPointAgainstCollisionMap
    ldx NpcXPosition
    inx ;x2
    inx ;y
    inx ;y2
    inx ;screen
    ;collision result is in A

    rts
;----------------------------------
TestCollisionGoingLeft:
    stx TempIndex ; save x reg
    sta TempX
    sta TempPointX
    inx
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
    inx ;y
    inx
    inx ; screen
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
    adc TempNpcWidth
    sec
    sbc #4 ;2+2 from both sides
    sta TempPointX
    lda NewNpcScreen
    sta TempScreen
    jsr TestPointAgainstCollisionMap

@exit:
    ldx NpcXPosition
    inx ; x2
    inx ; y
    inx ; y2
    inx ; screen

    rts
;-----------------------------------------------------
;does an npc collide with the player
OnCollisionWithPlayer:
    ;x is at screen
    ;calc player box
    lda PlayerX
    clc
    adc #PLAYER_WIDTH - 3  ;bit less than full player width
    sta TempX

    lda PlayerX
    clc
    adc #3
    sta TempPointX2 ; bit more than just PlayerX

    lda PlayerY
    clc
    adc #PLAYER_HEIGHT
    sta TempY
    ;---------------

    lda NewNpcY
    sta TempPointY

;----x position to check
    lda NewNpcX
    sec
    sbc ScrollX
    sta TempPointX
;-----

    lda TempNpcRows
    sec
    sbc #1
    asl
    asl
    asl ;(row_count - 1) * 8
    clc
    adc TempPointY
    sta TempPointY2

;--collision check
    lda TempPointX ;npc min x
    cmp TempX      ;player max x
    bcs @exit

    lda TempPointX
    clc
    adc TempNpcWidth
    cmp TempPointX2
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
    ;lda Npcs, x

    ;and #%00000111
    ;cmp #NPC_STATE_DAMAGED
    ;beq @collides ; don't attack if in damaged state

    lda Npcs, x     ;  reload the status
    and #%11111100  ;  remove previous status
    eor #NPC_STATE_WARNING  ;  set the warning state
    sta Npcs, x

    txa
    clc
    adc #7 ;move from "state" to "frame"
    tax 

    lda #NPC_WARNING_FRAME
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
    lda #SFX_WEAPON_BREAKS
    sta SfxName
    lda #1
    sta MustPlaySfx
    jmp @exit


@noclothing:
    lda #<HP
    sta DigitPtr
    lda #>HP
    sta DigitPtr + 1
    jsr DecreaseDigits
    lda #1
    sta HpUpdated
    sta MustUpdatePalette
    ldy #PLAYER_OUTLINE_COLOR_POS
    lda #COLOR_DARK_RED
    sta RamPalette, y
    lda #PLAYER_DAMAGED_DELAY
    sta PlayerDamagedCounter
    lda #PALETTE_SIZE_MAX
    sta PaletteUpdateSize

@exit:

    rts





