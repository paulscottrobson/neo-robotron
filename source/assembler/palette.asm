; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		palette.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		24th April 2024
;		Reviewed :	No
;		Purpose :	Palette animation
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;								Animate the palette
;
; ***************************************************************************************

AnimatePalette:
		lda 	APICommand
		bne 	AnimatePalette

		inc 	_APCount
		lda 	_APCount
		lsr 	a
		lsr 	a
		ldy 	#1
		jsr 	_APBit
		jsr 	_APBit
		jsr 	_APBit

		lda 	#14*16
		sta 	APIParams
		lda 	#32
		sta 	APIFunction
		lda 	#5
		sta 	APICommand
		rts

_APBit:
		lsr 	a
		pha
		lda 	#0
		sbc 	#0
		sta 	APIParams,y
		iny
		pla
		rts

_APCount:		
		.byte 	0