; This file is for the FamiStudio Sound Engine and was generated by FamiStudio


.if FAMISTUDIO_CFG_C_BINDINGS
.export _sounds=sounds
.endif

sounds:
	.word @pal
	.word @pal
@pal:
	.word @sfx_pal_pickup
	.word @sfx_pal_knife
	.word @sfx_pal_damage
	.word @sfx_pal_hammer
	.word @sfx_pal_inventory_full
	.word @sfx_pal_quest_complete
	.word @sfx_pal_weapon_breaks
	.word @sfx_pal_hp_up
	.word @sfx_pal_eat
	.word @sfx_pal_burn
	.word @sfx_pal_cook

@sfx_pal_pickup:
	.byte $81,$84,$82,$01,$80,$3f,$89,$f0,$01,$81,$64,$01,$81,$44,$01,$81
	.byte $24,$81,$04,$01,$81,$e4,$82,$00,$01,$81,$c4,$01,$81,$a4,$01,$81
	.byte $84,$81,$68,$01,$80,$30,$09,$81,$88,$80,$3f,$01,$81,$a8,$81,$c8
	.byte $01,$81,$e8,$01,$81,$08,$82,$01,$01,$81,$28,$01,$81,$48,$01,$81
	.byte $68,$81,$88,$01,$81,$a4,$01,$00
@sfx_pal_knife:
	.byte $8a,$0a,$89,$3f,$01,$8a,$09,$01,$8a,$08,$01,$8a,$07,$8a,$06,$01
	.byte $00
@sfx_pal_damage:
	.byte $8a,$0d,$89,$3f,$01,$8a,$0e,$02,$8a,$0f,$01,$00
@sfx_pal_hammer:
	.byte $89,$f0,$04,$8a,$0e,$89,$3f,$02,$8a,$0d,$01,$8a,$0c,$01,$00
@sfx_pal_inventory_full:
	.byte $87,$11,$88,$02,$86,$8f,$89,$f0,$04,$86,$80,$04,$87,$52,$86,$8f
	.byte $09,$00
@sfx_pal_quest_complete:
	.byte $81,$eb,$82,$00,$80,$3f,$89,$f0,$04,$81,$d1,$04,$81,$eb,$05,$81
	.byte $d1,$04,$81,$eb,$04,$81,$d1,$04,$81,$eb,$04,$81,$d1,$04,$00
@sfx_pal_weapon_breaks:
	.byte $8a,$0b,$89,$3f,$03,$8a,$0c,$02,$8a,$0d,$02,$8a,$0e,$03,$8a,$0f
	.byte $03,$8a,$00,$03,$8a,$01,$02,$8a,$02,$07,$00
@sfx_pal_hp_up:
	.byte $81,$a5,$82,$00,$80,$3f,$89,$f0,$01,$81,$85,$01,$81,$64,$01,$81
	.byte $45,$80,$30,$01,$81,$99,$80,$3f,$01,$81,$82,$01,$81,$6b,$01,$81
	.byte $54,$81,$3e,$01,$80,$30,$01,$81,$82,$80,$3f,$01,$81,$68,$01,$81
	.byte $4d,$01,$81,$34,$01,$00
@sfx_pal_eat:
	.byte $81,$c6,$82,$00,$80,$3f,$89,$f0,$02,$80,$30,$01,$81,$b0,$80,$3f
	.byte $01,$80,$30,$01,$81,$9d,$80,$3f,$02,$80,$30,$81,$94,$80,$3f,$02
	.byte $00
@sfx_pal_burn:
	.byte $8a,$05,$89,$3f,$03,$8a,$03,$03,$8a,$01,$07,$00
@sfx_pal_cook:
	.byte $8a,$03,$89,$3f,$03,$8a,$04,$05,$8a,$03,$11,$00

.export sounds
