; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		data.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		14th April 2024
;		Reviewed :	No
;		Purpose :	Data structures
;
; ***************************************************************************************
; ***************************************************************************************


OBBase = *	
;
;			Object flags. 
;
;			Bit 7 : object is not in use if set.
;			Bit 0..4 : object ID
;
OBFlags = OBBase + 0*OBJ_COUNT
;
;			Position of object in screen coordinates, divided by 2.
;
OBXPos = OBBase + 1*OBJ_COUNT
OBYPos = OBBase + 2*OBJ_COUNT
;
;			Sprite images to use. These are alternated using the animation bit
;
OBSprite1 = OBBase + 3*OBJ_COUNT
OBSprite2 = OBBase + 4*OBJ_COUNT
;
;			Move direction. These are the same as the joypad
; 			bit 0:Left bit 1:Right bit2:Up bit3:Down
;
OBDirection = OBBase + 5*OBJ_COUNT
;
;			Speed and Speed counter
;
OBSpeed = OBBase + 6*OBJ_COUNT
OBSpeedCounter = OBBase + 7*OBJ_COUNT
;
;			Message Handler
;
OBHandlerLow = OBBase + 8*OBJ_COUNT
OBHandlerHigh = OBBase + 9*OBJ_COUNT
;
;			Intelligence check (switches per move)
;
OBIntelligence = OBBase + 10*OBJ_COUNT
OBIntelligenceCount = OBBase + 11*OBJ_COUNT
;
;			Score (in BCD), $FFFF to be non-shootable
;
OBScoreLow = OBBase + 12*OBJ_COUNT
OBScoreHigh = OBBase + 13*OBJ_COUNT
;
;			General data
;
OBObjectData1 = OBBase + 14*OBJ_COUNT