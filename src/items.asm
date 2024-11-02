;-------------------------------------
;Load Items from ROM data to RAM
;ItemListPtr points to the items data
LoadItems:
    ldy #0
    lda (ItemListPtr), y
    sta ItemCount
    lda ItemCount
    beq @exit   ; no items
    iny
    ldx #0
@itemLoop:

    stx TempItemLoadX
    sty TempItemLoadY
    ldy LocationIndex
    lda LocationItemIndexes, y
    ldy TempItemLoadY
    clc
    adc TempItemLoadX
    tax
    lda Item_Location1_Collection_times, x
    ldx TempItemLoadX
@checkDay:
    sta Temp
    cmp #ITEM_NEVER_BEEN_PICKED
    beq @loadIt


    lda LocationsWithRespawnableItems, y
    beq @deactivatedItem

    lda Hours
    sec
    sbc Temp
    cmp #ITEM_RESPAWN_HOURS
    bcc @deactivatedItem

@loadIt:
    txa
    asl
    asl
    tay
    iny


    lda (ItemListPtr), y ; id + status
    dey
    sta Items, y

    lsr
    asl
    asl
    sty TempPointY
    tay
    iny
    iny
    lda item_data, y
    cmp #ITEM_TYPE_DOCUMENT
    bne @notDocument

    lda Temp
    cmp #ITEM_NEVER_BEEN_PICKED
    bne @deactivatedItem

@notDocument:
   ldy TempPointY

    iny
    iny
    lda (ItemListPtr), y ; screen
    dey
    sta Items, y
    iny
    iny
    lda (ItemListPtr), y
    dey
    sta Items, y
    iny
    iny
    lda (ItemListPtr), y
    dey
    sta Items, y
    jmp @decrementItemIndex

@deactivatedItem:
    jsr DeactivatedItem

@decrementItemIndex:
    inx
    cpx ItemCount
    bcc @itemLoop
@exit:

    rts
;--------------------------------------
DeactivatedItem:
    txa
    asl
    asl
    tay
    iny


    lda #0
    dey
    sta Items, y
    iny
    sta Items, y
    iny
    sta Items, y
    iny
    sta Items, y

    rts


;--------------------------------------
ItemCollisionCheck:
    lda #ITEM_DELAY
    sta ItemUpdateDelay

    lda ItemCount
    beq @exit

    lda current_bank
    sta bankBeforeStatusBarLoad

    ldy #6
    jsr bankswitch_y

    jsr ItemCollision

    ldy bankBeforeStatusBarLoad
    jsr bankswitch_y
@exit:

    rts


;======================================================
.segment "ROM6"
ItemCollision:

    lda PlayerX
    clc
    adc #4
    sta TempPlayerRangeX1
    lda PlayerX
    clc
    adc #12
    sta TempPlayerRangeX2

    ldy #0
@itemLoop:
    tya
    asl
    asl ;y * 4
    tax
    lda Items, x ; index + active?
    lsr
    bcc @nextItem ; inactive
    inx
    lda Items, x ;screen index
    inx

    jsr ScreenFilter
    bne @nextItem

    jsr CheckItemsXY

@nextItem:
    iny
    cpy ItemCount
    bcc @itemLoop

@exit:
    rts

;----------------------------------
CheckItemsXY:

    lda Items, x ; x coord
    sta TempX

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @ItemMatchesScreen

    lda TempX
    sec
    sbc ScrollX
    bcs @exit ; x > 255 ?
    sta TempPointX
    lda TempPlayerRangeX2 ; playerx + 12
    cmp TempPointX
    bcc @exit

@checkX2:
    lda TempX ; itemx
    clc
    adc #16
    sec
    sbc ScrollX
    bcs @exit ; x > 255 ?
    sta TempPointX
    lda TempPlayerRangeX1 ; playerx + 4
    cmp TempPointX
    bcs @exit
    jmp @checkY

@ItemMatchesScreen:

    lda TempX
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX
    sta TempPointX

    lda TempPlayerRangeX2 ; playerx + 12
    cmp TempPointX
    bcc @exit

@CheckX2Match:

    sty TempIndex
    lda TempX
    clc
    adc #16
    bcc @cont

@checkIfLastScreen:

    jsr LastScreenCheck
    bcs @clamp ; if on last screen, then clamp
    lda TempPointX2 ;restore max item X
    jmp @cont
@clamp:
    lda #255
@cont:
    ldy TempIndex
    sec
    sbc ScrollX

    sta TempPointX
    lda TempPlayerRangeX1 ;playerx + 4
    cmp TempPointX
    bcs @exit
@checkY:
    jsr CheckYPoints
@exit:
    rts
;----------------------------------
LastScreenCheck:
    sta TempPointX2
    ldy LocationIndex
    lda CurrentMapSegmentIndex
    clc
    adc #1
    cmp LocationScreenCountList, y


    rts

;-----------------------------------
CheckYPoints:

    inx
    lda Items, x ;y coordinate
    sta TempPointY
    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcs @checkY2
    jmp @exit

@checkY2:

    lda Items, x
    clc
    adc #16
    sta TempPointY
    lda PlayerY
    clc
    adc #10
    cmp TempPointY
    bcs @exit

    jsr AddAndDeactivateItems
@exit:

    rts

;-----------------------------------
AddAndDeactivateItems:

    sty TempY ; store item index

    ldy #0 
@inventoryLoop:
    lda Inventory, y
    beq @addItem
    iny ;item's hp
    iny
    cpy #INVENTORY_MAX_SIZE
    bcc @inventoryLoop
    jmp @playInventoryFull ; no place in the inventory?

@addItem:
    sty Temp  ; store empty inventory slot


    lda #SFX_ITEM_PICKUP
    sta SfxName
    lda #1
    sta MustPlaySfx

    ;let's store the time when the item was picked up
    ldy LocationIndex
    lda LocationItemCounts, y
    beq @continueAdding  ; item is generated, not loaded
    cmp TempY
    beq @continueAdding
    bcc @continueAdding  ; also a generated item

    lda LocationItemIndexes, y
    clc
    adc TempY ; add item index
    tay

    lda Hours
    sta Item_Location1_Collection_times, y

@continueAdding:
    ldy TempY
    tya
    asl
    asl
    tax
    ;put to inventory
    lda Items, x
    lsr
    sta TempItemIndex
    tay
    lda important_items, y
    beq @not_important
    ;it's important
    lda #IMPORTANT_ITEM_TIME
    sta ImportantItemTimer
    lda #5
    sta PlayerAnimationRowIndex
    lda #2
    sta PlayerFrame
    lda #0
    sta AttackTimer

    lda TempItemIndex
    asl
    asl
    tay
    lda item_data, y
    sta ImportantItemTile
    iny
    lda item_data, y
    sta ImportantItemPaletteIdx
@not_important:
    lda TempItemIndex
    ldy Temp
    sta Inventory, y
    iny
    lda #ITEM_MAX_HP
    sta Inventory, y
    ;deactivate
    lda Items, x
    and #%11111110
    sta Items, x

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    bne @exit

    ldy VillagerIndex
    lda TakenQuestItems, y
    bne @checkSpecialReward ; quest item is already taken, so must be something else
    jsr GetItemIdForTheQuest
    cmp TempItemIndex
    bne @checkSpecialReward

    ldy VillagerIndex
    sta TakenQuestItems, y
    jmp @exit

@checkSpecialReward:
    ldy #MAX_VILLAGERS
@villagerLoop:
    dey
    bmi @checkReward ; maybe it's a generic reward then ?
    lda special_receivers, y
    cmp VillagerIndex
    bne @villagerLoop

    lda CompletedSpecialQuests, y
    bne @villagerLoop ; the quest already completed

    lda #1
    ldy VillagerIndex
    sta SpecialQuestReceiverRewardTaken, y
    jmp @exit

@checkReward: ; check if it is a quest reward you've taken
    lda VillagerIndex
    asl
    asl
    clc
    ldy VillagerIndex
    adc ActiveVillagerQuests, y
    tay
    lda reward_items_list, y
    cmp TempItemIndex
    bne @exit

    ldy VillagerIndex
    lda #1
    sta QuestRewardsTaken, y

    jmp @exit

@playInventoryFull:
    lda ScrollX
    cmp FullInventoryScrollX
    bne @play
    lda PlayerX
    cmp FullInventoryPlayerX
    bne @play
    lda PlayerY
    cmp FullInventoryPlayerY
    beq @exit
@play:
    lda ScrollX
    sta FullInventoryScrollX
    lda PlayerX
    sta FullInventoryPlayerX
    lda PlayerY
    sta FullInventoryPlayerY

    lda #SFX_INVENTORY_FULL
    sta SfxName
    lda #1
    sta MustPlaySfx


@exit:
    ldy TempY
    rts
.segment "CODE"
;-------------------------------------
;TempPointX2 - 255 if times are set for the first time
ResetTimesWhenItemsWerePicked:

    ldy #0
    lda current_bank
    sta bankBeforeItemReset
@loop:
    lda LocationItemCounts, y
    beq @nextLocation
    tax
    dex
    stx TempItemLoadX

    sty TempPointY
    tya
    asl
    tay
    lda LocationItems, y
    sta pointer
    iny
    lda LocationItems, y
    sta pointer + 1

    ldy TempPointY
    lda LocationBanks, y
    tay
    jsr bankswitch_y
    ldy TempPointY

    lda InitiateCompleteItemRespawn
    bne @location_loop
    lda LocationsWithRespawnableItems, y
    beq @nextLocation

@location_loop:

    lda TempPointX2
    cmp #255
    beq @just_reset_it

    sty TempPointY

    lda TempItemLoadX ;item index * 4 + 1
    asl
    asl
    clc
    adc #1
    tay
    lda (pointer), y ; item id + status
    lsr ; strip status
    asl
    asl
    tay
    iny
    iny ; item type
    lda item_data, y ; get the type
    cmp #ITEM_TYPE_DOCUMENT
    beq @next_item

    ldy TempPointY
@just_reset_it:
    lda LocationItemIndexes, y
    clc
    adc TempItemLoadX
    tax
    lda #ITEM_NEVER_BEEN_PICKED
    sta Item_Location1_Collection_times, x

@next_item:
    ldy TempPointY
    dec TempItemLoadX
    bpl @location_loop

@nextLocation:
    iny
    cpy #MAX_LOCATIONS
    bcc @loop

    ldy bankBeforeItemReset
    jsr bankswitch_y

    rts


;===================================================
.SEGMENT "ROM6"
;update sprites from ItemCount-1 to 0
UpdateItemSpritesInWorldZtoA:

    ldy ItemCount
    beq @exit ; no items
    dey ;let's start from ItemCount - 1
@itemLoop:

    sty TempItemIndex
    jsr UpdateSpritesForSingleItem

@nextItem:
    ldy TempItemIndex
    dey
    bpl @itemLoop

@exit:
    rts
;----------------------------------------
;Update sprites from 0 to ItemCount-1
UpdateItemSpritesInWorldAtoZ:

    ldy #0
    cpy ItemCount
    beq @exit
@itemLoop:
    sty TempItemIndex
    jsr UpdateSpritesForSingleItem
@nextItem:
    ldy TempItemIndex
    iny
    cpy ItemCount
    bcc @itemLoop
@exit:
    rts

;----------------------------------------
UpdateSpritesForSingleItem:
;X register stores sprite data byte index (sprites are made of 4 bytes)

    tya
    asl
    asl ; y * 4
    tay
    lda Items, y ; item index + is active ?
    lsr
    bcc @exit ;lowest bit was zero, item's not active
    sta TempZ ; store item DB index

    iny
    lda Items, y; Item map screen index
    jsr ScreenFilter
    bne @exit

    iny
    lda Items, y ; x coord
    sta TempX
;---
    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @ItemMatchesScreen
    lda TempX
    sec
    sbc ScrollX
    bcs @exit ; x > 255
    sta Temp; save new x
    jmp @continueWithSprite
@ItemMatchesScreen:
    lda TempX
    cmp ScrollX
    bcc @exit
    sec
    sbc ScrollX
    sta Temp
@continueWithSprite:

    jsr UpdateItemSprites
@exit:
    rts
;-----------------------

UpdateItemSprites:
    iny
    lda Items, y ; y coord
    sta TempPointY

    lda TempZ ; item index
    asl
    asl; a * 4
    tay
    lda item_data, y ;tile index
    sta TempZ
    iny
    lda item_data, y
    sta TempPointX; store palette index


    lda #0
    sta TempY ; sprite index (0 or 1)

@spriteloop:
    lda TempPointY
    sta FIRST_SPRITE, x ;y
    inx
    lda TempZ ;frame
    clc
    adc TempY
    sta FIRST_SPRITE, x
    inx
    lda TempPointX 
    sta FIRST_SPRITE, x; ;write attributes
    inx
    lda Temp ;x
    sta FIRST_SPRITE, x
    ;x
    inx
    inc TempSpriteCount
;--------------
    lda Temp
    clc
    adc #8
    bcs @exit ; x > 255
    sta Temp

    lda TempY
    clc
    adc #1
    sta TempY
    cmp #2
    bcc @spriteloop


  @exit:

    rts

.SEGMENT "CODE"

