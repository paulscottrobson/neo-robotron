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

		cmp 	#PF_LEFT					; check out of bounds.
		bcc 	_MOHitWall
		cmp 	#PF_RIGHT
		bcs 	_MOHitWall
		cpy 	#PF_TOP
		bcc 	_MOHitWall
		cpy 	#PF_BOTTOM
		bcs 	_MOHitWall

		sta 	OBXPos,x 					; update position.
		tya
		sta 	OBYPos,x

		.sendmsg MSG_ONMOVE
		bit 	OBFlags,x 					; killed.		
		bmi 	_MONotMove		

		jsr 	RedrawObject 				; repaint.

_MONotMove:
		rts

_MOHitWall:
		.sendmsg MSG_HITWALL 				; hit the wall.
		rts		

FrameCount:
		.byte 	0

; ***************************************************************************************
;
;			   Delay for game speed. 40 seems to be about right for default
;
; ***************************************************************************************

ClockDelay:
		phx
		phy
		ldx 	MoveSpeed
_MLDelay:
		dey
		bne 	_MLDelay
		dex		
		bne 	_MLDelay
		ply
		plx
		rts

MoveSpeed:
		.byte 	40