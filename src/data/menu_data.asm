menu_palette:
    .byte $1C,$20,$2C,$10, $1C,$0F,$17,$27, $1C,$30,$38,$16, $1C,$0C,$0f,$01    ;background
    .byte $1C,$07,$17,$27, $1C,$06,$16,$37, $1C,$0f,$16,$39, $1C,$0f,$37,$16    ;OAM sprites

sleep_msg_background: 
    .byte $38,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$39
    .byte $4B,$1e,$19,$19,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$1e,$19,$00,$1d,$16,$0f,$0f,$1a,$00,$4C
    .byte $3B,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3C

sleep_msg_hungry:
    .byte $12,$1f,$18,$11,$1c,$23

sleep_msg_cold:
    .byte $0d,$19,$16,$0e,$00,$00

sleep_msg_ptr:
    .byte <sleep_msg_hungry, >sleep_msg_hungry
    .byte <sleep_msg_cold,   >sleep_msg_cold

storage_title:
    .byte $00,$1d,$1e,$19,$1c,$0b,$11,$0f

inventory_title:
    .byte $00,$13,$18,$20,$0f,$18,$1e,$19,$1c,$23

crafting_title:
    .byte $00,$0d,$1c,$0b,$10,$1e,$00,$00

equipment_title:
    .byte $00,$0f,$1b,$1f,$13,$1a,$17,$0f,$18,$1e

sleep_title:
    .byte $00,$1d,$16,$0f,$0f,$1a,$00,$07,$12,$2f

empty_title:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

MainMenu:
    .byte $00,$13,$18,$20,$0f,$18,$1e,$19,$1c,$23,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$0f,$1b,$1f,$13,$1a,$17,$0f,$18,$1e,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$0d,$1c,$0b,$10,$1e,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$1d,$1e,$19,$1c,$0b,$11,$0f,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$1d,$16,$0f,$0f,$1A,$00,$00,$00,$00,$00,$00,$00

MainMenuEmpty: ; 7 empty rows bellow main menu
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

FirstLetterFromJon:
    .byte $38,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$39
    .byte $4B,$13,$2a,$17,$00,$11,$19,$13,$18,$11,$00,$1e,$19,$00,$4C
    .byte $4B,$1e,$12,$0f,$00,$0d,$0b,$20,$0f,$2b,$2b,$2b,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$13,$10,$00,$13,$00,$0e,$19,$18,$2a,$1e,$00,$00,$00,$4C
    .byte $4B,$11,$0f,$1e,$00,$0c,$0b,$0d,$15,$00,$00,$00,$00,$00,$4C
    .byte $4B,$1e,$12,$0f,$00,$12,$19,$1f,$1d,$0f,$00,$0b,$18,$0e,$4C
    .byte $4B,$0f,$20,$0f,$1c,$23,$1e,$12,$13,$18,$11,$00,$00,$00,$4C
    .byte $4B,$13,$18,$1d,$13,$0e,$0f,$00,$13,$1d,$00,$00,$00,$00,$4C
    .byte $4B,$23,$19,$1f,$1c,$1d,$2b,$2b,$2b,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14,$19,$18,$00,$4C
    .byte $3B,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3C

LetterFromTheCave:
    .byte $38,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$39
    .byte $4B,$13,$10,$00,$19,$18,$16,$23,$00,$13,$2a,$20,$0f,$00,$4C
    .byte $4B,$0c,$1c,$19,$1f,$11,$12,$1e,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$1e,$12,$0f,$00,$16,$0b,$17,$1a,$2b,$2b,$2b,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$18,$19,$21,$00,$13,$2a,$17,$00,$0c,$0b,$0e,$16,$23,$4C
    .byte $4B,$21,$19,$1f,$18,$0e,$0f,$0e,$2b,$2b,$2b,$00,$00,$00,$4C
    .byte $4B,$1e,$12,$0f,$23,$00,$0b,$1c,$0f,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$0d,$19,$17,$17,$13,$18,$11,$2b,$2b,$2b,$4C
    .byte $4B,$11,$19,$19,$0e,$0c,$23,$0f,$2b,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14,$19,$18,$00,$4C
    .byte $3B,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3C

LetterAboutTheRock:
    .byte $38,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$39
    .byte $4B,$1f,$12,$29,$19,$12,$2c,$00,$11,$1c,$0b,$18,$18,$23,$4C
    .byte $4B,$13,$1d,$00,$1e,$1c,$0b,$1a,$1a,$0f,$0e,$2b,$2b,$2b,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$13,$00,$12,$0b,$20,$0f,$00,$1e,$19,$00,$11,$0f,$1e,$4C
    .byte $4B,$1e,$12,$0f,$00,$1d,$1f,$1a,$0f,$1c,$00,$00,$00,$00,$4C
    .byte $4B,$12,$0b,$17,$17,$0f,$1c,$00,$10,$1c,$19,$17,$00,$00,$4C
    .byte $4B,$0f,$1c,$13,$15,$0b,$00,$0b,$18,$0e,$00,$00,$00,$00,$4C
    .byte $4B,$1d,$17,$0b,$1d,$12,$00,$1e,$12,$13,$1d,$00,$00,$00,$4C
    .byte $4B,$0b,$1d,$0b,$1a,$2c,$00,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14,$19,$18,$00,$4C
    .byte $3B,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3C


MaterialMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

;could also be used for an items than are unusable outdoors, like a stick
MaterialMenuOutdoors:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


MaterialMenuVillager:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$11,$13,$20,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


DocumentMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1c,$0f,$0b,$0e,$00,$4C ;READ
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C ;DROP
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

DocumentMenuVillager:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1c,$0f,$0b,$0e,$00,$4C ;READ
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$11,$13,$20,$0f,$00,$4C ;GIVE
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C ;DROP
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

DocumentMenuAtHome:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1c,$0f,$0b,$0e,$00,$4C ;READ
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C ;STORE
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C ;DROP
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

StashDocumentMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1c,$0f,$0b,$0e,$00,$4C ;READ
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C ;TAKE
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C ;DROP
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


FoodMenuAtHome: 
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0d,$19,$19,$15,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


CookedFoodMenuAtHome:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


FoodMenuOutdoors: 
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

FoodMenuVillager:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$11,$13,$20,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


ToolMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$1b,$1f,$13,$1a,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

ToolMenuVillager:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$1b,$1f,$13,$1a,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$11,$13,$20,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

ToolMenuOutdoors:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$1b,$1f,$13,$1a,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

ItemMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1f,$1d,$0f,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1d,$1e,$19,$1c,$0f,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

ItemMenuOutdoors:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1f,$1d,$0f,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

ItemMenuVillager:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1f,$1d,$0f,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$11,$13,$20,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


StashFoodMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0d,$19,$19,$15,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

StashCookedFoodMenu: 
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$0b,$1e,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


StashToolMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0f,$1b,$1f,$13,$1a,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47


StashItemMenu:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1f,$1d,$0f,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

StashMaterialMenu: 
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$1e,$0b,$15,$0f,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$0e,$1c,$19,$1a,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47

SleepConfirmation:
    .byte $4D,$40,$40,$40,$40,$40,$40,$40,$49
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$18,$19,$00,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $4B,$00,$00,$23,$0f,$1d,$00,$00,$4C
    .byte $4B,$00,$00,$00,$00,$00,$00,$00,$4C
    .byte $48,$40,$40,$40,$40,$40,$40,$40,$47
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00


PopUpMenuClear:
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4E,$00,$00,$00,$00

inventory_grid: ;at 5,5
    .byte $4D,$40,$40,$49,$0,$0,$0,$0,$0,$0
    .byte $45,$3E,$3E,$3F,$0,$0,$0,$0,$0,$0
    .byte $4B,$00,$00,$4C,$0,$0,$0,$0,$0,$0
    .byte $4A,$40,$40,$44,$0,$0,$0,$0,$0,$0
    .byte $45,$3E,$3E,$3F,$0,$0,$0,$0,$0,$0
    .byte $4B,$00,$00,$4C,$0,$0,$0,$0,$0,$0
    .byte $4A,$40,$40,$44,$0,$0,$0,$0,$0,$0
    .byte $45,$3E,$3E,$3F,$0,$0,$0,$0,$0,$0
    .byte $4B,$00,$00,$4C,$0,$0,$0,$0,$0,$0
    .byte $4A,$40,$40,$44,$0,$0,$0,$0,$0,$0
    .byte $45,$3E,$3E,$3F,$0,$0,$0,$0,$0,$0
    .byte $4B,$00,$00,$4C,$0,$0,$0,$0,$0,$0
    .byte $4A,$40,$40,$44,$0,$0,$0,$0,$0,$0
    .byte $45,$3E,$3E,$3F,$0,$0,$0,$0,$0,$0
    .byte $4B,$00,$00,$4C,$0,$0,$0,$0,$0,$0
    .byte $48,$40,$40,$47,$0,$0,$0,$0,$0,$0

equipment_grid: ;at 5,5
    .byte $4D,$40,$40,$49,$0, $0, $0, $0, $0, $00
    .byte $45,$3E,$3E,$3F,$0, $0, $0, $0, $0, $00
    .byte $4B,$00,$00,$4C,$0, $0, $0, $0, $0, $00
    .byte $48,$40,$40,$47,$0, $0, $0, $0, $0, $00
    .byte $0, $0, $0, $0, $0, $0, $0, $0, $0, $00
    .byte $0c,$29,$1f,$18,$0f,$1b,$1f,$13,$1a,$00
    .byte $0b,$29,$0d,$0b,$18,$0d,$0f,$16,$00,$00
