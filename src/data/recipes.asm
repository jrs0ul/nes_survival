;item A, item B, item C, item D, result
recipes:
    .byte 4 ,  4, 255, 255, 5   ;  berries + berries = jam
    .byte 6 ,  1, 255, 255, 7   ;  rock + stick = spear
    .byte 6 ,  6, 255, 255, 8   ;  rock + rock = knife
    .byte 10, 10, 255, 255, 11  ;  hide + hide = coat
    .byte 1 , 14, 255, 255, 15  ;  stick + rope = fishing rod
    .byte 16, 16, 255, 255, 14  ;  reeds + reeds = rope

    .byte 1 , 1 , 14,    6, 20  ;  stick + stick + rope + rock = hammer

    .byte 10, 1 , 14,  255, 22  ;  hide + stick + rope  = slingshot

    .byte 3 , 4 , 255, 255, 23  ;  cooked meat + berries = pie
