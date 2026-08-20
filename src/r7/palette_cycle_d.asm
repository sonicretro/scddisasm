; ------------------------------------------------------------------------------

CyclePalette:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_200240,a1
	lea	word_20024E,a2
	bsr.w	sub_2001F6
	lea	byte_200256,a1
	lea	word_20025E,a2
	bsr.w	sub_2001F6
	lea	byte_20026A,a1
	lea	word_200272,a2
	bsr.w	sub_2001F6
	lea	byte_20027E,a1
	lea	word_200286,a2
	bsr.w	sub_2001F6
	lea	byte_2002A0,a1
	lea	word_2002B2,a2
	bsr.w	sub_2001F6
	lea	byte_2002C2,a1
	tst.b	act
	bne.s	loc_2001F0
	lea	byte_2002E4,a1

loc_2001F0:
	lea	word_2002D4,a2

; ------------------------------------------------------------------------------

sub_2001F6:
	subq.b	#1,(a5)
	bpl.s	loc_200236
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
	bcs.s	loc_200218
	moveq	#0,d0

loc_200218:
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

loc_200236:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

byte_200240:
	dc.b	$27, 6
	dc.b	5, 0
	dc.b	$23, 1
	dc.b	5, 0
	dc.b	5, 1
	dc.b	$A, 0
	dc.b	$64, 1

word_20024E:
	dc.w	$48E
	dc.w	0
	dc.w	$48E
	dc.w	0

byte_200256:
	dc.b	$2D, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2

word_20025E:
	dc.w	$88C
	dc.w	$44C
	dc.w	6
	dc.w	$88C
	dc.w	$44C
	dc.w	6

byte_20026A:
	dc.b	$2E, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2

word_200272:
	dc.w	$44C
	dc.w	6
	dc.w	$88C
	dc.w	$44C
	dc.w	6
	dc.w	$88C

byte_20027E:
	dc.b	$2F, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2

word_200286:
	dc.w	6
	dc.w	$88C
	dc.w	$4C
	dc.w	6
	dc.w	$88C
	dc.w	$4C

	dc.b	$31, 2
	dc.b	4, 0
	dc.b	4, 1

	dc.w	2
	dc.w	$A
	dc.w	2
	dc.w	$A

byte_2002A0:
	dc.b	$31, 8
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	2, 1
	dc.b	5, 2
	dc.b	$1E, 3

word_2002B2:
	dc.w	2
	dc.w	0
	dc.w	$A8C
	dc.w	8
	dc.w	2
	dc.w	0
	dc.w	$A8C
	dc.w	8

byte_2002C2:
	dc.b	$3E, 8
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	2, 1
	dc.b	5, 2
	dc.b	$1E, 3

word_2002D4:
	dc.w	2
	dc.w	$A6C
	dc.w	2
	dc.w	$A6C
	dc.w	2
	dc.w	$A6C
	dc.w	2
	dc.w	$A6C

byte_2002E4:
	dc.b	$3A, 8
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	$64, 0
	dc.b	2, 1
	dc.b	5, 2
	dc.b	$1E, 3

; ------------------------------------------------------------------------------
