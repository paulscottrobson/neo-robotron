; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		default.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		18th April 2024
;		Reviewed :	No
;		Purpose :	Default handler
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Default handlers
;
; ***************************************************************************************

DefaultHandler:
		.method MSG_CONTROL,DefaultControl
		.method MSG_HITWALL,DefaultHitWall
		.method MSG_SHOT,DefaultShot
		.superclass

;
;		Control default is random walking.
;
DefaultControl:
		jmp 	ChooseRandomDirection		
;
;		Hit wall default is to randomly redirect.
;
DefaultHitWall:
		jmp 	ChooseRandomDirection		
;
;		Robot has been shot. Y missile, X object hit.
;
DefaultShot:
		lda 	#TP_EXPLODE 				; spawn an explosion
		jsr 	CreateSingleObject
		ldy 	NewObject
		jsr 	CopyStartPosition
		jsr 	RemoveAndScoreObject 		; remove object and score it
		rts

RemoveAndScoreObject:
		lda 	OBScoreLow,x 				; get score into YA
		ldy 	OBScoreHigh,x
		phx		
		jsr 	AddYAToScore 				; add to score
		plx
		jmp 	KillObject 					; delete the object
