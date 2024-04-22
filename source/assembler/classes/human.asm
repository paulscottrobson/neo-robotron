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
;									Human Object 
;
; ***************************************************************************************

OHHuman1:
		.method MSG_INIT,OHHInitHandler1
		.superclass

OHHuman2:
		.method MSG_INIT,OHHInitHandler2
		.superclass

OHHuman3:
		.method MSG_INIT,OHHInitHandler3
		.superclass

OHHInitHandlerMain:
		.speed 	30
		.brains 15
		rts

OHHInitHandler1:
		.animation GR_HUMANS+0
		bra 	OHHInitHandlerMain

OHHInitHandler2:
		.animation GR_HUMANS+2
		bra 	OHHInitHandlerMain

OHHInitHandler3:
		.animation GR_HUMANS+4
		bra 	OHHInitHandlerMain
		

