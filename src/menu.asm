LoadMenu:

    lda MustLoadMenu
    beq @exit
    
    
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
    sta InventoryActivated
    sta InventoryItemIndex
    sta EquipmentActivated
    sta BaseMenuIndex
    sta SubMenuIndex

    lda #INVENTORY_POINTER_X
    sta InventoryPointerX

    lda #BASE_MENU_MIN_Y
    sta InventoryPointerY

    lda #STATE_MENU
    sta GameState

    lda #0
    sta MustUpdatePalette
@exit:

    rts
;------------------------------------
.segment "ROM1"
;------------------------------------

inventorypositions:
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 1
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 2
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 3
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 4
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 5
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 6
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 7
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 8
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 9
    .byte MENU_ITEM_SPRITE_MIN_Y + INVENTORY_STEP_PIXELS * 10


UpdateMenuGfx:

    jsr DrawMenuTitle
    jsr DrawInventoryGrid
    jsr DrawEquipmentGrid
    jsr DrawFoodMenu
    jsr DrawItemMenu
    jsr DrawMaterialMenu
    jsr DrawToolMenu
    jsr DrawStashMaterialMenu
    jsr DrawStashToolMenu
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

    lda #MENU_TITLE_ADDRESS
    sta TempX

    lda #8
    sta TempPointX
    lda #1
    sta TempPointY

    lda EquipmentActivated
    beq @crafting
    
    lda #10
    sta TempPointX
    lda #<equipment_title
    sta pointer
    lda #>equipment_title
    sta pointer + 1
    
    jmp @draw

@crafting:
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
    lda #10
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

    lda InHouse
    bne @cont


    jsr ColorDisabledMenuAttributes

@cont:

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_ITEM_GRID_ADDRESS
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
DrawEquipmentGrid:
    lda MustDrawEquipmentGrid
    beq @exit

lda InHouse
    bne @cont

    jsr ColorDisabledMenuAttributes

@cont:


    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_ITEM_GRID_ADDRESS
    sta TempX

    lda #10
    sta TempPointX
    lda #16
    sta TempPointY

    lda #<equipment_grid
    sta pointer
    lda #>equipment_grid
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawEquipmentGrid

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

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX

    lda InVillagerHut
    bne @smallmenu

    lda InHouse
    beq @smallestmenu

    lda #11
    jmp @storeY

@smallmenu:

    lda #9
    jmp @storeY

@smallestmenu:
    lda #7

@storeY:
    sta TempPointY


    lda InVillagerHut
    bne @villagerMenu

    lda InHouse
    beq @outdoorsMenu

    lda #<FoodMenuAtHome
    sta pointer
    lda #>FoodMenuAtHome
    sta pointer + 1
    jmp @startTransfer

@outdoorsMenu:
    lda #<FoodMenuOutdoors
    sta pointer
    lda #>FoodMenuOutdoors
    sta pointer + 1

    jmp @startTransfer

@villagerMenu:
    lda #<FoodMenuVillager
    sta pointer
    lda #>FoodMenuVillager
    sta pointer + 1


@startTransfer:
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

    lda #MENU_SUBMENU_ADDRESS_LOW
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

    lda #MENU_SUBMENU_ADDRESS_LOW
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
DrawToolMenu:
    lda MustDrawToolMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX
    lda #9
    sta TempPointY

    lda InVillagerHut
    beq @regularMenu

    lda #<ToolMenuVillager
    sta pointer
    lda #>ToolMenuVillager
    sta pointer + 1
    jmp @startTransfer


@regularMenu:
    lda #<ToolMenu
    sta pointer
    lda #>ToolMenu
    sta pointer + 1

@startTransfer:
    jsr TransferTiles

    lda #0
    sta MustDrawToolMenu

@exit:
    rts
;-------------------------
DrawStashToolMenu:
    lda MustDrawStashToolMenu
    beq @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX
    lda #9
    sta TempPointY

    lda #<StashToolMenu
    sta pointer
    lda #>StashToolMenu
    sta pointer + 1
    jsr TransferTiles

    lda #0
    sta MustDrawStashToolMenu

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

    lda #MENU_SUBMENU_ADDRESS_LOW
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

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX
    lda #7
    sta TempPointY

    lda InVillagerHut
    bne @villagermenu


    lda #<MaterialMenu
    sta pointer
    lda #>MaterialMenu
    sta pointer + 1
    jmp @transfertiles

@villagermenu:

    lda #<MaterialMenuVillager
    sta pointer
    lda #>MaterialMenuVillager
    sta pointer + 1

@transfertiles:
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

    lda #MENU_SUBMENU_ADDRESS_LOW
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

    lda #MENU_SUBMENU_ADDRESS_LOW
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


    lda InHouse
    beq @exit

    jsr ColorDisabledMenuAttributes

@exit:


    rts
;-------------------------------------
ColorDisabledMenuAttributes:

    lda $2002
    lda FirstNametableAddr
    clc
    adc #3
    sta $2006
    lda #$D9
    sta $2006
    lda $FF
    sta $2007
    sta $2007

    lda $2002
    lda FirstNametableAddr
    clc
    adc #3
    sta $2006
    lda #$E1
    sta $2006
    lda $FF
    sta $2007
    sta $2007



    rts


;-------------------------------------
MenuInput:
    lda Buttons
    cmp MenuButtons
    beq @exit

    lda InventoryActivated
    bne @DoInventoryInput

    lda SubMenuActivated
    beq @skipSubmenuStuff

    lda SubMenuIndex
    cmp #SUBMENU_FOOD
    beq @DoFoodMenuInput

    cmp #SUBMENU_STASH_FOOD
    beq @DoFoodMenuInput

    cmp #SUBMENU_STASH_ITEM
    beq @DoItemMenuInput

    cmp #SUBMENU_STASH_MATERIAL
    beq @DoMaterialInput

    cmp #SUBMENU_STASH_TOOL
    beq @DoToolInput

    cmp #SUBMENU_ITEM
    beq @DoItemMenuInput

    cmp #SUBMENU_MATERIAL
    beq @DoMaterialInput

    cmp #SUBMENU_TOOL
    beq @DoToolInput

@skipSubmenuStuff:

    lda CraftingActivated
    bne @DoCraftingInput

    lda EquipmentActivated
    bne @DoEquipmentInput


    ;put stash sub menus before this
    lda StashActivated
    bne @DoInventoryInput

    
@RegularInput:
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

@DoEquipmentInput:
    jsr EquipmentInput
    jmp @exit

@DoToolInput:
    jsr ToolInput
    jmp @exit

@DoCraftingInput:
    jsr CraftingInput

@exit:
    lda Buttons
    sta MenuButtons

    rts
;--------------------------------------
CraftingInput:


    lda #12
    sta MenuStep
    lda #INVENTORY_SPRITE_MIN_Y
    sta MenuUpperLimit
    lda #INVENTORY_SPRITE_MAX_Y - 12
    sta MenuLowerLimit
    lda #<InventoryItemIndex
    sta pointer
    lda #>InventoryItemIndex
    sta pointer + 1
    lda #INVENTORY_MAX_ITEMS
    sta MenuMaxItem
    jsr MenuInputUpDownCheck


@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    lda InventoryItemIndex
    asl ;item_index * 2
    tay
    lda Inventory, y
    beq @exit ;empty slot was picked
    tya
    ldx CurrentCraftingComponent
    cpx #1
    bne @storeIndex
    sty TempY
    ldy #0
    lda CraftingIndexes, y
    cmp TempY
    beq @exit
    lda TempY

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
    cpx #RECIPES_SIZE
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

    lda Temp ;result
    sta Inventory, y
    iny
    lda #ITEM_MAX_HP
    sta Inventory, y

    dex
    lda CraftingIndexes, x
    tay
    lda #0
    sta Inventory, y
    iny
    sta Inventory, y ; reset item hp as well

    lda Fuel
    clc
    adc Fuel + 1
    clc
    adc Fuel + 2
    cmp #1
    bcc @skipWarmthIncrease

    lda #WARMTH_CRAFTING_INCREASE
    sta DigitChangeSize
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    jsr IncreaseDigits

@skipWarmthIncrease:
    lda #CRAFTING_TIME
    sta ParamTimeValue
    jsr SkipTime


@exit:
    rts

;--------------------------------------
EquipmentInput:

    lda #12
    sta MenuStep
    lda #INVENTORY_SPRITE_MIN_Y
    sta MenuUpperLimit
    lda #INVENTORY_SPRITE_MIN_Y + 12
    sta MenuLowerLimit
    lda #<InventoryItemIndex
    sta pointer
    lda #>InventoryItemIndex
    sta pointer + 1
    lda #2
    sta MenuMaxItem
    jsr MenuInputUpDownCheck


@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    lda InventoryItemIndex
    bne @unequipCloth

    lda EquipedItem
    beq @exit ; no item equiped

    lda SpearData
    lsr
    bcs @exit ; you've launched a spear can't unequip it now

    ;let's simply unequip

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr UnequipItem
    jmp @exit

@unequipCloth:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr UnequipItem
    jmp @exit

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda #0
    sta EquipmentActivated
    lda #1
    sta MustLoadSomething
    sta MustLoadMenu


@exit:
    rts
;--------------------------------------
;pointer - EquipedItem or EquipedClothing
UnequipItem:
    ldx #254 ;-2
@loop:
    inx
    inx
    cpx #INVENTORY_MAX_SIZE
    bcs @exit ; no place for an unequiped item
    lda Inventory, x
    bne @loop

    ldy #0
    lda (pointer), y
    sta Inventory, x
    inx
    iny
    lda (pointer), y
    sta Inventory, x ; item's hp

    lda #0
    tay
    sta (pointer), y
    iny
    sta (pointer), y
@exit:
    rts


;--------------------------------------
InventoryInput:

    lda #12
    sta MenuStep
    lda #INVENTORY_SPRITE_MIN_Y
    sta MenuUpperLimit
    lda #INVENTORY_SPRITE_MAX_Y - 12
    sta MenuLowerLimit
    lda #<InventoryItemIndex
    sta pointer
    lda #>InventoryItemIndex
    sta pointer + 1
    lda #INVENTORY_MAX_ITEMS
    sta MenuMaxItem
    jsr MenuInputUpDownCheck


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

    cmp #ITEM_TYPE_TOOL
    beq @tool
    cmp #ITEM_TYPE_CLOTHING
    beq @tool

    ;regular item

    lda StashActivated
    beq @ItemFromInventory

    lda #1
    sta MustLoadSomething
    sta MustDrawStashItemMenu
    lda #SUBMENU_STASH_ITEM
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex


    jmp @exit

@ItemFromInventory:
    jsr RegularItemClicked
    jmp @exit
;--------
@addFood:
    lda StashActivated
    beq @useFromInventory

    lda #1
    sta MustLoadSomething
    sta MustDrawStashFoodMenu
    lda #SUBMENU_STASH_FOOD
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex


    jmp @exit
@useFromInventory:
    lda #1
    sta MustLoadSomething
    sta MustDrawFoodMenu
    lda #SUBMENU_FOOD
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex
    sta InventoryActivated
    jmp @exit
;-----------
@material:
   jsr MaterialItemClicked
   jmp @exit
@tool:
    jsr ToolItemClicked

@exit:
    rts
;-------------------------------------
RegularItemClicked:
    lda #1
    sta MustLoadSomething
    sta MustDrawItemMenu
    lda #SUBMENU_ITEM
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    rts
;-------------------------------------
ToolItemClicked:

    lda StashActivated
    bne @stashedTool

    lda #1
    sta MustLoadSomething
    sta MustDrawToolMenu
    lda #SUBMENU_TOOL
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated
    
    jmp @exit

@stashedTool:

    lda #1
    sta MustLoadSomething
    sta MustDrawStashToolMenu
    lda #SUBMENU_STASH_TOOL
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

@exit:
    rts

;-------------------------------------
MaterialItemClicked:
    lda StashActivated
    bne @stashedMaterial

    lda #1
    sta MustLoadSomething
    sta MustDrawMaterialMenu
    lda #SUBMENU_MATERIAL
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    jmp @exit
@stashedMaterial:
    lda #1
    sta MustLoadSomething
    sta MustDrawStashMaterialMenu
    lda #SUBMENU_STASH_MATERIAL
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated
@exit:
    rts

;--------------------------------------
ActivateSubmenu:
    lda #1
    sta SubMenuActivated
    lda #MENU_SUBMENU_POINTER_X
    sta InventoryPointerX
    lda InventoryPointerY
    sta OldInventoryPointerY
    lda #MENU_SUBMENU_POINTER_MIN_Y
    sta InventoryPointerY

    rts


;--------------------------------------
FoodMenuInput:
    lda #16
    sta MenuStep

    lda InVillagerHut
    bne @smallerMenu
    lda InHouse
    beq @smallestMenu

    lda #144
    jmp @saveLimit

@smallestMenu:
    lda #112
    jmp @saveLimit

@smallerMenu:
    lda #128
@saveLimit:
    sta MenuLowerLimit
    lda #96
    sta MenuUpperLimit
    lda #<FoodMenuIndex
    sta pointer
    lda #>FoodMenuIndex
    sta pointer + 1

    lda InVillagerHut
    bne @villagerMenuHeight

    lda InHouse
    beq @OutdoorMenuHeight

    lda #4
    jmp @maxItem

@OutdoorMenuHeight:
    lda #2
    jmp @maxItem

@villagerMenuHeight:
    lda #3
@maxItem:
    sta MenuMaxItem

    jsr MenuInputUpDownCheck

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda InVillagerHut
    bne @villagerInput

    lda InHouse
    beq @outdoorInput

    jsr FoodMenuInputAtHome
    beq @exit
    jmp @hidemenu
@outdoorInput:
    jsr FoodMenuInputOutdoors
    beq @exit
    jmp @hidemenu

@villagerInput:

    jsr FoodMenuInputVillager
    beq @exit

@hidemenu:
    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
    jsr ExitSubmenu
    jmp @exit

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
    jsr ExitSubmenu
@exit:
    rts
;------------------------------
FoodMenuInputOutdoors:

    lda FoodMenuIndex
    bne @otherOptions
    ;eat

    jsr UseFood
    jmp @clear

@otherOptions:
@clear:
    jsr ClearThatItem


    lda #1
    jmp @end

@exit:
    lda #0

@end:


    rts

;------------------------------
FoodMenuInputAtHome:
    lda FoodMenuIndex
    bne @otherOptions
    ;cook
    jsr CookMeat
    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
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
    jsr ClearThatItem

    lda #1
    jmp @end


@exit:
    lda #0


@end:
    rts
;------------------------------------
;food menu while visiting a villager
FoodMenuInputVillager:

    stx TempRegX
    lda FoodMenuIndex
    bne @otherOptions
    ;eat

    jsr UseFood
    jmp @clear

@otherOptions:

    cmp #1
    bne @clear ; drop

    ;give item

    jsr GetPaletteFadeValueForHour
    cmp #$40
    bne @continue

    lda VillagerIndex
    beq @exit ;can't give item to a bear at night

@continue:
    lda ItemIGave
    bne @exit ; already gave an item

    ldx TempRegX

    lda VillagerIndex
    tay
    asl
    asl ; villager index * 4
    clc
    adc ActiveVillagerQuests, y
    tay
    lda Inventory, x
    cmp goal_items_list, y
    bne @exit

    jsr SpawnRewardItem

@clear:
    jsr ClearThatItem


    lda #1
    jmp @end

@exit:
    lda #0

@end:
    ldx TempRegX
    rts



;-------------------------------------
ClearThatItem:
    lda StashActivated
    beq @useInventory
    lda #0
    sta Storage, x
    inx
    sta Storage, x
    jmp @hidemenu
@useInventory:
    lda #0
    sta Inventory, x
    inx
    sta Inventory, x
@hidemenu:

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

    lda #16
    sta MenuStep
    lda #112
    sta MenuLowerLimit
    lda #96
    sta MenuUpperLimit
    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1
    lda #2
    sta MenuMaxItem
    jsr MenuInputUpDownCheck


@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda ItemMenuIndex
    bne @clearItem ; DROP

    lda InVillagerHut
    bne @giveItem

    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @exit ;failed to add to stash
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @exit ;failed to retrieve
    jmp @clearItem

@giveItem:
    stx TempRegX
    jsr GetPaletteFadeValueForHour
    cmp #$40
    bne @continue

    lda VillagerIndex
    beq @exit ;can't give item to a bear at night
@continue:
    lda ItemIGave
    bne @exit ; already gave an item

    ldx TempRegX

    lda VillagerIndex
    tay
    asl
    asl ; villager index * 4
    clc
    adc ActiveVillagerQuests, y
    tay
    lda Inventory, x
    cmp goal_items_list, y
    bne @exit

    jsr SpawnRewardItem



@clearItem:
    jsr ClearThatItem
@hidemenu:
    jsr HideSubMenu
@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    jsr HideSubMenu
@exit:
    rts
;------------------------------------
ToolInput:

    lda #16
    sta MenuStep
    lda #96
    sta MenuUpperLimit
    lda #128
    sta MenuLowerLimit
    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1
    lda #3
    sta MenuMaxItem
    jsr MenuInputUpDownCheck

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    lda SpearData
    lsr
    bcs @exit ; can't equip anything when you throw a spear

    jsr LoadSelectedItemStuff
    beq @exit

    lda InVillagerHut
    beq @inputAtHome

    jsr ToolMenuInputVillager
    jmp @exit

@inputAtHome:
    jsr ToolMenuInputAtHome
    jmp @exit

@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

@hidemenu:
    jsr HideSubMenu
@exit:
    rts
;-------------------------------------
ToolMenuInputAtHome:

    lda ItemMenuIndex
    bne @checkIfStash

    lda TempIndex
    cmp #ITEM_TYPE_CLOTHING
    beq @equipClothes

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jmp @clearItem ;return 1

@equipClothes:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jmp @clearItem ;return 1


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
    jsr ClearThatItem


@hidemenu:
    jsr HideSubMenu

@exit:

    rts
;-------------------------------------
ToolMenuInputVillager:

    lda ItemMenuIndex
    bne @checkIfGive

    lda TempIndex
    cmp #ITEM_TYPE_CLOTHING
    beq @equipClothes

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jmp @clearItem ;return 1

@equipClothes:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jmp @clearItem ;return 1


@checkIfGive:
    cmp #1
    bne @clearItem ; DROP


    stx TempRegX
    jsr GetPaletteFadeValueForHour
    cmp #$40
    bne @continue

    lda VillagerIndex
    beq @exit  ; no giving at night to bear
@continue:
    lda ItemIGave
    bne @exit ; already gave item

    ldx TempRegX
    lda VillagerIndex
    tay
    asl
    asl
    clc
    adc ActiveVillagerQuests, y
    tay
    lda Inventory, x
    cmp goal_items_list, y
    bne @exit


    jsr SpawnRewardItem


@clearItem:
    jsr ClearThatItem


@hidemenu:
    jsr HideSubMenu

@exit:

    rts
;-------------------------------------
;active quest index is in y register
;a register contains the quest item id
SpawnRewardItem:

    sta ItemIGave
    
    lda reward_items_list, y
    beq @no_item
    asl
    ora #%00000001
    sta Items
    lda #0
    sta Items + 1
    lda #120
    sta Items + 2
    lda #108
    sta Items + 3

    lda #1
    sta ItemCount


@no_item:
    lda #1
    sta MustExitMenuState


    rts

;-------------------------------------
;pointer - EquipedItem or EquipedClothing
EquipItem:

    ldy #0
    lda (pointer), y
    sta Temp
    ldy #1
    lda (pointer), y ;item's hp
    sta TempHp
    ;--
    lda StashActivated
    beq @inventory
    lda Storage, x
    ldy #0
    sta (pointer), y
    inx
    lda Storage, x
    jmp @equip_hp
@inventory:
    lda Inventory, x
    ldy #0
    sta (pointer), y
    inx
    lda Inventory, x
@equip_hp:
    ldy #1
    sta (pointer), y
    dex
    ;--
    lda Temp
    beq @clearItem
    lda StashActivated
    beq @useInv
    lda Temp
    sta Storage, x
    inx
    lda TempHp
    sta Storage, x
    jmp @hidemenu
@useInv:
    lda Temp
    sta Inventory, x
    inx
    lda TempHp
    sta Inventory, x
    jmp @hidemenu


@clearItem:
    lda #1 ; clear item
    jmp @exit
@hidemenu:
    lda #0
@exit:
    rts

;-------------------------------------
ItemMenuInput:

    lda #16
    sta MenuStep
    lda #96
    sta MenuUpperLimit
    lda #128
    sta MenuLowerLimit
    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1
    lda #3
    sta MenuMaxItem
    jsr MenuInputUpDownCheck

@CheckB:
    lda Buttons
    and #BUTTON_B_MASK
    beq @CheckA

    jsr LoadSelectedItemStuff
    beq @exit

    lda ItemMenuIndex
    bne @checkIfStash
    ;use

    lda TempItemIndex
    cmp #ITEM_RADIO
    bne @checktype
    lda #1
    sta PlayerWins
    sta MustExitMenuState
@checktype:
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
    jsr ClearThatItem
@hidemenu:
    jsr HideSubMenu
@CheckA:
    lda Buttons
    and #BUTTON_A_MASK
    beq @exit

    jsr HideSubMenu
@exit:
    rts

;---------------------------------
HideSubMenu:
    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
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
    ldy #254
@inventoryLoop:
    iny
    iny
    cpy #INVENTORY_MAX_SIZE
    bcs @fail
    lda Inventory, y
    bne @inventoryLoop
    lda Storage, x
    sta Inventory, y
    ;transfer item's hp
    inx
    iny
    lda Storage, x
    sta Inventory, y
    dex

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
    ldy #254
@stashLoop:
    iny
    iny
    cpy #INVENTORY_MAX_SIZE
    bcs @fail
    lda Storage, y
    bne @stashLoop
    lda Inventory, x
    sta Storage, y
    ;store item's hp
    inx
    iny
    lda Inventory, x
    sta Storage, y
    dex

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

    lda #16
    sta MenuStep
    lda #BASE_MENU_MIN_Y + 64
    sta MenuLowerLimit
    lda #BASE_MENU_MIN_Y
    sta MenuUpperLimit
    lda #<BaseMenuIndex
    sta pointer
    lda #>BaseMenuIndex
    sta pointer + 1
    lda #5
    sta MenuMaxItem
    jsr MenuInputUpDownCheck

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

    cmp #1
    beq @equipment

    ;sleep
    lda InHouse
    beq @exit

    jsr StartSleep
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

@equipment:
    jsr OpenEquipment
    jmp @exit

@activateInventory:
    jsr OpenupInventory
    jmp @exit

@setPointerToSleep:

    lda #0
    sta PlayerInteractedWithBed
    lda #4
    sta BaseMenuIndex
    lda #BASE_MENU_MIN_Y + 64
    sta InventoryPointerY


@exit:

    rts
;------------------------------------
MenuInputUpDownCheck:

@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda InventoryPointerY
    cmp MenuLowerLimit
    bcs @rewindUp;
    clc
    adc MenuStep
    sta InventoryPointerY
    ldy #0
    lda (pointer), y
    clc
    adc #1
    sta (pointer), y

    jmp @exit

@rewindUp:
    lda MenuUpperLimit
    sta InventoryPointerY
    lda #0
    ldy #0
    sta (pointer), y

    jmp @exit

@CheckUp:
    lda Buttons
    and #BUTTON_UP_MASK
    beq @exit

    lda InventoryPointerY
    cmp MenuUpperLimit
    beq @rewindDown
    sec
    sbc MenuStep
    sta InventoryPointerY
    ldy #0
    lda (pointer), y
    sec
    sbc #1
    sta (pointer), y
    jmp @exit
@rewindDown:
    lda MenuLowerLimit
    sta InventoryPointerY
    lda MenuMaxItem
    sec
    sbc #1
    ldy #0
    sta (pointer), y
@exit:
    rts

;------------------------------------
OpenEquipment:
    lda #1
    sta MustLoadSomething
    sta MustDrawMenuTitle
    sta EquipmentActivated
    sta MustDrawEquipmentGrid
    lda #INVENTORY_SPRITE_MIN_Y
    sta InventoryPointerY

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
StartSleep:

    lda #1
    sta MustExitMenuState
    sta PaletteFadeAnimationState ; set fade-out
    lda #FADE_DELAY_SLEEP
    sta PaletteAnimDelay
    sta MustSleepAfterFadeOut

    lda #<house_palette
    sta PalettePtr
    lda #>house_palette
    sta PalettePtr + 1

    lda #0
    sta PaletteFadeTimer
    sta FadeIdx


    rts
;--------------------------------------
CookMeat:
    lda InHouse
    beq @cantcook

    lda TempItemIndex
    cmp #ITEM_RAW_MEAT
    beq @startCooking
    cmp #ITEM_RAW_JUMBO_MEAT
    beq @startCooking
    cmp #ITEM_RAW_FISH
    beq @startCooking

    jmp @cantcook

@startCooking:
    lda Fuel
    clc
    adc Fuel + 1
    cmp #0
    bne @cook ; fuel > 9

    lda Fuel + 2
    cmp #COOKING_FUEL_COST
    bcc @cantcook

@cook:
    jsr DoCooking
    lda TempItemIndex
    cmp #ITEM_RAW_MEAT
    bne @checkNextItem
    lda #ITEM_COOKED_MEAT
    jmp @storeResult
@checkNextItem:
    cmp #ITEM_RAW_JUMBO_MEAT
    bne @checkNextItem2
    lda #ITEM_COOKED_JUMBO_MEAT
    jmp @storeResult
@checkNextItem2:
    lda #ITEM_COOKED_FISH

@storeResult:
    sta Temp
    lda StashActivated
    bne @putToStash

    lda Temp
    sta Inventory, x ; put cooked meat
    jmp @cantcook
@putToStash:
    lda Temp
    sta Storage, x
@cantcook:

    rts
;--------------------------------------
DoCooking:
    lda #MAX_FUEL_DELAY
    sta FuelDelay

    stx TempPush ;preserve x register

    lda #COOKING_FUEL_COST
    sta DigitChangeSize

    lda #<Fuel
    sta DigitPtr
    lda #>Fuel
    sta DigitPtr + 1

    jsr DecreaseDigits


    lda #WARMTH_COOKING_INCREASE
    sta DigitChangeSize
    lda #<Warmth
    sta DigitPtr
    lda #>Warmth
    sta DigitPtr + 1
    jsr IncreaseDigits

    lda #COOKING_TIME
    sta ParamTimeValue
    jsr SkipTime


    ldx TempPush


    rts
;--------------------------------------
LoadSelectedItemStuff:
    lda InventoryItemIndex
    asl ;item_index * 2
    tax

    lda StashActivated ; let's check what's active
    beq @useInventory
    lda Storage, x
    sta TempItemIndex
    jmp @cont
@useInventory:
    lda Inventory, x
    sta TempItemIndex
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

    lda #MENU_ITEM_SPRITE_MIN_Y
    sta TempTileYPos

    lda InventoryActivated
    bne @itemLoop

    lda StashActivated
    clc
    adc CraftingActivated
    adc EquipmentActivated
    adc SubMenuActivated
    cmp #0
    beq @ThePointer

@itemLoop:
    lda EquipmentActivated
    beq @checkIfStash
    lda EquipedItem, x
    jmp @cnt

@checkIfStash:
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
    iny ;increment data index
    lda TempTileYPos
    clc
    adc #INVENTORY_STEP_PIXELS
    sta TempTileYPos
    jmp @next
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
    lda EquipmentActivated
    beq @invenotryprobably
    inx
    inx
    cpx #4 ;both EquipedItem and EquipedClothing plus their hps
    bcc @itemLoop
    jmp @ThePointer
@invenotryprobably:
    inx ;item hp
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @itemLoop

@ThePointer:

    lda SubMenuActivated
    beq @singlePointer
    
    ldx TempSpriteIdx
    lda OldInventoryPointerY
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #$FC
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #%00000000
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #INVENTORY_POINTER_X
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inc TempSpriteIdx
    inx


@singlePointer:
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
    lda #%00000001
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda InventoryPointerX
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inc TempSpriteIdx


    inx

    lda CraftingActivated
    beq @hideSprites
    lda CurrentCraftingComponent
    beq @hideSprites

    ldx #0
    lda CraftingIndexes, x
    lsr
    tax
    lda inventorypositions, x
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #$FC
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #%01000001
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #MENU_CRAFT_POINTER_POS
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inc TempSpriteIdx
    inx


@hideSprites:
    lda #MAX_SPRITE_COUNT - 1

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

;---------------------------------
;skips a time interval 
;specified by ParamTimeValue
SkipTime:
    lda Hours
    clc
    adc ParamTimeValue
    sta Hours
    bcs @increaseDays
    cmp #HOURS_MAX
    bcs @increaseDays
    jmp @exit

@increaseDays:
    lda Hours
    sec
    sbc #HOURS_MAX
    sta Hours
    jsr IncreaseDays
    jsr ResetTimesWhenItemsWerePicked
    jsr RotFood

@exit:
    rts


;---------------------------------
;pointer - storage or inventory
RotFood:

    ldy #0
@loop:
    sty TempInventoryItemIndex
    tya
    asl ; y * 2
    tay

    lda (pointer), y
    beq @nextItem       ;if empty

    cmp #ITEM_RAW_MEAT
    beq @setRaw
    cmp #ITEM_RAW_JUMBO_MEAT
    beq @setRaw
    cmp #ITEM_RAW_FISH
    beq @setRaw
    jmp @checkCooked

@setRaw:
    lda #ROT_AMOUNT_RAW_MEAT
    sta RotAmount
    jmp @rot

@checkCooked:
    cmp #ITEM_COOKED_MEAT
    beq @setCooked
    cmp #ITEM_COOKED_JUMBO_MEAT
    beq @setCooked
    cmp #ITEM_COOKED_FISH
    beq @setCooked

    jmp @nextItem

@setCooked:
    lda #ROT_AMOUNT_COOKED_MEAT
    sta RotAmount
@rot:
    iny
    lda (pointer), y
    cmp RotAmount
    bcc @turnToPoop
    beq @turnToPoop

    sec
    sbc RotAmount
    sta (pointer), y
    jmp @nextItem


@turnToPoop:
    dey
    lda #ITEM_POOP
    sta (pointer), y

    
@nextItem:
    ldy TempInventoryItemIndex ; stored item index
    iny
    cpy #INVENTORY_MAX_ITEMS
    bcc @loop

    rts
;----------------------------------

.segment "CODE"

ExitMenuState:
    lda #STATE_GAME
    sta GameState

    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
    lda OldInventoryPointerY
    sta InventoryPointerY

    lda #0
    sta StashActivated

    lda MustSleepAfterFadeOut ;little hack
    bne @loadHousePalette
    jsr ClearPalette
    jmp @cont
@loadHousePalette:

    ldy #0
@paletteCopy:
    lda house_palette, y
    sta RamPalette, y
    iny
    cpy #PALETTE_SIZE_MAX
    bne @paletteCopy
    lda #1
    sta MustUpdatePalette
    lda #PALETTE_SIZE_MAX
    sta PaletteUpdateSize

@cont:
    lda InHouse
    beq @loadOther ;InHouse = 0
    lda #1
    sta MustLoadHouseInterior
    sta MustLoadSomething
    jmp @exit
@loadOther:
    lda InVillagerHut
    beq @loadOutside

    lda #1
    sta MustLoadHouseInterior
    sta MustLoadSomething
    jmp @exit

@loadOutside:
    lda #1
    sta MustLoadOutside
    sta MustLoadSomething
@exit:
    ldx LocationIndex
    ldy LocationBanks, x
    bankswitch

    rts
;-------------------------------------

