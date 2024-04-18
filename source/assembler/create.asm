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
;						Create X objects of type A
;
; ***************************************************************************************

CreateObjects:
		cpx 	#0
		beq 	_COExit
		phx
		pha
		jsr 	CreateObject
		pla
		plx
		dex 	
		bne 	CreateObjects
_COExit:		
		rts

; ***************************************************************************************
;
;							Create Object type A.
;
; ***************************************************************************************

CreateObject:
		ldx 	#OB_PLAYER 					; player object (1st one)
		ldy 	#1
		cmp 	#TP_PLAYER 					
		beq 	_COLoop

		ldx 	#OB_PLAYERMISSILE 			; player missiles (next 4)
		ldy 	#OBC_PLAYERMISSILES
		cmp 	#TP_PLAYERMISSILE
		beq 	_COLoop

		ldx 	#OB_HUMANS 					; humans (next 6)
		ldy 	#OBC_HUMANS
		cmp 	#TP_CHILD+1
		bcc 	_COLoop

		ldx 	#OB_ENEMIES 				; check everything else
		ldy 	#OBC_ENEMIES
_COLoop: 			
		bit 	OBFlags,x  
		bmi 	_COFound
		inx
		dey
		bne 	_COLoop 
		rts  								; cannot create, exit.

_COFound:
		sta 	OBFlags,x 					; clear unused flag, set type.
		asl 	a 							; double -> Y
		tay
		lda 	HandlerTable,y  			; put the handler address in.
		sta 	OBHandlerLow,x
		lda 	HandlerTable+1,y  			
		sta 	OBHandlerHigh,x

_COPos1:
		jsr 	Random8Bit  				; value is 0-151
		cmp 	#152
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
		lda 	#GR_HULK 					; temporary value.
		sta 	OBSprite1,x
		inc 	a
		sta 	OBSprite2,x

		txa  								; set intelligence, speed & counter defaults.
		and 	#7 							
		inc 	a
		sta 	OBSpeedCounter,x 			; init counter derived from index so they don't all move in sync.
		sta 	OBIntelligenceCount,x
		lda 	#1
		sta 	OBSpeed,x  			
		lda 	#10
		sta 	OBIntelligence,x

		jsr 	ChooseRandomDirection

		.sendmsg MSG_INIT 					; send Initialise message

		jsr 	RedrawObject
		rts

_COAbsolute:
		cmp 	#0
		bpl 	_COAExit
		eor 	#$FF
		inc 	a
_COAExit:
		rts		

ChooseRandomDirection:
		jsr 	Random8Bit 					; get valid random direction
		and 	#15
		beq 	ChooseRandomDirection 				; stationary (0)
		sta 	OBDirection,x  				
		and 	#3 							; check LR not both on.
		cmp 	#3  
		beq 	ChooseRandomDirection

		lda 	OBDirection,x 				; check UD not both on
		and 	#12
		cmp 	#12
		beq 	ChooseRandomDirection
		rts
