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
		jmp 	MainLoop 					; $C006 main loop code.
		
		.include 	"create.asm"
		.include 	"move.asm"
		.include 	"palette.asm"
		.include 	"utility.asm"
		.include 	"classes/default.asm"
		.include 	"classes/player.asm"
		.include 	"classes/pmissile.asm"
		.include 	"classes/human.asm"
		.include 	"classes/grunt.asm"
		.include 	"classes/hulk.asm"
		.include 	"classes/sphere.asm"
		.include 	"classes/quarks.asm"
		.include 	"classes/electrode.asm"

MainLoop:
		jsr 	AnimatePalette
		jsr 	MoveObjects
		rts

HandlerTable:
		.word 		OHPlayer 				; type 0, player object
		.word 		OHMissile 				; type 1, player missile object
		.word 		OHHuman1 				; type 2-4 humans
		.word 		OHHuman2
		.word 		OHHuman3
		.word 		OHGrunt 				; type 5 grunt
		.word 		OHHulk 					; type 6 hulk
		.word 		OHESpark 				; type 7 Enforcer Sparks.
		.word 		OHEnforcer 				; type 8 Enforcer
		.word 		OHSphere 				; type 9 Sphere
		.word 		OHShell 				; type 10 shell
		.word 		OHTank 					; type 11 tank
		.word 		OHQuark 				; type 12 quark
		.word 		OHElectrode 			; type 13 electrode

		* = $E000
		.include "data.asm"