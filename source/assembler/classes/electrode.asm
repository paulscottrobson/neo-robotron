; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		electrode.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		22nd April 2024
;		Reviewed :	No
;		Purpose :	Electrode Class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Electrode Object 
;
; ***************************************************************************************

OHElectrode:
		.method MSG_INIT,OHELInitHandler
		.method MSG_CONTROL,OHELFreeze
		.superclass


OHELInitHandler:
		.static GR4_ELECTRODES
		.speed 	0
		.brains 0
		.score  0
OHELFreeze:		
		stz 	OBDirection,x
		rts




