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

TP_PLAYER = 0
TP_PLAYERMISSILE = 1
TP_MUM = 2
TP_DAD = 3
TP_CHILD = 4

OB_PLAYER = 0 								; player object (1)
OB_PLAYERMISSILE = 1 						; player missile (4)
OB_HUMANS = 5 								; humans (6)
OB_ENEMIES = 11 							; enemies (everything else)

OBC_PLAYERMISSILES = OB_HUMANS-OB_PLAYERMISSILE
OBC_HUMANS = OB_ENEMIES-OB_HUMANS
OBC_ENEMIES = OBJ_COUNT - OB_ENEMIES

GR_PLAYERH = 0 								; horizontal player
GR_PLAYERV = 2  							; vertical player
GR_HUMANS = 4  								; 3 sets of human graphics
GR_HULK = 10  								; Hulk graphic
GR_GRUNT = 12  								; Grunt graphic
GR_SPHEROID = 14   							; Spheroid graphic 
GR1_EMBRYO	= 16  							; Embryo graphic (1 only)
GR1_QUARK = 17   							; Quark graphic (1 only)
GR_TANK = 18  								; Tank graphic
GR_BRAIN = 20  								; Brain graphic
GR8_ELECTRODES = 22  						; Set of 8 electrode graphics
GR1_MISSILE1 = 30  							; Robotron missiles
GR1_MISSILE2 = 31
GR1_HORIZFIRE = 32  						; Horizontal fire
GR1_VERTFIRE = 33  							; Vertical fire 
GR1_SWNEFIRE = 34   						; / fire  
GR1_NWSEFIRE = 35  							; \ fire 



OBJ_COUNT = 108 								; maximum number of supported objects

APICommand = $FF00
APIFunction = $FF01
APIParams = $FF04
