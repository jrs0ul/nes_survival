LoadMenu:

    lda MustLoadMenu
    beq @exit


    lda current_bank
    cmp #1
    beq @cont
    ;uh-oh, wrong bank!
    ;probably the NMI switched back to a previous bank
    lda #0
    sta MustLoadMenu
    sta MustLoadSomething
    jmp @exit
@cont:
    lda #$00
    sta $2000
    sta $2001

    lda #<menu_screen
    sta pointer
    lda #>menu_screen
    sta pointer + 1
    lda FirstNametableAddr
    sta NametableAddress
    jsr DecompressRLE


    lda #<menu_palette
    sta pointer
    lda #>menu_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette


    jsr UpdateMenuStats

    jsr ResetMenuVars

    lda #1
    sta MustUpdateSunMoon

    lda #0
    sta MustUpdatePalette
    sta MustLoadSomething

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit

    lda #$00
    sta Temp
    jsr ColorMainMenuAttributes


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
;---------------------------------------
LoadStatusBar:
    ldy #$00
    ldx #128 ;tiles
    lda $2002
    lda #$20
    sta $2006
    lda #$00
    sta $2006
InitializeStatusBarLoop:     ; copy status bar to first nametable
    lda StatusBar, y
    sta $2007
    iny
    dex
    bne InitializeStatusBarLoop 

    lda #$00
    sta $2006
    sta $2006
    sta $2005
    sta $2005
    lda #1
    sta HpUpdated
    sta FoodUpdated
    sta WarmthUpdated
    rts

;------------------------------------------
ResetOverlayedMenuVars:

    lda #0
    sta MustBlinkFuel
    sta FuelBlinkIteration
    sta MustClearSubMenu
    sta MustDrawDocument
    sta MustDrawSleepMessage
    sta MustDrawInventoryGrid
    sta MustDrawEquipmentGrid
    sta MustDrawMenu
    sta MustResetMenu
    sta MenuStepLast
    sta DocumentJustClosed
    sta FoodMenuIndex
    sta ItemMenuIndex
    ldx #0
@craftingIndexesLoop:
    sta CraftingIndexes, x
    inx
    cpx #4
    bcc @craftingIndexesLoop

    sta InventoryActivated
    sta SubMenuIndex
    sta SubMenuActivated
    sta SleepMessageActivated
    sta DocumentActivated
    sta ActiveDocument

    sta CraftingActivated
    sta EquipmentActivated
    sta CurrentCraftingComponent


    rts

;------------------------------------------
ResetMenuVars:

    lda #0
    sta MustLoadMenu
    sta CraftingActivated
    sta StashActivated
    sta InventoryActivated
    sta InventoryItemIndex
    sta EquipmentActivated
    sta BaseMenuIndex
    sta SubMenuIndex

    lda #INVENTORY_POINTER_X
    sta InventoryPointerX

    lda #BASE_MENU_MIN_Y
    sta InventoryPointerY


    rts


;------------------------------------------
UpdateMenuGfx:

    jsr BlinkFuel
    jsr ResetMenu
    jsr DrawMenuTitle
    jsr DrawInventoryGrid
    jsr DrawEquipmentGrid
    jsr DrawSleepMenu
    jsr DrawFoodMenu
    jsr DrawItemMenu
    jsr DrawMaterialMenu
    jsr DrawToolMenu
    jsr DrawDocumentMenu
    jsr DrawStashMaterialMenu
    jsr DrawStashToolMenu
    jsr DrawStashFoodMenu
    jsr DrawStashItemMenu
    jsr DrawStashDocumentMenu
    jsr DrawDocument
    jsr DrawSleepMessage
    jsr ClearSubMenu


    lda menuTileTransferRowIdx
    bne @exit ; not finished updating gfx

    lda MustBlinkFuel
    bne @exit ; keep blinking

    lda #0
    sta MustLoadSomething

    lda DocumentJustClosed
    beq @exit

    lda #0
    sta DocumentActivated
    sta DocumentJustClosed
    lda #1
    sta MustLoadSomething
    lda StashActivated
    bne @stash
    lda #SUBMENU_DOCUMENT
    sta MustDrawMenu
    jmp @exit
@stash:
    lda #SUBMENU_STASH_DOCUMENT
    sta MustDrawMenu

@exit:
    rts

;----------------------------------
BlinkFuel:

    lda MustBlinkFuel
    beq @exit

    ldy FuelBlinkIteration
    lda FuelBlinkPosition, y
    tay

    ldx #0

@attrLoop:
    lda $2002
    lda FirstNametableAddr
    clc
    adc blink_fuel_OFF_attributes, y
    sta $2006
    inx
    iny
    lda blink_fuel_OFF_attributes, y
    sta $2006

    iny
    inx
    lda blink_fuel_OFF_attributes, y
    sta $2007

    iny
    inx
    cpx #MENU_FUEL_BLINK_ATTR_SIZE
    bcc @attrLoop

    inc FuelBlinkIteration
    lda FuelBlinkIteration
    cmp #MENU_FUEL_BLINK_IT_COUNT ; is this max iteration ?
    bcc @exit

    lda #0
    sta MustBlinkFuel
    sta FuelBlinkIteration


@exit:
    rts

;----------------------------------
ResetMenu:

    lda MustResetMenu
    bne @cont

    rts

@cont:

    lda menuTileTransferRowIdx
    bne @continueTileTransfer

    jsr UpdateMenuStats
    jsr ResetMenuVars


@continueTileTransfer:

    lda TransferingSecondMenuPart
    bne @secondPart

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$03
    sta TempX

    lda #13
    sta TempPointX
    lda #9
    sta TempPointY


    lda #<MainMenu
    sta pointer
    lda #>MainMenu
    sta pointer + 1
    jsr TransferTiles
    beq @exit

    lda #0
    sta menuTileTransferRowIdx
    lda #1
    sta TransferingSecondMenuPart

@secondPart:
    lda #1
    sta RepeatSameRowInTransfer
    lda #8
    sta TempPointY
    lda #13
    sta TempPointX

    lda FirstNametableAddr
    clc
    adc #2
    sta Temp

    lda #$23
    sta TempX


    lda #<MainMenuEmpty
    sta pointer
    lda #>MainMenuEmpty
    sta pointer + 1
    jsr TransferTiles
    beq @exit

    lda #0
    sta MustResetMenu
    sta menuTileTransferRowIdx
    sta RepeatSameRowInTransfer
    sta TransferingSecondMenuPart
    lda #1
    sta MustDrawMenuTitle

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @exit


    lda #$FF
    sta Temp
    jsr ColorMainMenuAttributes


@exit:
    rts


;----------------------------------
DrawMenuTitle:
    lda MustDrawMenuTitle
    bne @cont

    rts
@cont:
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
    lda InventoryActivated
    beq @SleepTitle
    lda #10
    sta TempPointX
    lda #<inventory_title
    sta pointer
    lda #>inventory_title
    sta pointer + 1
    jmp @draw
@SleepTitle:
    lda SubMenuActivated
    beq @empty
    lda SubMenuIndex
    cmp #SUBMENU_SLEEP
    bne @empty
    lda #10
    sta TempPointX
    lda #<sleep_title
    sta pointer
    lda #>sleep_title
    sta pointer + 1
    jmp @draw

@empty:

    lda #10
    sta TempPointX
    lda #<empty_title
    sta pointer
    lda #>empty_title
    sta pointer + 1


@draw:
    jsr TransferTiles

    ;let's assume it's jut one row
    lda #0
    sta MustDrawMenuTitle
    sta menuTileTransferRowIdx

@exit:
    rts
;----------------------------------
DrawInventoryGrid:
    lda MustDrawInventoryGrid
    beq @exit

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @cont


    lda #$00
    sta Temp
    jsr ColorMainMenuAttributes

@cont:

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_ITEM_GRID_ADDRESS
    sta TempX

    lda #10
    sta TempPointX
    lda CraftingActivated
    beq @regularInventory
    lda #17
    jmp @storeHeight
@regularInventory:
    lda #16
@storeHeight:
    sta TempPointY

    lda #<inventory_grid
    sta pointer
    lda #>inventory_grid
    sta pointer + 1

    jsr TransferTiles
    beq @exit; not fully drawn

    lda #0
    sta MustDrawInventoryGrid
    sta menuTileTransferRowIdx
    sta MustLoadSomething

@exit:
    rts
;----------------------------------
DrawEquipmentGrid:
    lda MustDrawEquipmentGrid
    beq @exit

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @cont

    lda #$00
    sta Temp
    jsr ColorMainMenuAttributes

@cont:
    lda TransferingSecondMenuPart
    bne @secondPart

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_ITEM_GRID_ADDRESS
    sta TempX

    lda #10
    sta TempPointX
    lda #7
    sta TempPointY

    lda #<equipment_grid
    sta pointer
    lda #>equipment_grid
    sta pointer + 1
    jsr TransferTiles
    beq @exit ; not done yet

    lda #1
    sta TransferingSecondMenuPart
    sta RepeatSameRowInTransfer
    lda #0
    sta menuTileTransferRowIdx

@secondPart:

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$E3
    sta TempX


    lda #13
    sta TempPointX
    lda #11 ; 11 empty rows
    sta TempPointY

    lda #<MainMenuEmpty
    sta pointer
    lda #>MainMenuEmpty
    sta pointer + 1
    jsr TransferTiles
    beq @exit ; not done yet



    lda #0
    sta TransferingSecondMenuPart
    sta RepeatSameRowInTransfer
    sta MustDrawEquipmentGrid
    sta menuTileTransferRowIdx

@exit:
    rts
;----------------------------------
DrawSleepMessage:

    lda MustDrawSleepMessage
    beq @exit

    lda TransferingSecondMenuPart
    bne @secondPart

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$23
    sta TempX

    lda #12
    sta TempPointX

    lda #5
    sta TempPointY

    lda #<sleep_msg_background
    sta pointer
    lda #>sleep_msg_background
    sta pointer + 1


    jsr TransferTiles
    beq @exit; not done

    lda #0
    sta menuTileTransferRowIdx
    lda #1
    sta TransferingSecondMenuPart

@secondPart:

    lda SubMenuIndex
    asl ; x2
    tay

    lda sleep_msg_ptr, y
    sta pointer
    iny
    lda sleep_msg_ptr, y
    sta pointer + 1

    lda #6
    sta TempPointX

    lda #1
    sta TempPointY

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #$48
    sta TempX


    jsr TransferTiles
    beq @exit


    lda #0
    sta TransferingSecondMenuPart
    sta MustDrawSleepMessage
    sta menuTileTransferRowIdx


@exit:
    rts

;----------------------------------
DrawDocument:
    lda MustDrawDocument
    bne @continue

    rts

@continue:

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #MAX_LETTER_OBJECT_COUNT ; letter count - 1
    sta TempNpcSpeed
@loop:
    lda TempNpcSpeed ; index * 4
    asl
    asl
    tay


    lda document_item_data, y
    cmp ActiveDocument
    beq @LoadMoreData
    lda TempNpcSpeed
    sec
    sbc #1
    sta TempNpcSpeed
    bpl @loop ;not found
    jmp @exit

@LoadMoreData:
    iny
    lda document_item_data, y
    sta TempPointX

    lda #12
    sta TempPointY

    iny
    lda document_item_data, y
    sta pointer
    iny
    lda document_item_data, y
    sta pointer + 1


    jsr TransferTiles
    beq @exit; not done

    lda #0
    sta MustDrawDocument
    sta menuTileTransferRowIdx

    ldy #0
@attributeLoop:

    lda $2002
    lda FirstNametableAddr
    clc
    adc document_attributes, y
    sta $2006
    iny
    lda document_attributes, y
    sta $2006
    iny
    lda document_attributes, y
    sta $2007
    iny
    cpy #18
    bcc @attributeLoop

@exit:
    rts
;---------------------------------
DrawSleepMenu:
    lda MustDrawMenu
    cmp #SUBMENU_SLEEP
    bne @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #04
    sta TempX

    lda #9
    sta TempPointX

    lda #<SleepConfirmation
    sta pointer
    lda #>SleepConfirmation
    sta pointer + 1
    lda #9
    sta TempPointY

    jsr TransferTiles
    beq @exit ; not done

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx


@exit:
    rts

;----------------------------------
DrawStashDocumentMenu:

    lda MustDrawMenu
    cmp #SUBMENU_STASH_DOCUMENT
    bne @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX



    lda #<StashDocumentMenu
    sta pointer
    lda #>StashDocumentMenu
    sta pointer + 1
    lda #9
    sta TempPointY



@startTransfer:
    jsr TransferTiles
    beq @exit ; not done

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx


@exit:
    rts
;----------------------------------
DrawDocumentMenu:

    lda MustDrawMenu
    cmp #SUBMENU_DOCUMENT
    bne @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX


    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @villagerDocument
    cmp #LOCATION_TYPE_HOUSE
    beq @atHomeDocument

    lda #<DocumentMenu
    sta pointer
    lda #>DocumentMenu
    sta pointer + 1
    lda #7
    sta TempPointY
    jmp @startTransfer

@villagerDocument:

    lda #<DocumentMenuVillager
    sta pointer
    lda #>DocumentMenuVillager
    sta pointer + 1
    lda #9
    sta TempPointY
    jmp @startTransfer

@atHomeDocument:

    lda #<DocumentMenuAtHome
    sta pointer
    lda #>DocumentMenuAtHome
    sta pointer + 1
    lda #9
    sta TempPointY

@startTransfer:
    jsr TransferTiles
    beq @exit ; not done

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;----------------------------------
DrawFoodMenu:
    lda MustDrawMenu
    cmp #SUBMENU_FOOD
    bne @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @smallmenu
    cmp #LOCATION_TYPE_HOUSE
    bne @smallestmenu

    lda #11
    jmp @storeY

@smallmenu:

    lda #9
    jmp @storeY

@smallestmenu:
    lda #7

@storeY:
    sta TempPointY

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @villagerMenu
    cmp #LOCATION_TYPE_HOUSE
    bne @outdoorsMenu

    jsr IsFoodCooked
    bne @foodIsCooked

    lda #<FoodMenuAtHome
    sta pointer
    lda #>FoodMenuAtHome
    sta pointer + 1
    jmp @startTransfer
@foodIsCooked:
    lda #<CookedFoodMenuAtHome
    sta pointer
    lda #>CookedFoodMenuAtHome
    sta pointer + 1
    lda #9
    sta TempPointY
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
    beq @exit ; not done

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;-------------------------
DrawStashFoodMenu:
    lda MustDrawMenu
    cmp #SUBMENU_STASH_FOOD
    bne @exit

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #9
    sta TempPointX

    jsr IsFoodCooked
    bne @foodIsCooked


    lda #11
    sta TempPointY

    lda #<StashFoodMenu
    sta pointer
    lda #>StashFoodMenu
    sta pointer + 1
    jmp @transfer

@foodIsCooked:

    lda #9
    sta TempPointY

    lda #<StashCookedFoodMenu
    sta pointer
    lda #>StashCookedFoodMenu
    sta pointer + 1

@transfer:

    jsr TransferTiles
    beq @exit ; not fully transfered yet

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;-------------------------
DrawStashItemMenu:
    lda MustDrawMenu
    cmp #SUBMENU_STASH_ITEM
    bne @exit

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
    beq @exit

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:

    rts
;-------------------------
DrawToolMenu:
    lda MustDrawMenu
    cmp #SUBMENU_TOOL
    bne @exit

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


    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @regularMenu
    cmp #LOCATION_TYPE_VILLAGER
    bne @outdoorMenu

    lda #<ToolMenuVillager
    sta pointer
    lda #>ToolMenuVillager
    sta pointer + 1
    jmp @startTransfer

@outdoorMenu:
    lda #7
    sta TempPointY
    lda #<ToolMenuOutdoors
    sta pointer
    lda #>ToolMenuOutdoors
    sta pointer + 1

    jmp @startTransfer


@regularMenu:
    lda #<ToolMenu
    sta pointer
    lda #>ToolMenu
    sta pointer + 1

@startTransfer:
    jsr TransferTiles
    beq @exit ; not finished transfering

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;-------------------------
DrawStashToolMenu:
    lda MustDrawMenu
    cmp #SUBMENU_STASH_TOOL
    bne @exit

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
    beq @exit

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;-------------------------
;TempItemIndex - item index
;a - 1 -> yes
CanItemBeUsedOutdoors:

    lda TempItemIndex

    cmp #ITEM_ROWAN_BERRIES
    beq @yes
    cmp #ITEM_RADIO
    beq @yes
    cmp #ITEM_MEDICINAL_SHROOM
    beq @yes
    cmp #ITEM_POTION
    beq @yes


    jmp @no

@yes:
    lda #1
    jmp @end
@no:
    lda #0
@end:


    rts
;-------------------------
DrawItemMenu:
    lda MustDrawMenu
    cmp #SUBMENU_ITEM
    bne @exit

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

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @regularMenu
    cmp #LOCATION_TYPE_VILLAGER
    bne @outdoors

    jsr CanItemBeUsedOutdoors
    bne @usableVillager

    lda #7
    sta TempPointY
    lda #<MaterialMenuVillager
    sta pointer
    lda #>MaterialMenuVillager
    sta pointer + 1
    jmp @transfer

@usableVillager:
    lda #<ItemMenuVillager
    sta pointer
    lda #>ItemMenuVillager
    sta pointer + 1
    jmp @transfer

@outdoors:

    jsr CanItemBeUsedOutdoors
    bne @usable
    ;can't be used
    lda #5
    sta TempPointY
    lda #<MaterialMenuOutdoors
    sta pointer
    lda #>MaterialMenuOutdoors
    sta pointer + 1
    jmp @transfer


@usable:
    lda #7
    sta TempPointY
    lda #<ItemMenuOutdoors
    sta pointer
    lda #>ItemMenuOutdoors
    sta pointer + 1
    jmp @transfer


@regularMenu:
    lda #<ItemMenu
    sta pointer
    lda #>ItemMenu
    sta pointer + 1
@transfer:
    jsr TransferTiles
    beq @exit ; not done

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;---------------------------
DrawMaterialMenu:
    lda MustDrawMenu
    cmp #SUBMENU_MATERIAL
    bne @exit

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

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @villagermenu
    cmp #LOCATION_TYPE_HOUSE
    bne @outdoorsMenu

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
    jmp @transfertiles

@outdoorsMenu:
    lda #5
    sta TempPointY
    lda #<MaterialMenuOutdoors
    sta pointer
    lda #>MaterialMenuOutdoors
    sta pointer + 1


@transfertiles:
    jsr TransferTiles
    beq @exit ; not finished transfering

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts
;---------------------------
DrawStashMaterialMenu:
    lda MustDrawMenu
    cmp #SUBMENU_STASH_MATERIAL
    bne @exit

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
    beq @exit

    lda #0
    sta MustDrawMenu
    sta menuTileTransferRowIdx

@exit:
    rts

;----------------------------
ClearSubMenu:
    lda MustClearSubMenu
    bne @continue

    rts

@continue:

    lda FirstNametableAddr
    clc
    adc #1
    sta Temp

    lda #MENU_SUBMENU_ADDRESS_LOW
    sta TempX

    lda #15
    sta TempPointX
    lda #12
    sta TempPointY


    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @ClearOutdoor

    lda #<PopUpMenuClear_Home
    sta pointer
    lda #>PopUpMenuClear_Home
    sta pointer + 1
    jmp @transfer

@ClearOutdoor:
    lda #<PopUpMenuClear_Outside
    sta pointer
    lda #>PopUpMenuClear_Outside
    sta pointer + 1
@transfer:

    jsr TransferTiles
    beq @exit


    lda #0
    sta MustClearSubMenu
    sta menuTileTransferRowIdx

    lda DocumentActivated ; did you close a document ?
    beq @exit

    lda #1
    sta DocumentJustClosed


    ldy #0
@attributeLoop:

    lda $2002
    lda FirstNametableAddr
    clc
    adc bg_attributes_after_clear, y
    sta $2006
    iny
    lda bg_attributes_after_clear, y
    sta $2006
    iny
    lda bg_attributes_after_clear, y
    sta $2007
    iny
    cpy #18
    bcc @attributeLoop

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

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @fuelcounter

    lda $2002
    lda FirstNametableAddr
    clc
    adc #1
    sta $2006
    lda #$F4
    sta $2006

    ldy #10
@hideFuelLoop:

    lda #0
    sta $2007
    dey
    bne @hideFuelLoop

    jmp @daysCounter

@fuelcounter:

    lda $2002
    lda FirstNametableAddr
    clc
    adc #1
    sta $2006
    lda #$FB
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

@daysCounter:
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

@exit:


    rts
;-------------------------------------
;changes palette values of optional main menu items
;Temp - palette value
ColorMainMenuAttributes:

    lda $2002
    lda FirstNametableAddr
    clc
    adc #3
    sta $2006
    lda #$D9
    sta $2006
    lda Temp
    sta $2007
    sta $2007

    lda $2002
    lda FirstNametableAddr
    clc
    adc #3
    sta $2006
    lda #$E1
    sta $2006
    lda Temp
    sta $2007
    sta $2007



    rts


;-------------------------------------
MenuInput:

    lda MustLoadSomething ; don't check input while the menu is still being drawn
    beq @cont

    rts

@cont:
    lda Buttons
    cmp MenuButtons
    bne @continue
    rts

@continue:
    lda InventoryActivated
    bne @DoInventoryInput

    lda SubMenuActivated
    beq @skipSubmenuStuff

    lda DocumentActivated
    bne @DocumentStuff

    lda SleepMessageActivated
    bne @SleepMessageStuff

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

    cmp #SUBMENU_DOCUMENT
    beq @DoDocumentInput

    cmp #SUBMENU_STASH_DOCUMENT
    beq @DoDocumentInput

    cmp #SUBMENU_SLEEP
    beq @DoSleepInput

    jmp @skipSubmenuStuff

@SleepMessageStuff:
    jsr SleepMessageInput
    jmp @exit

@DocumentStuff:
    jsr ActivatedDocumentInput
    jmp @exit

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

@DoDocumentInput:
    jsr DocumentMenuInput
    jmp @exit

@DoSleepInput:
    jsr SleepMenuInput
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
ActivatedDocumentInput:

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    jsr HideDocument

@exit:
    rts
;-------------------------------------
SleepMessageInput:

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    lda #0
    sta SubMenuActivated
    sta SubMenuIndex
    sta SleepMessageActivated
    sta menuTileTransferRowIdx
    sta menuTileTransferDataIdx
    jsr UpdateMenuStats
    lda #1
    sta MustLoadSomething
    sta MustResetMenu

@exit:
    rts

;--------------------------------------
SleepMenuInput:

    lda #96
    sta MenuLowerLimit
    lda #2
    sta MenuMaxItem
    lda #16
    sta MenuStep
    lda #0
    sta MenuStepLast
    lda #80
    sta MenuUpperLimit

    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1


    jsr MenuInputUpDownCheck

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    lda ItemMenuIndex
    cmp #1 ; yes
    bne @hidemenu
    jsr StartSleep

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

@hidemenu:
    lda #0
    sta menuTileTransferRowIdx
    sta SubMenuActivated
    sta SubMenuIndex
    sta SleepMessageActivated
    sta MustDrawSleepMessage
    sta TransferingSecondMenuPart
    sta menuTileTransferDataIdx
    sta MustDrawMenu
    jsr UpdateMenuStats
    lda #1
    sta MustLoadSomething
    sta MustResetMenu



@exit:
    rts
;--------------------------------------
PlaySfx_InvenotryFull:
    lda #1
    sta MustPlaySfx
    lda #SFX_INVENTORY_FULL
    sta SfxName
    rts
;--------------------------------------
PlaySfx_ItemBreaks:
    lda #1
    sta MustPlaySfx
    lda #SFX_WEAPON_BREAKS
    sta SfxName

    rts
;--------------------------------------
PlaySfx_Pickup:
    lda #1
    sta MustPlaySfx
    lda #SFX_ITEM_PICKUP
    sta SfxName
    rts
;--------------------------------------
PlaySfx_Store:
    lda #1
    sta MustPlaySfx
    lda #SFX_STORE
    sta SfxName
    rts
;--------------------------------------
PlaySfx_Equip:
    lda #1
    sta MustPlaySfx
    lda #SFX_EQUIP
    sta SfxName
    rts

;--------------------------------------
DocumentMenuInput:

    lda #16
    sta MenuStep
    lda #0
    sta MenuStepLast
    lda #96
    sta MenuUpperLimit
    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1


    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @atVillager
    cmp #LOCATION_TYPE_HOUSE
    beq @atVillager

    lda #112
    sta MenuLowerLimit
    lda #2
    sta MenuMaxItem

    jmp @doInput

@atVillager:
    lda #128
    sta MenuLowerLimit
    lda #3
    sta MenuMaxItem


@doInput:
    jsr MenuInputUpDownCheck

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    jsr LoadSelectedItemInfo
    bne @goON
    rts

@goON:
    lda ItemMenuIndex
    bne @otherOptions

    ;Activate 'read' here
    lda #1
    sta MustLoadSomething
    sta MustDrawDocument
    sta DocumentActivated
    lda TempItemIndex
    sta ActiveDocument

    jmp @Cancel_pressed

@otherOptions:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @notAtHome

    ;options at home
    lda StashActivated
    bne @stashActive
    ;store or drop

    lda ItemMenuIndex
    cmp #1
    bne @discard
    ;store

    jsr StoreItemInStash
    bne @OutOfRoom ; can't store
    jsr PlaySfx_Store

    jmp @justDropIt
@stashActive: ; take or drop

    lda ItemMenuIndex
    cmp #1
    bne @discard

    ;take
    jsr TakeItemFromStash
    bne @OutOfRoom
    jsr PlaySfx_Pickup

    jmp @justDropIt

@notAtHome: ;give, drop

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    bne @discard

    ;give or drop
    lda ItemMenuIndex
    cmp #1
    bne @discard

    jsr GiveItem
    beq @hidemenu
    jmp @justDropIt

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

@justDropIt:
    jsr ClearThatItem
    jsr HideSubMenu


@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

@hidemenu:
    jsr HideSubMenu

@exit:
    rts

;--------------------------------------
CraftingInput:

    lda #12
    sta MenuStep
    lda #INVENTORY_SPRITE_MIN_Y
    sta MenuUpperLimit
    lda #INVENTORY_SPRITE_MAX_Y + 3
    sta MenuLowerLimit
    lda #<InventoryItemIndex
    sta pointer
    lda #>InventoryItemIndex
    sta pointer + 1
    lda #INVENTORY_MAX_ITEMS
    clc
    adc #1
    sta MenuMaxItem
    lda #15
    sta MenuStepLast
    jsr MenuInputUpDownCheck


@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    lda MenuMaxItem
    sec
    sbc #1
    cmp InventoryItemIndex

    beq @tryCrafting

    lda InventoryItemIndex
    asl ;item_index * 2
    tay
    lda Inventory, y
    beq @exit ;empty slot was picked
    tya
    ldx CurrentCraftingComponent
    cpx #0
    beq @storeIndex ; first ingredient, just store it
    sty TempY

    ldy CurrentCraftingComponent
@compareLoop:
    dey
    bmi @store
    lda CraftingIndexes, y
    cmp TempY
    beq @deselect
    jmp @compareLoop
@store:
    lda TempY
    jmp @storeIndex
@deselect:

    jsr DeselectRecipe
    jmp @exit

@storeIndex:
    sta CraftingIndexes, x
    lda CurrentCraftingComponent
    cmp #MAX_CRAFTING_INDEX
    bcs @exit
    inc CurrentCraftingComponent
    jmp @exit
@tryCrafting:
    jsr CraftFromSelectedComponents

    jmp @resetIndexes

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit
@revert:
    lda #1
    sta MustLoadSomething
    sta MustResetMenu
    lda #0
    sta CurrentCraftingComponent
@resetIndexes:
    lda #255
    ldx #0
    stx CurrentCraftingComponent
    sta CraftingIndexes, x
    inx
    sta CraftingIndexes, x
    inx
    sta CraftingIndexes, x
    inx
    sta CraftingIndexes, x

@exit:
    rts
;--------------------------------------
;TODO: optimize
DeselectRecipe:
    ;y is the recipe index
    cpy #0
    bne @checkOne
    ldy #1
    lda CraftingIndexes, y
    ldy #0
    sta CraftingIndexes, y
    ldy #2
    lda CraftingIndexes, y
    ldy #1
    sta CraftingIndexes, y
    ldy #3
    lda CraftingIndexes, y
    ldy #2
    sta CraftingIndexes, y
    jmp @checkThree
@checkOne:
    cpy #1
    bne @checkTwo
    ldy #2
    lda CraftingIndexes, y
    ldy #1
    sta CraftingIndexes, y
    ldy #3
    lda CraftingIndexes, y
    ldy #2
    sta CraftingIndexes, y
    jmp @checkThree
@checkTwo:
    cpy #2
    bne @checkThree
    ldy #3
    lda CraftingIndexes, y
    ldy #2
    sta CraftingIndexes, y
    jmp @checkThree
@checkThree:
    dec CurrentCraftingComponent
    rts

;-------------------------------------
TestAllIngredients:

    ldx #0
@ComponentLoop:
    cmp Ingredients, x
    beq @found
    inx
    cpx #4
    bcc @ComponentLoop
    jmp @exit
@found:
    lda #250 ; ingredient matches
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
    bcc @cont
    rts
@cont: ;store ingredients and the result into RAM
    ldy #0
@ingredientLoop:
    lda recipes, x
    sta Ingredients, y
    inx
    iny
    cpy #4
    bcc @ingredientLoop

    lda recipes, x
    sta Temp        ; Result
    stx TempRegX    ; store recipe data index


;--ingredientA
    ldx #0
    lda CraftingIndexes, x
    tay
    lda Inventory, y

    jsr TestAllIngredients
    cmp #250
    bne @loop ; no matches, next recipe
    sta Ingredients, x

;--ingredient B
    ldx #1
    lda CraftingIndexes, x
    tay
    lda Inventory, y

    jsr TestAllIngredients
    cmp #250
    bne @loop
    sta Ingredients, x

;--ingredient C
    ldx #2
    lda CraftingIndexes, x
    cmp #255
    beq @justCompareWithC
    tay
    lda Inventory, y

@justCompareWithC:

    jsr TestAllIngredients
    cmp #250
    bne @loop
    sta Ingredients, x

;--ingredient D
    ldx #3
    lda CraftingIndexes, x
    cmp #255
    beq @justCompareWithD
    tay
    lda Inventory, y
@justCompareWithD:

    jsr TestAllIngredients
    cmp #250
    bne @loop
    sta Ingredients, x

    sty TempY ; store the position of a newly made item

    ;play sfx on success
    lda #SFX_ITEM_PICKUP
    sta SfxName
    lda #1
    sta MustPlaySfx

   ;clear the ingredients
    ldx #0
@ingredientsClearLoop:
    lda CraftingIndexes, x
    cmp #255
    beq @nextIngredient
    tay
    lda #0
    sta Inventory, y
    iny
    sta Inventory, y ; reset item hp as well
@nextIngredient:
    inx
    cpx #3
    bcc @ingredientsClearLoop

    ;put the newly crafted item
    ldy TempY ;restore item's position
    lda Temp  ;result
    sta Inventory, y
    iny
    lda #ITEM_MAX_HP
    sta Inventory, y


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
    lda #1
    sta MustUpdateSunMoon


@exit:
    rts

;--------------------------------------
EquipmentInput:

    lda #12
    sta MenuStep
    lda #0
    sta MenuStepLast
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


@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    lda InventoryItemIndex
    bne @unequipCloth

    lda EquipedItem
    beq @exit ; no item equiped

    lda SpearData
    lsr
    bcs @exit ; you've launched a spear can't unequip it now

    lda FishingRodActive
    bne @exit ;  the fishing rod is active, can't unequip

    ;let's simply unequip

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr UnequipItem
    jsr PlaySfx_Store
    jmp @exit

@unequipCloth:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr UnequipItem
    jsr PlaySfx_Store
    jmp @exit

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    lda #0
    sta EquipmentActivated
    sta TransferingSecondMenuPart
    sta RepeatSameRowInTransfer
    sta menuTileTransferRowIdx

    lda #1
    sta MustLoadSomething
    sta MustResetMenu

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
    bcs @PlaySfx ; no place for an unequiped item
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
    jmp @exit
@PlaySfx:
    lda #SFX_INVENTORY_FULL
    sta SfxName
    lda #1
    sta MustPlaySfx
@exit:
    rts


;--------------------------------------
InventoryInput:

    lda #12
    sta MenuStep
    lda #0
    sta MenuStepLast
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


@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    jsr OnItemClicked
    jmp @exit

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    lda #0
    sta menuTileTransferRowIdx
    sta menuTileTransferDataIdx
    sta MustDrawInventoryGrid
    lda #1
    sta MustLoadSomething
    sta MustResetMenu


@exit:
    rts
;--------------------------------------
OnItemClicked:

    jsr LoadSelectedItemInfo
    bne @continue

    rts

@continue:

    lda TempIndex
    cmp #ITEM_TYPE_FOOD
    beq @addFood

    cmp #ITEM_TYPE_MATERIAL
    beq @material

    cmp #ITEM_TYPE_TOOL
    beq @tool
    cmp #ITEM_TYPE_CLOTHING
    beq @tool
    cmp #ITEM_TYPE_DOCUMENT
    beq @document

    ;regular item

    lda StashActivated
    beq @ItemFromInventory

    lda #1
    sta MustLoadSomething
    lda #SUBMENU_STASH_ITEM
    sta MustDrawMenu
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
    lda #SUBMENU_STASH_FOOD
    sta MustDrawMenu
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex


    jmp @exit
@useFromInventory:
    lda #1
    sta MustLoadSomething
    lda #SUBMENU_FOOD
    sta SubMenuIndex
    sta MustDrawMenu
    jsr ActivateSubmenu
    lda #0
    sta FoodMenuIndex
    sta InventoryActivated
    jmp @exit
;-----------
@material:
    jsr MaterialItemClicked
    jmp @exit
@document:
    lda StashActivated
    beq @fromInv
    jsr DocumentItemClickedInStash
    jmp @exit
@fromInv:
    jsr DocumentItemClicked
    jmp @exit

@tool:
    jsr ToolItemClicked

@exit:
    rts
;-------------------------------------
RegularItemClicked:
    lda #1
    sta MustLoadSomething
    lda #SUBMENU_ITEM
    sta MustDrawMenu
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    rts
;-------------------------------------
DocumentItemClicked:
    lda #1
    sta MustLoadSomething
    lda #SUBMENU_DOCUMENT
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated
    lda #SUBMENU_DOCUMENT
    sta MustDrawMenu
    rts
;------------------------------------
DocumentItemClickedInStash:
    lda #1
    sta MustLoadSomething
    lda #SUBMENU_STASH_DOCUMENT
    sta SubMenuIndex
    sta MustDrawMenu
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
    lda #SUBMENU_TOOL
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated
    lda #SUBMENU_TOOL
    sta MustDrawMenu
    
    jmp @exit

@stashedTool:

    lda #1
    sta MustLoadSomething
    lda #SUBMENU_STASH_TOOL
    sta SubMenuIndex
    sta MustDrawMenu
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
    lda #SUBMENU_MATERIAL
    sta MustDrawMenu
    sta SubMenuIndex
    jsr ActivateSubmenu
    lda #0
    sta ItemMenuIndex
    sta InventoryActivated

    jmp @exit
@stashedMaterial:
    lda #1
    sta MustLoadSomething
    lda #SUBMENU_STASH_MATERIAL
    sta MustDrawMenu
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
    lda #0
    sta MenuStepLast

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @smallerMenu
    cmp #LOCATION_TYPE_HOUSE
    bne @smallestMenu

    jsr IsFoodCooked
    bne @smallerMenu

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

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @villagerMenuHeight
    cmp #LOCATION_TYPE_HOUSE
    bne @OutdoorMenuHeight

    jsr IsFoodCooked
    bne @villagerMenuHeight ; cooked food menu same height as villager menu

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

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    jsr LoadSelectedItemInfo
    beq @exit

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @villagerInput
    cmp #LOCATION_TYPE_HOUSE
    bne @outdoorInput

    jsr IsFoodCooked
    bne @cookedFoodInput

    jsr FoodMenuInputAtHome
    beq @exit
    jmp @hidemenu
@outdoorInput:
    jsr FoodMenuInputOutdoors
    beq @exit
    jmp @hidemenu

@cookedFoodInput:
    jsr CookedFoodMenuInputAtHome
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

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
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
    bne @discard ; drop
    ;eat

    jsr UseFood
    jmp @clear

@discard:
    jsr PlaySfx_ItemBreaks

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
    bne @OutOfRoom
    jsr PlaySfx_Pickup
    jmp @clearItem
@storeItem:
    jsr StoreItemInStash
    bne @OutOfRoom
    jsr PlaySfx_Store
    jmp @clearItem
@checkEat:
    cmp #1
    bne @discard ;drop
    jsr UseFood
    jmp @clearItem

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

@clearItem:
    jsr ClearThatItem

    lda #1
    jmp @end


@exit:
    lda #0


@end:
    rts
;------------------------------------
CookedFoodMenuInputAtHome:
    lda FoodMenuIndex
    cmp #0
    beq @Eat

    cmp #1
    bne @discard ; drop

    lda StashActivated
    beq @storeItem
    jsr TakeItemFromStash
    bne @OutOfRoom
    jsr PlaySfx_Pickup
    jmp @clearItem
@storeItem:
    jsr StoreItemInStash
    bne @exit
    jsr PlaySfx_Store
    jmp @clearItem
@Eat:
    jsr UseFood
    jmp @clearItem

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

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
    bne @discard ; drop

    ;give item

    jsr GiveItem
    beq @exit
    jmp @clear


@discard:
    jsr PlaySfx_ItemBreaks

@clear:
    jsr ClearThatItem

    ldx TempRegX
    lda #1
    jmp @end

@exit:
    ldx TempRegX
    lda #0

@end:
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
    lda #0
    sta MenuStepLast

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @normal
    cmp #LOCATION_TYPE_HOUSE
    bne @Confirm_pressed

@normal:
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


@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    jsr LoadSelectedItemInfo
    beq @exit

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @cont
    cmp #LOCATION_TYPE_VILLAGER
    bne @discard ; drop if outdoors

@cont:
    lda ItemMenuIndex
    bne @discard ; DROP

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    beq @giveItem

    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @OutOfRoom ;failed to add to stash
    jsr PlaySfx_Store
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @OutOfRoom ;failed to retrieve
    jsr PlaySfx_Pickup
    jmp @clearItem

@giveItem:
    jsr GiveItem
    beq @hidemenu
    jmp @clearItem

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

@clearItem:
    jsr ClearThatItem
@hidemenu:
    jsr HideSubMenu

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    jsr HideSubMenu
@exit:
    rts
;------------------------------------
ToolInput:

    lda #16
    sta MenuStep
    lda #0
    sta MenuStepLast
    lda #96
    sta MenuUpperLimit
     lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @threeoptions
    cmp #LOCATION_TYPE_VILLAGER
    beq @threeoptions

    lda #112
    sta MenuLowerLimit
    lda #2
    sta MenuMaxItem
    jmp @doInput

@threeoptions:
    lda #128
    sta MenuLowerLimit
    lda #3
    sta MenuMaxItem
@doInput:
    jsr MenuInputUpDownCheck

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    lda SpearData
    lsr
    bcs @exit ; can't equip anything when you throw a spear

    lda FishingRodActive
    bne @exit  ; can't equip anything else while the rod is casted

    jsr LoadSelectedItemInfo
    beq @exit

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    bne @checkIfOutdoors

    jsr ToolMenuInputVillager
    jmp @exit

@checkIfOutdoors:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @atHome

    jsr ToolMenuInputOutdoors
    jmp @exit

@atHome:
    jsr ToolMenuInputAtHome
    jmp @exit

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
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
    bne @discard ; DROP
    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @OutOfRoom ;failed to add to stash
    jsr PlaySfx_Store
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @OutOfRoom ;failed to retrieve
    jsr PlaySfx_Pickup
    jmp @clearItem

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

@clearItem:
    jsr ClearThatItem

@hidemenu:
    jsr HideSubMenu

@exit:

    rts
;-------------------------------------
ToolMenuInputOutdoors:

    lda ItemMenuIndex
    bne @discard

    lda TempIndex
    cmp #ITEM_TYPE_CLOTHING
    beq @equipClothes

    lda #<EquipedItem
    sta pointer
    lda #>EquipedItem
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jsr PlaySfx_Equip
    jmp @clearItem ;return 1

@equipClothes:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jsr PlaySfx_Equip
    jmp @clearItem ;return 1

@discard:
    jsr PlaySfx_ItemBreaks

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
    jsr PlaySfx_Equip
    jmp @clearItem ;return 1

@equipClothes:
    lda #<EquipedClothing
    sta pointer
    lda #>EquipedClothing
    sta pointer + 1
    jsr EquipItem
    beq @hidemenu ;return 0
    jsr PlaySfx_Equip
    jmp @clearItem ;return 1


@checkIfGive:
    cmp #1
    bne @discard; DROP

    jsr GiveItem
    beq @hidemenu
    jmp @clearItem

@discard:
    jsr PlaySfx_ItemBreaks

@clearItem:
    jsr ClearThatItem

@hidemenu:
    jsr HideSubMenu

@exit:

    rts
;-------------------------------------
;active quest index is in y register
;a register contains the quest item id
;y - goal item index
;a - is item id
SpawnRewardItem:

    sta Temp

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
    jmp @done

@no_item:
    lda #1
    ldy VillagerIndex
    sta QuestRewardsTaken, y
@done:
    lda #1
    sta MustExitMenuState

    lda Temp
    ldy VillagerIndex
    sta ItemIGave, y


    rts
;------------------------------------
SpawnSpecialReward:

    sta Temp
    lda special_reward_items, y
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

    ldy VillagerIndex
    lda Temp
    sta SpecialItemsDelivered, y

    tya
    asl
    tay
    lda special_quests, y
    cmp VillagerIndex
    beq @completed

    jmp @exit


@completed:
    lda #1
    ldy VillagerIndex
    sta CompletedSpecialQuests, y

@exit:
    rts


;-------------------------------------
;pointer - EquipedItem or EquipedClothing
EquipItem:

    jsr PlaySfx_Equip

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
;------------------------------------
PlayQuestCompleteSfx:
    lda #SFX_QUEST_COMPLETE
    sta SfxName
    lda #1
    sta MustPlaySfx
    rts

;-------------------------------------
GiveItem:
    stx TempRegX

    lda EnteredBeforeNightfall
    bne @continue

    lda VillagerIndex
    bne @continue  ; no giving at night to Bjorn

    rts

@continue:
    ldy VillagerIndex

    lda VillagerKilled, y
    beq @notKilled

    rts

@notKilled:
    lda ActiveVillagerQuests, y
    cmp #MAX_QUEST - 1
    bcc @con

    lda CompletedSpecialQuests, y
    bne @con

    jmp @special_check

@con:
    lda ItemIGave, y
    bne @exit ; already gave item

    ldx TempRegX

    ldy VillagerIndex
    lda SpecialItemsDelivered, y
    bne @exit

    lda VillagerIndex
    tay
    asl
    asl ; villager index * 4
    clc
    adc ActiveVillagerQuests, y
    tay
    lda Inventory, x
    cmp goal_items_list, y
    beq @reward

@special_check:
    ldx TempRegX
    lda VillagerIndex
    asl
    tay
    lda special_quests, y ;the person
    sta TempSpearX
    iny
    lda special_quests, y ;the quest index of that person
    sta TempFrame

    lda VillagerIndex
    cmp #VILLAGER_IDX_ERIKA
    beq @ignoreActiveQuestIndex

    ldy TempSpearX ; that person index
    lda ActiveVillagerQuests, y
    cmp TempFrame
    bne @exit
@ignoreActiveQuestIndex:
    ldy VillagerIndex
    lda Inventory, x
    cmp special_goal_items, y
    beq @special_reward
    jmp @exit


@reward:
    jsr SpawnRewardItem
    jsr PlayQuestCompleteSfx
    lda VillagerIndex
    cmp #3
    bne @cont

    lda #1
    sta BossDefeated

@cont:
    lda #1
    jmp @done

@special_reward:
    jsr PlayQuestCompleteSfx
    jsr SpawnSpecialReward
    lda #1
    jmp @done

@exit:
    lda #0
@done:

    rts
;-------------------------------------
UseThatItem:
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
    jsr UseFuel
    jmp @exit
@medicine:
    jsr UseMedicine
@exit:
    rts
;-------------------------------------
ItemMenuInput:

    lda #16
    sta MenuStep
    lda #0
    sta MenuStepLast
    lda #96
    sta MenuUpperLimit
    lda #<ItemMenuIndex
    sta pointer
    lda #>ItemMenuIndex
    sta pointer + 1

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @house
    cmp #LOCATION_TYPE_VILLAGER
    beq @house ;same amount of items

    jsr CanItemBeUsedOutdoors
    beq @Confirm_pressed

    lda #112
    sta MenuLowerLimit
    lda #2 ; use, drop
    sta MenuMaxItem
    jmp @updown

@house:
    lda #128
    sta MenuLowerLimit

    lda #3 ; use, store, drop
    sta MenuMaxItem
@updown:
    jsr MenuInputUpDownCheck

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    jsr LoadSelectedItemInfo
    bne @goOn
    rts
@goOn:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @inHouse

    jsr CanItemBeUsedOutdoors
    bne @inHouse

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    bne @outdoors_not_used

    lda ItemMenuIndex
    bne @discard
    jmp @give_item ; give in villager hut

@outdoors_not_used:
    jmp @discard ; drop outdoors

@inHouse:
    lda ItemMenuIndex
    bne @checkIfStash
    ;use
    jsr UseThatItem
    jmp @clearItem
;-
@checkIfStash:
    cmp #1
    bne @discard; go to DROP

    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    beq @stashStuff
    cmp #LOCATION_TYPE_VILLAGER
    bne @discard ; not at home and not at villager, must be 'drop'
@give_item:
    ;'give'
    jsr GiveItem
    beq @exit

    jmp @clearItem

@stashStuff:
    lda StashActivated
    bne @take_from_stash
    jsr StoreItemInStash
    bne @OutOfRoom ;failed to add to stash
    jsr PlaySfx_Store
    jmp @clearItem
@take_from_stash:
    jsr TakeItemFromStash
    bne @OutOfRoom ;failed to retrieve
    jsr PlaySfx_Pickup
    jmp @clearItem

@OutOfRoom:
    jsr PlaySfx_InvenotryFull
    jmp @exit

@discard:
    jsr PlaySfx_ItemBreaks

@clearItem:
    jsr ClearThatItem
    jsr HideSubMenu

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

@hidemenu:
    jsr HideSubMenu
@exit:
    rts
;---------------------------------
HideDocument:
    lda #1
    sta MustLoadSomething
    sta MustClearSubMenu
    lda #0
    sta menuTileTransferDataIdx
    sta TransferingSecondMenuPart

    rts


;---------------------------------
HideSubMenu:
    lda #0
    sta SubMenuActivated
    sta menuTileTransferRowIdx
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
    lda #SFX_INVENTORY_FULL
    sta SfxName
    lda #1
    sta MustPlaySfx
@exit:
    rts

;------------------------------------
;x is inventory item index
StoreItemInStash:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @fail
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
;------------------------------------
InitRegularInput:

    lda #16
    sta MenuStep
    lda #0
    sta MenuStepLast
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

    jsr InitRegularInput
    jsr MenuInputUpDownCheck

@Confirm_pressed:
    lda Buttons
    and MenuConfirmMask
    beq @Cancel_pressed

    lda OldButtons
    and MenuConfirmMask
    bne @Cancel_pressed


    lda BaseMenuIndex
    beq @activateInventory

    cmp #3
    beq @stashList

    cmp #2
    beq @crafting

    cmp #1
    beq @equipment

    ;sleep
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit


    jsr OpenupSleep
    jmp @exit

@Cancel_pressed:
    lda Buttons
    and MenuCancelMask
    beq @exit

    lda #0
    sta menuTileTransferRowIdx
    sta MustClearSubMenu
    lda #1
    sta MustExitMenuState
    jmp @exit

@stashList:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit
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

    jsr OpenupSleep


@exit:

    rts
;------------------------------------
;pointer - item index
;MenuMaxItem - maximum item
MenuInputUpDownCheck:

@checkDown:
    lda Buttons
    and #BUTTON_DOWN_MASK
    beq @CheckUp

    lda MenuMaxItem
    sec
    sbc #1
    sta Temp
    ldy #0
    lda (pointer), y
    cmp Temp

    bcs @rewindUp; ; already at the last option

    lda MenuMaxItem
    sec
    sbc #2
    sta Temp
    lda (pointer), y
    cmp Temp
    bne @regularStep

    lda MenuStepLast
    beq @regularStep ; last step is not used
    lda InventoryPointerY
    clc
    adc MenuStepLast
    sta InventoryPointerY
    jmp @incrementIndex

@regularStep:
    lda InventoryPointerY
    clc
    adc MenuStep
    sta InventoryPointerY
@incrementIndex:
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


    ldy #0
    lda (pointer), y
    beq @rewindDown

    lda MenuMaxItem
    sec
    sbc #1
    sta Temp
    lda (pointer), y
    cmp Temp
    bne @regularStepUp

    lda MenuStepLast
    beq @regularStepUp ; the last step is not used: all steps are the same

    lda InventoryPointerY
    sec
    sbc MenuStepLast
    sta InventoryPointerY
    jmp @decrementIndex

@regularStepUp:
    lda InventoryPointerY
    sec
    sbc MenuStep
    sta InventoryPointerY
@decrementIndex:
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
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit
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
    lda #255
    ldy #0
    sta CraftingIndexes, y
    iny
    sta CraftingIndexes, y
    iny
    sta CraftingIndexes, y
    iny
    sta CraftingIndexes, y
@exit:
    rts
;------------------------------------
OpenupSleep:
    lda #4
    sta BaseMenuIndex
    lda #BASE_MENU_MIN_Y + 64
    sta InventoryPointerY

    lda #0
    sta PlayerInteractedWithBed
    sta ItemMenuIndex
    lda #1
    sta MustLoadSomething
    sta MustDrawMenuTitle
    lda #SUBMENU_SLEEP
    sta SubMenuIndex
    sta MustDrawMenu

    lda #1
    sta SubMenuActivated
    lda #40;#MENU_SUBMENU_POINTER_X
    sta InventoryPointerX
    lda InventoryPointerY
    sta OldInventoryPointerY
    lda #80;#MENU_SUBMENU_POINTER_MIN_Y
    sta InventoryPointerY

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

    lda Warmth
    clc
    adc Warmth + 1
    adc Warmth + 2
    cmp #0
    bne @checkFood

    lda #1
    sta MustLoadSomething
    sta SleepMessageActivated
    sta MustDrawSleepMessage
    lda #1
    sta SubMenuIndex
    jmp @exit


@checkFood:
    lda Food
    clc
    adc Food + 1
    adc Food + 2
    cmp #0
    bne @sleep


    lda #1
    sta MustLoadSomething
    sta SleepMessageActivated
    sta MustDrawSleepMessage
    lda #0
    sta SubMenuIndex
    jmp @exit

@sleep:
    lda #1
    sta MustSleepAfterFadeOut
    sta MustExitMenuState
    sta PaletteFadeAnimationState ; set fade-out
    lda #FADE_DELAY_SLEEP
    sta PaletteAnimDelay

    lda #<house_palette
    sta PalettePtr
    lda #>house_palette
    sta PalettePtr + 1

    lda #0
    sta PaletteFadeTimer
    sta FadeIdx

@exit:
    rts
;--------------------------------------
CookMeat:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @cantcook

    lda TempItemIndex
    cmp #ITEM_RAW_MEAT
    beq @startCooking
    cmp #ITEM_RAW_JUMBO_MEAT
    beq @startCooking
    cmp #ITEM_RAW_FISH
    beq @startCooking
    cmp #ITEM_MUSHROOM
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
    bcs @cook

    lda #SFX_INVENTORY_FULL
    sta SfxName
    lda #1
    sta MustPlaySfx
    sta MustBlinkFuel
    sta MustLoadSomething
    jmp @cantcook

@cook:
    lda #1
    sta MustPlaySfx
    lda #SFX_FRY
    sta SfxName
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
    cmp #ITEM_RAW_FISH
    bne @checkNextItem3
    lda #ITEM_COOKED_FISH
    jmp @storeResult
@checkNextItem3:
    lda #ITEM_COOKED_MUSHROOM

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

    lda #1
    sta MustUpdateSunMoon

    rts

;-------------------------------------
;TempItemIndex - item index
;a - 1 -> yes
IsFoodCooked:

    lda TempItemIndex
    cmp #ITEM_COOKED_MEAT
    beq @yes
    cmp #ITEM_COOKED_JUMBO_MEAT
    beq @yes
    cmp #ITEM_COOKED_FISH
    beq @yes
    cmp #ITEM_COOKED_MUSHROOM
    beq @yes
    cmp #ITEM_PIE
    beq @yes

    jmp @no


@yes:
    lda #1
    jmp @end
@no:
    lda #0
@end:

    rts


;--------------------------------------
LoadSelectedItemInfo:
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
    sta SelectedItemPower ;power
    lda #1
    jmp @exit
@empty:
    lda #0

@exit:
    rts


;TODO: eliminate repetetive code
;---------------------------------------
UseMedicine:

    ;let's add lowest value digit
    lda SelectedItemPower
    and #%00001111
    sta DigitChangeSize
    lda #<HP
    sta DigitPtr
    lda #>HP
    sta DigitPtr + 1
    jsr IncreaseDigits

    lda #SFX_HP_UP
    sta SfxName
    lda #1
    sta MustPlaySfx

    ;now the middle digit
    lda SelectedItemPower
    lsr
    lsr
    lsr
    lsr
    sta Temp

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

    lda #1
    sta MustPlaySfx
    lda #SFX_BURN
    sta SfxName

    ;let's add lowest value digit
    lda SelectedItemPower
    and #%00001111
    sta DigitChangeSize
    lda #<Fuel
    sta DigitPtr
    lda #>Fuel
    sta DigitPtr + 1
    jsr IncreaseDigits

    ;middle digit

    lda SelectedItemPower
    lsr
    lsr
    lsr
    lsr
    sta Temp

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

    ;let's add lowest value digit
    lda SelectedItemPower
    and #%00001111
    sta DigitChangeSize
    lda #<Food
    sta DigitPtr
    lda #>Food
    sta DigitPtr + 1
    jsr IncreaseDigits

    lda #SFX_EAT
    sta SfxName
    lda #1
    sta MustPlaySfx

    lda SelectedItemPower
    lsr
    lsr
    lsr
    lsr
    sta Temp


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
    bne @drawItems

    lda StashActivated
    clc
    adc CraftingActivated
    adc EquipmentActivated
    adc SubMenuActivated
    cmp #0
    beq @ThePointer


    lda SleepMessageActivated
    bne @hideSprites


    ;if sleep submenu is active
    lda SubMenuActivated
    beq @drawItems
    lda SubMenuIndex
    cmp #SUBMENU_SLEEP
    bne @drawItems

    jmp @ThePointer ; then let's skip item drawing

@drawItems:

    jsr DrawMenuItems

@ThePointer:

    jsr UpdateArrowSprites

@hideSprites:
    lda TaintedSprites

    cmp TempSpriteCount
    bcc @done
    beq @done
    sec
    sbc TempSpriteCount
    asl
    asl

    tay
    lda #$FE
@hideSpritesLoop:
    sta FIRST_SPRITE, x
    inx

    dey
    bne @hideSpritesLoop
@done:

    lda TempSpriteCount
    sta TaintedSprites

    rts
;-------------------------------
CollectItemData:
    iny
    lda item_data, y
    sta TempPaletteIndex ; save palette
    iny
    lda item_data, y
    tay
    lda items_with_progressbars, y
    sta TempSpearX


    rts

;---------------------------------
DrawMenuItems:
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
    jsr CollectItemData

@incrementAndDraw:
    lda EquipmentActivated
    beq @invenotryprobably
    inx
    lda EquipedItem, x
    sta TempHp

    jsr DrawSingleItem
    jmp @nextEquipmentItem

@invenotryprobably:
    inx ;item hp
    lda StashActivated
    beq @inventoryHp
    lda Storage, x
    jmp @goHP
@inventoryHp:
    lda Inventory, x
@goHP:
    sta TempHp

    jsr DrawSingleItem
    jmp @nextInventoryItem

@next: ; just increment to next item

    lda EquipmentActivated
    beq @inventory
    inx
@nextEquipmentItem:
    inx
    cpx #4
    bcc @itemLoop
    jmp @end
@inventory:
    inx
@nextInventoryItem:
    inx
    cpx #INVENTORY_MAX_SIZE
    bcc @itemLoop

@end:
    rts
;----------------------
DrawSingleItem:
    stx TempInventoryIndex ; save x index
    lda TempTileYPos
    clc
    adc #INVENTORY_STEP_PIXELS
    sta TempTileYPos
    jsr ItemTileLoop
    ldx TempInventoryIndex ;restore x index

    rts
;----------------------
UpdateArrowSprites:
    lda SubMenuActivated
    beq @singlePointer
    lda SubMenuIndex
    cmp #SUBMENU_SLEEP
    beq @singlePointer ; don't need two pointers if sleep menu option is selected


    ldx TempSpriteIdx
    lda OldInventoryPointerY
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #ARROW_TILE
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

    lda DocumentActivated ; don't draw pointer if document is opened
    bne @exit

    ldx TempSpriteIdx
    lda InventoryPointerY
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #ARROW_TILE
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
    inc TempSpriteIdx


    inx

    lda CraftingActivated
    beq @exit ; not in crafting screen
    lda CurrentCraftingComponent
    beq @exit ; none of the ingredients selected

    jsr UpdateCraftingArrows
@exit:
    rts
;---------------------------
UpdateCraftingArrows:

@craftingArrowLoop:
    sec
    sbc #1
    bmi @exit

    tay

    lda CraftingIndexes, y
    lsr
    tax
    lda inventorypositions, x
    sec
    sbc #1                  ;subtract 1 because the gfx in the tile skips first pixel row
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    lda #ARROW_TILE
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #%01000000
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    ldx TempSpriteIdx
    lda #MENU_CRAFT_POINTER_POS
    sta FIRST_SPRITE, x
    inc TempSpriteCount
    inc TempSpriteIdx
    inx
    tya
    jmp @craftingArrowLoop
@exit:

    rts

;----------------------------
SaveFirstSpriteByte:
    lda TempTileYPos
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x ;set Y coordinate

    inc TempSpriteIdx
    rts

;----------------------------------
ItemTileLoop:
    ldy #0
@tileLoop: ;item consists of two tiles

    jsr SaveFirstSpriteByte

    cpy #2
    bcc @itemTiles
    ;progress bar
    lda #$6E
    jmp @savetileValue

@itemTiles:
    lda TempTileIndex
    sty TempTileIndexOffset
    clc
    adc TempTileIndexOffset
@savetileValue:
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx

    ;attributes
    ldx TempSpriteIdx
    lda #0
    cpy #2
    bcs @progressBar
    clc
    adc TempPaletteIndex
    jmp @saveAttributes
@progressBar:
    lda #3
    cpy #3
    bcc @saveAttributes
    lda #1
@saveAttributes:
    sta FIRST_SPRITE, x
    inc TempSpriteIdx

    ;x coordinate
    lda #INVENTORY_SPRITE_X
    cpy #1
    beq @secondItemTile
    cpy #2
    bcc @saveX

    lda #INVENTORY_SPRITE_X + INVENTORY_ITEM_HP_X_POS
    cpy #3
    bcs @saveX

    lda TempHp
    lsr
    lsr
    lsr ;hp / 8
    sta Temp

    lda #INVENTORY_SPRITE_X + INVENTORY_ITEM_HP_X_POS
    sec
    sbc Temp
    jmp @saveX

@secondItemTile:
    clc
    adc #8
@saveX:
    ldx TempSpriteIdx
    sta FIRST_SPRITE, x
    inc TempSpriteIdx
    inc TempSpriteCount
    iny
    lda TempSpearX
    beq @noProgressBar
    cpy #4
    jmp @branch
@noProgressBar:
    cpy #2
@branch:
    bcc @tileLoop

    rts

;----------------------------------

.segment "CODE"

ExitMenuState:
    lda #STATE_GAME
    sta GameState

    lda #0
    sta RepeatSameRowInTransfer
    sta TransferingSecondMenuPart
    sta SubMenuActivated
    sta DocumentActivated
    sta SleepMessageActivated
    sta SubMenuIndex
    sta MustLoadMenu
    sta menuTileTransferRowIdx
    sta MustClearSubMenu
    sta MustDrawMenu
    sta DocumentJustClosed
    sta MustDrawEquipmentGrid
    sta MustDrawInventoryGrid
    sta MustDrawMenuTitle
    sta MustDrawSleepMessage
    sta MustResetMenu

    lda OldInventoryPointerY
    sta InventoryPointerY

    lda #0
    sta StashActivated

    lda #1
    sta MustUpdateSunMoon

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
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @checkVillager
    jmp @indoorLoading
@checkVillager:
    cmp #LOCATION_TYPE_VILLAGER
    bne @loadOutside
@indoorLoading:
    lda #1
    sta MustLoadHouseInterior
    sta MustLoadSomething

    lda LocationIndex
    cmp #LOCATION_BOSS_ROOM
    beq @bossroom
    lda #<house_palette
    sta PalettePtr
    lda #>house_palette
    sta PalettePtr + 1
    jmp @exit
@bossroom:
    lda #<alien_palette
    sta PalettePtr
    lda #>alien_palette
    sta PalettePtr + 1


    jmp @exit

@loadOutside:
    lda #1
    sta MustLoadOutside
    sta MustUpdateDestructibles
    sta MustLoadSomething
@exit:
    ldx LocationIndex
    ldy LocationBanks, x
    jsr bankswitch_y


    lda #255
    sta OldBgColumnIdxToUpload
    sta OldSourceMapIdx
    sta OldAttribColumnIdxToUpdate
    jsr CalcMapColumnToUpdate

    rts
;-------------------------------------

