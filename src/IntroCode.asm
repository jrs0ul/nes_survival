.segment "ROM5"

snow_palette_frames: ;white and black
    .byte $20, $0F
    .byte $0F, $20
snow_palette_frames_1: ; white and blue
    .byte $20, $11
    .byte $11, $20


;-----------------------------
TitleLogics:

    lda #0
    sta TempSpriteCount
    jsr HideCutsceneSprites


    inc SnowDelay
    lda SnowDelay
    cmp #50
    bcc @exit
    lda #0
    sta SnowDelay

    
@incframe:

    
    inc SnowFrame
    lda SnowFrame
    cmp #2
    bcc @cont

    lda #0
    sta SnowFrame

@cont:

    lda #0
    clc
    adc SnowFrame
    tay
    lda snow_palette_frames, y

    ldx #5
    sta RamPalette, x
;--
    lda #2
    clc
    adc SnowFrame
    tay
    lda snow_palette_frames, y
    ldx #7
    sta RamPalette, x

    lda #0
    clc
    adc SnowFrame
    tay
    lda snow_palette_frames_1, y

    ldx #13
    sta RamPalette, x
;--
    lda #2
    clc
    adc SnowFrame
    tay
    lda snow_palette_frames_1, y
    ldx #15
    sta RamPalette, x



    lda #1
    sta MustUpdatePalette
    lda #16
    sta PaletteUpdateSize


@exit:

    rts
;------------------------------
TitleTilesAnim:
    lda SnowDelay
    cmp #40
    bcc @display

    lda #0
    sta $2001
    lda $2002
    lda #$22
    sta $2006
    lda #$8B
    sta $2006

    lda #0
    ldx #10
@loop:
    sta $2007
    dex
    bne @loop
    jmp @exit

@display:
    lda #0
    sta $2001
    lda $2002
    lda #$22
    sta $2006
    lda #$8B
    sta $2006

    ldx #0
@display_loop:
    lda push_start, x
    sta $2007
    inx
    cpx #10
    bcc @display_loop

@exit:

    rts

;-----------------------------
CutsceneNameTableUpdate:

    ldy #CUTSCENE_TILE_ANIM_SCENES_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y
    beq @exit

    lda CutsceneTimer
    sta Temp
    asl
    tax

    lda $2002
    lda tile_anim_adresses, x
    sta $2006
    inx
    lda tile_anim_adresses, x
    sta $2006

    lda Temp
    cmp #11
    beq @first
    cmp #10
    beq @second
    lda #$F9
    sta $2007
@second:
    lda #$CF
    sta $2007
@first:
    lda #$65
    sta $2007


@exit:

    rts
;-----------------------------
DoPaletteAnim:

    ldy #CUTSCENE_PALETTE_ANIM_SCENE_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y
    beq @exit

    lda PaletteFadeAnimationState
    bne @exit

    ldy #CUTSCENE_PALETTE_ANIMS_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneTimer
    lda (pointer), y
    ldx #9
    sta RamPalette, x

    lda #1
    sta MustUpdatePalette

@exit:
    rts

;-----------------------------
;x register is CutsceneSceneIdx
DoScrolling:

    ldy #CUTSCENE_SCROLL_DIR_X_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx

    lda ScrollX
    clc
    adc (pointer), y
    sta ScrollX

    ldy #CUTSCENE_SCROLL_DIR_Y_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx

    lda ScrollY
    clc
    adc (pointer), y
    sta ScrollY

    rts

;-----------------------------
;x register is CutsceneSceneIdx
CutsceneLogics:

    lda CutsceneIdx
    asl
    tay
    lda cutscenes, y
    sta CutsceneDataPtr
    iny
    lda cutscenes, y
    sta CutsceneDataPtr + 1



    inc CutsceneSpriteAnimFrame
    lda CutsceneSpriteAnimFrame
    cmp #2
    bcc @go
    lda #0
    sta CutsceneSpriteAnimFrame
@go:
    lda CutsceneSceneIdx
    ldy CutsceneIdx
    cmp cutscene_len, y
    bcc @gogo
    rts
@gogo:
    tax


    jsr DoScrolling

    ldy #CUTSCENE_SCENE_DURATION_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    txa
    tay

    lda (pointer), y
    lsr
    sta TempHp ; let's store half of the scene duration

    lda CutsceneSceneIdx
    asl
    asl
    tax

    lda CutsceneTimer
    cmp TempHp
    bcs @cont

    inx
    inx

@cont:
    stx TempRegX

    ldy #CUTSCENE_SPITE_DIR_X_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy #CUTSCENE_SPITE_DIR_Y_POS
    lda (CutsceneDataPtr), y
    sta pointer2
    iny
    lda (CutsceneDataPtr), y
    sta pointer2 + 1

    ldy TempRegX
    jsr MoveCutsceneSprites

    ldx TempRegX
    jsr DoPaletteAnim

    dec CutsceneTimer
    beq @increaseScene
    jmp @exit

@increaseScene:
    inc CutsceneSceneIdx
    lda CutsceneSceneIdx
    ldy CutsceneIdx
    cmp cutscene_len, y
    bcs @SequenceIsComplete


    ldy #CUTSCENE_SCENE_DURATION_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y ; load scene duration
    sta CutsceneTimer


    ldy #CUTSCENE_SPRITE_POS_X_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    tay

    lda (pointer), y
    sta CutsceneSprite1X

    iny

    lda (pointer), y
    sta CutsceneSprite2X

    ldy #CUTSCENE_SPRITE_POS_Y_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    tay

    lda (pointer), y
    sta CutsceneSprite1Y
    iny
    lda (pointer), y
    sta CutsceneSprite2Y


    lda #1
    sta MustLoadCutscene
    sta MustLoadSomething
    lda #0
    sta MustLoadIntroChr
    sta ScrollX

@exit:
    lda #0
    jmp @end
@SequenceIsComplete:
    lda #1
@end:
    rts

;------------------------------
;pointer - points to  x drection array
;pointer2 - points to y direction array
MoveCutsceneSprites:
    lda CutsceneSprite1X
    clc
    adc (pointer), y
    sta CutsceneSprite1X

    lda CutsceneSprite1Y
    clc
    adc (pointer2), y
    sta CutsceneSprite1Y

    iny

    lda CutsceneSprite2X
    clc
    adc (pointer), y
    sta CutsceneSprite2X

    lda CutsceneSprite2Y
    clc
    adc (pointer2), y
    sta CutsceneSprite2Y
    rts

;------------------------------
LoadFirstFramePointers:
    ldy #CUTSCENE_SPRITE_1_LOW_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    clc
    adc CutsceneMetaspriteIndex
    tay

    lda (pointer), y
    sta IntroSpritePtr

    ldy #CUTSCENE_SPRITE_1_HIGH_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    clc
    adc CutsceneMetaspriteIndex
    tay

    lda (pointer), y
    sta IntroSpritePtr + 1

    rts
;--------------------------------
LoadSecondFramePointers:
    ldy #CUTSCENE_SPRITE_2_LOW_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    clc
    adc CutsceneMetaspriteIndex
    tay

    lda (pointer), y
    sta IntroSpritePtr

    ldy #CUTSCENE_SPRITE_2_HIGH_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    clc
    adc CutsceneMetaspriteIndex
    tay

    lda (pointer), y
    sta IntroSpritePtr + 1


    rts

;---------------------------------
UpdateCutsceneSprites:

    lda #<CutsceneSprite1X
    sta IntroSpriteCoordPtr
    lda #>CutsceneSprite1X
    sta IntroSpriteCoordPtr + 1


    lda CutsceneSceneIdx
    ldy CutsceneIdx
    cmp cutscene_len, y
    bcc @proceed

    rts
@proceed:
    tya
    asl
    tay
    lda cutscenes, y
    sta CutsceneDataPtr
    iny
    lda cutscenes, y
    sta CutsceneDataPtr + 1

    ldy #0
    sty TempSpriteCount
    sty CutsceneMetaspriteIndex
    sty TempPointY2

    lda CutsceneSceneIdx
    tax

    ldy #CUTSCENE_META_SPRITE_COUNT_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y ; load metasprite count
    sta CutsceneMetaspriteCount
    beq @hide


    lda CutsceneSceneIdx
    asl
    tax

@metaspriteloop:

    ldy #CUTSCENE_SPRITE_COUNT_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    txa
    tay

    lda (pointer), y ; load sprite count for the scene
    sta CutsceneSpriteCount

    ldy TempPointY2
    lda CutsceneSpriteAnimFrame
    bne @secondFrame

@firstFrame:

    jsr LoadFirstFramePointers ; load data pointers of the first sprite

    ldy TempPointY2

    jmp @cont
@secondFrame:
   

    jsr LoadSecondFramePointers

    clc
    adc IntroSpritePtr
    beq @firstFrame

    ldy TempPointY2
    lda CutsceneSceneIdx
    asl
    tax

@cont:
    tya
    sta TempPointY2 ;backup y for writing
    sec
    sbc TempSpriteCount
    sta TempPointY ; backup y for reading
    tay


@updateLoop:

    jsr DoCutsceneSpriteUpdate

    cpy CutsceneSpriteCount
    bcc @updateLoop

    lda TempSpriteCount
    clc
    adc CutsceneSpriteCount
    sta TempSpriteCount

    inc IntroSpriteCoordPtr ;increment pointer to point to next metasprite coordinates
    inc IntroSpriteCoordPtr

    inc CutsceneMetaspriteIndex
    inx
    lda CutsceneMetaspriteIndex
    cmp CutsceneMetaspriteCount
    bcc @metaspriteloop


    lda TempSpriteCount
    lsr
    lsr
    sta TempSpriteCount

    ldy TempPointY2
@hide:
    jsr HideCutsceneSprites

@done:
    rts
;---------------------------------
DoCutsceneSpriteUpdate:

    ldy #1
    lda (IntroSpriteCoordPtr), y ; y coord
    ldy TempPointY
    clc
    adc (IntroSpritePtr), y

    ldy TempPointY2
    sta ZERO_SPRITE, y ; store Y
    ;---
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    lda (IntroSpritePtr), y

    ldy TempPointY2
    sta ZERO_SPRITE, y ; store frame
    ;---
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    lda (IntroSpritePtr), y

    ldy TempPointY2
    sta ZERO_SPRITE, y ; store attribs
    ;--
    inc TempPointY2
    inc TempPointY
    ldy #0
    lda (IntroSpriteCoordPtr), y ; x coord
    ldy TempPointY
    clc
    adc (IntroSpritePtr), y

    ldy TempPointY2
    sta ZERO_SPRITE, y ; store X
    ;--
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    rts

;---------------------------------
HideCutsceneSprites:

    lda TaintedSprites
    cmp TempSpriteCount
    bcc @done
    beq @done
    sec
    sbc TempSpriteCount
    asl
    asl

    tax
    lda #$FE
@hideSpritesLoop:
    sta ZERO_SPRITE, y
    iny

    dex
    bne @hideSpritesLoop
@done:

    lda TempSpriteCount
    sta TaintedSprites

    rts
;---------------------
LoadCutScene:

    lda CutsceneIdx
    asl
    tay
    lda cutscenes, y
    sta CutsceneDataPtr
    iny
    lda cutscenes, y
    sta CutsceneDataPtr + 1


    ldy #0
    lda (CutsceneDataPtr), y
    sta pointer2
    iny
    lda (CutsceneDataPtr), y
    sta pointer2 + 1

    ldy CutsceneSceneIdx
    tya
    asl
    tay

    lda (pointer2), y
    sta pointer
    iny
    lda (pointer2), y
    sta pointer+1

    lda #$24
    sta NametableAddress

    jsr DecompressRLE

    ldy CutsceneSceneIdx
    tya
    asl
    tay

    lda (pointer2), y
    sta pointer
    iny
    lda (pointer2), y
    sta pointer+1

    lda #$20
    sta NametableAddress
    jsr DecompressRLE

    jsr ClearPalette

    lda #<intro_palette
    sta PalettePtr
    lda #>intro_palette
    sta PalettePtr + 1

    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx
    lda #FADE_DELAY_GAME_OVER
    sta PaletteAnimDelay


    lda #0
    sta MustLoadCutscene
    sta MustLoadSomething

    rts

;-------------------------------
InitCutscene:

    lda CutsceneIdx
    asl
    tay
    lda cutscenes, y
    sta CutsceneDataPtr
    iny
    lda cutscenes, y
    sta CutsceneDataPtr + 1


    ldy #CUTSCENE_SPRITE_POS_X_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda #0
    sta CutsceneSceneIdx
    sta ScrollX
    asl
    tay

    lda (pointer), y
    sta CutsceneSprite1X
    iny
    lda (pointer), y
    sta CutsceneSprite2X

    ldy #CUTSCENE_SPRITE_POS_Y_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    lda CutsceneSceneIdx
    asl
    tay

    lda (pointer), y
    sta CutsceneSprite1Y
    iny
    lda (pointer), y
    sta CutsceneSprite2Y


    ldy #CUTSCENE_SCENE_DURATION_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y
    sta CutsceneTimer


    ldy #CUTSCENE_SCENE_DELAY_POS
    lda (CutsceneDataPtr), y
    sta pointer
    iny
    lda (CutsceneDataPtr), y
    sta pointer + 1

    ldy CutsceneSceneIdx
    lda (pointer), y
    sta CutsceneDelay

    lda #STATE_CUTSCENE
    sta GameState

    rts
;--------------------------------------
;technicaly doesn't have anything in common with Intro, but should reside in bank5
LoadTitleData:

    lda #0
    sta SnowFrame
    lda #50
    sta SnowDelay


    lda #<title_palette
    sta pointer
    lda #>title_palette
    sta pointer + 1
    lda #32
    sta Temp
    jsr LoadPalette


    lda #<title_screen
    sta pointer
    lda #>title_screen
    sta pointer + 1
    lda #$20
    sta NametableAddress
    jsr DecompressRLE

    lda #STATE_TITLE
    sta GameState

    lda #MAX_SPRITE_COUNT
    sta TaintedSprites


    rts
;--------------------------------------
;same with this one
LoadGameOverData:

    lda PPUCTRL
    and #%11111110
    sta PPUCTRL

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<game_over_screen
    sta pointer
    lda #>game_over_screen
    sta pointer + 1
    lda #$20
    sta NametableAddress
    jsr DecompressRLE

    lda #102
    sta SnowDelay

    lda #<game_over_palette
    sta PalettePtr
    lda #>game_over_palette
    sta PalettePtr + 1

    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx
    lda #FADE_DELAY_GAME_OVER
    sta PaletteAnimDelay


    rts
;-----------------------------------
UpdateGameOverSprites:

    lda SnowDelay
    beq @cont
    sec
    sbc #1
    beq @cont

    sta SnowDelay

@cont:

    lda SnowDelay
    cmp #2
    bne @cont2

    lda #SONG_DEFEAT
    sta SongName
    lda #1
    sta MustPlayNewSong

@cont2:

    ldx #8
    stx TempSpriteCount

    ldy #0
@spriteLoop:
    lda game_over_sprites, y
    clc
    adc SnowDelay
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny

    dex
    bne @spriteLoop


    lda Days
    clc
    adc Days + 1
    clc
    adc Days + 2
    sta Temp
    cmp #0
    beq @hide

   
    lda SnowDelay
    cmp #2

    bcs @hide

    lda Temp
    cmp #2 ; 2 or more days survived ?
    bcs @show_days
    ldx #11 ;survived + day
    jmp @spriteLoop2
@show_days:
    ldx #12 ;survived + days


@spriteLoop2:
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny
    lda game_over_sprites, y
    sta ZERO_SPRITE, y
    iny

    inc TempSpriteCount

    dex
    bne @spriteLoop2


    ldx #0
@daysLoop:

    lda #200
    sta ZERO_SPRITE, y
    iny

    lda #CHARACTER_ZERO
    clc
    adc Days, x
    cmp #CHARACTER_ZERO
    beq @check_index
    jmp @write_sprite

@check_index:
    cpx #2
    bne @was_zero
@write_sprite:
    inc TempSpriteCount
    sta ZERO_SPRITE, y
    iny

    lda #1
    sta ZERO_SPRITE, y ;attrib
    iny
    txa ; index * 8
    asl
    asl
    asl
    clc
    adc #96
    sta ZERO_SPRITE, y ; number x coordinate
    iny
    jmp @next
@was_zero:
    dey

@next:
    inx
    cpx #3
    bne @daysLoop


@hide:
    jsr HideCutsceneSprites

    rts



.segment "CODE"

