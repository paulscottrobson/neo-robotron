; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		main.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Assembly Main Program
;
; ***************************************************************************************
; ***************************************************************************************

		.include 	"constants.inc"

		* = $C000
		jmp 	ResetObjects 				; $C000 reset all sprites.
		jmp 	CreateObject 				; $C003 create object of type A.

		.include 	"create.asm"
		.include 	"utility.asm"

		* = $E000
		.include "data.asm"