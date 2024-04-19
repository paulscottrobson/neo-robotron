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
		jmp 	CreateObjects 				; $C003 create X objects of type A.
		jmp 	MoveObjects 				; $C006 move all objects
		
		.include 	"create.asm"
		.include 	"move.asm"
		.include 	"utility.asm"
		.include 	"classes/default.asm"
		.include 	"classes/player.asm"
		.include 	"classes/pmissile.asm"

HandlerTable:
		.word 		OHPlayer 				; type 0, player object
		.word 		OHMissile 				; type 1, player missile object

		* = $E000
		.include "data.asm"