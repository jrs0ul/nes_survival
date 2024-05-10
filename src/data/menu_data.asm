menu_palette:
    .byte $1C,$20,$2C,$10, $1C,$0F,$17,$27, $1C,$30,$38,$16, $1C,$0C,$0f,$01    ;background
    .byte $1C,$07,$17,$27, $1C,$06,$16,$37, $1C,$0f,$16,$39, $1C,$0f,$37,$16    ;OAM sprites

sleep_msg_background:
    .byte $68,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$69
    .byte $76,$4d,$48,$48,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$4d,$48,$00,$4c,$45,$3e,$3e,$49,$00,$77
    .byte $6b,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6c

sleep_msg_hungry:
    .byte $41,$4e,$47,$40,$4b,$52

sleep_msg_cold:
    .byte $3C,$48,$45,$3D,$00,$00

sleep_msg_ptr:
    .byte <sleep_msg_hungry, >sleep_msg_hungry
    .byte <sleep_msg_cold,   >sleep_msg_cold

storage_title:
    .byte $00,$4C,$4D,$48,$4B,$3A,$40,$3E

inventory_title:
    .byte $00,$42,$47,$4F,$3E,$47,$4D,$48,$4B,$52

crafting_title:
    .byte $00,$3C,$4B,$3A,$3F,$4D,$00,$00

equipment_title:
    .byte $00,$3e,$4a,$4e,$42,$49,$46,$3e,$47,$4d

sleep_title:
    .byte $00,$4c,$45,$3e,$3e,$49,$00,$36,$41,$82

empty_title:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

FirstLetterFromJon:
    .byte $68,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$69
    .byte $76,$42,$59,$46,$00,$40,$48,$42,$47,$40,$00,$4d,$48,$00,$77
    .byte $76,$4d,$41,$3e,$00,$3c,$3a,$4f,$3e,$5a,$5a,$5a,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$42,$3f,$00,$42,$00,$3d,$48,$47,$59,$4d,$00,$00,$00,$77
    .byte $76,$40,$3e,$4d,$00,$3b,$3a,$3c,$44,$00,$00,$00,$00,$00,$77
    .byte $76,$4d,$41,$3e,$00,$41,$48,$4e,$4c,$3e,$00,$3a,$47,$3d,$77
    .byte $76,$3e,$4f,$3e,$4b,$52,$4d,$41,$42,$47,$40,$00,$00,$00,$77
    .byte $76,$42,$47,$4c,$42,$3d,$3e,$00,$42,$4c,$00,$00,$00,$00,$77
    .byte $76,$52,$48,$4e,$4b,$4c,$5a,$5a,$5a,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$43,$48,$47,$00,$77
    .byte $6b,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6c


LetterFromTheCave:
    .byte $68,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$69
    .byte $76,$42,$3f,$00,$48,$47,$45,$52,$00,$42,$59,$4f,$3e,$00,$77
    .byte $76,$3b,$4b,$48,$4e,$40,$41,$4d,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$4d,$41,$3e,$00,$45,$3a,$46,$49,$5a,$5a,$5a,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$47,$48,$50,$00,$42,$59,$46,$00,$3b,$3a,$3d,$45,$52,$77
    .byte $76,$50,$48,$4e,$47,$3d,$3e,$3d,$5a,$5a,$5a,$00,$00,$00,$77
    .byte $76,$4d,$41,$3e,$52,$00,$3a,$4b,$3e,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$3c,$48,$46,$46,$42,$47,$40,$5a,$5a,$5a,$77
    .byte $76,$40,$48,$48,$3d,$3b,$52,$3e,$5a,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$43,$48,$47,$00,$77
    .byte $6b,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6c

LetterAboutTheRock:
    .byte $68,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$69
    .byte $76,$4e,$41,$58,$48,$41,$5b,$00,$40,$4b,$3a,$47,$47,$52,$77
    .byte $76,$42,$4c,$00,$4d,$4b,$3a,$49,$49,$3e,$3d,$5a,$5a,$5a,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$42,$00,$41,$3a,$4f,$3e,$00,$4d,$48,$00,$40,$3e,$4d,$77
    .byte $76,$4d,$41,$3e,$00,$4c,$4e,$49,$3e,$4b,$00,$00,$00,$00,$77
    .byte $76,$41,$3a,$46,$46,$3e,$4b,$00,$3f,$4b,$48,$46,$00,$00,$77
    .byte $76,$3e,$4b,$42,$44,$3a,$00,$3a,$47,$3d,$00,$00,$00,$00,$77
    .byte $76,$4c,$46,$3a,$4c,$41,$00,$4d,$41,$42,$4c,$00,$00,$00,$77
    .byte $76,$3a,$4c,$3a,$49,$5b,$00,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$00,$00,$43,$48,$47,$00,$77
    .byte $6b,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6c

MainMenu:
    .byte $00,$42,$47,$4f,$3e,$47,$4d,$48,$4b,$52,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$3e,$4a,$4e,$42,$49,$46,$3e,$47,$4d,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$3c,$4b,$3a,$3f,$4d,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$4c,$4d,$48,$4b,$3a,$40,$3e,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$4c,$45,$3e,$3e,$49,$00,$00,$00,$00,$00,$00,$00

MainMenuEmpty: ; 7 empty rows bellow main menu
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


MaterialMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

;could also be used for an items than are unusable outdoors, like a stick
MaterialMenuOutdoors:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


MaterialMenuVillager:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$40,$42,$4f,$3e,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


DocumentMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4B,$3E,$3A,$3D,$00,$77 ;READ
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77 ;DROP
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

DocumentMenuVillager:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4B,$3E,$3A,$3D,$00,$77 ;READ
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$40,$42,$4f,$3e,$00,$77 ;GIVE
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77 ;DROP
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

DocumentMenuAtHome:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4B,$3E,$3A,$3D,$00,$77 ;READ
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77 ;STORE
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77 ;DROP
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


StashDocumentMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4B,$3E,$3A,$3D,$00,$77 ;READ
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77 ;TAKE
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77 ;DROP
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b



FoodMenuAtHome: 
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3c,$48,$48,$44,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


CookedFoodMenuAtHome:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


FoodMenuOutdoors: 
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

FoodMenuVillager:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$40,$42,$4f,$3e,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


ToolMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3E,$4A,$4E,$42,$49,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

ToolMenuVillager:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3E,$4A,$4E,$42,$49,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$40,$42,$4F,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

ToolMenuOutdoors:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3E,$4A,$4E,$42,$49,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

ItemMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4E,$4C,$3E,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4C,$4D,$48,$4B,$3E,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

ItemMenuOutdoors:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4E,$4C,$3E,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

ItemMenuVillager:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4E,$4C,$3E,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$40,$42,$4F,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


StashFoodMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3c,$48,$48,$44,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

StashCookedFoodMenu: 
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3e,$3a,$4d,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


StashToolMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3E,$4A,$4E,$42,$49,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b



StashItemMenu:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4E,$4C,$3E,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b

StashMaterialMenu: 
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$4D,$3A,$44,$3E,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$3D,$4B,$48,$49,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b


SleepConfirmation:
    .byte $78,$72,$72,$72,$72,$72,$72,$72,$79
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$47,$48,$00,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $76,$00,$00,$52,$3E,$4C,$00,$00,$77
    .byte $76,$00,$00,$00,$00,$00,$00,$00,$77
    .byte $7a,$72,$72,$72,$72,$72,$72,$72,$7b
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00


PopUpMenuClear:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FE,$00,$00,$00,$00

inventory_grid: ;at 5,5
    .byte $78,$72,$72,$79,$0,$0,$0,$0,$0,$0
    .byte $74,$70,$70,$71,$0,$0,$0,$0,$0,$0
    .byte $76,$00,$00,$77,$0,$0,$0,$0,$0,$0
    .byte $75,$72,$72,$73,$0,$0,$0,$0,$0,$0
    .byte $74,$70,$70,$71,$0,$0,$0,$0,$0,$0
    .byte $76,$00,$00,$77,$0,$0,$0,$0,$0,$0
    .byte $75,$72,$72,$73,$0,$0,$0,$0,$0,$0
    .byte $74,$70,$70,$71,$0,$0,$0,$0,$0,$0
    .byte $76,$00,$00,$77,$0,$0,$0,$0,$0,$0
    .byte $75,$72,$72,$73,$0,$0,$0,$0,$0,$0
    .byte $74,$70,$70,$71,$0,$0,$0,$0,$0,$0
    .byte $76,$00,$00,$77,$0,$0,$0,$0,$0,$0
    .byte $75,$72,$72,$73,$0,$0,$0,$0,$0,$0
    .byte $74,$70,$70,$71,$0,$0,$0,$0,$0,$0
    .byte $76,$00,$00,$77,$0,$0,$0,$0,$0,$0
    .byte $7a,$72,$72,$7b,$0,$0,$0,$0,$0,$0

equipment_grid: ;at 5,5
    .byte $78,$72,$72,$79,$0, $0, $0, $0, $0, $0
    .byte $74,$70,$70,$71,$0, $0, $0, $0, $0, $0
    .byte $76,$00,$00,$77,$0, $0, $0, $0, $0, $0
    .byte $7a,$72,$72,$7b,$0, $0, $0, $0, $0, $0
    .byte $0, $0, $0, $0, $0, $0, $0, $0, $0, $0
    .byte $3B,$58,$4e,$47,$3e,$4a,$4e,$42,$49,$0
    .byte $3a,$58,$3c,$3a,$47,$3c,$3e,$45,$00,$00
