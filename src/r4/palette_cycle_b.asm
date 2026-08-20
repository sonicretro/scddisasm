; ------------------------------------------------------------------------------

CyclePalette:
	tst.b	act
	bne.s	loc_20018E
	rts

; ------------------------------------------------------------------------------

loc_20018E:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_200204,a1
	lea	word_20021C,a2
	bsr.w	CycleColor
	lea	byte_20020C,a1
	lea	word_20021C,a2
	bsr.w	CycleColor
	lea	byte_200214,a1
	lea	word_20021C,a2
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

byte_200204:
	dc.b	$32, 3
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 2

byte_20020C:
	dc.b	$33, 3
	dc.b	2, 1
	dc.b	2, 2
	dc.b	2, 0

byte_200214:
	dc.b	$34, 3
	dc.b	2, 2
	dc.b	2, 0
	dc.b	2, 1

word_20021C:
	dc.w	$CC0
	dc.w	$EE0
	dc.w	$EE4

; ------------------------------------------------------------------------------
