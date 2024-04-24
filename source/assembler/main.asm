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
		jmp 	ResetScore 					; $C009 reset the score.
		jmp 	SetWave 					; $C00C New Wave A
		
		.include 	"create.asm"
		.include 	"move.asm"
		.include 	"palette.asm"
		.include 	"utility.asm"
		.include 	"score.asm"
		.include 	"classes/default.asm"
		.include 	"classes/player.asm"
		.include 	"classes/pmissile.asm"
		.include 	"classes/human.asm"
		.include 	"classes/grunt.asm"
		.include 	"classes/hulk.asm"
		.include 	"classes/sphere.asm"
		.include 	"classes/quarks.asm"
		.include 	"classes/electrode.asm"
		.include 	"classes/brains.asm"

MainLoop:
		inc 	FrameCount
		jsr 	AnimatePalette 				; causes flashing effects
		jsr 	MoveObjects 				; move all objects
		jsr 	ClockDelay 					; delay to stop it being insanely fast.
		rts

FrameCount:
		.byte 	0

HandlerTable:
		.word 		OHPlayer 				; type 0 Player
		.word 		OHMissile 				; type 1 Player missile 
		.word 		OHGrunt 				; type 2 Grunt
		.word 		OHElectrode 			; type 3 Electrode
		.word 		OHHuman1 				; type 4-6 Humans
		.word 		OHHuman2
		.word 		OHHuman3
		.word 		OHHulk 					; type 7 Hulk
		.word 		OHBrain 				; type 8 Brain
		.word 		OHSphere 				; type 9 Sphere
		.word 		OHQuark 				; type 10 Quark
		.word 		OHProg 					; type 11 Prog
		.word 		OHESpark 				; type 12 Enforcer Sparks.
		.word 		OHEnforcer 				; type 13 Enforcer
		.word 		OHShell 				; type 14 Shell
		.word 		OHTank 					; type 15 Tank

		* = $E000
		
		.include "data.asm"