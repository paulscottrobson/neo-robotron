; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		missiles.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		24th April 2024
;		Reviewed :	No
;		Purpose :	Check missiles hit robots
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Check Missile/Robot collisions
;
; ***************************************************************************************

CheckHitRobots:
		ldx 	#OB_ENEMIES 				; check enemies collide ?
_CHRLoop1:
		lda 	OBFlags,x 					; check enemy alive
		bmi 	_CHRNext1
		ldy 	#OB_PLAYERMISSILE 			; check missiles
_CHRLoop2:
		lda 	OBFlags,y 					; missile in use
		bmi 	_CHRNext2

		lda 	OBObjectData1,y 			; not immediately fired
		bne 	_CHRNext2

		jsr 	CheckCollision 				; check collision.
		bcc 	_CHRNext2


		phy
		.sendmsg  MSG_SHOT 					; notify object it has been shot.
		ply
		phx 								; kill this missile.
		tya
		tax
		jsr		KillObject
		plx

		bra 	_CHRNext1 					; go to check next human

_CHRNext2:
		iny
		cpy		#OB_HUMANS 					; reached the end				
		bne 	_CHRLoop2

_CHRNext1:
		inx
		cpx 	#OBJ_COUNT
		bne 	_CHRLoop1
		rts

		rts

