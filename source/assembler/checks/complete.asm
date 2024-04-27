; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		complete.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		27th April 2024
;		Reviewed :	No
;		Purpose :	Check level completed.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Check Complete, CS if true
;
; ***************************************************************************************

CheckComplete:
		ldx 	#OB_ENEMIES
_CheckLoop:
		lda 	OBFlags,x
		bmi 	_CheckNext 					; not in use
		and 	#31 						; object ID

		cmp		#TP_GRUNT 					; must be none of these left.
		beq		_CheckFail  				; don't have to destroy everything
		cmp		#TP_BRAIN
		beq		_CheckFail
		cmp		#TP_SPHERE
		beq		_CheckFail
		cmp		#TP_QUARK
		beq		_CheckFail
		cmp		#TP_PROG
		beq		_CheckFail

_CheckNext:
		inx
		cpx 	#OBJ_COUNT
		bne 	_CheckLoop
		sec
		rts

_CheckFail:
		clc
		rts


