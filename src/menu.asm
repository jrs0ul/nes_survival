LoadMenu:

    lda MustLoadMenu
    beq @exit
    
    ldy #1
    jsr bankswitch_y

    lda #$00
    sta $2000
    sta $2001

    lda #<menu_screen
    sta pointer
    lda #>menu_screen
    sta pointer + 1

    lda FirstNametableAddr
    sta NametableAddress

    jsr LoadNametable

    lda #<menu_palette
    sta pointer
    lda #>menu_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette


    jsr UpdateMenuStats

    lda #0
    sta MustLoadMenu
    sta MustLoadSomething

    lda #INVENTORY_POINTER_X
    sta InventoryPointerX

    lda #STATE_MENU
    sta GameState
@exit:

    rts

.segment "ROM1"

;----------------------------------
UpdateMenuStats:
    lda $2002
    lda FirstNametableAddr
    sta $2006
    lda #$BB
    sta $2006

    ldy #0
@hpLoop:
    lda #CHARACTER_ZERO
    clc 
    adc HP, y
    sta $2007
    iny
    cpy #3
    bne @hpLoop


    lda $2002
    lda FirstNametableAddr
    sta $2006
    lda #$FB
    sta $2006

    ldy #0
@foodLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Food, y
    sta $2007
    iny
    cpy #3
    bne @foodLoop

    lda $2002
    lda FirstNametableAddr
    clc
    adc #1
    sta $2006
    lda #$3B
    sta $2006

    ldy #0
@warmthLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Warmth, y
    sta $2007
    iny
    cpy #3
    bne @warmthLoop


    lda $2002
    lda FirstNametableAddr
    clc
    adc #1
    sta $2006
    lda #$DB
    sta $2006

    ldy #0
@fuelLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Fuel, y
    sta $2007
    iny
    cpy #3
    bne @fuelLoop


    lda $2002
    lda FirstNametableAddr
    clc
    adc #3
    sta $2006
    lda #$3B
    sta $2006

    ldy #0
@daysLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Days, y
    sta $2007
    iny
    cpy #3
    bne @daysLoop


    rts
;-------------------------------------
MenuInput:
    lda Buttons
    cmp MenuButtons
    beq @exit

@checkDown:

    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda FoodMenuActivated
    beq @regularMenuDown

    lda InventoryPointerPos
    cmp #112
    bcs @CheckUp
    clc
    adc #16
    sta InventoryPointerPos
    inc FoodMenuIndex

    jmp @CheckB

@regularMenuDown:
    lda InventoryPointerPos
    cmp #INVENTORY_SPRITE_MAX_Y - 12
    bcs @CheckUp
    clc
    adc #12
    sta InventoryPointerPos
    inc InventoryItemIndex

    jmp @CheckB

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda FoodMenuActivated
    beq @regularMenuUp

    lda InventoryPointerPos
    cmp #112
    bcc @CheckB
    sec 
    sbc #16
    sta InventoryPointerPos
    dec FoodMenuIndex

    jmp @CheckB
@regularMenuUp:
    lda InventoryPointerPos
    cmp #INVENTORY_SPRITE_MIN_Y + 12
    bcc @CheckB
    sec
    sbc #12
    sta InventoryPointerPos
    dec InventoryItemIndex

@CheckB:
    jsr Button_B_Pressed

@exit:
    lda Buttons
    sta MenuButtons

    rts
;--------------------------------------
Button_B_Pressed:
    lda Buttons
    and #BUTTON_B_MASK
    beq @exit

    lda FoodMenuActivated
    beq @checkItemSelect

    jsr LoadSelectedItemStuff
    beq @exit

    lda FoodMenuIndex
    bne @eat
    ;cook
    jsr CookMeat
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    lda #0
    sta FoodMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerPos
    jmp @exit
@eat:
    jsr UseFood
    jmp @clearItem

@checkItemSelect:
    jsr LoadSelectedItemStuff
    beq @exit
    dey
    lda inventory_data, y ; type

    cmp #ITEM_TYPE_FUEL
    beq @addFuel

@checkFood:
    cmp #ITEM_TYPE_FOOD
    beq @addFood

    jmp @clearItem

@addFuel:
    lda InHouse
    beq @exit ; can't use a stick outside the hut
    jsr UseFuel
    jmp @clearItem
;--------
@addFood:
    lda #1
    sta MustLoadSomething
    sta MustDrawPopupMenu
    sta FoodMenuActivated
    lda #80
    sta InventoryPointerX
    lda InventoryPointerPos
    sta OldInventoryPointerY
    lda #96
    sta InventoryPointerPos
    lda #0
    sta FoodMenuIndex

    jmp @exit
@clearItem:
    lda #0
    sta Inventory, x
    lda #1
    sta MustExitMenuState

@exit:
    rts
;-------------------------------------
CookMeat:
    lda InHouse
    beq @cantcook

    lda Fuel
    clc
    adc Fuel + 1
    cmp #0
    bne @cook ; fuel > 9

    lda Fuel + 2
    cmp #COOKING_FUEL_COST
    bcc @cantcook

@cook:
    lda #COOKING_FUEL_COST
    sta DigitChangeSize
    lda #MAX_FUEL_DELAY
    sta FuelDelay
    lda #<Fuel
    sta DigitPtr
    lda #>Fuel
    sta DigitPtr + 1

    stx TempPush
    jsr DecreaseDigits
    ldx TempPush

    lda #3
    sta Inventory, x ; put cooked meat
@cantcook:
    rts
;--------------------------------------
LoadSelectedItemStuff:
    ldx InventoryItemIndex
    lda Inventory, x
    beq @empty
    asl
    asl
    tay
    iny
    iny
    iny
    lda inventory_data, y 
    sta Temp ;power
    lda #1
    jmp @exit
@empty:
    lda #0

@exit:
    rts

;---------------------------------------
UseFuel:
    lda #MAX_FUEL_DELAY
    sta FuelDelay

    lda Fuel
    bne @clampFuel

    lda Fuel + 1
    clc
    adc Temp
    cmp #10
    bcs @clampFuel
    jmp @saveFuel
@clampFuel:
    lda #0
    sta Fuel + 1
    sta Fuel + 2
    lda #1
    sta Fuel
    jmp @exit
@saveFuel:
    sta Fuel + 1
@exit:
    rts
;--------------------------------------
UseFood:
    lda #MAX_FOOD_DELAY
    sta FoodDelay

    lda Food    ; highest digit
    bne @clampFood

    lda Food + 1
    clc
    adc Temp
    cmp #10
    bcs @clampFood
    jmp @saveFood
@clampFood:
    lda #0
    sta Food + 1
    sta Food + 2
    lda #1
    sta Food
    jmp @exit
@saveFood:
    sta Food + 1

@exit:

    rts
;-------------------------------------

UpdateInventorySprites:

    ldx #0
    lda #0
    sta TempSpriteIdx
    sta TempSpriteCount

    lda #32
    sta TempTileYPos


@itemLoop:

    lda Inventory, x
    asl
    asl ;inventory_index * 4
    tay
    lda inventory_data, y ;grab sprite index
    bne @store_sprite_index
    lda #$FD ;empty sprite index
@store_sprite_index:
    sta TempTileIndex ; save sprite index
    iny
    lda inventory_data, y
    sta TempPaletteIndex ; save palette

    stx TempInventoryIndex ; save x index
    lda TempTileYPos
    clc
    adc #INVENTORY_STEP_PIXELS
    sta TempTileYPos

    ldy #0
@twoTileLoop: ;item consists of two tiles

    lda TempTileYPos
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x ;set Y coordinate

    inc TempSpriteIdx
    lda TempTileIndex
    sty TempTileIndexOffset
    clc
    adc TempTileIndexOffset
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x

    inc TempSpriteIdx
    ;attributes
    ldx TempSpriteIdx
    lda #0
    clc
    adc TempPaletteIndex
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ;x coordinate
    lda #INVENTORY_SPRITE_X
    cpy #1
    bne @saveX
    clc
    adc #8
@saveX:
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    inc TempSpriteCount
    iny
    cpy #2
    bcc @twoTileLoop

    ldx TempInventoryIndex ;restore x index
@next:
    inx
    cpx #INVENTORY_MAX_ITEMS
    bcc @itemLoop


    ldx TempSpriteIdx
    lda InventoryPointerPos
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #$FC
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #%00000011
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda InventoryPointerX
    sta FIRST_SPRITE, x
    inc TempSpriteCount


    inx
    lda #63

    cmp TempSpriteCount
    bcc @done
    sec
    sbc TempSpriteCount

    tay
@hideSpritesLoop:
    lda #$FE
    sta FIRST_SPRITE, x
    inx
    inx
    inx
    inx

    dey
    bne @hideSpritesLoop
@done:



    rts
;----------------------------------

.segment "CODE"

ExitMenuState:
    lda #STATE_GAME
    sta GameState

    lda FoodMenuActivated
    beq @ignorethis
    lda #0
    sta FoodMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerPos
@ignorethis:
    lda InHouse
    beq @loadOutside ;InHouse = 0
    lda #1
    sta MustLoadHouseInterior
    sta MustLoadSomething
    jmp @exit
@loadOutside:
    lda #1
    sta MustLoadOutside
    sta MustLoadSomething
@exit:
    ldy #0
    jsr bankswitch_y

    rts
;-------------------------------------

