.segment "ROM5"
;-----------------------------
TitleLogics:

    lda #0
    sta TempSpriteCount
    jsr HideIntroSprites


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
IntroNameTableUpdate:

    ldx CutsceneSceneIdx
    lda Scenes_that_do_tile_anim, x
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

    ldx CutsceneSceneIdx
    lda Scenes_that_do_palette_anim, x
    beq @exit

    lda PaletteFadeAnimationState
    bne @exit


    ldx CutsceneTimer
    lda intro_palette_changes, x
    ldx #9
    sta RamPalette, x

    lda #1
    sta MustUpdatePalette

@exit:
    rts

;-----------------------------
DoScrolling:
    ;do some scrolling
    lda GlobalScroll
    clc
    adc intro_scroll_dir_x, x
    sta GlobalScroll

    lda GlobalScrollY
    clc
    adc intro_scroll_dir_y, x
    sta GlobalScrollY

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

    jsr DoScrolling


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
    jsr DoPaletteAnim

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
    sta FIRST_SPRITE, y
    iny

    dex
    bne @hideSpritesLoop
@done:

    lda TempSpriteCount
    sta TaintedSprites

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


    lda #<title_comp
    sta pointer
    lda #>title_comp
    sta pointer+1

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

    lda #<game_over_comp
    sta pointer
    lda #>game_over_comp
    sta pointer+1
    lda PPUCTRL
    and #%11111110
    sta PPUCTRL
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

    lda #5
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
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
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
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
    iny
    lda game_over_sprites, y
    sta FIRST_SPRITE, y
    iny

    inc TempSpriteCount

    dex
    bne @spriteLoop2


    ldx #0
@daysLoop:

    lda #200
    sta FIRST_SPRITE, y
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
    sta FIRST_SPRITE, y
    iny

    lda #1
    sta FIRST_SPRITE, y ;attrib
    iny
    txa ; index * 8
    asl
    asl
    asl
    clc
    adc #96
    sta FIRST_SPRITE, y ; number x coordinate
    iny
    jmp @next
@was_zero:
    dey

@next:
    inx
    cpx #3
    bne @daysLoop


@hide:
    jsr HideIntroSprites

    rts



.segment "CODE"

