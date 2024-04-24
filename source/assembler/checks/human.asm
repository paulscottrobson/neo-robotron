; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		human.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		22nd April 2024
;		Reviewed :	No
;		Purpose :	Human Class
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Check Player/Human Collisions
;
; ***************************************************************************************

CheckPlayerHuman:
		ldx 	#OB_HUMANS 					; check player human collisions
_CPHLoop:
		lda 	OBFlags,x 					; check live
		bmi 	_CPHFail
		ldy 	#0 							; check collision with player
		jsr 	CheckCollision
		bcc 	_CPHFail
		jsr 	KillObject 					; delete the human as collected
		lda 	CollectCount 				; bump collect count, limit to 5
		inc 	a
		cmp 	#6
		bcc 	_CPHMax5
		lda 	#5
_CPHMax5:	
		sta 	CollectCount
		asl 	a 							; make to BCD x000
		asl 	a	
		asl 	a	
		asl 	a	
		tay
		lda 	#0
		jsr 	AddYAToScore		
_CPHFail:
		inx
		cpx 	#OB_ENEMIES+1		
		bne 	_CPHLoop
		rts

CollectCount:				
		.byte 	0

