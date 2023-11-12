;-------------------------------------
;Load Items from ROM data to RAM
;pointer points to the items data
LoadItems:
    ldy #0
    lda (pointer), y
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
    cmp #ITEM_NEVER_BEEN_PICKED
    beq @loadIt

    sta Temp

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


    lda (pointer), y
    dey
    sta Items, y
    iny
    iny
    lda (pointer), y
    dey
    sta Items, y
    iny
    iny
    lda (pointer), y
    dey
    sta Items, y
    iny
    iny
    lda (pointer), y
    dey
    sta Items, y
    jmp @decrementItemIndex

@deactivatedItem:
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
    
@decrementItemIndex:
    inx
    cpx ItemCount
    bcc @itemLoop
@exit:

    rts
;======================================================
ItemCollisionCheck:
    lda #ITEM_DELAY
    sta ItemUpdateDelay

    lda ItemCount
    beq @exit

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
;TODO: Optimize !!!!
CheckItemsXY:

    lda Items, x
    sta TempX

    lda CurrentMapSegmentIndex
    cmp ItemMapScreenIndex
    beq @ItemMatchesScreen

    lda TempX
    sec
    sbc GlobalScroll
    bcs @exit ; x > 255 ?
    sta TempPointX
    lda PlayerX
    clc
    adc #12
    cmp TempPointX
    bcs @checkX2
    jmp @exit

@checkX2:
    lda TempX
    clc
    adc #16
    sec
    sbc GlobalScroll
    bcs @exit ; x > 255 ?
    sta TempPointX
    lda PlayerX
    clc
    adc #4
    cmp TempPointX
    bcs @exit
    jmp @checkY

@ItemMatchesScreen:
    lda TempX
    cmp GlobalScroll
    bcc @exit
    sec
    sbc GlobalScroll
    sta TempPointX
    lda PlayerX
    clc
    adc #12
    cmp TempPointX
    bcs @CheckX2Match
    jmp @exit
@CheckX2Match:

    sty TempIndex
    lda TempX
    clc
    adc #16
    bcs @checkIfLastScreen
    jmp @cont
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
    sbc GlobalScroll

    sta TempPointX
    lda PlayerX
    clc
    adc #4
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

;-------------------------------------
ResetTimesWhenItemsWerePicked:

    ldy #0
@loop:
    lda LocationItemCounts, y
    beq @nextLocation
    tax
    dex
    stx TempItemLoadX

@location_loop:

    lda LocationItemIndexes, y
    clc
    adc TempItemLoadX
    tax

    lda #ITEM_NEVER_BEEN_PICKED
    sta Item_Location1_Collection_times, x

    dec TempItemLoadX
    bpl @location_loop

@nextLocation:
    iny
    cpy #MAX_LOCATIONS
    bcc @loop

    rts

;-----------------------------------
AddAndDeactivateItems:

    sty TempY

    ldy #0 
@inventoryLoop:
    lda Inventory, y
    beq @addItem
    iny ;item's hp
    iny
    cpy #INVENTORY_MAX_SIZE
    bcc @inventoryLoop
    jmp @exit ; no place in the inventory?

@addItem:
    sty Temp  ; store empty inventory slot

    ldy current_bank
    sty oldbank
    ldy #6
    jsr bankswitch_y
    lda #0
    ldx #FAMISTUDIO_SFX_CH1
    jsr famistudio_sfx_play
    ldy oldbank
    jsr bankswitch_y


    ;let's store the time when the item was picked up
    ldy LocationIndex
    lda LocationItemCounts, y
    beq @continueAdding; item is generated, not loaded
    cmp TempY
    beq @continueAdding
    bcc @continueAdding; also a generated item

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
    ldy Temp
    sta TempItemIndex
    sta Inventory, y
    iny
    lda #ITEM_MAX_HP
    sta Inventory, y
    ;deactivate
    lda Items, x
    and #%11111110
    sta Items, x

    lda InVillagerHut
    beq @exit

    ldy VillagerIndex
    jsr GetItemIdForTheQuest
    cmp TempItemIndex
    bne @exit

    ldy VillagerIndex
    sty SpecialItemOwner
    sta TakenQuestItems, y

@exit:
    ldy TempY
    rts

;===================================================
.SEGMENT "ROM1"
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
    sbc GlobalScroll
    bcs @exit ; x > 255
    sta Temp; save new x
    jmp @continueWithSprite
@ItemMatchesScreen:
    lda TempX
    cmp GlobalScroll
    bcc @exit
    sec
    sbc GlobalScroll
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

