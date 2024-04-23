; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		constants.inc
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Constant values
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Class numbers
;
; ***************************************************************************************

TP_PLAYER = 0
TP_PLAYERMISSILE = 1
TP_MUM = 2
TP_DAD = 3
TP_CHILD = 4
TP_GRUNT = 5
TP_HULK = 6
TP_ESPARK = 7
TP_ENFORCER = 8
TP_SPHERE = 9
TP_SHELL = 10
TP_TANK = 11
TP_QUARK = 12
TP_ELECTRODE = 13

; ***************************************************************************************
;
;									Object constants
;
; ***************************************************************************************

OB_PLAYER = 0 								; player object (1)
OB_PLAYERMISSILE = 1 						; player missile (4)
OB_HUMANS = 5 								; humans (6)
OB_ENEMIES = 11 							; enemies (everything else)

OBC_PLAYERMISSILES = OB_HUMANS-OB_PLAYERMISSILE
OBC_HUMANS = OB_ENEMIES-OB_HUMANS
OBC_ENEMIES = OBJ_COUNT - OB_ENEMIES

; ***************************************************************************************
;
;									Playfield frame
;
; ***************************************************************************************

PF_LEFT = 4
PF_RIGHT = 156
PF_TOP = 4
PF_BOTTOM = 108

; ***************************************************************************************
;
;									Graphic values
;
; ***************************************************************************************

GR_PLAYERH = 0 								; horizontal player
GR_PLAYERV = 2  							; vertical player
GR_HUMANS = 4  								; 3 sets of human graphics
GR_HULK = 10  								; Hulk graphic
GR_GRUNT = 12  								; Grunt graphic
GR_SPHEROID = 14   							; Spheroid graphic 
GR1_ENFORCER= 16  							; Enforcer graphic (1 only)
GR1_QUARK = 17   							; Quark graphic (1 only)
GR_TANK = 18  								; Tank graphic
GR_BRAIN = 20  								; Brain graphic
GR1_HORIZFIRE = 22  						; Horizontal fire
GR1_VERTFIRE = 23  							; Vertical fire 
GR1_SWNEFIRE = 24   						; / fire  
GR1_NWSEFIRE = 25  							; \ fire 
GR4_ELECTRODES = 26  						; Set of 3 electrode graphics
GR1_MISSILE1 = 30  							; Robotron missiles
GR1_MISSILE2 = 31

GR_HIDE = 63 								; stops drawing

OBJ_COUNT = 108 							; maximum number of supported objects


; ***************************************************************************************
;
;									API Constants
;
; ***************************************************************************************

APICommand = $FF00
APIFunction = $FF01
APIParams = $FF04


; ***************************************************************************************
;
;									Messages
;
; ***************************************************************************************

MSG_INIT = $01 								; Initialise object
MSG_REPAINT = $02 							; About to repaint
MSG_CONTROL = $03 							; Time for a rethink
MSG_HITWALL = $04 							; Hit wall.
MSG_ONMOVE = $05 							; On movement.

sendmsg	.macro
		lda 	#\1
		jsr 	SendObjectMessage
		bcc 	_1
		jsr 	DefaultHandler
_1:		
		.endm

method 	.macro
		cmp 	#\1
		bne 	_1
		jsr 	\2
		clc
		rts
_1:		
		.endm

superclass .macro				
		sec
		rts
		.endm

animation .macro
		lda 	#\1
		jsr 	SetObjectGraphic
		.endm

static .macro
		lda 	#\1
		sta 	OBSprite1,x
		sta 	OBSprite2,x
		.endm
		
speed .macro
		lda 	#\1
		sta 	OBSpeed,x
		.endm		

brains .macro		
		lda 	#\1
		sta 	OBIntelligence,x
		.endm		

score 	.macro
		lda 	#($\1 & 255)
		sta 	OBScoreLow,x
		lda 	#($\1 >> 8)
		sta 	OBScoreHigh,x
		.endm		