; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		player.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		18th April 2024
;		Reviewed :	No
;		Purpose :	Player class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									Player object
;
; ***************************************************************************************

OHPlayer:
		.method MSG_INIT,OHPInitHandler
		.method MSG_REPAINT,OHPRepaintHandler
		.superclass

OHPInitHandler:
		lda 	#160/2
		sta 	OBXPos,x
		lda 	#128/2
		sta 	OBYPos,y
		.speed 	2
		rts

OHPRepaintHandler:
		.animation GR_PLAYERH
		rts