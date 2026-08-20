; ------------------------------------------------------------------------------

PaletteTable:
	dc.l	S1SegaPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	StageWaterPalette
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
	dc.l	BossPalette
	dc.w	palette+$20
	dc.w	$20/4-1

S1SegaPalette:

StageWaterPalette:
	incbin	"src/palettes/r4/water_d.pal"
	even

S1LevelSelectPalette:
	incbin	"src/palettes/s1_level_select.pal"
	even

PlayerPalette:
	incbin	"src/palettes/player.pal"
	even

StagePalette:
	incbin	"src/palettes/r4/stage_d.pal"
	even

BossPalette:
	incbin	"src/palettes/r4/stage_d.pal", 0, $20
	even

; ------------------------------------------------------------------------------
