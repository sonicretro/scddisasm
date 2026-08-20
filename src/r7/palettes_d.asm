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
	dc.l	0
	dc.w	0
	dc.w	0/4-1
	dc.l	BossPalette
	dc.w	palette+$20
	dc.w	$C/4-1

S1SegaPalette:

StageLightPalette:
	incbin	"src/palettes/player.pal"
	incbin	"src/palettes/r7/stage_d.pal", 0, $20
	incbin	"src/palettes/r7/light_d.pal"
	even

S1LevelSelectPalette:
	incbin	"src/palettes/s1_level_select.pal"
	even

PlayerPalette:
	incbin	"src/palettes/player.pal"
	even

StagePalette:
	incbin	"src/palettes/r7/stage_d.pal"
	even

BossPalette:
	incbin	"src/palettes/r7/boss.pal"
	even

; ------------------------------------------------------------------------------
