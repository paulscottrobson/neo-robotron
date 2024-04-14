; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		utility.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Utility functions
;
; ***************************************************************************************
; ***************************************************************************************


; ***************************************************************************************
;
;							Reset all sprite objects
;
; ***************************************************************************************

ResetObjects:
		ldx 	#0
_RSLoop:
		lda 	#$FF
		sta 	OBFlags,x
		inx
		cpx 	#OBJ_COUNT
		bne 	_RSLoop
		rts

; ***************************************************************************************
;
;							Redraw the current object
;
; ***************************************************************************************
		
RedrawObject:			
		lda 	APICommand 					; wait for API to be available
		bne 	RedrawObject

		stx 	APIParams+0 				; sprite # same as object #

		stz 	APIParams+2 				; shift X left into X position
		lda 	OBXPos,x
		asl 	a
		sta 	APIParams+1
		rol 	APIParams+2

		stz 	APIParams+4  				; shift Y left into Y position
		lda 	OBYPos,x
		asl 	a
		adc 	#16 						; allow for top area
		sta 	APIParams+3

		lda 	OBSprite1,x 				; set graphic
		bit 	OBFlags,x
		bvc 	_ROUseSprite1
		lda 	OBSprite2,x
_ROUseSprite1:		
		sta 	APIParams+5

		lda 	OBDirection,x 				; check moving left
		and 	#1 							; bit 0 of direction sets xflip
		sta 	APIParams+6 				; set flip

_RONotLeft:		
		lda 	#2  						; and draw it.
		sta 	APIFunction
		lda 	#6
		sta 	APICommand

		rts

; ***************************************************************************************
;
;										8 bit RNG
;
; ***************************************************************************************

Random8Bit:
		phy
		ldy 	#8
		lda 	_R8SeedValue+0
_R8RandomLoop
		asl     a
		rol 	_R8SeedValue+1
		bcc 	_R8NotSet
		eor 	#$39   
_R8NotSet:
		dey
		bne 	_R8RandomLoop
		sta 	_R8SeedValue+0
		ply		
		rts		

_R8SeedValue
		.word 	$ABCD
