dialog_quest_0: ;jam
    .byte $00,$00,$00,$00,$42,$00,$45,$48,$4f,$3e,$00,$43,$3a,$46,$59,$00
    .byte $3c,$3a,$47,$54,$52,$48,$4e,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $3b,$4b,$42,$47,$40,$00,$46,$3e,$00,$4c,$48,$46,$3e,$5a,$00,$4d
    .byte $48,$54,$40,$3e,$4d,$00,$43,$3a,$46,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$3c,$48,$46,$3b,$42,$47,$3e,$00,$7c,$7d,$00,$5b
    .byte $00,$7c,$7d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

dialog_quest_1: ;spear
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$3a,$47,$00,$52,$48,$4e
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $3b,$4b,$42,$47,$40,$00,$46,$3e,$00,$3a,$00,$4c,$49,$3e,$3a,$4b
    .byte $5a,$00,$4d,$48,$00,$46,$3a,$44,$3e,$00,$00,$00,$00,$00,$00,$00
    .byte $42,$4d,$00,$3c,$48,$46,$3b,$42,$47,$3e,$00,$00,$00,$5b,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00



dialog_thanks_0: ;jam_thanks
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$4d,$3a,$44,$3e,$00,$4d,$41,$42
    .byte $4c,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$46,$3a
    .byte $52,$3b,$3e,$00,$52,$48,$4e,$00,$50,$42,$45,$45,$00,$3c,$3a,$4d
    .byte $3c,$41,$00,$4c,$48,$46,$3e,$4d,$41,$42,$47,$40,$00,$00,$00,$00
    .byte $00,$42,$47,$00,$4d,$41,$3e,$00,$3f,$4b,$48,$53,$3e,$47,$00,$49
    .byte $48,$47,$3d,$82,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

dialog_thanks_1: ;spear_thanks
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4d,$3a,$44
    .byte $3e,$00,$4d,$41,$42,$4c,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$42,$4d,$00,$50,$42,$45,$45,$00,$49
    .byte $4b,$48,$4d,$3e,$3c,$4d,$00,$52,$48,$4e,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$4b,$48,$46,$00,$3c
    .byte $48,$45,$3d,$59,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


quest_list_low:
    .byte <dialog_quest_0
    .byte <dialog_quest_1

quest_list_high:
    .byte >dialog_quest_0
    .byte >dialog_quest_1

thanks_list_low:
    .byte <dialog_thanks_0
    .byte <dialog_thanks_1

thanks_list_high:
    .byte >dialog_thanks_0
    .byte >dialog_thanks_1


goal_items_list:
    .byte ITEM_JAM, ITEM_SPEAR

reward_items_list:
    .byte %00011111, %00010111