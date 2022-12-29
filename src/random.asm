UpdateRandomNumber:

    lda RandomNumber
    lsr 
    bcc noeor
    eor #$B4
noeor:
    sta RandomNumber

    rts
