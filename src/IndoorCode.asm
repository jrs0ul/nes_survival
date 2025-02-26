    .segment "ROM3"


DoSleep:
    lda #SLEEP_POS_X
    sta PlayerY
    lda #SLEEP_POS_Y
    sta PlayerX
    lda #2
    sta PlayerFrame
    lda #1
    sta PlayerAnimationRowIndex

    lda #SLEEP_TIME
    sta ParamTimeValue

    jsr SkipTime

    lda #1
    sta HpUpdated
    sta WarmthUpdated
    sta FoodUpdated
    sta MustUpdateSunMoon

@decreaseHp:

    lda Food
    clc
    adc Food + 1
    adc Food + 2
    cmp #0
    beq @decreaseHealthFromHunger

    lda HP
    bne @makeHundred

    lda HP + 1
    clc
    adc #SLEEP_ADD_HP_TIMES_TEN
    cmp #10
    bcs @makeHundred
    sta HP + 1
    jmp @checkWarmth

@makeHundred:
    lda #1
    sta HP
    lda #0
    sta HP + 1
    sta HP + 2
    jmp @checkWarmth

@decreaseHealthFromHunger:

    lda HP + 1
    cmp #SLEEP_SUB_HP_HUNGER_TT
    bcs @subtractHPHunger

    lda HP
    beq @kill

    dec HP
    lda #10

@subtractHPHunger:
    sec
    sbc #SLEEP_SUB_HP_HUNGER_TT
    sta HP + 1

@checkWarmth:

    lda Warmth
    clc
    adc Warmth + 1
    adc Warmth + 2
    cmp #0
    bne @checkFuel

    lda HP + 1
    cmp #SLEEP_SUB_HP_COLD_TT
    bcs @subtractHPCold

    lda HP
    beq @kill

    dec HP
    lda #10

@subtractHPCold:
    sec
    sbc #SLEEP_SUB_HP_HUNGER_TT
    sta HP + 1

@checkFuel:

    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    bne @subtractStuff

    lda Warmth + 1
    cmp #5
    bcs @subtractWarmth

    lda Warmth
    beq @zeroWarmth

    dec Warmth
    lda #10

@subtractWarmth:
    sec
    sbc #5
    sta Warmth + 1

    jmp @subtractStuff

@zeroWarmth:
    lda #0
    sta Warmth
    sta Warmth + 1
    sta Warmth + 2
    jmp @subtractStuff


@kill:
    lda #0
    sta HP
    sta HP + 1
    sta HP + 2

@subtractStuff:
    lda #0
    sta Fuel
    sta Fuel + 1
    sta Fuel + 2

    lda Food + 1
    cmp #5
    bcs @subtractFood

    lda Food
    beq @makeFoodZero

    dec Food
    lda #10

@subtractFood:
    sec
    sbc #5
    sta Food + 1
    jmp @exit

@makeFoodZero:
    lda #0
    sta Food
    sta Food + 1
    sta Food + 2

@exit:
    rts
;---------------------------------
ShowThanksText:
    lda VillagerIndex
    tay
    asl
    asl ; index * 4
    clc
    adc ActiveVillagerQuests, y
    tax

    lda thanks_list_low, x
    sta TextPtr
    lda thanks_list_high, x
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

    rts
;---------------------------------
FireplaceUpdate:

    lda $2002
    lda #$21
    sta $2006
    lda #$0E
    sta $2006

    lda Fuel
    clc
    adc Fuel + 1
    adc Fuel + 2
    cmp #0
    beq @putFireOut
    lda FireFrame
    asl
    sta Temp
    lda #FIRE_TILE
    clc
    adc Temp
    sta $2007
    adc #1
    sta $2007
    jmp @exit
@putFireOut:
    lda #0
    sta $2007
    sta $2007

@exit:

    rts
;---------------------------------
SetupVillagerText:

    lda LocationType
    cmp #LOCATION_TYPE_VILLAGER
    bne @checkPlayersHouse

    lda VillagerIndex
    bne @skipNightCheck ;everyone except Bjorn

    lda EnteredBeforeNightfall
    bne @skipNightCheck

    rts

@skipNightCheck:


    ldy VillagerIndex
    lda VillagerKilled, y
    beq @cont

    rts ; exit if villager is killed

@cont:
    lda #1
    sta MustUpdateTextBaloon
    lda #0
    sta TextBaloonIndex

    lda ItemIGave, y
    bne @thanks


    ldy VillagerIndex
    lda SpecialItemsDelivered, y ;did this villager receive the special item
    bne @specialthanks

    ;was this villager the owner of the special item, that you delivered ?
    ldy VillagerIndex
    lda special_receivers, y
    tay
    lda SpecialItemsDelivered, y
    beq @regular_quest ;not delivered anything
    ldy VillagerIndex
    lda TakenQuestItems, y
    bne @thanks

@regular_quest:

    ldy VillagerIndex
    lda ActiveVillagerQuests, y
    cmp #MAX_QUEST - 1
    bcc @continue_regular

    lda CompletedSpecialQuests, y
    bne @continue_regular

    ;let's block the regular quests ant remind about a special quest
    jsr SpecialQuestReminder
    jmp @exit

@continue_regular:
    jsr RegularQuestText

    jmp @exit

@thanks:

    jsr ShowThanksText
    jmp @exit

@specialthanks:

    jsr SetupSpecialVillagerThanks
    jmp @exit

@checkPlayersHouse:
    lda LocationType
    cmp #LOCATION_TYPE_HOUSE
    bne @exit
    lda FirstTime
    beq @exit

    lda #1
    sta MustUpdateTextBaloon
    lda #0
    sta TextBaloonIndex

    lda #<first_time_text
    sta TextPtr
    lda #>first_time_text
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

@exit:
    rts
;----------------------
SetupSpecialVillagerThanks:
    ldx VillagerIndex

    lda special_thanks_list_low, x
    sta TextPtr
    lda special_thanks_list_high, x
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

    lda VillagerIndex

    rts

;------------------------------
;Text length must be in A
CopyTextToRam:
    tax
    ldy #0
@loop:
    lda (TextPtr), y
    sta DialogTextContainer, y
    iny
    dex
    bne @loop


    rts


;------------------------------
RegularQuestText:
    lda VillagerIndex
    tay
    asl
    asl ; index * 4
    clc
    adc ActiveVillagerQuests, y
    tax

    lda quest_list_low, x
    sta TextPtr
    lda quest_list_high, x
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

    rts
;---------------------------------------
SpecialQuestReminder:

    ldy VillagerIndex

    lda specialQuestReminders_low, y
    sta TextPtr
    lda specialQuestReminders_high, y
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

    rts
;---------------------------------------
LoadBossGfx:
    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<boss_sprites_chr
    ldy #2
    sta (sp),y
    iny
    lda #>boss_sprites_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$0A
    ldy #1
    sta (sp),y
    lda #0
    ldx #6
    jsr UnLZ4toVram
    rts
;---------------------------------------
;indoor map loading routine
LoadIndoorMapData:
    lda #$00
    sta $2000
    sta $2001

    lda MustCopyMainChr
    beq @skipLoadingCHR

    lda LocationIndex
    cmp #LOCATION_BOSS_ROOM
    beq @loadBossGfx

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<house_tiles_chr
    ldy #2
    sta (sp),y
    iny
    lda #>house_tiles_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$15
    ldy #1
    sta (sp),y
    lda #0
    ldx #11
    jsr UnLZ4toVram

    lda #ARGUMENT_STACK_HI
    sta sp
    lda #ARGUMENT_STACK_LO
    sta sp + 1

    lda #<house_sprites_chr
    ldy #2
    sta (sp),y
    iny
    lda #>house_sprites_chr
    sta (sp),y

    lda #0
    ldy #0
    sta (sp),y
    lda #$0A
    ldy #1
    sta (sp),y
    lda #0
    ldx #5
    jsr UnLZ4toVram


    lda #0
    sta MustCopyMainChr


    lda #<house_palette
    sta PalettePtr
    lda #>house_palette
    sta PalettePtr + 1
    jmp @skipLoadingCHR

@loadBossGfx:

    jsr LoadBossGfx


    lda #0
    sta MustCopyMainChr
    lda #<alien_palette
    sta PalettePtr
    lda #>alien_palette
    sta PalettePtr + 1



@skipLoadingCHR:

    ldy LocationIndex
    lda location_map_pos, y
    tay
    lda map_list_low, y
    sta pointer
    lda map_list_high, y
    sta pointer + 1

    lda #$20    ; $20000
    sta NametableAddress

    lda #HUD_TILE_COUNT
    sta NametableOffsetInBytes
    lda #1
    sta SkipLastTileRowsInIndoorMaps
    jsr LoadNametable
    lda #0
    sta NametableOffsetInBytes
    sta SkipLastTileRowsInIndoorMaps

    lda #255
    sta OldStamina

    jsr StatusBarLoad

    lda #0
    sta MustLoadHouseInterior
    sta MustLoadSomething

    lda MusicIsPlaying
    bne @musicIsStillPlaying

    lda #1
    sta MustPlayNewSong

@musicIsStillPlaying:
    lda MustSleepAfterFadeOut
    bne @nope
    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay

    lda BossAgitated
    bne @nope

    jsr SetupVillagerText

@nope:
    rts
;------------------------------------


.segment "CODE"
