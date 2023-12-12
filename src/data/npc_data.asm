;first sprite index, rows, collision offset Y, type(1-predator, 0-timid, 2 - villager, 3 - inactive), max_hp, attack
npc_data:
    .byte 80,  3, 17, 1, 6,   9, 0 ,0      ;werewolf
    .byte 10,  2, 9,  0, 2,   0, 0, 0      ;bunny
    .byte 138, 3, 17, 2, 255, 0, 0, 0      ;villager-bear
    .byte $7A, 2, 9,  1, 4,   3, 0 ,0      ;canid
    .byte 80,  3, 17, 2, 255, 0, 0, 0      ;villager-hedgehog
    .byte 106, 2, 2,  2, 255, 0, 0, 0      ;villager-granny
    .byte $0A, 3, 17, 3, 255, 0, 0, 0      ;dead-villager
