
.segment "ROM2"

;destructible idx in y register
SwitchPlate:

    lda ModifiedTiles, y
    beq @switchLockOn
    lda #0
    jmp @saveLock
@switchLockOn:
    lda #1
@saveLock:
    sta ModifiedTiles, y

    rts

;---------------------------
Switch1Logic:

    ldy #7
    jsr SwitchPlate

    ldy #9
    lda ModifiedTiles, y
    ldy #8
    clc
    adc ModifiedTiles, y
    cmp #0
    beq @first_lock

    lda ModifiedTiles, y ;8
    bne @third_lock
    ;second lock
    ldy #7
    lda ModifiedTiles, y
    ldy #5
    sta ModifiedTiles, y
    jmp @done

@third_lock:
    ldy #7
    lda ModifiedTiles, y
    ldy #4
    sta ModifiedTiles, y
    jmp @done

@first_lock:
    ldy #7
    lda ModifiedTiles, y
    ldy #6
    sta ModifiedTiles, y

@done:
    rts
;------------------------
Switch2Logic:
    ldy #4
    lda ModifiedTiles, y
    ldy #7
    sta ModifiedTiles, y

    ldy #8
    jsr SwitchPlate
    lda ModifiedTiles, y
    beq @done
    ldy #9
    lda #0
    sta ModifiedTiles, y
@done:
    rts
;------------------------
Switch3Logic:
    ldy #5
    lda ModifiedTiles, y
    ldy #7
    sta ModifiedTiles, y

    ldy #9
    jsr SwitchPlate
    lda ModifiedTiles, y
    beq @done
    ldy #8
    lda #0
    sta ModifiedTiles, y

@done:
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

   jsr Switch3Logic

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
