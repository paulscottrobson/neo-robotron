; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		grunt.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		22nd April 2024
;		Reviewed :	No
;		Purpose :	Grunt Class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Grunt Object 
;
; ***************************************************************************************

OHGrunt:
		.method MSG_INIT,OHGInitHandler
		.method MSG_CONTROL,ChasePlayer
		.method MSG_ONMOVE,OHGSound
		.superclass

OHGSound:
		jsr 	SND_GruntMove
		.superclass		

OHGInitHandler:
		.animation GR_GRUNT
		.speed 	32
		.brains 1
		.score  100
		rts




