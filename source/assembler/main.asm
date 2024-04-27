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

Start:
		jmp 	ResetObjects 				; $C000 reset all sprites.
		jmp 	CreateObjects 				; $C003 create X objects of type A.
		jmp 	MainGame 					; $C006 main loop code, speed A
		jmp 	ResetScore 					; $C009 reset the score.
		jmp 	SetWave 					; $C00C New Wave A
		
		* = Start + $40
Result:
		.byte 	0
Lives:	
		.byte 	3	
DScore:
		.byte 	0,0,0

		.include 	"create.asm"
		.include 	"move.asm"
		.include 	"palette.asm"
		.include 	"utility.asm"
		.include 	"score.asm"
		.include 	"census.asm"
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
		.include 	"classes/explode.asm"
		.include 	"checks/human.asm"
		.include 	"checks/missiles.asm"
		.include 	"checks/complete.asm"
		.include 	"checks/dead.asm"
		
; ***************************************************************************************
;
;							Current level routine
;
; ***************************************************************************************

MainGame:
		jsr 	ResetObjects 				; reset all game objects
		lda 	#0 							; create player
		ldx 	#1
		jsr 	CreateObjects
		jsr 	CreateCurrentObjects 		; create the objects expected.
		jsr 	DrawWave
		jsr 	DrawScore 
MainLoop:
		inc 	FrameCount 					; bump frame counter
		jsr 	CheckComplete 				; check completed first.
		bcs 	_MLComplete

		jsr 	CheckDead 					; robot collision
		bcs 	_MLKilled

		jsr 	AnimatePalette 				; causes flashing effects
		jsr 	MoveObjects 				; move all objects
		jsr 	ClockDelay 					; delay to stop it being insanely fast.
		jsr 	CheckPlayerHuman 			; collect ?
		jsr 	CheckHitRobots 				; check if hit robot.
		lda 	FrameCount
		and 	#7
		bne 	_MainNoScore
		jsr 	DrawScore
_MainNoScore:		
		bra 	MainLoop

_MLKilled:									; return 1 (level not complete, player dead)	
		lda 	#1
		sta 	Result
		rts

_MLComplete:		
		stz 	Result						; return 0 (level complete, not dead)
		rts

FrameCount:
		.byte 	0

; ***************************************************************************************
;
;			   Delay for game speed. 40 seems to be about right for default
;
; ***************************************************************************************

ClockDelay:
		phx
		phy
		ldx 	MoveSpeed
_MLDelay:
		dey
		bne 	_MLDelay
		dex		
		bne 	_MLDelay
		ply
		plx
		rts

MoveSpeed:
		.byte 	40

; ***************************************************************************************
;
;						Message handlers for each object type
;
; ***************************************************************************************

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
		.word 		OHExplode 				; type 16 Explosion Graphic
		
		* = $E000
		
		.include "data.asm"