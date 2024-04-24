; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		brains.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		24th April 2024
;		Reviewed :	No
;		Purpose :	Brains and Progs classes
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Brains Object 
;
; ***************************************************************************************

OHBrain:
		.method MSG_INIT,OHBInitHandler
		.method MSG_ONMOVE,OHBCheckEat
		.method MSG_CONTROL,OHBChaseHuman
		.method MSG_HITWALL,ChooseRandomDirection
		.superclass

OHBInitHandler:
		.animation GR_BRAIN
		.speed 	24
		.brains 1
		.score  500
		jsr 	ChooseRandomDirection
		rts

OHBCheckEat:
		ldy 	OBObjectData1,x 			; object being chased.
		beq 	_OHBCEExit 					; none
		lda 	OBFlags,y 					; actual object
		bmi 	_OHBCEExit 					; not existing.
		jsr 	CheckCollision 				; are Y/X colliding ?
		bcc 	_OHBCEExit

		phx
		lda 	#TP_PROG 					; create a PROG here
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		plx
		phx		
		jsr 	KillObject	 				; kill the parent object
		lda 	OBObjectData1,x 			; and the thing it collided with, the human.
		tax
		jsr 	KillObject
		plx

_OHBCEExit:		
		rts

OHBChaseHuman:
		ldy 	OBObjectData1,x 			; check chase
		beq 	_OHBNewChoose
		lda 	OBFlags,y 					; chased still alive ?
		bpl 	_OHBChaseIt
_OHBNewChoose:
		jsr 	Random8Bit 					; no, keep randomly trying till found a live one.
		and 	#OBH_RANDOM_MASK
		cmp 	#OBC_HUMANS
		bcs 	_OHBNewChoose
		adc 	#OB_HUMANS
		tay
		lda 	OBObjectData1,y
		bmi 	_OHBExit
		tya
		sta 	OBObjectData1,x
		rts
_OHBChaseIt:
		ldy 	OBObjectData1,x
		jsr 	ChaseObject
_OHBExit:		
		rts


; ***************************************************************************************
;
;									Prog Object 
;
; ***************************************************************************************

OHProg:
		.method MSG_INIT,OHPRInitHandler
		.method MSG_CONTROL,ChasePlayer
		.superclass

OHPRInitHandler:
		.static GR1_PROG
		.speed 4
		.brains 1
		.score 100
		rts		

