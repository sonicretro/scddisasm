; ------------------------------------------------------------------------------

CyclePalette:
	bra.w	CyclePalette_0

; ------------------------------------------------------------------------------

	lea	word_2001F8,a0
	subq.b	#1,palette_cycle_timers
	bpl.s	loc_2001BE
	move.b	#7,palette_cycle_timers
	moveq	#0,d0
	move.b	palette_cycle_steps,d0
	cmpi.b	#2,d0
	bne.s	loc_2001AA
	moveq	#0,d0
	bra.s	loc_2001AC

; ------------------------------------------------------------------------------

loc_2001AA:
	addq.b	#1,d0

loc_2001AC:
	move.b	d0,palette_cycle_steps
	lsl.w	#3,d0
	lea	palette+$6A,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

loc_2001BE:
	adda.w	#word_200210-word_2001F8,a0
	subq.b	#1,palette_cycle_timers+1
	bpl.s	locret_2001F6
	move.b	#5,palette_cycle_timers+1
	moveq	#0,d0
	move.b	palette_cycle_steps+1,d0
	cmpi.b	#2,d0
	bne.s	loc_2001DE
	moveq	#0,d0
	bra.s	loc_2001E0

; ------------------------------------------------------------------------------

loc_2001DE:
	addq.b	#1,d0

loc_2001E0:
	move.b	d0,palette_cycle_steps+1
	andi.w	#3,d0
	lsl.w	#3,d0
	lea	palette+$58,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

locret_2001F6:
	rts

; ------------------------------------------------------------------------------

word_2001F8:
	dc.w	$EEA
	dc.w	$CE6
	dc.w	$EEE
	dc.w	$8C4
	dc.w	$8C4
	dc.w	$EEA
	dc.w	$EEA
	dc.w	$CE6
	dc.w	$CE6
	dc.w	$8C4
	dc.w	$CE6
	dc.w	$EEA
	
word_200210:
	dc.w	$EEC
	dc.w	$CE6
	dc.w	$AA0
	dc.w	$8C4
	dc.w	$CE6
	dc.w	$8C4
	dc.w	$AA0
	dc.w	$EEC
	dc.w	$8C4
	dc.w	$EEC
	dc.w	$AA0
	dc.w	$CE6

; ------------------------------------------------------------------------------

CyclePalette_0:
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_2002C0,a1
	lea	word_2002C8,a2
	bsr.s	CycleColor
	lea	byte_2002CE,a1
	lea	word_2002D6,a2
	bsr.s	CycleColor
	lea	byte_2002DC,a1
	lea	word_2002E4,a2
	bsr.s	CycleColor
	lea	byte_2002EA,a1
	lea	word_2002F2,a2
	bsr.s	CycleColor
	lea	byte_2002F8,a1
	lea	word_200300,a2
	bsr.s	CycleColor
	lea	byte_200306,a1
	lea	word_20030E,a2

; ------------------------------------------------------------------------------

CycleColor:
	subq.b	#1,(a5)
	bpl.s	loc_2002B6
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
	bcs.s	loc_2002A2
	moveq	#0,d0

loc_2002A2:
	move.b	d0,(a4)
	add.w	d0,d0
	move.b	(a1,d0.w),(a5)
	move.b	1(a1,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	move.w	(a2,d0.w),(a3)

loc_2002B6:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

byte_2002C0:
	dc.b	$31, 3
	dc.b	8, 0
	dc.b	8, 1
	dc.b	8, 2

word_2002C8:
	dc.w	$EEA
	dc.w	$CE6
	dc.w	$8C4

byte_2002CE:
	dc.b	$32, 3
	dc.b	8, 0
	dc.b	8, 1
	dc.b	8, 2

word_2002D6:
	dc.w	$8C4
	dc.w	$EEA
	dc.w	$CE6

byte_2002DC:
	dc.b	$33, 3
	dc.b	8, 0
	dc.b	8, 1
	dc.b	8, 2

word_2002E4:
	dc.w	$CE6
	dc.w	$8C4
	dc.w	$EEA

byte_2002EA:
	dc.b	$2C, 3
	dc.b	6, 0
	dc.b	6, 1
	dc.b	6, 2

word_2002F2:
	dc.w	$EEC
	dc.w	$CE6
	dc.w	$8C4

byte_2002F8:
	dc.b	$2D, 3
	dc.b	6, 0
	dc.b	6, 1
	dc.b	6, 2

word_200300:
	dc.w	$CE6
	dc.w	$8C4
	dc.w	$EEC

byte_200306:
	dc.b	$2F, 3
	dc.b	6, 0
	dc.b	6, 1
	dc.b	6, 2

word_20030E:
	dc.w	$8C4
	dc.w	$EEC
	dc.w	$CE6

; ------------------------------------------------------------------------------
