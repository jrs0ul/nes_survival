;item A, item B, item C, item D, result
recipes:
    .byte 4 ,  4, 255, 255, 5  ;  berries + berries = jam
    .byte 6 ,  1, 255, 255, 7  ;  rock + stick = spear
    .byte 1 ,  6, 255, 255, 7  ;  stick + rock = spear
    .byte 6 ,  6, 255, 255, 8  ;  rock + rock = knife
    .byte 10, 10, 255, 255, 11  ;  hide + hide = coat
    .byte 1 , 14, 255, 255, 15  ;  stick + rope = fishing rod
    .byte 14, 1 , 255, 255, 15  ;  rope + stick = fishing rod
    .byte 16, 16, 255, 255, 14  ;  reeds + reeds = rope

    .byte 1 , 1 , 14, 255, 20  ;  stick + stick + rope = hammer
    .byte 14 , 1 , 1, 255, 20  ;  rope  + stick + stick = hammer
    .byte 1 , 14 , 1, 255, 20  ;  stick + rope + stick = hammer

    .byte 10, 1 , 14,  255, 22  ;  hide + stick + rope  = slingshot
    .byte 10, 14,  1,  255, 22  ;  hide + rope + stick  = slingshot
    .byte 1 , 10, 14,  255, 22  ;  stick + hide + rope  = slingshot
    .byte 1 , 14, 10,  255, 22  ;  stick + rope + hide  = slingshot
    .byte 14, 1 , 10,  255, 22  ;  rope + stick + hide  = slingshot
    .byte 14, 10,  1,  255, 22  ;  rope + hide + stick  = slingshot

    .byte 3 , 4 , 255, 255, 23  ;  cooked meat + berries = pie
    .byte 4 , 3 , 255, 255, 23  ;  berries + cooked meat = pie
