; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		sphere.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		22nd April 2024
;		Reviewed :	No
;		Purpose :	Spheres, Enforcers and Sparks Classes
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Sphere Object 
;
; ***************************************************************************************

OHSphere:
		.method MSG_INIT,OHSInitHandler
		.method MSG_CONTROL,OHSControl
		.method MSG_ONMOVE,OHSCheckFire
		.method MSG_REPAINT,OHSRepaint
		.superclass

OHSInitHandler:
		.animation GR_SPHEROID
		.speed 	8
		.brains 40
		.score  1000
		jsr 	Random8Bit
		and 	#63
		sta 	OBIntelligenceCount,x
		rts

OHSControl:
		lda 	OBDirection,x
		bne 	_OHSNoMove
		jsr		ChooseRandomDirection 	
		rts
_OHSNoMove:
		stz 	OBDirection,x
		rts		

OHSCheckFire:
		jsr 	Random8Bit
		and 	#63
		bne 	_OHSCFExit
		lda 	#TP_ENFORCER
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		rts
_OHSCFExit:
		rts		

OHSRepaint:		
		lsr 	APIParams+5
		inc 	OBObjectData1,x
		lda 	OBObjectData1,x
		lsr 	a
		rol 	APIParams+5		
		rts

; ***************************************************************************************
;
;									Enforcer Object 
;
; ***************************************************************************************

OHEnforcer:
		.method MSG_INIT,OHENInitHandler
		.method MSG_CONTROL,ChasePlayer
		.method MSG_ONMOVE,OHENCheckFire
		.superclass

OHENInitHandler:
		.static GR1_ENFORCER
		.speed 	15
		.brains 30
		.score  150
		rts

OHENCheckFire:
		jsr 	Random8Bit
		and 	#31
		bne 	_OHENCFExit
		lda 	#TP_ESPARK
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		jsr 	ChasePlayerY
		rts
_OHENCFExit:
		rts		

; ***************************************************************************************
;
;							Enforcer Sparks Object 
;
; ***************************************************************************************

OHESpark:
		.method MSG_INIT,OHESInitHandler
		.method MSG_HITWALL,KillObject
		.method MSG_CONTROL,NoControlEffect
		.superclass

OHESInitHandler:
		jsr 	ChasePlayer
		.static GR1_MISSILE2
		.speed 	7
		.brains 255
		.score  25
		rts
