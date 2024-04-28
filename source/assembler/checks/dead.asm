; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		dead.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		27th April 2024
;		Reviewed :	No
;		Purpose :	Check player dead
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Check player dead
;
; ***************************************************************************************

CheckDead:
		ldx 	#OB_ENEMIES 				; check enemies collide ?
_CDLoop1:
		lda 	OBFlags,x 					; check enemy alive
		bmi 	_CDNext1
		and 	#$1F 						; object class, check if >= explosion animation
		cmp 	#TP_EXPLODE
		bcs 	_CDNext1
		ldy 	#0 							; check hit player object
		jsr 	CheckCollision 				; check collision.
		bcs 	_CDDead 					; collision
_CDNext1:
		inx 								; check next.
		cpx 	#OBJ_COUNT
		bne 	_CDLoop1
		clc 
		rts

_CDDead:
		jsr 	SND_PlayerDead
		sec
		rts

