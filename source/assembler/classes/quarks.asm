; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		quarks.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		22nd April 2024
;		Reviewed :	No
;		Purpose :	Quarks, Tanks and Shells Classes
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Quark Object 
;
; ***************************************************************************************

OHQuark:
		.method MSG_INIT,OHQInitHandler
		.method MSG_ONMOVE,OHQCheckFire
		.superclass

OHQInitHandler:
		.static GR1_QUARK
		.speed 	10
		.brains 30
		.score  1000
		jsr 	Random8Bit
		and 	#63
		sta 	OBIntelligenceCount,x
		rts

OHQCheckFire:
		jsr 	Random8Bit
		and 	#31
		bne 	_OHQCFExit
		lda 	#TP_TANK
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		rts
_OHQCFExit:
		rts		


; ***************************************************************************************
;
;									Tank Object 
;
; ***************************************************************************************

OHTank:
		.method MSG_INIT,OHTNInitHandler
		.method MSG_ONMOVE,OHTNCheckFire
		.superclass

OHTNInitHandler:
		.animation GR_TANK
		.speed 	15
		.brains 30
		.score  200
		rts

OHTNCheckFire:
		jsr 	Random8Bit
		and 	#31
		bne 	_OHTNCFExit
		lda 	#TP_SHELL
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		jsr 	ChasePlayerY
		rts
_OHTNCFExit:
		rts		

; ***************************************************************************************
;
;									Shells Object 
;
; ***************************************************************************************

OHShell:
		.method MSG_INIT,OHSHInitHandler
		.method MSG_HITWALL,OHSHHitWall
		.method MSG_CONTROL,NoControlEffect
		.method MSG_ONMOVE,OHSHCheckLife
		.superclass

OHSHCheckLife:
		dec 	OBObjectData1,x
		bne 	_OHSHCLExit
		jsr 	KillObject
_OHSHCLExit:
		rts

OHSHInitHandler:
		jsr 	ChasePlayer
		.static GR1_MISSILE2
		.speed 	5
		.brains 255
		.score  50
		lda 	#200
		sta 	OBObjectData1,x
		rts

OHSHHitWall:
		lda 	OBXPos,x
		cmp 	#PF_LEFT+1
		bcc 	_OHSH1
		cmp 	#PF_RIGHT-1
		bcc 	_OHSHCheckVertical
_OHSH1:
		lda 	OBDirection,x
		eor 	#3
		sta 	OBDirection,x	
_OHSHCheckVertical:			
		lda 	OBYPos,x
		cmp 	#PF_TOP+1
		bcc 	_OHSH2
		cmp 	#PF_BOTTOM-1
		bcc 	_OHSHExit
_OHSH2:
		lda 	OBDirection,x
		eor 	#12
		sta 	OBDirection,x
_OHSHExit:		
		rts
