; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		score.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		24th April 2024
;		Reviewed :	No
;		Purpose :	Score code
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;										 Set Wave
;
; ***************************************************************************************

SetWave:
		sta 	Wave
		rts

; ***************************************************************************************
;
;										Reset Score
;
; ***************************************************************************************

ResetScore:
		stz 	DScore+0
		stz 	DScore+1
		stz 	DScore+2
		lda 	#3
		sta 	Lives
		jsr 	DrawScore

		ldx 	#24
		ldy 	#29
		jsr 	MoveCursor
		lda 	#$81
		jsr 	PrintCharacter
		jsr 	RSPrintWave
		lda 	#$82
		jsr 	PrintCharacter
		lda 	#32
		jsr 	PrintCharacter
		ldx 	#235
_RSPrintWave:
		txa
		jsr 	PrintCharacter
		inx
		cpx 	#239
		bne 	_RSPrintWave	
		rts
RSPrintWave:		
		lda 	Wave
		cmp 	#$10
		bcs 	PrintByte
		bra 	PrintNibble
		lda 	Wave

; ***************************************************************************************
;
;									  Redraw the score
;
; ***************************************************************************************

DrawScore:
		ldx 	#4
		ldy 	#0
		jsr 	MoveCursor

		lda 	#$86
		jsr 	PrintCharacter
		lda 	DScore+2
		jsr 	PrintByte
		lda 	DScore+1
		jsr 	PrintByte
		lda 	DScore+0
		jsr 	PrintByte

		lda 	#32
		jsr 	PrintCharacter
		lda		#$83
		ldx 	Lives
		jsr 	PrintCharacter
_DSLoop:dex
		beq 	_DSExit
		lda 	#234
		jsr 	PrintCharacter
		bra 	_DSLoop
_DSExit:				
		rts

MoveCursor:
		lda 	APICommand
		bne 	DrawScore
		sty 	APIParams+1
		stx 	APIParams+0
		lda 	#7
		sta 	APIFunction
		lda 	#2
		sta 	APICommand
		rts

PrintByte:
		pha
		lsr 	a
		lsr 	a
		lsr 	a
		lsr 	a
		jsr 	PrintNibble
		pla
PrintNibble:
		and 	#15
		ora 	#224

PrintCharacter:
		ldy 	APICommand
		bne 	PrintCharacter
		sta 	APIParams+0
		lda 	#6
		sta 	APIFunction
		lda 	#2
		sta 	APICommand
		rts

DScore:
		.byte 	0,0,0,0
Lives:	
		.byte 	3		
Wave:	
		.byte 	$12		