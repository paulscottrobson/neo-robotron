; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		explode.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		27th April 2024
;		Reviewed :	No
;		Purpose :	Exploding effect
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;								Explosion Object 
;
; ***************************************************************************************

OHExplode:
		.method MSG_INIT,OHXInitHandler
		.method MSG_ONMOVE,OHXOnMove
		.method MSG_CONTROL,OHXNoMove
		.method MSG_SHOT,OHXNoHit
		.superclass


OHXInitHandler:
		jsr 	UpdateAnimation
		.speed 	8
		.brains 255
OHXNoMove:		
		stz 	OBDirection,x
OHXNoHit:		
		rts

OHXOnMove:
		lda 	OBObjectData1,x
		cmp 	#4
		beq 	_OHXKill
		inc 	OBObjectData1,x
		jsr 	UpdateAnimation
		stz 	OBDirection,x
		rts
_OHXKill:
		jsr 	KillObject
		rts

UpdateAnimation:
		lda 	OBObjectData1,x
		ora 	#$C0
		sta 	OBSprite1,x
		sta 	OBSprite2,x
		rts				




