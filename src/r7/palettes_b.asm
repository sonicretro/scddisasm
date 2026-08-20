; ------------------------------------------------------------------------------

PaletteTable:
	dc.l	S1SegaPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	StageLightPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	S1LevelSelectPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	PlayerPalette
	dc.w	palette
	dc.w	$20/4-1
	dc.l	StagePalette
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	StagePalette2
	dc.w	palette+$20
	dc.w	$60/4-1

S1SegaPalette:

StageLightPalette:

S1LevelSelectPalette:

PlayerPalette:
	incbin	"src/palettes/player.pal"
	even

StagePalette:
	incbin	"src/palettes/r7/stage_b.pal"
	even

StagePalette2:
	incbin	"src/palettes/r7/stage_b.pal"
	even

; ------------------------------------------------------------------------------
