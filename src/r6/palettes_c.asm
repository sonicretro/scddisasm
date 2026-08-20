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
	dc.l	StagePalette
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	StageUnusedPalette
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	BossPalette
	dc.w	palette+$20
	dc.w	$20/4-1

S1SegaPalette:

S1TitlePalette:

S1LevelSelectPalette:
	if STAGE_ACT<>1
		incbin	"src/palettes/s1_level_select.pal"
		even
	endif

PlayerPalette:
	incbin	"src/palettes/player.pal"
	even

StagePalette:
	incbin	"src/palettes/r6/stage_c.pal"
	even

StageUnusedPalette:
	incbin	"src/palettes/r6/unused_c.pal"
	even

BossPalette:
	incbin	"src/palettes/r6/boss_c.pal"
	even

; ------------------------------------------------------------------------------
