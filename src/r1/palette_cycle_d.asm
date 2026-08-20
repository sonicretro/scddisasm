; ------------------------------------------------------------------------------

CyclePalette:
	lea	word_200244,a0
	subq.b	#1,palette_cycle_timers
	bpl.s	loc_2001BA
	move.b	#7,palette_cycle_timers
	moveq	#0,d0
	move.b	palette_cycle_steps,d0
	cmpi.b	#2,d0
	bne.s	loc_2001A6
	moveq	#0,d0
	bra.s	loc_2001A8

; ------------------------------------------------------------------------------

loc_2001A6:
	addq.b	#1,d0

loc_2001A8:
	move.b	d0,palette_cycle_steps
	lsl.w	#3,d0
	lea	palette+$6A,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

loc_2001BA:
	adda.w	#word_20025C-word_200244,a0
	subq.b	#1,palette_cycle_timers+1
	bpl.s	loc_2001F2
	move.b	#5,palette_cycle_timers+1
	moveq	#0,d0
	move.b	palette_cycle_steps+1,d0
	cmpi.b	#2,d0
	bne.s	loc_2001DA
	moveq	#0,d0
	bra.s	loc_2001DC

; ------------------------------------------------------------------------------

loc_2001DA:
	addq.b	#1,d0

loc_2001DC:
	move.b	d0,palette_cycle_steps+1
	andi.w	#3,d0
	lsl.w	#3,d0
	lea	palette+$58,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

loc_2001F2:
	lea	palette_cycle_timers+2,a5
	lea	palette_cycle_steps+2,a4
	lea	byte_200274,a1
	lea	word_200286,a2

; ------------------------------------------------------------------------------

CycleColor:
	subq.b	#1,(a5)
	bpl.s	loc_20023A
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
	bcs.s	loc_200226
	moveq	#0,d0

loc_200226:
	move.b	d0,(a4)
	add.w	d0,d0
	move.b	(a1,d0.w),(a5)
	move.b	1(a1,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	move.w	(a2,d0.w),(a3)

loc_20023A:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

word_200244:
	dc.w	$888
	dc.w	$666
	dc.w	$888
	dc.w	$444
	dc.w	$444
	dc.w	$888
	dc.w	$666
	dc.w	$666
	dc.w	$666
	dc.w	$444
	dc.w	$444
	dc.w	$888

word_20025C:
	dc.w	$CAE
	dc.w	$C8C
	dc.w	$A44
	dc.w	$C6A
	dc.w	$C8C
	dc.w	$C6A
	dc.w	$A44
	dc.w	$CAE
	dc.w	$C6A
	dc.w	$CAE
	dc.w	$A44
	dc.w	$C8C

byte_200274:
	dc.b	$22, 8
	dc.b	4, 0
	dc.b	4, 1
	dc.b	4, 2
	dc.b	4, 3
	dc.b	4, 4
	dc.b	4, 3
	dc.b	4, 2
	dc.b	4, 1

word_200286:
	dc.w	$E
	dc.w	$C
	dc.w	$A
	dc.w	8
	dc.w	6

; ------------------------------------------------------------------------------
