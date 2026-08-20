; ------------------------------------------------------------------------------

PaletteTable:
	dc.l	S1SegaPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	S1TitlePalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	S1LevelSelectPalette
	dc.w	palette
	dc.w	$80/4-1
	dc.l	PlayerPalette
	dc.w	palette
	dc.w	$20/4-1
	dc.l	StageInsidePalette
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	StageOutsidePalette
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	BossPalette
	dc.w	palette+$20
	dc.w	$20/4-1

S1SegaPalette:

S1TitlePalette:
	incbin	"src/palettes/s1_title.pal"
	even

S1LevelSelectPalette:
	incbin	"src/palettes/s1_level_select.pal"
	even

PlayerPalette:
	incbin	"src/palettes/player.pal"
	even

StageInsidePalette:
	incbin	"src/palettes/r5/inside_d.pal"
	even

StageOutsidePalette:
	incbin	"src/palettes/r5/outside_d.pal"
	even

BossPalette:
	incbin	"src/palettes/r5/boss_d.pal"
	even

; ------------------------------------------------------------------------------
