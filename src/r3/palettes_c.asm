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
	dc.l	StagePalette3
	dc.w	palette+$20
	dc.w	$60/4-1
	dc.l	BossFlashPalette
	dc.w	palette+$20
	dc.w	$20/4-1
	dc.l	BossPalette
	dc.w	palette+$20
	dc.w	$20/4-1
	dc.l	StagePalette12
	dc.w	palette+$20
	dc.w	$60/4-1

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

StagePalette12:
	incbin	"src/palettes/r3/stage_1c_2c.pal"
	even

StagePalette3:
	incbin	"src/palettes/r3/stage_3c.pal"
	even

BossFlashPalette:
	incbin	"src/palettes/r3/boss_flash.pal"
	even

BossPalette:
	incbin	"src/palettes/r3/boss.pal"
	even

; ------------------------------------------------------------------------------
