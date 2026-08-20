; ------------------------------------------------------------------------------

CyclePalette:
	rts
	lea	palette_cycle_timers,a5
	lea	palette_cycle_steps,a4
	lea	byte_200214,a1
	lea	word_20021C,a2
	bsr.w	sub_2001CA
	lea	byte_200228,a1
	lea	word_200230,a2
	bsr.w	sub_2001CA
	lea	byte_20023C,a1
	lea	word_200244,a2
	bsr.w	sub_2001CA
	lea	byte_200250,a1
	lea	word_200308,a2

; ------------------------------------------------------------------------------

sub_2001CA:
	subq.b	#1,(a5)
	bpl.s	loc_20020A
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
	bcs.s	loc_2001EC
	moveq	#0,d0

loc_2001EC:
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

loc_20020A:
	adda.w	#1,a4
	adda.w	#1,a5
	rts

; ------------------------------------------------------------------------------

byte_200214:
	dc.b	$21, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 2

word_20021C:
	dc.w	$EE
	dc.w	$E
	dc.w	0
	dc.w	$EE
	dc.w	$E
	dc.w	0

byte_200228:
	dc.b	$22, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 2

word_200230:
	dc.w	$E
	dc.w	0
	dc.w	$EE
	dc.w	$E
	dc.w	0
	dc.w	$EE

byte_20023C:
	dc.b	$23, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 2

word_200244:
	dc.w	0
	dc.w	$EE
	dc.w	$E
	dc.w	0
	dc.w	$EE
	dc.w	$E

byte_200250:
	dc.b	$31, $5B
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	1, 1
	dc.b	1, 0
	dc.b	1, 2
	dc.b	1, 0
	dc.b	1, 3
	dc.b	1, 0
	dc.b	$1E, 1

word_200308:
	dc.w	0
	dc.w	$C28
	dc.w	$EE
	dc.w	$EEE
	dc.w	0
	dc.w	$C28
	dc.w	$EE
	dc.w	$EEE

; ------------------------------------------------------------------------------
