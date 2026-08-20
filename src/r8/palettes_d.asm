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
	dc.l	StagePalette1
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	StagePalette3
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	0
	dc.w	0
	dc.w	0/4-1
	dc.l	BossPalette1
	dc.w	fade_palette+$20
	dc.w	$20/4-1
	dc.l	BossPalette2
	dc.w	palette+$20
	dc.w	$20/4-1
	dc.l	BossPalette3
	dc.w	palette+$60
	dc.w	$20/4-1
	dc.l	StagePalette2
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	AmyRosePalette
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

StagePalette1:
	incbin	"src/palettes/r8/stage_1d.pal"
	even

StagePalette2:
	incbin	"src/palettes/r8/stage_2d.pal"
	even

StagePalette3:
	incbin	"src/palettes/r8/stage_3d.pal"
	even

BossPalette2:
	incbin	"src/palettes/r8/boss_2.pal"
	even

BossPalette3:
	incbin	"src/palettes/r8/boss_3.pal"
	even

BossPalette1:
	incbin	"src/palettes/r8/boss_1.pal"
	even

AmyRosePalette:
	incbin	"src/palettes/r8/amy_rose.pal"
	even

; ------------------------------------------------------------------------------
