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
;			Bit 0 : animation selector bit.
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