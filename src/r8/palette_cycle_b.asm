; ------------------------------------------------------------------------------

CyclePalette:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	unk_20023A,a1
	lea	unk_200242,a2
	bsr.w	CycleColor
	lea	unk_200248,a1
	lea	unk_200250,a2
	bsr.w	CycleColor
	lea	unk_200256,a1
	lea	unk_20025E,a2
	bsr.s	CycleColor
	cmpi.b	#1,act
	beq.s	loc_2001E2
	lea	unk_200264,a1
	lea	unk_200276,a2
	bsr.s	CycleColor
	lea	unk_20027C,a1
	lea	unk_200282,a2
	bra.w	CycleColor

; ------------------------------------------------------------------------------

loc_2001E2:
	lea	unk_200286,a1
	lea	unk_200296,a2
	bsr.s	CycleColor
	lea	unk_20029A,a1
	lea	unk_2002A8,a2

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

unk_20023A:
	dc.b	$26, 3
	dc.b	4, 2
	dc.b	4, 1
	dc.b	4, 0

unk_200242:
	dc.w	$6AE
	dc.w	$46C
	dc.w	$22A

unk_200248:
	dc.b	$27, 3
	dc.b	4, 2
	dc.b	4, 1
	dc.b	4, 0

unk_200250:
	dc.w	$46C
	dc.w	$22A
	dc.w	$6AE

unk_200256:
	dc.b	$28, 3
	dc.b	4, 2
	dc.b	4, 1
	dc.b	4, 0

unk_20025E:
	dc.w	$22A
	dc.w	$6AE
	dc.w	$46C

unk_200264:
	dc.b	$3E, 8
	dc.b	$63, 0
	dc.b	2, 1
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 2
	dc.b	2, 1
	dc.b	2, 2
	dc.b	2, 1

unk_200276:
	dc.w	$CC0
	dc.w	$EEE
	dc.w	0

unk_20027C:
	dc.b	$3F
	dc.b	2
	dc.b	$F
	dc.b	0
	dc.b	$F
	dc.b	1

unk_200282:
	dc.w	$E0
	dc.w	$EE

unk_200286:
	dc.b	$31, 7
	dc.b	$16, 0
	dc.b	2, 1
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 0
	dc.b	2, 1
	dc.b	$21, 0

unk_200296:
	dc.w	0
	dc.w	$EEE

unk_20029A:
	dc.b $32, 6
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 0
	dc.b	2, 1
	dc.b	2, 0
	dc.b	$37, 1
	
unk_2002A8:
	dc.w	$EEE
	dc.w	0

; ------------------------------------------------------------------------------
