; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------

.Sprites:
	dc.w	.Sprite0-.Sprites
	dc.w	.Sprite1-.Sprites
	dc.w	.Sprite2-.Sprites
	dc.w	.Sprite3-.Sprites
	dc.w	.Sprite4-.Sprites
	dc.w	.Sprite5-.Sprites
	dc.w	.Sprite6-.Sprites

.Sprite0:
	dc.b	1
	dc.b	$F8, 5, 0, $19, $F8

.Sprite1:
	dc.b	1
	dc.b	$F8, 5, 8, $25, $F8

.Sprite2:
	dc.b	1
	dc.b	$F8, 5, 0, $1D, $F8

.Sprite3:
	dc.b	1
	dc.b	$F8, 5, 0, $21, $F8

.Sprite4:
	dc.b	1
	dc.b	$F8, 5, 8, $1D, $F8

.Sprite5:
	dc.b	1
	dc.b	$F8, 5, 8, $15, $F8

.Sprite6:
	dc.b	2
	dc.b	$E8, 5, 8, $D, $F8
	dc.b	$F8, 5, 8, $11, $F8

; ------------------------------------------------------------------------------
