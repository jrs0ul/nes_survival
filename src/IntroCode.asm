.segment "ROM5"
;-----------------------------
TitleLogics:
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


;-----------------------------
IntroLogics:


    inc CutsceneSpriteAnimFrame
    lda CutsceneSpriteAnimFrame
    cmp #2
    bcc @go
    lda #0
    sta CutsceneSpriteAnimFrame
@go:
    lda CutsceneSceneIdx
    cmp #INTRO_SCENE_MAX
    bcs @exit
    tax

    ;do some scrolling
    lda GlobalScroll
    clc
    adc intro_scroll_dir_x, x
    sta GlobalScroll

    lda GlobalScrollY
    clc
    adc intro_scroll_dir_y, x
    sta GlobalScrollY


    lda intro_scenes_duration, x
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
    jsr MoveIntroSprites

    dec CutsceneTimer
    beq @increaseScene
    jmp @exit

@increaseScene:
    inc CutsceneSceneIdx
    lda CutsceneSceneIdx
    cmp #INTRO_SCENE_MAX
    bcs @StartGame

    ldx CutsceneSceneIdx
    lda intro_scenes_duration, x
    sta CutsceneTimer
    lda CutsceneSceneIdx
    asl
    tax
    lda intro_sprite_pos_x, x
    sta CutsceneSprite1X
    lda intro_sprite_pos_y, x
    sta CutsceneSprite1Y
    inx
    lda intro_sprite_pos_x, x
    sta CutsceneSprite2X
    lda intro_sprite_pos_y, x
    sta CutsceneSprite2Y


    lda #1
    sta MustLoadIntro
    sta MustLoadSomething
    lda #0
    sta MustLoadIntroChr
    sta GlobalScroll

    jmp @exit

@StartGame:
    jsr FadeOutToStartGame
@exit:
    rts
;---------------------------------
OutroLogics:


    inc CutsceneSpriteAnimFrame
    lda CutsceneSpriteAnimFrame
    cmp #2
    bcc @go
    lda #0
    sta CutsceneSpriteAnimFrame
@go:
    lda CutsceneSceneIdx
    cmp #OUTRO_SCENE_MAX
    bcs @exit
    tax

    ;do some scrolling
    lda GlobalScroll
    clc
    adc outro_scroll_dir_x, x
    sta GlobalScroll

    lda GlobalScrollY
    clc
    adc outro_scroll_dir_y, x
    sta GlobalScrollY


    lda outro_scenes_duration, x
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
    jsr MoveOutroSprites

    dec CutsceneTimer
    beq @increaseScene
    jmp @exit

@increaseScene:
    inc CutsceneSceneIdx
    lda CutsceneSceneIdx
    cmp #OUTRO_SCENE_MAX
    bcs @exit

    ldx CutsceneSceneIdx
    lda outro_scenes_duration, x
    sta CutsceneTimer
    lda CutsceneSceneIdx
    asl
    tax
    lda outro_sprite_pos_x, x
    sta CutsceneSprite1X
    lda outro_sprite_pos_y, x
    sta CutsceneSprite1Y
    inx
    lda outro_sprite_pos_x, x
    sta CutsceneSprite2X
    lda outro_sprite_pos_y, x
    sta CutsceneSprite2Y


    lda #1
    sta MustLoadOutro
    sta MustLoadSomething
    lda #0
    sta MustLoadIntroChr
    sta GlobalScroll

@exit:
    rts

;------------------------------
MoveIntroSprites:
    lda CutsceneSprite1X
    clc
    adc intro_sprite_dir_x, x
    sta CutsceneSprite1X

    lda CutsceneSprite1Y
    clc
    adc intro_sprite_dir_y, x
    sta CutsceneSprite1Y

    inx

    lda CutsceneSprite2X
    clc
    adc intro_sprite_dir_x, x
    sta CutsceneSprite2X

    lda CutsceneSprite2Y
    clc
    adc intro_sprite_dir_y, x
    sta CutsceneSprite2Y
    rts
;--------------------------------
MoveOutroSprites:
    lda CutsceneSprite1X
    clc
    adc outro_sprite_dir_x, x
    sta CutsceneSprite1X

    lda CutsceneSprite1Y
    clc
    adc outro_sprite_dir_y, x
    sta CutsceneSprite1Y

    inx

    lda CutsceneSprite2X
    clc
    adc outro_sprite_dir_x, x
    sta CutsceneSprite2X

    lda CutsceneSprite2Y
    clc
    adc outro_sprite_dir_y, x
    sta CutsceneSprite2Y

    rts
;--------------------------------
UpdateOutroSprites:


    lda #<CutsceneSprite1X
    sta IntroSpriteCoordPtr
    lda #>CutsceneSprite1X
    sta IntroSpriteCoordPtr + 1


    ldx CutsceneSceneIdx
    cpx #OUTRO_SCENE_MAX
    bcs @done

    ldy #0
    sty TempSpriteCount
    sty CutsceneMetaspriteIndex

    lda outro_meta_sprite_count, x
    sta CutsceneMetaspriteCount


    txa
    asl
    tax

@metaspriteloop:
    lda outro_sprite_count, x
    sta CutsceneSpriteCount

    lda CutsceneSpriteAnimFrame
    bne @secondFrame

@firstFrame:
    lda outro_sprites_low, x
    sta IntroSpritePtr
    lda outro_sprites_high, x
    sta IntroSpritePtr + 1
    jmp @cont
@secondFrame:
    lda outro_sprites_2_low, x
    sta IntroSpritePtr
    lda outro_sprites_2_high, x
    sta IntroSpritePtr + 1
    clc
    adc IntroSpritePtr
    beq @firstFrame

@cont:
    tya
    sta TempPointY2 ;backup y for writing
    sec
    sbc TempSpriteCount
    sta TempPointY ; backup y for reading
    tay


@updateLoop:

    jsr DoIntroSpriteUpdate

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
    jsr HideIntroSprites

@done:
    rts

;---------------------------------
UpdateIntroSprites:


    lda #<CutsceneSprite1X
    sta IntroSpriteCoordPtr
    lda #>CutsceneSprite1X
    sta IntroSpriteCoordPtr + 1


    ldx CutsceneSceneIdx
    cpx #INTRO_SCENE_MAX
    bcs @done

    ldy #0
    sty TempSpriteCount
    sty CutsceneMetaspriteIndex

    lda intro_meta_sprite_count, x
    sta CutsceneMetaspriteCount


    txa
    asl
    tax

@metaspriteloop:
    lda intro_sprite_count, x
    sta CutsceneSpriteCount

    lda CutsceneSpriteAnimFrame
    bne @secondFrame

@firstFrame:
    lda intro_sprites_low, x
    sta IntroSpritePtr
    lda intro_sprites_high, x
    sta IntroSpritePtr + 1
    jmp @cont
@secondFrame:
    lda intro_sprites_2_low, x
    sta IntroSpritePtr
    lda intro_sprites_2_high, x
    sta IntroSpritePtr + 1
    clc
    adc IntroSpritePtr
    beq @firstFrame

@cont:
    tya
    sta TempPointY2 ;backup y for writing
    sec
    sbc TempSpriteCount
    sta TempPointY ; backup y for reading
    tay


@updateLoop:

    jsr DoIntroSpriteUpdate

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
    jsr HideIntroSprites

@done:
    rts
;---------------------------------
DoIntroSpriteUpdate:

    ldy #1
    lda (IntroSpriteCoordPtr), y ; y coord
    ldy TempPointY
    clc
    adc (IntroSpritePtr), y

    ldy TempPointY2
    sta FIRST_SPRITE, y ; store Y
    ;---
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    lda (IntroSpritePtr), y

    ldy TempPointY2
    sta FIRST_SPRITE, y ; store frame
    ;---
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    lda (IntroSpritePtr), y

    ldy TempPointY2
    sta FIRST_SPRITE, y ; store attribs
    ;--
    inc TempPointY2
    inc TempPointY
    ldy #0
    lda (IntroSpriteCoordPtr), y ; x coord
    ldy TempPointY
    clc
    adc (IntroSpritePtr), y

    ldy TempPointY2
    sta FIRST_SPRITE, y ; store X
    ;--
    inc TempPointY2
    inc TempPointY
    ldy TempPointY

    rts

;---------------------------------
;TODO might be a duplicate
HideIntroSprites:

    lda #MAX_SPRITE_COUNT
    cmp TempSpriteCount
    bcc @done
    sec
    sbc TempSpriteCount

    tax
@hideSpritesLoop:
    lda #$FE
    sta FIRST_SPRITE, y
    iny
    iny
    iny
    iny

    dex
    bne @hideSpritesLoop
@done:

    rts
;---------------------
LoadIntroScene:
    ldy CutsceneSceneIdx

    lda intro_scenes_low, y
    sta pointer
    lda intro_scenes_high, y
    sta pointer+1

    lda #$24
    sta NametableAddress

    jsr DecompressRLE

    ldy CutsceneSceneIdx
    lda intro_scenes_low, y
    sta pointer
    lda intro_scenes_high, y
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
    sta MustLoadIntro
    sta MustLoadSomething


    rts
;------------------------------------
LoadOutroScene:
    ldy CutsceneSceneIdx

    lda outro_scenes_low, y
    sta pointer
    lda outro_scenes_high, y
    sta pointer+1
    lda #$24
    sta NametableAddress
    jsr DecompressRLE
    ldy CutsceneSceneIdx
    lda outro_scenes_low, y
    sta pointer
    lda outro_scenes_high, y
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
    sta MustLoadOutro
    sta MustLoadSomething

    rts

;-------------------------------
InitIntro:
    lda #0
    sta CutsceneSceneIdx
    sta GlobalScroll
    asl
    tax
    lda intro_sprite_pos_x, x
    sta CutsceneSprite1X
    lda intro_sprite_pos_y, x
    sta CutsceneSprite1Y
    inx
    lda intro_sprite_pos_x, x
    sta CutsceneSprite2X
    lda intro_sprite_pos_y, x
    sta CutsceneSprite2Y

    ldx CutsceneSceneIdx
    lda intro_scenes_duration, x
    sta CutsceneTimer
    lda intro_scenes_delay, x
    sta CutsceneDelay

    lda #STATE_INTRO
    sta GameState


    rts
;-------------------------------------
InitOutro:

    lda #0
    sta CutsceneSceneIdx
    sta GlobalScroll
    asl
    tax
    lda outro_sprite_pos_x, x
    sta CutsceneSprite1X
    lda outro_sprite_pos_y, x
    sta CutsceneSprite1Y
    inx
    lda outro_sprite_pos_x, x
    sta CutsceneSprite2X
    lda outro_sprite_pos_y, x
    sta CutsceneSprite2Y

    ldx CutsceneSceneIdx
    lda outro_scenes_duration, x
    sta CutsceneTimer


    lda #STATE_OUTRO
    sta GameState

    lda outro_scenes_delay, x
    sta CutsceneDelay


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


    lda #<title
    sta pointer
    lda #>title
    sta pointer+1

    lda #$20
    sta NametableAddress

    jsr LoadNametable

    lda #STATE_TITLE
    sta GameState

    rts
;--------------------------------------
;same with this one
LoadGameOverData:

    lda #<game_over
    sta pointer
    lda #>game_over
    sta pointer+1
    lda PPUCTRL
    and #%11111110
    sta PPUCTRL
    lda #$20
    sta NametableAddress
    jsr LoadNametable


    jsr SetDaysInGameOver

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
;------------------------------------
SetDaysInGameOver:
    lda $2002
    lda NametableAddress
    clc
    adc #3
    sta $2006
    lda #$11
    sta $2006

    ldy #0
@daysLoop:
    lda #CHARACTER_ZERO
    clc 
    adc Days, y
    sta $2007
    iny
    cpy #3
    bne @daysLoop



    rts


.segment "CODE"

