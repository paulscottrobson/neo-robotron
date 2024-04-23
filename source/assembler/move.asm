; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		move.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Move all objects
;
; ***************************************************************************************
; ***************************************************************************************


; ***************************************************************************************
;
;									Move all object
;
; ***************************************************************************************

MoveObjects:
		inc 	FrameCount
		ldx 	#0  						; look for an unused object
_MOLoop: 		
		bit 	OBFlags,x
		bmi 	_MONoObject	
		jsr 	_MoveOneObject
_MONoObject:		
		inx
		cpx 	#OBJ_COUNT
		bne 	_MOLoop 
		rts  								; cannot create, exit.

_MoveOneObject:
		dec 	OBSpeedCounter,x 			; speed counter down to zero.
		bne 	_MONotMove
		lda 	OBSpeed,x 					; reset speed counter
		sta 	OBSpeedCounter,x
		
		dec 	OBIntelligenceCount,x 		; time for a rethink
		bne 	_MONoProcess
		lda 	OBIntelligence,x 			; reset the counter
		sta 	OBIntelligenceCount,x
		.sendmsg MSG_CONTROL 				; send a request to control change.
_MONoProcess:

		lda 	OBDirection,x 				; current direction.
		ldy 	OBXPos,x 					; new X position => Y
		lsr 	a
		bcc 	_MONotLeft
		dey
_MONotLeft:
		lsr 	a		
		bcc 	_MONotRight
		iny
_MONotRight:
		phy 								; new Y position on stack

		ldy 	OBYPos,x 					; new Y position => Y
		lsr 	a
		bcc 	_MONotUp
		dey
_MONotUp:
		lsr 	a		
		bcc 	_MONotDown
		iny
_MONotDown:
		pla 								; (A,Y) are new coordinates.

		cmp 	#4  						; check out of bounds.
		bcc 	_MOHitWall
		cmp 	#156
		bcs 	_MOHitWall
		cpy 	#4
		bcc 	_MOHitWall
		cpy 	#108
		bcs 	_MOHitWall

		sta 	OBXPos,x 					; update position.
		tya
		sta 	OBYPos,x

		.sendmsg MSG_ONMOVE
		
		jsr 	RedrawObject 				; repaint.

_MONotMove:
		rts

_MOHitWall:
		.sendmsg MSG_HITWALL 				; hit the wall.
		rts		

FrameCount:
		.byte 	0
