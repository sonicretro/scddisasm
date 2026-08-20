; ------------------------------------------------------------------------------

CyclePalette:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_200256,a1
	lea	word_20025E,a2
	bsr.w	CycleColor
	lea	byte_200264,a1
	lea	word_20026C,a2
	bsr.w	CycleColor
	lea	byte_200272,a1
	lea	word_20027A,a2
	bsr.s	CycleColor
	cmpi.b	#1,act
	beq.s	loc_2001F0
	lea	byte_200280,a1
	lea	word_20029A,a2
	bsr.s	CycleColor
	lea	byte_20029E,a1
	lea	word_2002B8,a2
	bsr.s	CycleColor
	lea	byte_2002BC,a1
	lea	word_2002D6,a2
	bra.w	CycleColor

; ------------------------------------------------------------------------------

loc_2001F0:
	lea	byte_2002DA,a1
	lea	word_2002EE,a2
	bsr.s	CycleColor
	lea	byte_2002F8,a1
	lea	word_20030C,a2
	bsr.s	CycleColor
	lea	byte_200316,a1
	lea	word_20031E,a2

; ------------------------------------------------------------------------------

CycleColor:
	subq.b	#1,(a5)
	bpl.s	loc_20024C
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
	bcs.s	loc_200238
	moveq	#0,d0

loc_200238:
	move.b	d0,(a4)
	add.w	d0,d0
	move.b	(a1,d0.w),(a5)
	move.b	1(a1,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	move.w	(a2,d0.w),(a3)

loc_20024C:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

byte_200256:
	dc.b	$26, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2
	
word_20025E:
	dc.w	$404
	dc.w	$808
	dc.w	$E0E

byte_200264:
	dc.b	$27, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2

word_20026C:
	dc.w	$E0E
	dc.w	$404
	dc.w	$808

byte_200272:
	dc.b	$28, 3
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2

word_20027A:
	dc.w	$808
	dc.w	$E0E
	dc.w	$404

byte_200280:
	dc.b	$31, $C
	dc.b	3, 0
	dc.b	3, 1
	dc.b	3, 0
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	3, 1
	dc.b	$3C, 1

word_20029A:
	dc.w	$E60
	dc.w	0

byte_20029E:
	dc.b	$32, $C
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 1
	dc.b	3, 0
	dc.b	3, 1
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	$3C, 0

word_2002B8:
	dc.w	0
	dc.w	$E60

byte_2002BC:
	dc.b	$33, $C
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 0
	dc.b	3, 1
	dc.b	3, 0
	dc.b	3, 1
	dc.b	$3C, 0

word_2002D6:
	dc.w	0
	dc.w	$E60

byte_2002DA:
	dc.b	$31, 9
	dc.b	$A, 0
	dc.b	$A, 1
	dc.b	$A, 2
	dc.b	$A, 3
	dc.b	$A, 4
	dc.b	$A, 3
	dc.b	$A, 2
	dc.b	$A, 1
	dc.b	$A, 0

word_2002EE:
	dc.w	$E0
	dc.w	$A0
	dc.w	$60
	dc.w	$20
	dc.w	0

byte_2002F8:
	dc.b	$32, 9
	dc.b	$A, 0
	dc.b	$A, 1
	dc.b	$A, 2
	dc.b	$A, 3
	dc.b	$A, 4
	dc.b	$A, 3
	dc.b	$A, 2
	dc.b	$A, 1
	dc.b	$A, 0

word_20030C:
	dc.w	$AE
	dc.w	$6E
	dc.w	$E
	dc.w	6
	dc.w	0

byte_200316:
	dc.b	$33, 3
	dc.b	5, 0
	dc.b	5, 1
	dc.b	5, 2

word_20031E:
	dc.w	$EE
	dc.w	$E
	dc.w	0

; ------------------------------------------------------------------------------
