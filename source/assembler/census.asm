; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		census.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		27th April 2024
;		Reviewed :	No
;		Purpose :	Track objects that are in the current level.
;
; ***************************************************************************************
; ***************************************************************************************


; Grunts	Electrodes	Mommies	Daddies	Mikeys	Hulks	Brains	Spheroids	Quarks

CurrentLevel:
	.byte 	0,0,0,0,0,0,0,1,0

WaveIndex:
	.byte 	0

; ***************************************************************************************
;
;										 Set Wave to n.
;
; ***************************************************************************************

SetWave:
		sta 	Wave
		cmp 	#0 							; if 0, use the level data
		beq 	_SWExit

		dec 	a 							; Wave starts from zero
		ldy 	#40 						; this is the speed.
_SWGetSet:
		cmp 	#40 						; is it in range 0..39 (e.g. waves 1-40)
		bcc 	_SWHaveWave

		sec  								; effectively doing mod 40 here.
		sbc 	#40

		dey 								; speed up.
		dey
		dey
		dey
		dey
		dey
		dey
		dey
		bpl 	_SWGetSet 					; no borrow
		ldy 	#0 							; as fast as we can go
		bra 	_SWGetSet

_SWHaveWave:
		sta 	WaveIndex					; 0-39 identifying the wave.
		sty 	MoveSpeed 					; the move speed.

		asl 	a 							; multiply by 9.
		asl 	a
		asl 	a
		adc 	WaveIndex
		tax
		ldy 	#0 							; copy the wave data in
_SWCopyCensus:		
		lda 	LevelData,x
		sta 	CurrentLevel,y
		inx
		iny
		cpy 	#9
		bne 	_SWCopyCensus
_SWExit:
		rts



; ***************************************************************************************
;
;					Create objects according to current level
;
; ***************************************************************************************

CreateCurrentObjects:
		ldy 	#0
_CreateLoop1:
		lda 	CurrentLevel,y 				; how many of these
		tax 								; into X
		tya 								; get object ID
		clc
		adc 	#TP_GRUNT
		phx
		phy
		jsr 	CreateObjects
		ply
		plx
		iny 								; do all 9 types
		cpy 	#9
		bne 	_CreateLoop1
		rts

; ***************************************************************************************
;
;								Object X killed ; update census
;
; ***************************************************************************************

CensusUpdate:
		lda 	OBFlags,x 					; get the object ID
		and 	#$1F
		dec 	a 							; in range for census objects 2-11
		dec 	a
		cmp 	#9
		bcs 	_UCExit 					; not a census object
		phx 								; decrement that count so if we restart it is right
		tax
		dec 	CurrentLevel,x
		plx
_UCExit:
		rts		

; ***************************************************************************************
;
;								Level Data for levels 1-40
;
; ***************************************************************************************

LevelData:
	.byte	15,5,1,1,0,0,0,0,0
	.byte	17,15,1,1,1,5,0,1,0
	.byte	22,25,2,2,2,6,0,3,0
	.byte	34,25,2,2,2,7,0,4,0
	.byte	20,20,15,0,1,0,15,1,0
	.byte	32,25,3,3,3,7,0,4,0
	.byte	0,0,4,4,4,12,0,0,10
	.byte	35,25,3,3,3,8,0,5,0
	.byte	60,0,3,3,3,4,0,5,0
	.byte	25,20,0,22,0,0,20,1,0
	.byte	35,25,3,3,3,8,0,5,0
	.byte	0,0,3,3,3,13,0,0,12
	.byte	35,25,3,3,3,8,0,5,0
	.byte	27,5,5,5,5,20,0,2,0
	.byte	25,20,0,0,22,2,20,1,0
	.byte	35,25,3,3,3,3,0,5,0
	.byte	0,0,3,3,3,14,0,0,12
	.byte	35,25,3,3,3,8,0,5,0
	.byte	70,0,3,3,3,3,0,5,0
	.byte	25,20,8,8,8,2,20,2,0
	.byte	35,25,3,3,3,8,0,5,0
	.byte	0,0,3,3,3,15,0,0,12
	.byte	35,25,3,3,3,8,0,5,0
	.byte	0,0,3,3,3,13,0,6,7
	.byte	25,20,25,0,1,1,21,1,0
	.byte	35,25,3,3,3,8,0,5,0
	.byte	0,0,3,3,3,16,0,0,12
	.byte	35,25,3,3,3,8,0,5,1
	.byte	75,0,3,3,3,4,0,5,1
	.byte	25,20,0,25,0,1,22,1,1
	.byte	35,25,3,3,3,8,0,5,1
	.byte	0,0,3,3,3,16,0,0,13
	.byte	35,25,3,3,3,8,0,5,1
	.byte	30,0,3,3,3,25,0,2,2
	.byte	27,15,0,0,25,2,23,1,2
	.byte	35,25,3,3,3,8,0,5,2
	.byte	0,0,3,3,3,16,0,0,14
	.byte	35,25,3,3,3,8,0,5,2
	.byte	80,0,3,3,3,6,0,5,1
	.byte	30,15,10,10,10,2,25,1,1

