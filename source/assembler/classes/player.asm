; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		player.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		18th April 2024
;		Reviewed :	No
;		Purpose :	Player class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Player object
;
; ***************************************************************************************

OHPlayer:
		.method MSG_INIT,OHPInitHandler
		.method MSG_REPAINT,OHPRepaintHandler
		.method MSG_CONTROL,OHPControlHandler
		.superclass

OHPInitHandler:
		lda 	#160/2
		sta 	OBXPos,x
		lda 	#128/2
		sta 	OBYPos,y
		.speed 	2
		.brains 1
		rts

OHPRepaintHandler:
		lda 	OBDirection,x 				; is movement purely vertical
		and 	#3
		bne 	_OHPRHorizontal
		.animation GR_PLAYERV
		rts
_OHPRHorizontal:		
		.animation GR_PLAYERH
		rts

OHPControlHandler:
		lda 	APICommand 					; wait for API
		bne 	OHPControlHandler
		lda 	#1  						; and draw it.
		sta 	APIFunction
		lda 	#7
		sta 	APICommand
_OHPWait		
		lda 	APICommand 					; wait for result
		bne 	_OHPWait
		lda 	APIParams 					; put the controller dpad bits into the direction.
		and 	#15  						; (made the same for this reason)
		sta 	OBDirection,x
		beq 	_OHPNoSetLast 				; set last direction if non zero
		sta 	OHPLastDirection
_OHPNoSetLast:		
		rts		

OHPLastDirection:
		.byte 	2		
		