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

.Sprite0:
	dc.b	3
	dc.b	$E0, 5, 0, $D, $F8
	dc.b	$F0, 5, 0, $11, $F8
	dc.b	0, 5, 0, $15, $F8

.Sprite1:
	dc.b	5
	dc.b	$D0, 5, 0, $D, $F8
	dc.b	$E0, 5, 0, $11, $F8
	dc.b	$F0, 5, 0, $15, $F8
	dc.b	0, 5, 0, $29, $F8
	dc.b	$10, 5, 0, $31, $F8

.Sprite2:
	dc.b	5
	dc.b	$D0, 5, 0, $D, $F8
	dc.b	$E0, 5, 0, $11, $F8
	dc.b	$F0, 5, 0, $15, $F8
	dc.b	0, 5, 0, $33, $F8
	dc.b	$10, 5, 0, $2B, $F8

.Sprite3:
	dc.b	5
	dc.b	$D0, 5, 0, $D, $F8
	dc.b	$E0, 5, 0, $11, $F8
	dc.b	$F0, 5, 0, $15, $F8
	dc.b	0, 5, 0, $1D, $F8
	dc.b	$10, 5, 0, $19, $F8

.Sprite4:
	dc.b	5
	dc.b	$D0, 5, 0, $D, $F8
	dc.b	$E0, 5, 0, $11, $F8
	dc.b	$F0, 5, 0, $15, $F8
	dc.b	0, 5, 8, $1D, $F8
	dc.b	$10, 5, 0, $19, $F8

.Sprite5:
	dc.b	5
	dc.b	$D0, 5, 0, $D, $F8
	dc.b	$E0, 5, 0, $11, $F8
	dc.b	$F0, 5, 0, $15, $F8
	dc.b	0, 5, 0, $21, $F8
	dc.b	$10, 5, 0, $19, $F8

; ------------------------------------------------------------------------------
