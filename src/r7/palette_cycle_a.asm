; ------------------------------------------------------------------------------

CyclePalette:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_200202,a1
	lea	word_200208,a2
	bsr.w	sub_2001B8
	lea	byte_200210,a1
	lea	word_200216,a2
	bsr.w	sub_2001B8
	lea	byte_20021E,a1
	lea	word_200224,a2

; ------------------------------------------------------------------------------

sub_2001B8:
	subq.b	#1,(a5)
	bpl.s	loc_2001F8
	moveq	#0,d0
	moveq	#0,d1
	move.b	(a1)+,d0
	move.b	(a1)+,d1
	add.w	d0,d0
	lea	palette,a3
	lea	(a3,d0.w),a3
	moveq	#0,d0
	move.b	(a4),d0
	addq.b	#1,d0
	cmp.b	d1,d0
	bcs.s	loc_2001DA
	moveq	#0,d0

loc_2001DA:
	move.b	d0,(a4)
	add.w	d0,d0
	move.b	(a1,d0.w),(a5)
	move.b	1(a1,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	move.w	(a2,d0.w),(a3)
	add.w	d1,d1
	add.w	d0,d1
	move.w	(a2,d1.w),water_palette-palette(a3)

loc_2001F8:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

byte_200202:
	dc.b	$29, 2
	dc.b	4, 0
	dc.b	4, 1

word_200208:
	dc.w	$E0
	dc.w	0
	dc.w	$E0
	dc.w	0

byte_200210:
	dc.b	$3E, 2
	dc.b	4, 0
	dc.b	4, 1

word_200216:
	dc.w	$EEE
	dc.w	2
	dc.w	$EEE
	dc.w	2

byte_20021E:
	dc.b	$3F, 2
	dc.b	4, 0
	dc.b	4, 1

word_200224:
	dc.w	$E0
	dc.w	2
	dc.w	$E0
	dc.w	2

; ------------------------------------------------------------------------------
