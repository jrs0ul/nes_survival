;
; Lauri Kasanen, 6 Jun 2017
; (C) Mega Cat Studios
; An optimized LZ4 decompressor
;

    .macpack    longbranch
    .macpack        cpu

regsave = MapColumnAttributes
regbank = MapColumnData
ptr3 = DigitPtr
ptr4 = ProjectilePtr
_out = regsave
_written = regsave + 2
_tmp = Temp
_token = TempX
tmp3 = TempY
tmp4 = TempZ
_offset = ptr3
_in = sreg
_outlen = ptr4
ptr1 = pointer
ptr2 = TextPtr

TEMP = pointer2

PPU_ADDR = $2006
PPU_DATA = $2007

popax:

        ldy     #1
        lda     (sp),y          ; get hi byte
        tax                     ; into x
.if (.cpu .bitand ::CPU_ISET_65SC02)
        lda     (sp)            ; get lo byte
.else
        dey
        lda     (sp),y          ; get lo byte
.endif

incsp2:

        inc     sp              ; 5
        beq     @L1             ; 2
        inc     sp              ; 5
        beq     @L2             ; 2
        rts

@L1:    inc     sp              ; 5
@L2:    inc     sp+1            ; 5
        rts
;--------------------------

pushax:

        pha                     ; (3)
        lda     sp              ; (6)
        sec                     ; (8)
        sbc     #2              ; (10)
        sta     sp              ; (13)
        bcs     @L1             ; (17)
        dec     sp+1            ; (+5)
@L1:    ldy     #1              ; (19)
        txa                     ; (21)
        sta     (sp),y          ; (27)
        pla                     ; (31)
        dey                     ; (33)
.if (.cpu .bitand ::CPU_ISET_65SC02)
        sta     (sp)            ; (37)
.else
        sta     (sp),y          ; (38)
.endif
        rts                     ; (44/43)
;----------------------------
vram_write:

    sta <TEMP
    stx <TEMP+1

    jsr popax
    sta <TEMP+2
    stx <TEMP+3

    ldy #0

@1:

    lda (TEMP+2),y
    sta PPU_DATA
    inc <TEMP+2
    bne @2
    inc <TEMP+3

@2:

    lda <TEMP
    bne @3
    dec <TEMP+1

@3:

    dec <TEMP
    lda <TEMP
    ora <TEMP+1
    bne @1

    rts

; ---------------------------------------------------------------
; void decompress_lz4 (const u8 *in, u8 * const out, const u16 outlen)
; ---------------------------------------------------------------


; size in ptr3, src in ptr1, dest in ptr2
; don't touch size
memcpy_r2v:

    lda ptr2+1
    sta PPU_ADDR
    lda ptr2
    sta PPU_ADDR

    lda ptr1
    ldx ptr1+1
    jsr pushax

    lda ptr3
    ldx ptr3+1

    jmp vram_write

memcpy_v2v:

    lda #0
    sta tmp3
    sta tmp4
    jmp @check

@loop:
; read source byte
    lda ptr1+1
    sta PPU_ADDR
    lda ptr1
    sta PPU_ADDR

    ldx PPU_DATA
    ldx PPU_DATA

    inc ptr1
    bne @nosrcinc
    inc ptr1+1
@nosrcinc:

; write dst byte
    lda ptr2+1
    sta PPU_ADDR
    lda ptr2
    sta PPU_ADDR

    stx PPU_DATA

    inc ptr2
    bne @nodstinc
    inc ptr2+1
@nodstinc:

; increase counter
    inc tmp3
    bne @noinc
    inc tmp4
@noinc:

@check:
    lda tmp3
    cmp ptr3
    lda tmp4
    sbc ptr3+1
    bcc @loop

    rts
;---------------------------

UnLZ4toVram:

    sta _outlen
    stx _outlen+1

    jsr popax
    sta _out
    stx _out+1

    jsr popax
    sta _in
    stx _in+1

;
; written = 0;
;
    lda     #$00
    sta     _written
;
; while (written < outlen) {
;
    jmp     L0046
;
; token = *in++;
;
L0004:  ldy #0
    lda     (_in),y
    sta _token

    inc _in
    bne L000A
    inc _in+1
L000A:
;
; offset = token >> 4;
;
    ldx     #$00
    lsr     a
    lsr     a
    lsr     a
    lsr     a
    sta     _offset
    stx     _offset+1
;
; token &= 0xf;
; token += 4; // Minmatch
;
    lda     _token
    and     #$0F
    clc
    adc #4
    sta     _token
;
; if (offset == 15) {
;
    lda     _offset
    cmp     #$0F
L0013:  bne     L001A
;
; tmp = *in++;
;
    ldy #0
    lda (_in),y
    sta _tmp

    inc _in
    bne L0017
    inc _in+1
L0017:
;
; offset += tmp;
;
    clc
    adc     _offset
    sta     _offset
    lda     #$00
    adc     _offset+1
    sta     _offset+1
;
; if (tmp == 255)
;
    lda     _tmp
    cmp     #$FF
;
; goto moreliterals;
;
    jmp     L0013
;
; if (offset) {
;
L001A:  lda     _offset
    ora     _offset+1
    beq     L001C
;
; memcpy(&out[written], in, offset);
;
    lda     _out
    clc
    adc     _written
    sta ptr2
    lda     _out+1
    adc     _written+1
    tax
    stx ptr2+1
    lda     _in
    ldx     _in+1
    sta ptr1
    stx ptr1+1
    jsr     memcpy_r2v
;
; written += offset;
;
    lda     _offset
    clc
    adc     _written
    sta     _written
    lda     _offset+1
    adc     _written+1
    sta     _written+1
;
; in += offset;
;
    lda     _offset
    clc
    adc     _in
    sta     _in
    lda     _offset+1
    adc     _in+1
    sta     _in+1
;
; if (written >= outlen)
;
L001C:  lda     _written
    cmp     _outlen
    lda     _written+1
    sbc     _outlen+1
;
; return;
;
    bcc     L0047
    rts
;
; memcpy(&offset, in, 2);
;
L0047:  ldy #0
    lda     (_in),y
    sta _offset
    iny
    lda     (_in),y
    sta _offset+1
;
; in += 2;
;
    lda     #$02
    clc
    adc     _in
    sta     _in
    bcc     L002F
    inc     _in+1
;
; copysrc = out + written - offset;
;
L002F:  lda     _out
    clc
    adc     _written
    pha
    lda     _out+1
    adc     _written+1
    tax
    pla
    sec
    sbc     _offset
    sta     ptr1
    txa
    sbc     _offset+1
    sta     ptr1+1
;
; offset = token;
;
    lda     #$00
    sta     _offset+1
    lda     _token
    sta     _offset
;
; if (token == 19) {
;
    cmp     #$13
L0045:  bne     L003C
;
; tmp = *in++;
;
    ldy #0
    lda (_in),y
    sta _tmp

    inc _in
    bne L0039
    inc _in+1
L0039:
;
; offset += tmp;
;
    clc
    adc     _offset
    sta     _offset
    tya
    adc     _offset+1
    sta     _offset+1
;
; if (tmp == 255)
;
    lda     _tmp
    cmp     #$FF
;
; goto morematches;
;
    jmp     L0045
;
; memcpy(&out[written], copysrc, offset);
;
L003C:  lda     _out
    clc
    adc     _written
    sta ptr2
    lda     _out+1
    adc     _written+1
    tax
    stx ptr2+1
    jsr     memcpy_v2v
;
; written += offset;
;
    lda     _offset
    clc
    adc     _written
    sta     _written
    lda     _offset+1
    adc     _written+1
L0046:  sta     _written+1
;
; while (written < outlen) {
;
    lda     _written
    cmp     _outlen
    lda     _written+1
    sbc     _outlen+1
    jcc     L0004

    rts

