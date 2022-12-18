;-------------------------------------
;Load Items from ROM data to RAM
;pointer points to the items data
LoadItems:
    ldy #0
    lda (pointer), y
    sta ItemCount
    ldx ItemCount
    beq @exit
    iny
@itemLoop:
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
    iny
    iny
    dex
    bne @itemLoop
@exit:

    rts
;--------------------------------------------
ItemCollisionCheck:
    lda #ITEM_DELAY
    sta ItemUpdateDelay

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
    inx
    inx
    lda Items, x ;screen index
    jsr CalcItemMapScreenIndexes
    dex
    dex

    lda ItemMapScreenIndex
    beq @skipPrev; the item is in the 0 screen

    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @nextItem
@skipPrev:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @nextItem

    jsr CheckItemsXY

@nextItem:
    iny
    cpy ItemCount
    bcc @itemLoop

@exit:
    rts
;----------------------------------
CheckItemsXY:
    lda Items, x ;x
    sec
    sbc GlobalScroll
    sta TempPointX
    lda PlayerX
    clc
    adc #8
    cmp TempPointX
    bcs @checkX2
    jmp @exit
@checkX2:
    lda Items,x
    clc
    adc #16
    sec
    sbc GlobalScroll
    sta TempPointX
    lda PlayerX
    clc
    adc #8
    cmp TempPointX
    bcs @exit

    inx
    lda Items, x ;y
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
    adc #16
    cmp TempPointY
    bcs @exit

    jsr AddAndDeactivateItems
@exit:
    rts

;-----------------------------------
CalcItemMapScreenIndexes:
    sta ItemMapScreenIndex
    clc
    adc #1
    sta NextItemMapScreenIndex
    sec
    sbc #2
    sta PrevItemMapScreenIndex

    rts
;-----------------------------------
AddAndDeactivateItems:
    sty TempY

    ldy #INVENTORY_MAX_ITEMS - 1
@inventoryLoop:
    lda Inventory, y
    beq @addItem
    dey
    bpl @inventoryLoop
    jmp @exit ; no place in the inventory?

@addItem:
    sty Temp  ; store empty inventory slot
    ldy TempY ; item index
    tya
    asl
    asl
    tax
    ;put to inventory
    lda Items, x
    lsr
    ldy Temp
    sta Inventory, y
    ;deactivate
    lda Items, x
    and #%11111110
    sta Items, x
@exit:
    ldy TempY
    rts

;-----------------------------------------

UpdateItemSpritesInWorld:
;X register stores sprite data byte index (sprites are made of 4 bytes)

    inx ;next sprite byte
    
    ldy ItemCount
    dey ;let's start from ItemCount - 1
@itemLoop:

    jsr UpdateSpritesForSingleItem

@nextItem:
    ldy TempItemIndex
    dey
    bpl @itemLoop

@exit:
    rts

;----------------------------------------
UpdateSpritesForSingleItem:

    sty TempItemIndex
    tya
    asl
    asl ; y * 4
    tay
    lda Items, y ; item index + is active ?
    lsr
    bcc @exit ;lowest bit was zero, item's not active
    sta TempZ ; store item DB index

    iny
    iny
    iny
    lda Items, y; Item map screen index
    jsr CalcItemMapScreenIndexes
    dey
    dey
    dey


    lda ItemMapScreenIndex
    beq @skipPrev; the item is in the 0 screen

    lda CurrentMapSegmentIndex
    cmp PrevItemMapScreenIndex
    bcc @exit
@skipPrev:
    lda CurrentMapSegmentIndex
    cmp NextItemMapScreenIndex
    bcs @exit

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

    jsr FinishFirstItemPart
    ;------------------------------------
    jsr SecondItemSpritePart
@exit:
    rts
;-----------------------

FinishFirstItemPart:
    iny
    lda Items, y ; y coord
    sta FIRST_SPRITE, x
    inx; next byte

    iny
    lda TempZ ; item index
    asl
    asl; a * 4
    sty TempY; store item index
    tay

    lda inventory_data, y ;tile index
    sta TempZ
    sta FIRST_SPRITE, x
    iny
    lda inventory_data, y
    sta TempPointX; store palette index
    ldy TempY ;restore item index

    inx
    sta FIRST_SPRITE, x; ;write attributes
    inx
    
    dey
    dey
    ;--

    lda Temp
    sta FIRST_SPRITE, x
    ;x
    inx
    iny
    lda Items, y
    sta FIRST_SPRITE, x
    inc TempSpriteCount

    rts

;----------------------
SecondItemSpritePart:
    lda Temp
    clc
    adc #8
    bcs @exit ; x > 255
    sta Temp

    ;y
    inx
    ;idx
    lda TempZ
    clc
    adc #1
    sta FIRST_SPRITE, x
    inx
    ;att
    lda TempPointX
    sta FIRST_SPRITE, x
    inx
    ;x
    lda Temp

    sta FIRST_SPRITE, x
    inx
    inc TempSpriteCount
@exit:
    rts
