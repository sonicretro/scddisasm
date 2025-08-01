; -------------------------------------------------------------------------
; Sonic CD Disassembly
; -------------------------------------------------------------------------
; Palmtree Panic title card data
; -------------------------------------------------------------------------

ObjTitleCard_Data:
	dc.w	$130, $228, $168, $15A
	dc.w	$100, $238, $178, $25A
	dc.w	$100, $240, $180, $25A
	dc.w	$100, $248, $188, $25A
	dc.w	$120, $230, $170, $35A
	dc.w	$140, $248, $188, $45A
	dc.w	$100, $1D0, $110, $75A
	dc.w	$100, $1D0, $110, $85A

; -------------------------------------------------------------------------

MapSpr_TitleCard:
	include	"Level/Palmtree Panic/Objects/Title Card/Mappings.asm"
	even
	
; -------------------------------------------------------------------------
