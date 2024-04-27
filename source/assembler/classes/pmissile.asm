; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		pmissile.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		19th April 2024
;		Reviewed :	No
;		Purpose :	Player Missile class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Player Missile object
;
; ***************************************************************************************

OHMissile:
		.method MSG_INIT,OHMInitHandler
		.method MSG_REPAINT,OHMRepaintHandler
		.method MSG_CONTROL,OHMControl
		.method MSG_HITWALL,OHMHitWall
		.method MSG_ONMOVE,OHMOnMove
		.superclass

OHMInitHandler:
		.speed 	1
		lda 	OBXPos 						; copy position
		sta 	OBXPos,x
		lda 	OBYPos
		sta 	OBYPos,x
		lda 	OHPLastDirection 			; copy direction
		sta 	OBDirection,x
		lda 	#3  						; stops collision testing straight after fire.
		sta 	OBObjectData1,x 	
		rts

OHMRepaintHandler:
		ldy 	OBDirection,x
		lda 	OHMGraphic,y 				; set graphic.
		sta 	OBSprite1,x
		sta 	OBSprite2,x
		stz 	APIParams+6 				; disables the flip.	
		rts

OHMGraphic:
		.byte 	0,GR1_HORIZFIRE,GR1_HORIZFIRE,0 
		.byte 	GR1_VERTFIRE,GR1_NWSEFIRE,GR1_SWNEFIRE,0
		.byte 	GR1_VERTFIRE,GR1_SWNEFIRE,GR1_NWSEFIRE,0
		.byte 	0,0,0,0

OHMControl:
		rts

OHMOnMove:
		lda 	OBObjectData1,x
		beq 	_OHMExit
		dec 	OBObjectData1,x
_OHMExit:
		rts	

OHMHitWall:
		jsr 	KillObject
		rts
		

