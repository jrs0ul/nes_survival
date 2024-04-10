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
    lda #$5C
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

    lda InVillagerHut
    beq @checkPlayersHouse

    lda VillagerIndex
    bne @skipNightCheck

    lda EnteredBeforeNightfall
    bne @skipNightCheck

    jsr GetPaletteFadeValueForHour
    cmp #DAYTIME_NIGHT
    bne @skipNightCheck
    
    rts

@skipNightCheck:
    lda #1
    sta MustUpdateTextBaloon
    lda #0
    sta TextBaloonIndex

    lda ItemIGave
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

    ldx VillagerIndex

    lda special_thanks_list_low, x
    sta TextPtr
    lda special_thanks_list_high, x
    sta TextPtr + 1
    lda #DIALOG_TEXT_LENGTH
    sta TextLength
    jsr CopyTextToRam

    lda VillagerIndex
    jmp @exit

@checkPlayersHouse:
    lda InHouse
    beq @exit
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
;indoor map loading routine
LoadIndoorMapData:
    lda #$00
    sta $2000
    sta $2001

    lda MustCopyMainChr
    beq @skipLoadingCHR

    lda #<house_tiles_chr
    sta pointer
    lda #>house_tiles_chr
    sta pointer + 1
    lda #$10
    sta chr_dest_high
    lda #$00
    sta chr_dest_low
    lda #16
    sta chr_pages_to_copy
    jsr CopyCHRTiles

    ;6x8 tile chunk for indoor npcs
    lda #<house_sprites_chr
    sta pointer
    lda #>house_sprites_chr
    sta pointer + 1

    lda #8 ; total rows
    sta TempRowIndex
    jsr CopyCHRChunk

    lda #<house_palette
    sta PalettePtr
    lda #>house_palette
    sta PalettePtr + 1


@skipLoadingCHR:


    lda MustRestartIndoorsMusic
    beq @loadHouseStuff
    lda #1
    sta SongName
    sta MustPlayNewSong
    lda #0
    sta MustRestartIndoorsMusic

@loadHouseStuff:
    lda MapPtr
    sta pointer
    lda MapPtr + 1
    sta pointer + 1
    lda #$20    ; $20000
    sta NametableAddress

    jsr LoadNametable
    jsr LoadStatusBar

    

    lda #0
    sta MustLoadHouseInterior
    sta MustLoadSomething

    lda MustSleepAfterFadeOut
    bne @nope
    lda #PALETTE_STATE_FADE_IN
    sta PaletteFadeAnimationState
    lda #PALETTE_FADE_MAX_ITERATION
    sta FadeIdx
    lda #FADE_DELAY_GENERIC
    sta PaletteAnimDelay

    jsr SetupVillagerText

@nope:
    rts
;------------------------------------


.segment "CODE"
