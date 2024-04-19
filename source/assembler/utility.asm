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

		ldy 	OBXPos,x 					; use Y to animate
		lda 	OBDirection,x 				; get direction.
		and 	#15 						; if 0 do not animate at all.
		beq 	_ROUseSprite2
		and 	#3  						; if a L/R component use X Pos
		bne 	_ROHasHorizonMovement
		ldy 	OBYPos,x 					; otherwise use Y Pos
_ROHasHorizonMovement:
		tya 								; put bit 2 into carry.
		lsr 	a
		lsr 	a
		lsr 	a
		lda 	OBSprite1,x 				; set graphic according to carry.
		bcc 	_ROUseSprite
_ROUseSprite2:		
		lda 	OBSprite2,x
_ROUseSprite:		
		sta 	APIParams+5

		lda 	OBDirection,x 				; check moving left
		and 	#1 							; bit 0 of direction sets xflip
		sta 	APIParams+6 				; set flip

_RONotLeft:		
		.sendmsg MSG_REPAINT 				; prior to repaint
		
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

; ***************************************************************************************
;
;									 Send object message
;
; ***************************************************************************************

SendObjectMessage:
		pha
		lda 	OBHandlerLow,x
		sta 	_SMCall+1
		lda 	OBHandlerHigh,x
		sta 	_SMCall+2
		pla
_SMCall:
		jmp 	$0000		

; ***************************************************************************************
;
;									Set the object graphic
;
; ***************************************************************************************

SetObjectGraphic:
		sta 	OBSprite1,x
		inc 	a
		sta 	OBSprite2,x
		rts