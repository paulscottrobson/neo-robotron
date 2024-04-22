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
		.method MSG_CONTROL,OHGControlHandler
		.superclass


OHGInitHandler:
		.animation GR_GRUNT
		.speed 	32
		.brains 1
		rts


OHGControlHandler:
		ldy 	#0
		jsr 	ChaseObject
		rts


