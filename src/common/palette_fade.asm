; ------------------------------------------------------------------------------

FadeFromBlack:
	moveq	#0,d0
	lea	palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	moveq	#0,d1
	move.b	palette_fade_length,d0

loc_200336:
	move.w	d1,(a0)+
	dbf	d0,loc_200336
	move.w	#$15,d4

loc_200340:
	move.b	#$12,vblank_routine
	bsr.w	VSync
	bsr.s	FadeColorsFromBlack
	bsr.w	AdvanceGfxQueue
	dbf	d4,loc_200340
	rts

; ------------------------------------------------------------------------------

FadeColorsFromBlack:
	moveq	#0,d0
	lea	palette,a0
	lea	fade_palette,a1
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	palette_fade_length,d0

loc_20036C:
	bsr.s	FadeColorFromBlack
	dbf	d0,loc_20036C
	cmpi.b	#1,zone
	bne.s	locret_200398
	moveq	#0,d0
	lea	water_palette,a0
	lea	water_fade_palette,a1
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	palette_fade_length,d0

loc_200392:
	bsr.s	FadeColorFromBlack
	dbf	d0,loc_200392

locret_200398:
	rts

; ------------------------------------------------------------------------------

FadeColorFromBlack:
	move.w	(a1)+,d2
	move.w	(a0),d3
	cmp.w	d2,d3
	beq.s	loc_2003C2
	move.w	d3,d1
	addi.w	#$200,d1
	cmp.w	d2,d1
	bhi.s	loc_2003B0
	move.w	d1,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2003B0:
	move.w	d3,d1
	addi.w	#$20,d1
	cmp.w	d2,d1
	bhi.s	loc_2003BE
	move.w	d1,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2003BE:
	addq.w	#2,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2003C2:
	addq.w	#2,a0
	rts

; ------------------------------------------------------------------------------

	if (STAGE_ZONE=6)&(STAGE_TIME=2)
	BossFadeFromBlack:
		move.b	#$12,vblank_routine
		lea	palette+$20,a0
		lea	fade_palette+$20,a1
		bsr.w	sub_200384
		if STAGE_GOOD_FUTURE=0
			lea	palette+$60,a0
			lea	fade_palette+$60,a1
			bsr.w	sub_200384
		endif
		rts

; ------------------------------------------------------------------------------

	sub_200384:
		move.w	#$F,d0

	loc_200388:
		bsr.s	FadeColorFromBlack
		dbf	d0,loc_200388
		rts
	endif

; ------------------------------------------------------------------------------

FadeToBlack:
	move.w	#$3F,palette_fade_start
	move.w	#$15,d4

loc_2003D0:
	move.b	#$12,vblank_routine
	bsr.w	VSync
	bsr.s	FadeColorsToBlack
	bsr.w	AdvanceGfxQueue
	dbf	d4,loc_2003D0
	rts

; ------------------------------------------------------------------------------

FadeColorsToBlack:
	moveq	#0,d0
	lea	palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	move.b	palette_fade_length,d0

loc_2003F6:
	bsr.s	FadeColorToBlack
	dbf	d0,loc_2003F6
	moveq	#0,d0
	lea	water_palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	move.b	palette_fade_length,d0

loc_20040C:
	bsr.s	FadeColorToBlack
	dbf	d0,loc_20040C
	rts

; ------------------------------------------------------------------------------

FadeColorToBlack:
	move.w	(a0),d2
	beq.s	loc_200440
	move.w	d2,d1
	andi.w	#$E,d1
	beq.s	loc_200424
	subq.w	#2,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_200424:
	move.w	d2,d1
	andi.w	#$E0,d1
	beq.s	loc_200432
	subi.w	#$20,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_200432:
	move.w	d2,d1
	andi.w	#$E00,d1
	beq.s	loc_200440
	subi.w	#$200,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_200440:
	addq.w	#2,a0
	rts

; ------------------------------------------------------------------------------

FadeFromWhite:
	move.w	#$3F,palette_fade_start
	moveq	#0,d0
	lea	palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	move.w	#$EEE,d1
	move.b	palette_fade_length,d0

loc_20045E:
	move.w	d1,(a0)+
	dbf	d0,loc_20045E
	move.w	#$15,d4

loc_200468:
	move.b	#$12,vblank_routine
	bsr.w	VSync
	bsr.s	FadeColorsFromWhite
	bsr.w	AdvanceGfxQueue
	dbf	d4,loc_200468
	rts

; ------------------------------------------------------------------------------

FadeColorsFromWhite:
	moveq	#0,d0
	lea	palette,a0
	lea	fade_palette,a1
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	palette_fade_length,d0

loc_200494:
	bsr.s	FadeColorFromWhite
	dbf	d0,loc_200494
	cmpi.b	#1,zone
	bne.s	locret_2004C0
	moveq	#0,d0
	lea	water_palette,a0
	lea	water_fade_palette,a1
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	palette_fade_length,d0

loc_2004BA:
	bsr.s	FadeColorFromWhite
	dbf	d0,loc_2004BA

locret_2004C0:
	rts

; ------------------------------------------------------------------------------

FadeColorFromWhite:
	move.w	(a1)+,d2
	move.w	(a0),d3
	cmp.w	d2,d3
	beq.s	loc_2004EE
	move.w	d3,d1
	subi.w	#$200,d1
	bcs.s	loc_2004DA
	cmp.w	d2,d1
	bcs.s	loc_2004DA
	move.w	d1,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2004DA:
	move.w	d3,d1
	subi.w	#$20,d1
	bcs.s	loc_2004EA
	cmp.w	d2,d1
	bcs.s	loc_2004EA
	move.w	d1,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2004EA:
	subq.w	#2,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_2004EE:
	addq.w	#2,a0
	rts

; ------------------------------------------------------------------------------

FadeToWhite:
	move.w	#$3F,palette_fade_start
	move.w	#$15,d4

loc_2004FC:
	move.b	#$12,vblank_routine
	bsr.w	VSync
	bsr.s	FadeColorsToWhite
	bsr.w	AdvanceGfxQueue
	dbf	d4,loc_2004FC
	rts

; ------------------------------------------------------------------------------

FadeColorsToWhite:
	moveq	#0,d0
	lea	palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	move.b	palette_fade_length,d0

loc_200522:
	bsr.s	FadeColorToWhite
	dbf	d0,loc_200522
	moveq	#0,d0
	lea	water_palette,a0
	move.b	palette_fade_start,d0
	adda.w	d0,a0
	move.b	palette_fade_length,d0

loc_200538:
	bsr.s	FadeColorToWhite
	dbf	d0,loc_200538
	rts

; ------------------------------------------------------------------------------

FadeColorToWhite:
	move.w	(a0),d2
	cmpi.w	#$EEE,d2
	beq.s	loc_20057C
	move.w	d2,d1
	andi.w	#$E,d1
	cmpi.w	#$E,d1
	beq.s	loc_200558
	addq.w	#2,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_200558:
	move.w	d2,d1
	andi.w	#$E0,d1
	cmpi.w	#$E0,d1
	beq.s	loc_20056A
	addi.w	#$20,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_20056A:
	move.w	d2,d1
	andi.w	#$E00,d1
	cmpi.w	#$E00,d1
	beq.s	loc_20057C
	addi.w	#$200,(a0)+
	rts

; ------------------------------------------------------------------------------

loc_20057C:
	addq.w	#2,a0
	rts

; ------------------------------------------------------------------------------

	if (STAGE_ZONE=4)&(STAGE_TIME=2)
	BossFadeStageFromWhite:
		addq.b	#1,(a4)
		cmpi.b	#$C,(a4)
		blt.s	locret_2004CE
		clr.b	(a4)
		moveq	#0,d0
		move.b	(a3),d0
		if STAGE_GOOD_FUTURE=0
			subi.b	#$16,d0
		else
			subi.b	#$14,d0
		endif
		bcc.s	loc_2004CC
		moveq	#0,d0

	loc_2004CC:
		bra.s	loc_2004F0

	locret_2004CE:
		rts

; ------------------------------------------------------------------------------

	BossFadeStageToWhite:
		addq.b	#1,(a4)
		cmpi.b	#$C,(a4)
		blt.s	locret_2004EE
		clr.b	(a4)
		moveq	#0,d0
		move.b	(a3),d0
		if STAGE_GOOD_FUTURE=0
			addi.b	#$16,d0
			cmpi.b	#$B0,d0
			bne.s	loc_2004EC
			move.b	#$9A,d0
		else
			addi.b	#$14,d0
			cmpi.b	#$A0,d0
			bne.s	loc_2004EC
			move.b	#$8C,d0
		endif

	loc_2004EC:
		bra.s	loc_2004F0

	locret_2004EE:
		rts

; ------------------------------------------------------------------------------

	loc_2004F0:
		move.b	d0,(a3)
		lea	word_20050A(pc,d0.w),a3
		move.w	(a3)+,palette+$40
		if STAGE_GOOD_FUTURE=0
			lea	palette+$64,a4
			move.l	(a3)+,(a4)+
			adda.w	#2,a4
			move.l	(a3)+,(a4)+
			adda.w	#6,a4
			move.l	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
		else
			lea	palette+$6E,a4
			move.w	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
			move.l	(a3)+,(a4)+
		endif
		rts

; ------------------------------------------------------------------------------

	word_20050A:
		if STAGE_GOOD_FUTURE=0
			dc.w	0, $E44, $E0E, $826, $604, $ACE, 0, $220, $244, $86, $2AE
			dc.w	$222, $E66, $E2E, $A48, $826, $CEE, $222, $442, $466, $2A8, $4CE
			dc.w	$444, $E88, $E4E, $C6A, $A48, $EEE, $444, $664, $688, $4CA, $6EE
			dc.w	$666, $EAA, $E6E, $E8C, $C6A, $EEE, $666, $886, $8AA, $6EC, $8EE
			dc.w	$888, $ECC, $E8E, $EAE, $E8C, $EEE, $888, $AA8, $ACC, $8EE, $AEE
			dc.w	$AAA, $EEE, $EAE, $ECE, $EAE, $EEE, $AAA, $CCA, $CEE, $AEE, $CEE
			dc.w	$CCC, $EEE, $ECE, $EEE, $ECE, $EEE, $CCC, $EEC, $EEE, $CEE, $EEE
			dc.w	$EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE
		else
			dc.w	0, $240, $6A0, $AE0, $EE0, $200, $602, $A04, $A62, $E80
			dc.w	$222, $462, $8C2, $CE2, $EE2, $422, $824, $C26, $C84, $EA2
			dc.w	$444, $684, $AE4, $EE4, $EE4, $644, $A46, $E48, $EA6, $EC4
			dc.w	$666, $8A6, $CE6, $EE6, $EE6, $866, $C68, $E6A, $EC8, $EE6
			dc.w	$888, $AC8, $EE8, $EE8, $EE8, $A88, $E8A, $E8C, $EEA, $EE8
			dc.w	$AAA, $CEA, $EEA, $EEA, $EEA, $CAA, $EAC, $EAE, $EEC, $EEA
			dc.w	$CCC, $EEC, $EEC, $EEC, $EEC, $ECC, $ECE, $ECE, $EEE, $EEC
			dc.w	$EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE
		endif

; ------------------------------------------------------------------------------

	BossFadeObjectsFromWhite:
		move.w	#$2F,palette_fade_start
		moveq	#0,d0
		lea	palette,a0
		move.b	palette_fade_start,d0
		adda.w	d0,a0
		move.w	#$EEE,d1
		move.b	palette_fade_length,d0

	loc_2005C4:
		move.w	d1,(a0)+
		dbf	d0,loc_2005C4
		move.w	#$15,d4

	loc_2005CE:
		move.b	#$12,vblank_routine
		bsr.w	VSync
		bsr.w	FadeColorsFromWhite
		move.w	#$EEE,palette+$40
		bsr.w	AdvanceGfxQueue
		dbf	d4,loc_2005CE
		rts
	endif

; ------------------------------------------------------------------------------
