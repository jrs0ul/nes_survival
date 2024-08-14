
.segment "ROM2"

Switch1Logic:
     dey ;row
    dey ;screen
    dey ;lo
    dey ;hi
    dey ;status idx
    lda (pointer2), y
    tay
    lda Destructibles, y
    bne @turnOff ; already switched on
    lda #1
    jmp @changeTiles
@turnOff:
    lda #0
@changeTiles:
    ldy #7
    sta Destructibles, y

    ldy #4 ; first lock
    lda Destructibles, y
    beq @switchLock1On
    lda #0
    jmp @saveLock
@switchLock1On:
    lda #1
@saveLock:
    sta Destructibles, y

    ldy #6 ;third lock
    lda Destructibles, y
    beq @switchLock3On
    lda #0
    jmp @saveLock3
@switchLock3On:
    lda #1
@saveLock3:
    sta Destructibles, y

    rts
;------------------------
Switch2Logic:
    dey ;row
    dey ;screen
    dey ;lo
    dey ;hi
    dey ;status idx
    lda (pointer2), y
    tay
    lda Destructibles, y
    bne @turnOff2 ; already switched on
    lda #1
    jmp @changeTiles2
@turnOff2:
    lda #0
@changeTiles2:
    ldy #8
    sta Destructibles, y

    ldy #5 ;second switch
    lda Destructibles, y
    beq @switchLock2On
    lda #0
    jmp @changeSwitch2
@switchLock2On:
    lda #1
@changeSwitch2:
    sta Destructibles, y

    lda #6
    lda Destructibles, y
    beq @switchLock3On
    lda #0
    jmp @changeSwitch3
@switchLock3On:
    lda #1
@changeSwitch3:
    sta Destructibles, y
    rts


;------------------------

SwitchesLogic:
    lda LocationIndex
    asl
    tay
    lda mod_tiles_by_location, y
    sta pointer2
    iny
    lda mod_tiles_by_location, y
    sta pointer2 + 1

    ldx #0
@tileLoop:

    txa ;tile index * 8
    asl
    asl
    asl
    tay
    iny
    iny
    iny ;at screen
    lda ScrollX
    cmp #128
    bcs @addScreen
    lda CurrentMapSegmentIndex
    jmp @compare
@addScreen:
    lda CurrentMapSegmentIndex
    clc
    adc #1
@compare:
    cmp (pointer2), y
    bne @nextDestructible
    iny
    lda (pointer2), y
    sec
    sbc #4
    cmp TempY
    bne @nextDestructible
    iny
    lda (pointer2), y
    cmp TempX
    bne @nextDestructible

    cpx #6
    bcc @exit
    cpx #10
    bcs @secondTrigger

    jsr Switch1Logic

    jmp @redraw

@secondTrigger:

    cpx #14
    bcs @thirdTrigger

    jsr Switch2Logic

    jmp @redraw

@thirdTrigger:

    dey ;row
    dey ;screen
    dey ;lo
    dey ;hi
    dey ;status idx
    lda (pointer2), y
    tay
    lda Destructibles, y
    bne @turnOff3 ; already switched on
    lda #1
    jmp @changeTiles3
@turnOff3:
    lda #0
@changeTiles3:
    ldy #9
    sta Destructibles, y

    ldy #4
    lda Destructibles, y
    beq @turnSwitch1On
    lda #0
    jmp @saveLock1
@turnSwitch1On:
    lda #1
@saveLock1:
    sta Destructibles, y

    ldy #5
    lda Destructibles, y
    beq @turnSwitch2On
    lda #0
    jmp @saveLock2
@turnSwitch2On:
    lda #1
@saveLock2:
    sta Destructibles, y


@redraw:
    lda #1
    sta MustUpdateDestructibles
    jmp @exit

@nextDestructible:
    inx
    txa
    ldy LocationIndex
    cmp mod_tiles_count_by_location, y
    bcs @exit

    jmp @tileLoop

@exit:
    rts

.segment "CODE"
