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
    sta CraftingActivated
    sta StashActivated
    sta MustLoadSomething
    sta StashFoodMenuActivated
    sta StashItemMenuActivated
    sta FoodMenuActivated
    sta ItemMenuActivated
    sta InventoryActivated
    sta InventoryItemIndex
    sta BaseMenuIndex
    sta MaterialMenuActivated
    sta StashMaterialMenuActivated

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

    jsr DrawMenuTitle
    jsr DrawInventoryGrid
    jsr DrawFoodMenu
    jsr DrawItemMenu
    jsr DrawMaterialMenu
    jsr DrawStashMaterialMenu
    jsr DrawStashFoodMenu
    jsr DrawStashItemMenu
    jsr ClearSubMenu

    lda #0
    sta MustLoadSomething

@exit:
    rts
;----------------------------------
DrawMenuTitle:
    lda MustDrawMenuTitle
    beq @exit

    lda FirstNametableAddr
    clc
    sta Temp

    lda #$40
    sta TempX

    lda #9
    sta TempPointX
    lda #1
    sta TempPointY

    lda CraftingActivated
    beq @storage
    lda #<crafting_title
    sta pointer
    lda #>crafting_title
    sta pointer + 1

    jmp @draw
    
@storage:
    lda StashActivated
    beq @Inventory_title
    lda #<storage_title
    sta pointer
    lda #>storage_title
    sta pointer + 1
    jmp @draw
@Inventory_title:
    lda #11
    sta TempPointX
    lda #<inventory_title
    sta pointer
    lda #>inventory_title
    sta pointer + 1


@draw:
    jsr TransferTiles

    lda #0
    sta MustDrawMenuTitle

@exit:
    rts
;----------------------------------
DrawInventoryGrid:
    lda MustDrawInventoryGrid
    beq @exit

    lda FirstNametableAddr
    clc
    sta Temp

    lda #$A4
    sta TempX

    lda #10
    sta TempPointX
    lda #16
    sta TempPointY

    lda #<inventory_grid
    sta pointer
    lda #>inventory_grid
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawInventoryGrid

@exit:
    rts
;----------------------------------
DrawFoodMenu:
    lda MustDrawFoodMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #11
    sta TempPointY

    lda #<FoodMenu
    sta pointer
    lda #>FoodMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawFoodMenu

@exit:
    rts
;-------------------------
DrawStashFoodMenu:
    lda MustDrawStashFoodMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #11
    sta TempPointY

    lda #<StashFoodMenu
    sta pointer
    lda #>StashFoodMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawStashFoodMenu

@exit:
    rts
;-------------------------
DrawStashItemMenu:
    lda MustDrawStashItemMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #9
    sta TempPointY

    lda #<StashItemMenu
    sta pointer
    lda #>StashItemMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawStashItemMenu

@exit:

    rts
;-------------------------
DrawItemMenu:
    lda MustDrawItemMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #9
    sta TempPointY

    lda #<ItemMenu
    sta pointer
    lda #>ItemMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawItemMenu

@exit:
    rts
;---------------------------
DrawMaterialMenu:
    lda MustDrawMaterialMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #7
    sta TempPointY

    lda #<MaterialMenu
    sta pointer
    lda #>MaterialMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawMaterialMenu

@exit:
    rts
;---------------------------
DrawStashMaterialMenu:
    lda MustDrawStashMaterialMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #7
    sta TempPointY

    lda #<StashMaterialMenu
    sta pointer
    lda #>StashMaterialMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawStashMaterialMenu

@exit:
    rts

;----------------------------
ClearSubMenu:
    lda MustClearSubMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX

    lda #9
    sta TempPointX
    lda #11
    sta TempPointY

    lda #<PopUpMenuClear
    sta pointer
    lda #>PopUpMenuClear
    sta pointer + 1
    jsr TransferTiles


    lda #0
    sta MustClearSubMenu

@exit:
    rts
;----------------------------------
UpdateMenuStats:

    lda #0
    sta $2001

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

    lda StashFoodMenuActivated
    bne @DoFoodMenuInput

    lda StashItemMenuActivated
    bne @DoItemMenuInput

    lda StashMaterialMenuActivated
    bne @DoMaterialInput

    lda ItemMenuActivated
    bne @DoItemMenuInput

    ;put stash sub menus before this
    lda StashActivated
    bne @DoInventoryInput

    lda CraftingActivated
    bne @DoCraftingInput

    lda MaterialMenuActivated
    bne @DoMaterialInput

    jsr DoRegularInput
    jmp @exit

@DoInventoryInput:
    jsr InventoryInput
    jmp @exit

@DoFoodMenuInput:
    jsr FoodMenuInput
    jmp @exit

@DoMaterialInput:
    jsr MaterialMenuInput
    jmp @exit

@DoItemMenuInput:
    jsr ItemMenuInput
    jmp @exit

@DoCraftingInput:
    jsr CraftingInput

@exit:
    lda Buttons
    sta MenuButtons

    rts
;--------------------------------------
CraftingInput:

@checkDown:

    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MAX_Y - 12
    bcs @rewindUp
    clc
    adc #12
    sta InventoryPointerY
    inc InventoryItemIndex
    jmp @CheckB
@rewindUp:
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY
    lda #0
    sta InventoryItemIndex


    jmp @CheckB

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MIN_Y + 12
    bcc @rewindDown
    sec
    sbc #12
    sta InventoryPointerY
    dec InventoryItemIndex
    jmp @CheckB
@rewindDown:
    lda #INVENTORY_SPRITE_MAX_Y - 12
    sta InventoryPointerY
    lda #9
    sta InventoryItemIndex

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    lda InventoryItemIndex
    tay
    lda Inventory, y
    beq @exit ;empty slot was picked
    tya
    ldx CurrentCraftingComponent
    cpx #1
    bne @storeIndex
    ldy #0
    lda CraftingIndexes, y
    cmp InventoryItemIndex
    beq @exit
    lda InventoryItemIndex

@storeIndex:
    sta CraftingIndexes, x
    inc CurrentCraftingComponent
    lda CurrentCraftingComponent
    cmp #2
    bcs @tryCrafting
    jmp @exit
@tryCrafting:
    jsr CraftFromSelectedComponents

    jmp @resetIndexes
    
@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit
@revert:
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu
    lda #0
    sta CurrentCraftingComponent
@resetIndexes:
    lda #255
    ldx #0
    stx CurrentCraftingComponent
    sta CraftingIndexes, x
    inx
    sta CraftingIndexes, x

@exit:
    rts

;--------------------------------------
CraftFromSelectedComponents:

    ldx #255
    stx TempRegX
@loop:
    ldx TempRegX
    inx
    cpx #12
    bcs @exit

    lda recipes, x
    sta TempY
    inx
    lda recipes, x
    sta TempZ
    inx
    lda recipes, x
    sta Temp
    stx TempRegX


    ldx #0
    lda CraftingIndexes, x
    tay
    lda Inventory, y
    cmp TempY ;ingredient A
    bne @loop

    inx
    lda CraftingIndexes, x
    tay
    lda Inventory, y
    cmp TempZ ;ingredient B
    bne @loop


    lda CraftingIndexes,x
    lda Temp ;result
    sta Inventory,y

    dex
    lda CraftingIndexes, x
    tay
    lda #0
    sta Inventory, y


@exit:
    rts

;--------------------------------------
InventoryInput:

@checkDown:

    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MAX_Y - 12
    bcs @rewindUp
    clc
    adc #12
    sta InventoryPointerY
    inc InventoryItemIndex
    jmp @CheckB
@rewindUp:
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY
    lda #0
    sta InventoryItemIndex


    jmp @CheckB

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @CheckB

    lda InventoryPointerY
    cmp #INVENTORY_SPRITE_MIN_Y + 12
    bcc @rewindDown
    sec
    sbc #12
    sta InventoryPointerY
    dec InventoryItemIndex
    jmp @CheckB
@rewindDown:
    lda #INVENTORY_SPRITE_MAX_Y - 12
    sta InventoryPointerY
    lda #9
    sta InventoryItemIndex

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr OnItemClicked
    jmp @exit
    
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
OnItemClicked:

    jsr LoadSelectedItemStuff
    beq @exit

    lda TempIndex
    cmp #ITEM_TYPE_FOOD
    beq @addFood

    cmp #ITEM_TYPE_MATERIAL
    beq @material

    ;regular item

    lda StashActivated
    beq @ItemFromInventory

    lda #1
    sta MustLoadSomething
    sta MustDrawStashItemMenu
    sta StashItemMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex


    jmp @exit

@ItemFromInventory:
    lda #1
    sta MustLoadSomething
    sta MustDrawItemMenu
    sta ItemMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    jmp @exit
;--------
@addFood:
    lda StashActivated
    beq @useFromInventory

    lda #1
    sta MustLoadSomething
    sta MustDrawStashFoodMenu
    sta StashFoodMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex


    jmp @exit
@useFromInventory:
    lda #1
    sta MustLoadSomething
    sta MustDrawFoodMenu
    sta FoodMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex
    sta InventoryActivated
    jmp @exit
;-----------
@material:
   jsr MaterialItemClicked
@exit:
    rts
;-------------------------------------
MaterialItemClicked:
    lda StashActivated
    bne @stashedMaterial

    lda #1
    sta MustLoadSomething
    sta MustDrawMaterialMenu
    sta MaterialMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    jmp @exit
@stashedMaterial:
    lda #1
    sta MustLoadSomething
    sta MustDrawStashMaterialMenu
    sta StashMaterialMenuActivated
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated
@exit:
    rts

;--------------------------------------
ActivateSubmenu:
    lda #72
    sta InventoryPointerX
    lda InventoryPointerY
    sta OldInventoryPointerY
    lda #96
    sta InventoryPointerY

    rts


;--------------------------------------
FoodMenuInput:
@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #144
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
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda FoodMenuIndex
    bne @otherOptions
    ;cook
    jsr CookMeat
    lda #0
    sta StashFoodMenuActivated
    sta FoodMenuActivated
    jsr ExitSubmenu
    jmp @exit
@otherOptions:
    cmp #2
    bne @checkEat
    lda StashActivated
    beq @storeItem
    jsr TakeItemFromStash
    bne @exit
    jmp @clearItem
@storeItem:
    jsr StoreItemInStash
    bne @exit
    jmp @clearItem
@checkEat:
    cmp #1
    bne @clearItem
    jsr UseFood
    

@clearItem:
    lda StashActivated
    beq @useInventory
    lda #0
    sta Storage, x
    jmp @hidemenu
@useInventory:
    lda #0
    sta Inventory, x
@hidemenu:
    lda #0
    sta StashFoodMenuActivated
    sta FoodMenuActivated
    jsr ExitSubmenu
    jmp @exit

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda #0
    sta StashFoodMenuActivated
    sta FoodMenuActivated
    jsr ExitSubmenu
@exit:
    rts
;-------------------------------------
ExitSubmenu:
    jsr UpdateMenuStats
    lda StashActivated
    bne @continue
    lda #1
    sta InventoryActivated
@continue:
    lda #INVENTORY_POINTER_X
    sta InventoryPointerX
    lda OldInventoryPointerY
    sta InventoryPointerY
    lda #1
    sta MustLoadSomething
    sta MustClearSubMenu


    rts
;-------------------------------------
MaterialMenuInput:
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
    inc ItemMenuIndex

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
    dec ItemMenuIndex

    jmp @CheckB

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda ItemMenuIndex
    bne @clearItem ; DROP
    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @exit ;failed to add to stash
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @exit ;failed to retrieve

@clearItem:
    lda StashActivated
    beq @useInventory
    lda #0
    sta Storage, x
    jmp @hidemenu
@useInventory:
    lda #0
    sta Inventory, x
@hidemenu:
    jsr HideMaterialMenu
@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    jsr HideMaterialMenu
@exit:
    rts



;-------------------------------------
ItemMenuInput:
@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #128
    bcs @CheckUp
    clc
    adc #16
    sta InventoryPointerY
    inc ItemMenuIndex

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
    dec ItemMenuIndex

    jmp @CheckB

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda ItemMenuIndex
    bne @checkIfStash
    ;use
    lda TempIndex
    cmp #ITEM_TYPE_FUEL
    bne @medicine
    lda InHouse
    beq @exit
    jsr UseFuel
    jmp @clearItem
@medicine:
    jsr UseMedicine
    jmp @clearItem
@checkIfStash:
    cmp #1
    bne @clearItem ; DROP
    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @exit ;failed to add to stash
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @exit ;failed to retrieve

@clearItem:
    lda StashActivated
    beq @useInventory
    lda #0
    sta Storage, x
    jmp @hidemenu
@useInventory:
    lda #0
    sta Inventory, x
@hidemenu:
    jsr HideItemMenu
@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    jsr HideItemMenu
@exit:
    rts

;----------------------------------
HideItemMenu:
    lda #0
    sta ItemMenuActivated
    sta StashItemMenuActivated
    jsr UpdateMenuStats
    lda StashActivated
    bne @cont
    lda #1
    sta InventoryActivated
@cont:
    lda #INVENTORY_POINTER_X
    sta InventoryPointerX
    lda OldInventoryPointerY
    sta InventoryPointerY
    lda #1
    sta MustLoadSomething
    sta MustClearSubMenu

    rts
;----------------------------------
HideMaterialMenu:
    lda #0
    sta MaterialMenuActivated
    sta StashMaterialMenuActivated
    sta StashItemMenuActivated
    jsr UpdateMenuStats
    lda StashActivated
    bne @cont
    lda #1
    sta InventoryActivated
@cont:
    lda #INVENTORY_POINTER_X
    sta InventoryPointerX
    lda OldInventoryPointerY
    sta InventoryPointerY
    lda #1
    sta MustLoadSomething
    sta MustClearSubMenu

    rts

;-----------------------------------
TakeItemFromStash:
    ldy #255
@inventoryLoop:
    iny
    cpy #INVENTORY_MAX_ITEMS
    bcs @fail
    lda Inventory, y
    bne @inventoryLoop
    lda Storage, x
    sta Inventory, y

    lda #0
    jmp @exit
@fail:
    lda #1
@exit:
    rts

;------------------------------------
;x is inventory item index
StoreItemInStash:
    lda InHouse
    beq @fail
    ldy #255
@stashLoop:
    iny
    cpy #INVENTORY_MAX_ITEMS
    bcs @fail
    lda Storage, y
    bne @stashLoop
    lda Inventory, x
    sta Storage, y

    lda #0
    jmp @exit
@fail:
    lda #1
@exit:
    rts

;-------------------------------------
DoRegularInput:

    lda PlayerInteractedWithStorage
    bne @stashList
    lda PlayerInteractedWithFireplace
    bne @activateInventory
    lda PlayerInteractedWithBed
    bne @setPointerToSleep
    lda PlayerInteractedWithTooltable
    bne @crafting

@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp #112
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
    beq @CheckA

    lda OldButtons
    and #BUTTON_B_MASK
    bne @CheckA


    lda BaseMenuIndex
    beq @activateInventory

    cmp #3
    beq @stashList

    cmp #2
    beq @crafting

    ;sleep
    lda InHouse
    beq @exit

    jsr Sleep
    jmp @exit

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda #1
    sta MustExitMenuState

@stashList:
    lda InHouse
    beq @exit
    jsr OpenUpStash
    jmp @exit

@crafting:
    jsr OpenupCrafting
    jmp @exit


@activateInventory:
    jsr OpenupInventory
    jmp @exit

@setPointerToSleep:

    lda #0
    sta PlayerInteractedWithBed
    lda #4
    sta BaseMenuIndex
    lda #112
    sta InventoryPointerY


@exit:

    rts
;------------------------------------
OpenupCrafting:
    lda InHouse
    beq @exit
    lda #1
    sta MustLoadSomething
    sta MustDrawInventoryGrid
    sta MustDrawMenuTitle
    sta CraftingActivated
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY
    lda #0
    sta PlayerInteractedWithTooltable
    sta CurrentCraftingComponent
@exit:
    rts
;------------------------------------
OpenupInventory:
    lda #0
    sta PlayerInteractedWithFireplace
    lda #1
    sta InventoryActivated
    sta MustLoadSomething
    sta MustDrawInventoryGrid
    sta MustDrawMenuTitle
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY

    rts

;-------------------------------------
OpenUpStash:
    lda #0
    sta PlayerInteractedWithStorage
    lda #1
    sta StashActivated
    sta MustLoadSomething
    sta MustDrawInventoryGrid
    sta MustDrawMenuTitle
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY

    rts

;--------------------------------------
Sleep:
    lda #SLEEP_POS_X
    sta PlayerY
    lda #SLEEP_POS_Y
    sta PlayerX
    lda #2
    sta PlayerFrame
    lda #1
    sta PlayerAnimationRowIndex
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

    dec HP
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

    dec HP
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

    dec Warmth
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

    dec Food
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

    lda StashActivated
    bne @putToStash
    lda #3
    sta Inventory, x ; put cooked meat
    jmp @cantcook
@putToStash:
    lda #3
    sta Storage, x
@cantcook:
    rts
;--------------------------------------
LoadSelectedItemStuff:
    ldx InventoryItemIndex
    lda StashActivated ; let's check what's active
    beq @useInventory
    lda Storage, x
    jmp @cont
@useInventory:
    lda Inventory, x
@cont:
    beq @empty
    asl
    asl
    tay
    iny
    iny
    lda item_data, y
    sta TempIndex
    iny
    lda item_data, y 
    sta Temp ;power
    lda #1
    jmp @exit
@empty:
    lda #0

@exit:
    rts


;TODO: eliminate repetetive code
;---------------------------------------
UseMedicine:

    lda HP
    bne @clampHp

    lda HP + 1
    clc
    adc Temp
    cmp #10
    bcs @clampHp
    jmp @saveHp
@clampHp:
    lda #0
    sta HP + 1
    sta HP + 2
    lda #1
    sta HP
    jmp @exit
@saveHp:
    sta HP + 1
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
    clc
    adc ItemMenuActivated
    adc StashActivated
    adc StashItemMenuActivated
    adc StashFoodMenuActivated
    adc CraftingActivated
    adc MaterialMenuActivated
    adc StashMaterialMenuActivated
    beq @ThePointer

@itemLoop:

    lda StashActivated
    beq @useInventory
    lda Storage, x
    jmp @cnt
@useInventory:
    lda Inventory, x
@cnt:
    asl
    asl ;inventory_index * 4
    tay
    lda item_data, y ;grab sprite index
    bne @store_sprite_index
    lda #$FD ;empty sprite index
@store_sprite_index:
    sta TempTileIndex ; save sprite index
    iny
    lda item_data, y
    sta TempPaletteIndex ; save palette

    stx TempInventoryIndex ; save x index
    lda TempTileYPos
    clc
    adc #INVENTORY_STEP_PIXELS
    sta TempTileYPos

    jsr TwoTileLoop
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
TwoTileLoop:
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

    rts


;----------------------------------

.segment "CODE"

ExitMenuState:
    lda #STATE_GAME
    sta GameState

    lda FoodMenuActivated
    beq @checkItemMenu
    lda #0
    sta FoodMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerY
@checkItemMenu:
    lda ItemMenuActivated
    beq @checkStashItemMenu
    lda #0
    sta ItemMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerY
@checkStashItemMenu:
    lda StashItemMenuActivated
    beq @checkStashFoodMenu
    lda #0
    sta StashItemMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerY
@checkStashFoodMenu:
    lda StashFoodMenuActivated
    beq @ignorethis
    lda #0
    sta StashFoodMenuActivated
    lda OldInventoryPointerY
    sta InventoryPointerY

    

@ignorethis:
    
    lda #0
    sta StashActivated

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

