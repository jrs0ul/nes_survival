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

    lda CurrentMapSegmentIndex
    bne @exit

    ldy #0
@itemLoop:
    tya
    asl
    asl ;y * 4
    tax
    lda Items, x ; active?
    beq @nextItem
    inx
    lda Items, x ;x
    sec
    sbc GlobalScroll
    sta TempPointX
    lda PlayerX
    clc
    adc #8
    cmp TempPointX
    bcs @checkX2
    jmp @nextItem
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
    bcs @nextItem

    inx
    lda Items, x ;y
    sta TempPointY
    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcs @checkY2
    jmp @nextItem
@checkY2:

    lda Items, x
    clc
    adc #16
    sta TempPointY
    lda PlayerY
    clc
    adc #16
    cmp TempPointY
    bcs @nextItem

    jsr AddAndDeactivateItems

@nextItem:
    iny
    cpy ItemCount
    bcc @itemLoop

@exit:
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
    inx
    lda Items, x
    sta Inventory, y
    ldy TempY

    tya
    asl
    asl
    tax
    lda #0
    sta Items, x
@exit:
    ldy TempY
    rts

;-----------------------------------------

UpdateItemSpritesInWorld:
;X register stores sprite data byte index (sprites are made of 4 bytes)

    inx ;next sprite byte
    
    lda CurrentMapSegmentIndex
    bne @exit

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
    lda Items, y ; is item active
    beq @exit
    iny
    lda Items, y ; x coord
    cmp GlobalScroll
    bcc @exit ;don't let the item reappear after you scrolled forward
    iny
    lda Items, y ; y coord
    sta FIRST_SPRITE, x
    inx; next byte

    iny
    lda Items, y ; item index
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
    lda Items, y
    sec
    sbc GlobalScroll
    sta FIRST_SPRITE, x
    ;x
    inx
    iny
    lda Items, y
    sta FIRST_SPRITE, x
    inc TempSpriteCount
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
    dey
    lda Items, y
    clc
    adc #8
    sec
    sbc GlobalScroll
    sta FIRST_SPRITE, x
    inx
    inc TempSpriteCount
@exit:
    rts
