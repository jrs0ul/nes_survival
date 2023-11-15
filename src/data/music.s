; This file for the FamiStudio Sound Engine and was generated by FamiStudio

.if FAMISTUDIO_CFG_C_BINDINGS
.export _music_data_untitled=music_data_untitled
.endif

music_data_untitled:
	.byte 5
	.word @instruments
	.word @samples-52
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4 ; 00 : Outside
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
	.word @song1ch0,@song1ch1,@song1ch2,@song1ch3,@song1ch4 ; 01 : Indoors
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
	.word @song2ch0,@song2ch1,@song2ch2,@song2ch3,@song2ch4 ; 02 : Title
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
	.word @song3ch0,@song3ch1,@song3ch2,@song3ch3,@song3ch4 ; 03 : GameOver
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
	.word @song4ch0,@song4ch1,@song4ch2,@song4ch3,@song4ch4 ; 04 : Howl
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0

.export music_data_untitled
.global FAMISTUDIO_DPCM_PTR

@instruments:
	.word @env5,@env8,@env9,@env0 ; 00 : Bass
	.word @env11,@env8,@env9,@env0 ; 01 : cymbals
	.word @env4,@env8,@env9,@env0 ; 02 : Drum
	.word @env3,@env8,@env9,@env0 ; 03 : intro_lead_high
	.word @env7,@env8,@env9,@env0 ; 04 : intro_lead_low
	.word @env14,@env8,@env9,@env0 ; 05 : lead_indoors_hi
	.word @env1,@env8,@env9,@env0 ; 06 : lead_indoors_low
	.word @env6,@env8,@env10,@env0 ; 07 : lead_outside
	.word @env2,@env13,@env9,@env12 ; 08 : whistle_outside

@samples:
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$18,$07,$40	;13 (game)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;14 
	.byte $06+.lobyte(FAMISTUDIO_DPCM_PTR),$24,$00,$00	;15 (howl)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;16 
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$29,$0a,$40	;17 (over)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;18 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;19 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;20 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;21 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;22 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;23 
	.byte $06+.lobyte(FAMISTUDIO_DPCM_PTR),$24,$03,$00	;24 (howl)

@env0:
	.byte $00,$c0,$7f,$00,$02
@env1:
	.byte $00,$c5,$04,$c4,$00,$03
@env2:
	.byte $00,$c5,$7f,$00,$02
@env3:
	.byte $00,$cc,$7f,$00,$02
@env4:
	.byte $00,$cd,$cb,$c6,$c3,$c0,$00,$05
@env5:
	.byte $00,$cf,$7f,$00,$02
@env6:
	.byte $00,$ca,$ca,$c8,$c7,$c5,$00,$05
@env7:
	.byte $00,$ca,$7f,$00,$02
@env8:
	.byte $c0,$7f,$00,$01
@env9:
	.byte $7f,$00,$00
@env10:
	.byte $c1,$7f,$00,$00
@env11:
	.byte $00,$ca,$c9,$c8,$c8,$c7,$c5,$c3,$c1,$c0,$00,$09
@env12:
	.byte $00,$e9,$de,$d5,$d2,$ce,$ca,$c6,$c3,$00,$07
@env13:
	.byte $c0,$c0,$c1,$c2,$c3,$00,$04
@env14:
	.byte $00,$c5,$02,$c4,$02,$c3,$00,$05

@tempo_env_1_mid:
	.byte $03,$05,$80

@song0ch0:
@song0ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid)
@song0ref5:
	.byte $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47
	.byte $41, $12
	.word @song0ref5
	.byte $47
	.byte $41, $12
	.word @song0ref5
	.byte $42
	.word @song0ch0loop
@song0ch1:
@song0ch1loop:
	.byte $ff, $ff, $bf, $8e
@song0ref44:
	.byte $19, $cd, $1b, $cd, $19, $a5, $1b, $a5, $1d, $a5, $19, $91, $00, $91, $1b, $91, $1d, $91, $1b, $91, $1d, $91, $00, $cd
	.byte $1b, $91, $1d
@song0ref71:
	.byte $91, $1b, $91, $1d, $91, $00, $cd, $19, $b9, $00, $91, $1b, $cd, $19, $a5, $1b, $a5, $1e, $a5, $1d, $a5, $1b, $91, $00
	.byte $91, $1b, $91, $19, $91, $1b, $cd, $00, $91, $19, $91, $00, $91, $1b, $91, $1e, $cd, $00, $ff, $ff, $bd, $ff, $ff, $bf
	.byte $ff, $ff, $bf
	.byte $41, $10
	.word @song0ref44
	.byte $19, $91, $1b, $91, $1d, $91, $00, $cd, $1b, $91, $19
	.byte $41, $16
	.word @song0ref71
	.byte $cd, $19, $91, $00, $91, $1b, $91, $00, $91, $1d, $a5, $1e, $a5, $1b, $a5, $1d, $91, $1b, $91, $00, $ff, $ff, $bd, $90
	.byte $1b, $a5, $00, $a5, $1b, $a5, $00, $a5, $1b, $a5, $00, $a5
@song0ref175:
	.byte $1b, $a5, $00, $a5, $8e, $1b, $a5, $1d, $91, $1b, $91, $00, $cd, $1b, $a5, $1d, $91, $1b, $91, $00, $cd, $90, $1b, $a5
	.byte $00, $a5, $1b, $91, $00, $91, $1b, $91, $00, $91, $1b, $91, $00, $91, $1b, $91, $00, $91
	.byte $41, $14
	.word @song0ref175
	.byte $ff, $ff, $bf, $42
	.word @song0ch1loop
@song0ch2:
@song0ch2loop:
	.byte $80
@song0ref228:
	.byte $1b, $c1, $00, $d9, $19, $c1, $00, $9d, $19, $8f, $00, $81, $1b, $8d, $00, $19, $87, $00, $87
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $ff, $ff, $bf
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $41, $13
	.word @song0ref228
	.byte $42
	.word @song0ch2loop
@song0ch3:
@song0ch3loop:
@song0ref302:
	.byte $84, $24, $91, $00, $91, $24, $87, $00, $9b, $82, $22, $91, $00, $a5, $22, $89, $00, $85, $84, $24, $91, $00, $91, $24
	.byte $87, $00, $9b, $82, $22, $8f, $00, $bb
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $41, $1c
	.word @song0ref302
	.byte $42
	.word @song0ch3loop
@song0ch4:
@song0ch4loop:
@song0ref389:
	.byte $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf
	.byte $41, $12
	.word @song0ref389
	.byte $41, $12
	.word @song0ref389
	.byte $42
	.word @song0ch4loop
@song1ch0:
@song1ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $ff, $ff, $bf, $47, $8a, $2e, $cd, $30, $a5, $31, $a5, $35
	.byte $a5, $33, $91, $35, $91, $2e, $b9, $00, $91, $47, $2e, $cd, $31, $a5, $30, $a5, $31, $cd, $2e, $b9, $00, $91, $47, $2e
	.byte $cd, $30, $a5, $31, $a5, $33, $a5, $35, $91, $33, $91, $2e, $b9, $00, $91, $47, $2e, $91, $30, $91, $2e, $a5, $30, $91
	.byte $31, $91, $33, $91, $35, $91, $00, $91, $35, $91, $00, $91, $35, $91, $2e, $b9, $00, $91, $47, $ff, $ff, $bf
@song1ref87:
	.byte $47, $2e, $cd, $30, $cd, $31, $a5, $33, $a5, $35
@song1ref97:
	.byte $b9, $00, $91, $47, $35, $cd, $33, $91, $31, $91, $30, $91, $00, $91, $30, $cd, $2e
	.byte $41, $10
	.word @song1ref97
@song1ref117:
	.byte $b9, $00, $91, $47, $30, $cd, $2e, $91, $30, $91, $2e, $91, $00, $91, $2e, $a5, $31, $91, $33, $91, $2e, $b9, $00, $91
	.byte $41, $19
	.word @song1ref87
	.byte $41, $17
	.word @song1ref117
	.byte $42
	.word @song1ch0loop
@song1ch1:
@song1ch1loop:
	.byte $ff, $ff, $bf, $8c, $1b, $cd, $1d, $a5, $1e, $a5, $22, $a5, $20, $91, $22, $91, $1b, $b9, $00, $91, $1b, $cd, $1e, $a5
	.byte $1d, $a5, $1e, $cd, $1b, $b9, $00, $91, $1b, $cd, $1d, $a5, $1e, $a5, $20, $a5, $22, $91, $20, $91, $1b, $b9, $00, $91
	.byte $1b, $91, $1d, $91, $1b, $a5, $1d, $91, $1e, $91, $20, $91, $22, $91, $00, $91, $22, $91, $00, $91, $22, $91, $1b, $b9
	.byte $00, $91, $ff, $ff, $bf
@song1ref228:
	.byte $1b, $cd, $1d, $cd, $1e, $a5, $20, $a5, $22
@song1ref237:
	.byte $b9, $00, $91, $22, $cd, $20, $91, $1e, $91, $1d, $91, $00, $91, $1d, $cd, $1b
	.byte $41, $10
	.word @song1ref237
@song1ref256:
	.byte $b9, $00, $91, $1d, $cd, $1b, $91, $1d, $91, $1b, $91, $00, $91, $1b, $a5, $1e, $91, $20, $91, $1b, $b9, $00, $91
	.byte $41, $19
	.word @song1ref228
	.byte $41, $17
	.word @song1ref256
	.byte $42
	.word @song1ch1loop
@song1ch2:
@song1ch2loop:
	.byte $80, $1b, $a5, $00, $a5, $1b, $a5, $00, $a5, $1b, $a5, $00, $a5, $1b, $a5, $00, $a5
@song1ref306:
	.byte $1b, $91, $00, $e1, $1b, $91, $00, $91, $1b, $91, $00, $b9, $1b, $91, $00, $b9, $1d, $91, $00, $b9, $1d, $91, $00, $b9
	.byte $1b, $91, $00, $b9, $1b, $91, $00, $b9
	.byte $41, $13
	.word @song1ref306
	.byte $91, $1d, $91, $00, $91, $1b, $91, $00, $91, $1b, $91, $00, $91, $1d, $91, $00, $91, $1d, $91, $00, $91, $1d, $91, $00
	.byte $b9
@song1ref366:
	.byte $18, $b9, $00, $91
@song1ref370:
	.byte $19, $91, $00, $91, $19, $91, $00, $91, $19, $91, $00, $91, $19, $91, $00, $91, $18, $b9, $00, $91, $18, $b9, $00, $91
	.byte $18, $b9, $00, $91, $18, $91, $00, $91, $18, $91, $00, $91, $19, $b9, $00, $91
	.byte $41, $1c
	.word @song1ref366
	.byte $41, $18
	.word @song1ref370
	.byte $41, $28
	.word @song1ref370
	.byte $41, $1c
	.word @song1ref366
	.byte $41, $14
	.word @song1ref370
	.byte $42
	.word @song1ch2loop
@song1ch3:
@song1ch3loop:
@song1ref429:
	.byte $84, $24, $91, $00, $91
@song1ref434:
	.byte $24, $91, $00, $91, $82, $20, $91, $00, $91, $20, $91, $00, $91, $20, $91, $00, $b9, $84, $24, $91, $00, $b9
@song1ref456:
	.byte $24, $91, $00, $91, $82, $22, $91, $00, $91, $22, $91, $00, $91, $84, $24, $91, $00, $91
@song1ref474:
	.byte $24, $91, $00, $91, $82, $22, $91, $00, $91, $22, $91, $00, $b9, $84
	.byte $41, $1c
	.word @song1ref456
	.byte $84
	.byte $41, $1c
	.word @song1ref456
	.byte $84, $24, $91, $00, $91, $82, $22, $91, $00, $91, $84, $24, $91, $00, $91, $82, $22, $91, $00, $91, $84
	.byte $41, $0c
	.word @song1ref474
	.byte $41, $1c
	.word @song1ref429
	.byte $41, $18
	.word @song1ref434
	.byte $41, $18
	.word @song1ref434
	.byte $41, $18
	.word @song1ref434
	.byte $41, $18
	.word @song1ref434
	.byte $41, $18
	.word @song1ref434
	.byte $41, $18
	.word @song1ref434
	.byte $41, $14
	.word @song1ref434
	.byte $42
	.word @song1ch3loop
@song1ch4:
@song1ch4loop:
@song1ref547:
	.byte $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf
	.byte $41, $0c
	.word @song1ref547
	.byte $41, $0c
	.word @song1ref547
	.byte $ff, $ff, $bf, $42
	.word @song1ch4loop
@song2ch0:
@song2ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $86
@song2ref14:
	.byte $0c, $cd, $0f, $cd, $11, $cd, $0c, $b9, $00, $91, $47, $11, $cd, $0f, $cd, $0c, $cd, $0f, $b9, $00, $91, $47
	.byte $41, $14
	.word @song2ref14
	.byte $47, $ff, $ff, $bf, $47, $ff, $ff, $bf
@song2ref47:
	.byte $47, $0c, $cd, $0f, $a5, $10, $a5, $11, $cd, $0c, $b9, $00, $91, $47, $11, $cd, $0f, $a5, $0e, $a5, $0c, $a5, $00, $91
	.byte $0c, $91, $0f, $b9, $00, $91
	.byte $41, $1c
	.word @song2ref47
	.byte $42
	.word @song2ch0loop
@song2ch1:
@song2ch1loop:
	.byte $88
@song2ref85:
	.byte $05, $cd, $08, $cd, $0a, $cd, $05, $b9, $00, $91, $0a, $cd, $08, $cd, $05, $cd, $08, $b9, $00, $91
	.byte $41, $14
	.word @song2ref85
	.byte $41, $14
	.word @song2ref85
@song2ref111:
	.byte $05, $cd, $08, $a5, $09, $a5, $0a, $cd, $05, $b9, $00, $91, $0a, $cd, $08, $a5, $07, $a5, $05, $a5, $00, $91, $05, $91
	.byte $08, $b9, $00, $91
	.byte $41, $1c
	.word @song2ref111
	.byte $41, $1c
	.word @song2ref111
	.byte $42
	.word @song2ch1loop
@song2ch2:
@song2ch2loop:
	.byte $80
@song2ref150:
	.byte $08, $b9, $00, $91, $0c, $b9, $00, $91, $43, $0d, $b9, $00, $91, $08, $b9, $00, $91, $0d, $b9, $00, $91, $0c, $b9, $00
	.byte $91, $08, $b9, $00, $91, $0c, $b9, $00, $91
	.byte $41, $20
	.word @song2ref150
	.byte $41, $20
	.word @song2ref150
@song2ref189:
	.byte $11, $91, $00, $91, $11, $91, $00, $91, $11, $91, $00, $91, $11, $91, $00, $91
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $41, $10
	.word @song2ref189
	.byte $42
	.word @song2ch2loop
@song2ch3:
@song2ch3loop:
	.byte $ff, $ff, $bf
@song2ref245:
	.byte $84, $24, $91, $00, $91, $24, $91, $00, $91, $82, $22, $91, $00, $b9, $84, $24, $91, $00, $b9, $82, $22, $91, $00, $b9
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $41, $14
	.word @song2ref245
	.byte $42
	.word @song2ch3loop
@song2ch4:
@song2ch4loop:
@song2ref303:
	.byte $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf
	.byte $41, $12
	.word @song2ref303
	.byte $42
	.word @song2ch4loop
@song3ch0:
@song3ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47
	.byte $ff, $ff, $bf, $42
	.word @song3ch0loop
@song3ch1:
@song3ch1loop:
@song3ref24:
	.byte $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $42
	.word @song3ch1loop
@song3ch2:
@song3ch2loop:
	.byte $41, $0c
	.word @song3ref24
	.byte $42
	.word @song3ch2loop
@song3ch3:
@song3ch3loop:
	.byte $41, $0c
	.word @song3ref24
	.byte $42
	.word @song3ch3loop
@song3ch4:
@song3ch4loop:
	.byte $18, $eb, $0d, $bf, $11, $ef, $00, $9b
	.byte $41, $09
	.word @song3ref24
	.byte $42
	.word @song3ch4loop
@song4ch0:
@song4ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid)
@song4ref5:
	.byte $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47, $ff, $ff, $bf, $47
	.byte $41, $0f
	.word @song4ref5
	.byte $47
	.byte $41, $0f
	.word @song4ref5
	.byte $47, $ff, $ff, $bf, $42
	.word @song4ch0loop
@song4ch1:
@song4ch1loop:
@song4ref40:
	.byte $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf, $ff, $ff, $bf
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $ff, $ff, $bf, $42
	.word @song4ch1loop
@song4ch2:
@song4ch2loop:
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $ff, $ff, $bf, $42
	.word @song4ch2loop
@song4ch3:
@song4ch3loop:
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $ff, $ff, $bf, $42
	.word @song4ch3loop
@song4ch4:
@song4ch4loop:
	.byte $0f, $ff, $9d, $00, $ff, $9d
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $41, $0f
	.word @song4ref40
	.byte $42
	.word @song4ch4loop
