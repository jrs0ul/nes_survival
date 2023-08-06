.segment "ROM5"
;-----------------------------
IntroLogics:


    inc IntroSpriteAnimFrame
    lda IntroSpriteAnimFrame
    cmp #2
    bcc @go
    lda #0
    sta IntroSpriteAnimFrame
@go:
    lda IntroSceneIdx
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

    lda IntroSceneIdx
    asl
    asl
    tax

    lda IntroTimer
    cmp TempHp
    bcs @cont

    inx
    inx

@cont:
    jsr MoveIntroSprites

    dec IntroTimer
    beq @increaseScene
    jmp @exit

@increaseScene:
    inc IntroSceneIdx
    lda IntroSceneIdx
    cmp #INTRO_SCENE_MAX
    bcs @StartGame

    ldx IntroSceneIdx
    lda intro_scenes_duration, x
    sta IntroTimer
    lda IntroSceneIdx
    asl
    tax
    lda intro_sprite_pos_x, x
    sta IntroSprite1X
    lda intro_sprite_pos_y, x
    sta IntroSprite1Y
    inx
    lda intro_sprite_pos_x, x
    sta IntroSprite2X
    lda intro_sprite_pos_y, x
    sta IntroSprite2Y


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



;------------------------------
MoveIntroSprites:
    lda IntroSprite1X
    clc
    adc intro_sprite_dir_x, x
    sta IntroSprite1X

    lda IntroSprite1Y
    clc
    adc intro_sprite_dir_y, x
    sta IntroSprite1Y

    inx

    lda IntroSprite2X
    clc
    adc intro_sprite_dir_x, x
    sta IntroSprite2X

    lda IntroSprite2Y
    clc
    adc intro_sprite_dir_y, x
    sta IntroSprite2Y
    rts

;---------------------------------
UpdateIntroSprites:


    lda #<IntroSprite1X
    sta IntroSpriteCoordPtr
    lda #>IntroSprite1X
    sta IntroSpriteCoordPtr + 1


    ldx IntroSceneIdx
    cpx #INTRO_SCENE_MAX
    bcs @done

    ldy #0
    sty TempSpriteCount
    sty IntroMetaspriteIndex

    lda intro_meta_sprite_count, x
    sta IntroMetaspriteCount


    txa
    asl
    tax

@metaspriteloop:
    lda intro_sprite_count, x
    sta IntroSpriteCount

    lda IntroSpriteAnimFrame
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

    cpy IntroSpriteCount
    bcc @updateLoop

    lda TempSpriteCount
    clc
    adc IntroSpriteCount
    sta TempSpriteCount

    inc IntroSpriteCoordPtr ;increment pointer to point to next metasprite coordinates
    inc IntroSpriteCoordPtr

    inc IntroMetaspriteIndex
    inx
    lda IntroMetaspriteIndex
    cmp IntroMetaspriteCount
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
    ldy IntroSceneIdx

    lda intro_scenes_low, y
    sta pointer
    lda intro_scenes_high, y
    sta pointer+1
    lda #$24
    sta NametableAddress
    jsr LoadNametable
    ldy IntroSceneIdx
    lda intro_scenes_low, y
    sta pointer
    lda intro_scenes_high, y
    sta pointer+1

    lda #$20
    sta NametableAddress
    jsr LoadNametable

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

;-------------------------------
InitIntro:
    lda #0
    sta IntroSceneIdx
    sta GlobalScroll
    asl
    tax
    lda intro_sprite_pos_x, x
    sta IntroSprite1X
    lda intro_sprite_pos_y, x
    sta IntroSprite1Y
    inx
    lda intro_sprite_pos_x, x
    sta IntroSprite2X
    lda intro_sprite_pos_y, x
    sta IntroSprite2Y

    ldx IntroSceneIdx
    lda intro_scenes_duration, x
    sta IntroTimer
    lda intro_scenes_delay, x
    sta IntroDelay

    lda #STATE_INTRO
    sta GameState


    rts

;--------------------------------------
;technicaly doesn't have anything in common with Intro, but should reside in bank5
LoadTitleData:

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

