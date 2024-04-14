; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		create.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Create new object
;
; ***************************************************************************************
; ***************************************************************************************


; ***************************************************************************************
;
;							Create Object type A.
;
; ***************************************************************************************

CreateObject:
		ldx 	#0  						; look for an unused object
_COLoop: 			
		bit 	OBFlags,x  
		bmi 	_COFound
		inx
		cpx 	#OBJ_COUNT
		bne 	_COLoop 
		rts  								; cannot create, exit.

_COFound:
		stz 	OBFlags,x 					; clear unused flag

_COPos1:
		jsr 	Random8Bit  				; value is 0-150
		cmp 	#150
		bcs 	_COPos1
		adc 	#4
		sta 	OBXPos,x

_COPos2:
		jsr 	Random8Bit 					; value is 0-103
		and 	#$7F		
		cmp 	#104
		bcs 	_COPos2
		adc 	#4
		sta 	OBYPos,x		

		sec   								; check Y centre offset
		sbc 	#52
		jsr 	_COAbsolute
		cmp 	#39	
		bcs 	_COIsOkay

		lda 	OBXPos,x 					; same for X
		sec
		sbc 	#75
		jsr 	_COAbsolute
		cmp 	#55
		bcc 	_COPos1

_COIsOkay:		
		lda 	#GR_HULK
		sta 	OBSprite1,x
		inc 	a
		sta 	OBSprite2,x

		jsr 	RedrawObject
		rts

_COAbsolute:
		cmp 	#0
		bpl 	_COAExit
		eor 	#$FF
		inc 	a
_COAExit:
		rts		
