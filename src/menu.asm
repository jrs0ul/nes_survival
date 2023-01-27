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
    sta InventoryActivated
    sta InventoryItemIndex
    sta BaseMenuIndex

    lda #INVENTORY_POINTER_X
    sta InventoryPointerX

    lda #BASE_MENU_MIN_Y
    sta InventoryPointerY

    lda #STATE_MENU
    sta GameState
@exit:

    rts
;------------------------------------
.segment "ROM1"
;------------------------------------
UpdateMenuGfx:


    jsr DrawInventoryGrid
    jsr DrawFoodMenu

    lda #0
    sta MustLoadSomething

@exit:
    rts
;----------------------------------
DrawInventoryGrid:
    lda MustDrawInventoryGrid
    beq @exit

    lda #0
    sta $2001

    lda FirstNametableAddr
    clc
    ;adc #1
    sta Temp

    ldy #0
    lda #$A5
    sta TempY
    sty TempIndex

@menuRowLoop:

    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldx #0
@menuCellLoop:
    stx TempX
    ldx TempIndex 
    lda inventory_grid, x
    sta $2007
    ldx TempX
    inx
    inc TempIndex
    cpx #9
    bne @menuCellLoop

    lda TempY
    clc
    adc #$20
    bcs @incrementUpperAddress
    sta TempY
    jmp @incrementRow
@incrementUpperAddress:
    sta TempY
    inc Temp
@incrementRow:
    iny
    cpy #16
    bne @menuRowLoop


    lda #0
    sta MustDrawInventoryGrid


@exit:
    rts
;----------------------------------
DrawFoodMenu:
    lda MustDrawFoodMenu
    beq @exit
    
    lda #0
    sta $2001

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    ldy #0
    lda #$49
    sta TempY
    sty TempIndex

@menuRowLoop:

    lda $2002
    lda Temp
    sta $2006
    lda TempY
    sta $2006

    ldx #0
@menuCellLoop:
    stx TempX
    ldx TempIndex 
    lda PopUpMenu, x
    sta $2007
    ldx TempX
    inx
    inc TempIndex
    cpx #8
    bne @menuCellLoop

    lda TempY
    clc
    adc #$20
    bcs @incrementUpperAddress
    sta TempY
    jmp @incrementRow
@incrementUpperAddress:
    sta TempY
    inc Temp
@incrementRow:
    iny
    cpy #7
    bne @menuRowLoop


    lda #0
    sta MustDrawFoodMenu

@exit:
    rts

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

    lda InventoryActivated
    bne @DoInventoryInput

    lda FoodMenuActivated
    bne @DoFoodMenuInput

    jsr DoRegularInput
    jmp @exit

@DoInventoryInput:
    jsr InventoryInput
    jmp @exit

@DoFoodMenuInput:
    jsr FoodMenuInput
    jmp @exit


@exit:
    lda Buttons
    sta MenuButtons

    rts
;--------------------------------------
InventoryInput:

@checkDown:

    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MAX_Y - 12
    bcs @CheckUp
    clc
    adc #12
    sta InventoryPointerY
    inc InventoryItemIndex

    jmp @CheckB

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MIN_Y + 12
    bcc @CheckB
    sec
    sbc #12
    sta InventoryPointerY
    dec InventoryItemIndex

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

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
    sta MustDrawFoodMenu
    sta FoodMenuActivated
    lda #80
    sta InventoryPointerX
    lda InventoryPointerY
    sta OldInventoryPointerY
    lda #96
    sta InventoryPointerY
    lda #0
    sta FoodMenuIndex
    sta InventoryActivated

    jmp @exit
@clearItem:
    lda #0
    sta Inventory, x
    lda #1
    sta MustExitMenuState

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda #1
    sta MustLoadSomething
    sta MustLoadMenu



@exit:
    rts


;--------------------------------------
FoodMenuInput:
@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #112
    bcs @CheckUp
    clc
    adc #16
    sta InventoryPointerY
    inc FoodMenuIndex

    jmp @CheckB

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda InventoryPointerY
    cmp #112
    bcc @CheckB
    sec 
    sbc #16
    sta InventoryPointerY
    dec FoodMenuIndex

    jmp @CheckB

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @exit

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
    sta InventoryPointerY
    jmp @exit
@eat:
    jsr UseFood
    

@clearItem:
    lda #0
    sta Inventory, x
    lda #1
    sta MustExitMenuState

@exit:
    rts
;-------------------------------------
DoRegularInput:
@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #64
    bcs @CheckB
    clc
    adc #16
    sta InventoryPointerY
    inc BaseMenuIndex

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda InventoryPointerY
    cmp #BASE_MENU_MIN_Y
    beq @CheckB
    sec
    sbc #16
    sta InventoryPointerY
    dec BaseMenuIndex

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @exit

    lda BaseMenuIndex
    beq @activateInventory

    ;sleep
    lda InHouse
    beq @exit

    jsr Sleep
    jmp @exit

@activateInventory:

    lda #1
    sta InventoryActivated
    sta MustLoadSomething
    sta MustDrawInventoryGrid
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY


@exit:

    rts

;--------------------------------------
Sleep:
    lda #SLEEP_POS_X
    sta PlayerY
    lda #SLEEP_POS_Y
    sta PlayerX
    lda #2
    sta PlayerFrame
    lda #16
    sta WalkAnimationIndex
    lda Hours
    clc
    adc #SLEEP_TIME
    sta Hours
    bcs @hoursOverFlow
    cmp #HOURS_MAX
    bcs @increaseDays
    jmp @adaptPalette

@hoursOverFlow:
    lda Hours
    sec
    sbc #15
    sta Hours
    jsr IncreaseDays
    jmp @adaptPalette

@increaseDays:
    lda Hours
    sec
    sbc #HOURS_MAX
    sta Hours
    jsr IncreaseDays

@adaptPalette:
    jsr AdaptBackgroundPalette
    lda #1
    sta MustExitMenuState


    lda Food
    clc
    adc Food + 1
    adc Food + 2
    cmp #0
    beq @decreaseHealthFromHunger

    lda HP
    bne @makeHundred

    lda HP + 1
    clc
    adc #3
    cmp #10
    bcs @makeHundred
    sta HP + 1
    jmp @checkWarmth

@makeHundred:
    lda #1
    sta HP
    lda #0
    sta HP + 1
    sta HP + 2
    jmp @checkWarmth

@decreaseHealthFromHunger:

    lda HP + 1
    cmp #5
    bcs @subtractHPHunger

    lda HP
    beq @kill

    lda #10

@subtractHPHunger:
    sec
    sbc #5
    sta HP + 1

@checkWarmth:

    lda Warmth
    clc
    adc Warmth + 1
    adc Warmth + 2
    cmp #0
    bne @checkFuel

    lda HP + 1
    cmp #5
    bcs @subtractHPCold

    lda HP
    beq @kill

    lda #10

@subtractHPCold:
    sec
    sbc #5
    sta HP + 1

@checkFuel:

    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    bne @subtractStuff

    lda Warmth + 1
    cmp #5
    bcs @subtractWarmth

    lda Warmth
    beq @zeroWarmth

    lda #10

@subtractWarmth:
    sec
    sbc #5
    sta Warmth + 1

    jmp @subtractStuff

@zeroWarmth:
    lda #0
    sta Warmth
    sta Warmth + 1
    sta Warmth + 2
    jmp @subtractStuff


@kill:
    lda #0
    sta HP
    sta HP + 1
    sta HP + 2

@subtractStuff:
    lda #0
    sta Fuel
    sta Fuel + 1
    sta Fuel + 2

    lda Food + 1
    cmp #5
    bcs @subtractFood

    lda Food
    beq @makeFoodZero

    lda #10

@subtractFood:
    sec
    sbc #5
    sta Food + 1
    jmp @exit

@makeFoodZero:
    lda #0
    sta Food
    sta Food + 1
    sta Food + 2


@exit:
    rts

;--------------------------------------
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

    lda InventoryActivated
    bne @itemLoop

@checkFoodMenu:
    lda FoodMenuActivated
    beq @ThePointer

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

@ThePointer:

    ldx TempSpriteIdx
    lda InventoryPointerY
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
    sta InventoryPointerY
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

