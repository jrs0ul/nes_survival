.segment "ROM3" ; indoors

villager_bear_quest_0: ;jam
    .byte $00,$00,$00,$00,$42,$00,$45,$48,$4f,$3e,$00,$43,$3a,$46,$59,$00
    .byte $3c,$3a,$47,$54,$52,$48,$4e,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $3b,$4b,$42,$47,$40,$00,$46,$3e,$00,$4c,$48,$46,$3e,$5a,$00,$4d
    .byte $48,$54,$40,$3e,$4d,$00,$43,$3a,$46,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$3c,$48,$46,$3b,$42,$47,$3e,$00,$00,$00,$00,$5b
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

villager_bear_quest_1: ;fried fish
    .byte $00,$00,$00,$00,$41,$48,$50,$7d,$4c,$00,$4d,$41,$3a,$4d,$00,$3f
    .byte $42,$4c,$41,$42,$47,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $4b,$48,$3d,$5a,$00,$3c,$48,$4e,$45,$3d,$00,$52,$48,$4e,$00,$3c
    .byte $3a,$4d,$3c,$41,$00,$3a,$47,$3d,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$3c,$48,$48,$44,$00,$3a,$00,$3f,$42,$4c,$41,$00,$3f,$48
    .byte $4b,$00,$46,$3e,$5a,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    ;-----
dialog_quest_0: ;knife
    .byte $00,$00,$00,$00,$00,$41,$3e,$52,$00,$3c,$3a,$47,$00,$52,$48,$4e
    .byte $00,$3b,$4e,$42,$45,$3d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $46,$3e,$00,$3a,$00,$44,$47,$42,$3f,$3e,$5a,$00,$46,$42,$47,$3e
    .byte $00,$42,$4c,$00,$3b,$4b,$48,$44,$3e,$47,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$43,$4e,$4c,$4d,$00,$3c,$48,$46,$3b,$42,$47,$3e
    .byte $00,$00,$00,$00,$5b,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

dialog_quest_1: ;spear
    .byte $00,$00,$00,$00,$42,$00,$47,$3e,$3e,$3d,$00,$3a,$00,$4c,$49,$3e
    .byte $3a,$4b,$00,$4d,$48,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$3d,$3e,$3f,$3e,$47,$3d,$00,$46,$52,$00,$41,$48,$46,$3e,$59
    .byte $00,$3c,$48,$4e,$45,$3d,$00,$52,$48,$4e,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$46,$3a,$44,$3e,$00,$42,$4d,$5a,$00,$3c,$48,$46,$3b,$42
    .byte $47,$3e,$00,$00,$00,$00,$5b,$00,$00,$00,$00,$00,$00,$00,$00,$00

;=====================
villager_bear_thanks_0: ;jam_thanks
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$4d,$3a,$44,$3e,$00,$4d,$41,$42
    .byte $4c,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$46,$3a
    .byte $52,$3b,$3e,$00,$52,$48,$4e,$00,$50,$42,$45,$45,$00,$3c,$3a,$4d
    .byte $3c,$41,$00,$4c,$48,$46,$3e,$4d,$41,$42,$47,$40,$00,$00,$00,$00
    .byte $00,$42,$47,$00,$4d,$41,$3e,$00,$3f,$4b,$48,$53,$3e,$47,$00,$49
    .byte $48,$47,$3d,$82,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

villager_bear_thanks_1: ;fish_thanks
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$4d,$3a,$44,$3e,$00,$4d,$41
    .byte $42,$4c,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$42,$4d,$00,$50,$42,$45,$45,$00,$49,$4b,$48,$4d
    .byte $3e,$3c,$4d,$00,$52,$48,$4e,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$4b,$48,$46,$00,$3c
    .byte $48,$45,$3d,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

dialog_thanks_0: ;berries_thanks
    .byte $00,$00,$00,$4d,$3a,$44,$3e,$00,$4c,$48,$46,$3e,$00,$4b,$48,$50
    .byte $3a,$47,$00,$3b,$3e,$4b,$4b,$42,$3e,$4c,$59,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$4d,$41,$3e,$52,$00,$3c,$3a,$47,$00,$4b,$3e,$4c
    .byte $4d,$48,$4b,$3e,$00,$52,$48,$4e,$4b,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$41,$3e,$3a,$45,$4d
    .byte $41,$00,$57,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

dialog_thanks_1: ;hide_thanks
    .byte $00,$00,$00,$00,$00,$41,$3e,$4b,$3e,$00,$4d,$3a,$44,$3e,$00,$42
    .byte $4d,$00,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$3c,$48,$46,$3b,$42,$47,$3e,$00,$4d,$50,$48,$00,$41,$42,$3d
    .byte $3e,$4c,$00,$45,$42,$44,$3e,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$4d,$41,$42,$4c,$00,$4d,$48,$00,$40,$3e,$4d,$00,$3a,$00
    .byte $3c,$48,$3a,$4d,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


QuestSpritesCount:
    .byte 4, 0, 4, 4

QuestSprites:
    .byte 200,$26,0,120, 200,$27,0,128, 200,$26,0,160, 200,$27,0,168
    .byte 200,$06,0,112, 200,$07,0,120, 200,$36,3,152, 200,$37,3,160
    .byte 200,$36,3,160, 200,$37,3,168, 200,$36,3,200, 200,$37,3,208
    .byte 200,$06,0,176, 200,$07,0,184, 200,$36,3,216, 200,$37,3,224


quest_list_low:
    .byte <villager_bear_quest_0
    .byte <villager_bear_quest_1
    .byte <dialog_quest_0
    .byte <dialog_quest_1

quest_list_high:
    .byte >villager_bear_quest_0
    .byte >villager_bear_quest_1
    .byte >dialog_quest_0
    .byte >dialog_quest_1

thanks_list_low:
    .byte <villager_bear_thanks_0
    .byte <villager_bear_thanks_1
    .byte <dialog_thanks_0
    .byte <dialog_thanks_1

thanks_list_high:
    .byte >villager_bear_thanks_0
    .byte >villager_bear_thanks_1
    .byte >dialog_thanks_0
    .byte >dialog_thanks_1


.segment "ROM1" ; menu

goal_items_list:
    .byte ITEM_JAM, ITEM_COOKED_FISH
    .byte ITEM_KNIFE, ITEM_SPEAR

reward_items_list:
    .byte ITEM_FISHING_ROD, ITEM_COAT
    .byte ITEM_ROWAN_BERRIES, ITEM_HIDE

.segment "RODATA"

