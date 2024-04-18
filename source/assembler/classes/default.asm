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
		.superclass

;
;		Control default is random walking.
;
DefaultControl:
		jmp 	ChooseRandomDirection		

