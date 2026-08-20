; ------------------------------------------------------------------------------

CyclePalette:
	tst.b	act
	bne.s	loc_20018E
	rts

; ------------------------------------------------------------------------------

loc_20018E:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_20020E,a1
	lea	word_20022C,a2
	bsr.w	CycleColor
	lea	byte_200218,a1
	lea	word_20022C,a2
	bsr.w	CycleColor
	lea	byte_200222,a1
	lea	word_20022C,a2
	bra.w	CycleColor

; ------------------------------------------------------------------------------

CycleColor:
	subq.b	#1,(a5)
	bpl.s	loc_2001FA
	moveq	#0,d0
	move.b	(a1)+,d0
	move.b	(a1)+,d1
	add.w	d0,d0
	lea	palette,a3
	lea	(a3,d0.w),a3
	moveq	#0,d0
	move.b	(a4),d0
	addq.b	#1,d0
	cmp.b	d1,d0
	bcs.s	loc_2001E6
	moveq	#0,d0

loc_2001E6:
	move.b	d0,(a4)
	add.w	d0,d0
	move.b	(a1,d0.w),(a5)
	move.b	1(a1,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	move.w	(a2,d0.w),(a3)

loc_2001FA:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

	dc.b	$31, 4
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 2
	dc.b	2, 3

byte_20020E:
	dc.b	$32, 4
	dc.b	2, 1
	dc.b	2, 2
	dc.b	2, 3
	dc.b	2, 0

byte_200218:
	dc.b	$33, 4
	dc.b	2, 2
	dc.b	2, 3
	dc.b	2, 0
	dc.b	2, 1

byte_200222:
	dc.b	$34, 4
	dc.b	2, 3
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 2

word_20022C:
	dc.w	$CCC
	dc.w	$C82
	dc.w	$EA6
	dc.w	$ECA

; ------------------------------------------------------------------------------
